#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <pthread.h>
#include "test.h"
#include <ctype.h>
#include <signal.h>

#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024
#define MAX_CLIENTS 10
pthread_mutex_t active_clients_mutex = PTHREAD_MUTEX_INITIALIZER;

int active_clients[MAX_CLIENTS];
int num_active_clients = 0;
int halt_signal_sent = 0;

typedef struct {
    int client_socket;
    char **port;
} ClientData;

typedef struct {
    char *command;
    char *output_file;
} RedirectArgs;

pthread_t server_thread;

void handle_interrupt(int signum) {
    if (signum == SIGINT) {
        send_halt_to_clients(active_clients, &num_active_clients, &halt_signal_sent, &active_clients_mutex);
        printf("Sent halt command to all clients.\n");
        exit(EXIT_SUCCESS); // Exit the program after sending halt command
    }
}

void *server_task(void *arg) {
    // Example of a server task, such as sending the halt message
    while (1) {
        char command[MAX_LINE_LENGTH];
        fgets(command, sizeof(command), stdin);
        command[strcspn(command, "\n")] = '\0'; // Remove newline character
        if (strcmp(command, "halt") == 0) {
            send_halt_to_clients(active_clients, &num_active_clients, &halt_signal_sent, &active_clients_mutex);
            printf("Sent halt command to all clients.\n");
            break;
        }
    }
    return NULL;
}

RedirectArgs redirect_argument(char *arg) {
    RedirectArgs args;

    // Initialize the fields to NULL
    args.command = NULL;
    args.output_file = NULL;

    // Find the position of '>'
    char *pos = strchr(arg, '>');
    if (pos == NULL) {
        // No output redirection, set command only
        args.command = strdup(arg);
    } else {
        // Output redirection found, split the argument
        *pos = '\0'; // Null-terminate the command
        args.command = strdup(arg);
        args.output_file = strdup(pos + 1); // Set the output file
    }

    // Trim leading and trailing whitespace from filenames
    if (args.command != NULL) {
        while (*args.command && isspace(*args.command)) {
            args.command++;
        }
        char *end = args.command + strlen(args.command) - 1;
        while (end > args.command && isspace(*end)) {
            *end-- = '\0';
        }
    }
    if (args.output_file != NULL) {
        while (*args.output_file && isspace(*args.output_file)) {
            args.output_file++;
        }
        char *end = args.output_file + strlen(args.output_file) - 1;
        while (end > args.output_file && isspace(*end)) {
            *end-- = '\0';
        }
    }

    return args;
}

char *lsh_execute_external(char **args) {
    pid_t pid;
    int fd[2];
    pipe(fd);

    pid = fork();
    if (pid == 0) {
        // Child process
        dup2(fd[1], STDOUT_FILENO); // Redirect stdout to the pipe
        close(fd[0]); // Close the read end of the pipe

        // Execute the command
        if (execvp(args[0], args) == -1) {
            perror("lsh");
            exit(EXIT_FAILURE);
        }
    } else if (pid < 0) {
        // Error forking
        perror("lsh");
    } else {
        // Parent process
        close(fd[1]); // Close the write end of the pipe

        // Read the output from the pipe
        char *output = NULL;
        char buffer[MAX_LINE_LENGTH];
        size_t output_size = 0;
        ssize_t bytes_read;

        while ((bytes_read = read(fd[0], buffer, sizeof(buffer))) > 0) {
            output = realloc(output, output_size + bytes_read + 1);
            if (output == NULL) {
                perror("Memory allocation error");
                exit(EXIT_FAILURE);
            }
            memcpy(output + output_size, buffer, bytes_read);
            output_size += bytes_read;
        }

        if (bytes_read < 0) {
            perror("Error reading from pipe");
            exit(EXIT_FAILURE);
        }

        output[output_size] = '\0'; // Null-terminate the output

        return output;
    }

    return NULL;
}

void handle_arguments(char *argument, int client_socket) {
    if (strstr(argument, ">") != NULL) {
        RedirectArgs args = redirect_argument(argument);
        if (strcmp(args.command, "help") == 0) {
            print_to_file(help_message(), args.output_file);
        } else {
            char **command = lsh_split_args(args.command);
            char *output = lsh_execute_external(command);
            print_to_file(output, args.output_file);
        }
        send(client_socket, "1", 3, 0);
    } else {
        char **command = lsh_split_args(argument);
        char *output = lsh_execute_external(command);
        if (output != NULL) {
            send(client_socket, output, strlen(output), 0);
        } else {
            send(client_socket, "Wrong command", strlen("Wrong command"), 0);
        }
    }
}

void *handle_client(void *arg) {
    ClientData *data = (ClientData *) arg;
    int client_socket = data->client_socket;
    char **port = data->port;

    pthread_mutex_lock(&active_clients_mutex);
    active_clients[num_active_clients++] = client_socket;
    pthread_mutex_unlock(&active_clients_mutex);

    char buffer[MAX_LINE_LENGTH];

    // Receive messages from the client
    while (!halt_signal_sent) {
        ssize_t num_bytes = recv(client_socket, buffer, sizeof(buffer), 0);
        if (num_bytes < 0) {
            perror("Receive failed");
            break;
        } else if (num_bytes == 0) {
            // Connection closed by client
            printf("User disconnected\n");
            // Close the connection with the client
            close(client_socket);
            break;
        } else {
            // Null-terminate the received data to treat it as a string
            buffer[num_bytes] = '\0';

            // Allocate memory for the word and copy it from the buffer
            char *argument = strdup(buffer);
            handle_arguments(argument, client_socket);
        }
    }

    pthread_mutex_lock(&active_clients_mutex);
    for (int i = 0; i < num_active_clients; ++i) {
        if (active_clients[i] == client_socket) {
            // Shift remaining elements to the left
            for (int j = i; j < num_active_clients - 1; ++j) {
                active_clients[j] = active_clients[j + 1];
            }
            num_active_clients--;
            break;
        }
    }
    pthread_mutex_unlock(&active_clients_mutex);

    // Close the connection with the client
    close(client_socket);
    free(data);

    if (num_active_clients == 0) {
        printf("All clients disconnected. Exiting server.\n");
        pthread_cancel(server_thread); // Cancel the server thread
        exit(EXIT_SUCCESS);
    }
    return NULL;
}


void server_side(char **port, char *socket_path) {
    int server_fd;
    struct sockaddr_in address;
    int addrlen = sizeof(address);

    // Create socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(atoi(*port));

    // Bind the socket to localhost and chosen port
    if (bind(server_fd, (struct sockaddr *) &address, sizeof(address)) < 0) {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }

    // Listen for incoming connections
    if (listen(server_fd, 3) < 0) {
        perror("Listen failed");
        exit(EXIT_FAILURE);
    }

    if (pthread_create(&server_thread, NULL, server_task, NULL) != 0) {
        perror("Failed to create server thread");
        exit(EXIT_FAILURE);
    }

    signal(SIGINT, handle_interrupt);

    // Accept incoming connections and handle them in separate threads
    while (1) {
        int client_socket;
        if ((client_socket = accept(server_fd, (struct sockaddr *) &address, (socklen_t * ) & addrlen)) < 0) {
            perror("Connection failed");
            continue;
        }

        printf("CONNECTION SUCCESS\n");
        // Create a thread to handle the client
        pthread_t tid;
        ClientData *data = malloc(sizeof(ClientData));
        if (data == NULL) {
            perror("Failed to allocate memory for client data");
            close(client_socket);
            continue;
        }
        data->client_socket = client_socket;
        data->port = port;

        if (pthread_create(&tid, NULL, handle_client, data) != 0) {
            perror("Failed to create thread");
            close(client_socket);
            free(data);
            continue;
        }

        // Detach the thread to clean up resources automatically
        pthread_detach(tid);
    }

    // Close the server socket
    close(server_fd);
}


