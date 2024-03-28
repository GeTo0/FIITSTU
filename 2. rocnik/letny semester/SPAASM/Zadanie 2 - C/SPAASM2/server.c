#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <pwd.h>
#include "test.h"

#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024

int connect_to_client(char **port) {
    int server_fd, new_socket;
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

    // Accept incoming connection
    if ((new_socket = accept(server_fd, (struct sockaddr *) &address, (socklen_t * ) & addrlen)) < 0) {
        perror("Connection failed");
        exit(EXIT_FAILURE);
    }
    // Now you can send and receive messages using new_socket
    printf("CONNECTION SUCCESS\n");
    return new_socket;
}

int send_message(int sockfd, char *message) {
    if (send(sockfd, message, strlen(message), 0) < 0) {
        perror("Send failed");
        return -1; // Return -1 on failure
    } else {
        printf("Message sent to server: %s\n", message);
        return 0; // Return 0 on success
    }
}

void server_side(char **port, char *socket_path) {
    int new_socket = connect_to_client(port);
    char buffer[MAX_LINE_LENGTH];

    // Receive messages from the client
    while (1) {
        ssize_t num_bytes = recv(new_socket, buffer, sizeof(buffer), 0);
        if (num_bytes < 0) {
            perror("Receive failed");
            exit(EXIT_FAILURE);
        } else if (num_bytes == 0) {
            // Connection closed by client
            printf("User disconnected\n");
            break;  // Exit the loop when the client disconnects
        } else {
            // Null-terminate the received data to treat it as a string
            buffer[num_bytes] = '\0';
            // Print the received message
            printf("Received message from user: %s\n", buffer);
        }
    }

    // Close the connection with the client
    close(new_socket);
}