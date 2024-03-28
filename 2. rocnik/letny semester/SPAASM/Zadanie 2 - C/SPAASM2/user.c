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

int connect_to_server(char **port) {
    int sockfd;
    struct sockaddr_in serv_addr;
    // Create socket
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        perror("Error creating socket");
        exit(EXIT_FAILURE);
    }
    // Set up server address structure
    memset(&serv_addr, '0', sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(atoi(*port));

    // Convert IPv4 and IPv6 addresses from text to binary form
    if (inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr) <= 0) {
        perror("Invalid address/ Address not supported");
        exit(EXIT_FAILURE);
    }

    if (connect(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
        perror("Connection failed");
        exit(EXIT_FAILURE);
    }
    // Now you can send and receive messages using sockfd
    printf("CONNECTION SUCCESS\n");
    return sockfd;
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

char *lsh_read_line(void) {
    char *line = malloc(MAX_LINE_LENGTH * sizeof(char));
    if (!line) {
        fprintf(stderr, "lsh: allocation error\n");
        exit(EXIT_FAILURE);
    }

    if (!fgets(line, MAX_LINE_LENGTH, stdin)) {
        free(line);
        if (!feof(stdin)) {
            perror("lsh: fgets");
        }
        exit(EXIT_FAILURE);
    }

    return line;
}

char **lsh_split_line(char *line) {
    int bufsize = MAX_LINE_LENGTH, position = 0;
    char **tokens = malloc(bufsize * sizeof(char *));
    char *token;

    if (!tokens) {
        fprintf(stderr, "lsh: allocation error\n");
        exit(EXIT_FAILURE);
    }

    token = strtok(line, " \t\n");
    while (token != NULL) {
        tokens[position] = token;
        position++;

        if (position >= bufsize) {
            bufsize += MAX_LINE_LENGTH;
            tokens = realloc(tokens, bufsize * sizeof(char *));
            if (!tokens) {
                fprintf(stderr, "lsh: allocation error\n");
                exit(EXIT_FAILURE);
            }
        }

        token = strtok(NULL, " \t\n");
    }
    tokens[position] = NULL;
    return tokens;
}

int lsh_execute(char **args, char **port, int *sockfd) {
    int i = 0;
    while (args[i] != NULL) {
        printf("%s\n", args[i]);
        if (strcmp(args[i], "-h") == 0) {
            print_help();
            return 1;
        } else if (strcmp(args[i], "-quit") == 0) {
            if (*sockfd != -1) {
                close(*sockfd); // Close the socket if it's open
            }
            return 0;

        } else {
            if (strcmp(args[i], "-p") == 0) {
                if (args[i + 1] != NULL) {
                    char *new_port = realloc(*port, (strlen(args[i + 1]) + 1) * sizeof(char));
                    *port = new_port;
                    strcpy(*port, args[i + 1]);
                    if (*port == NULL) {
                        fprintf(stderr, "Memory allocation failed\n");
                        exit(EXIT_FAILURE);
                    } else {
                        if (*sockfd != -1) {
                            close(*sockfd); // Close the socket if it's open
                        }
                        *sockfd = connect_to_server(port);
                    }
                    return 1;
                } else {
                    fprintf(stderr, "Missing port number after -p option\n");
                    return 1; // Return 1 to continue loop even if port is missing
                }
            } else if (strcmp(args[i], "-send") == 0) {
                if (args[i + 1] != NULL) {
                    if (*sockfd != -1) {
                        char message[MAX_LINE_LENGTH] = "";
                        int j = i + 1;
                        while (args[j] != NULL) {
                            strcat(message, args[j]);
                            strcat(message, " ");
                            j++;
                        }
                        if (send_message(*sockfd, message) == -1) {
                            return 1; // Return 1 to continue loop on failure
                        }
                        return 1; // Return 1 to continue loop on success
                    } else {
                        fprintf(stderr, "No connection to server\n");
                        return 1; // Return 1 to continue loop
                    }
                } else {
                    fprintf(stderr, "Missing message to send after -send option\n");
                    return 1; // Return 1 to continue loop
                }
            }
        }
        i++;
    }
    return 1;
}

void client_side(char **port, int *sockfd) {
    char *line;
    char **args;
    int status;
    printf("PORT IS %s\n", *port);

    do {
        /* FOR LOOP TO READ LINE, SPLIT IT INTO ARGUMENTS AND PUT THEM IN LIST, EXECUTE THEM*/
        printf("> ");
        line = lsh_read_line();
        args = lsh_split_line(line);
        status = lsh_execute(args, port, sockfd);
        printf("PORT IS %s\n", *port);


        /* FREE MEMORY*/
        /*for (int i = 0; args[i] != NULL; i++) {
            free(args[i]);
        }*/
        free(line);
        free(args);
    } while (status);

    // Close the socket if it's open before exiting
    if (*sockfd != -1) {
        close(*sockfd);
    }
}