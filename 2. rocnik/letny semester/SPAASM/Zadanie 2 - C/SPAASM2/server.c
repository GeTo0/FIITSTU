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

#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024

typedef struct {
    int client_socket;
    char **port;
} ClientData;

void *handle_client(void *arg) {
    ClientData *data = (ClientData *) arg;
    int client_socket = data->client_socket;
    char **port = data->port;

    char buffer[MAX_LINE_LENGTH];

    // Receive messages from the client
    while (1) {
        ssize_t num_bytes = recv(client_socket, buffer, sizeof(buffer), 0);
        if (num_bytes < 0) {
            perror("Receive failed");
            break;
        } else if (num_bytes == 0) {
            // Connection closed by client
            printf("User disconnected\n");
            break;  // Exit the loop when the client disconnects
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

                if(strcmp(word, "-help") == 0) {
                    char *help_message = arg_help();
                    send(client_socket, help_message, strlen(help_message), 0);
                } else if(strcmp(word, "-halt") == 0) {
                    printf("Sending halt message to client\n");
                    send(client_socket, "-halt", strlen("-halt"), 0); // Send the halt message to the client
                } else {
                    printf("Sending message: %s\n", word);
                    send(client_socket, word, strlen(word),0);
                }
                token = strtok(NULL, " ");
            }
        }
    }

    // Close the connection with the client
    close(client_socket);
    free(data);
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

    // Close the server socket (this part is never reached in this example)
    close(server_fd);
}