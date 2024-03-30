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
        if (strcmp(command, "-halt") == 0) {
            send_halt_to_clients(active_clients, &num_active_clients, &halt_signal_sent, &active_clients_mutex);
            printf("Sent halt command to all clients.\n");
            break;
        }
    }
    return NULL;
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

            char *token = strtok(buffer, " ");
            while (token != NULL) {
                // Trim leading whitespace characters
                while (isspace(*token)) {
                    token++;
                }
                // Trim trailing whitespace characters
                char *end = token + strlen(token) - 1;
                while (end > token && isspace(*end)) {
                    *end-- = '\0';
                }

                // Allocate memory for the word and copy it from the token
                char *word = strdup(token);

                if (strcmp(word, "-help") == 0) {
                    char *help_message = arg_help();
                    send(client_socket, help_message, strlen(help_message), 0);
                } else {
                    printf("Sending message: %s\n", word);
                    send(client_socket, word, strlen(word), 0);
                }
                token = strtok(NULL, " ");
            }
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