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
#include <ctype.h>
#include <sys/wait.h>
#include <fcntl.h>

#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024

int halt_flag = 0;
pthread_t receive_thread;

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

void *check_halt(void *arg) {
    int sockfd = *((int *) arg);
    char buffer[MAX_LINE_LENGTH];
    ssize_t num_bytes;

    while ((num_bytes = recv(sockfd, buffer, sizeof(buffer), 0)) > 0) {
        buffer[num_bytes] = '\0';
        if (strcmp(buffer, "halt") == 0) {
            printf("\rReceived halt signal from server. Disconnecting from the server.\n");
            halt_flag = 1;
            close(sockfd);
            pthread_exit(NULL);
        } else {
            printf("%s\n", buffer);
        }
    }

    if (num_bytes == 0) {
        printf("Server closed the connection unexpectedly.\n");
    } else {
        perror("Receive failed");
    }

    close(sockfd);
    pthread_exit(NULL);
}

int send_message(int sockfd, char *message) {
    if (send(sockfd, message, strlen(message), 0) < 0) {
        perror("Send failed");
        return -1; // Return -1 on failure
    } else {
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
    char *token, *saveptr;

    if (!tokens) {
        fprintf(stderr, "lsh: allocation error\n");
        exit(EXIT_FAILURE);
    }

    // Split the line based on semicolon
    token = strtok_r(line, ";\n", &saveptr);
    while (token != NULL) {

        // Add the token to the list
        tokens[position] = token;
        position++;

        // Resize the buffer if necessary
        if (position >= bufsize) {
            bufsize += MAX_LINE_LENGTH;
            tokens = realloc(tokens, bufsize * sizeof(char *));
            if (!tokens) {
                fprintf(stderr, "lsh: allocation error\n");
                exit(EXIT_FAILURE);
            }
        }

        // Get the next token
        token = strtok_r(NULL, ";\n", &saveptr);
    }
    tokens[position] = NULL; // Null-terminate the list
    return tokens;
}

char **lsh_split_args(char *argument) {
    int bufsize = MAX_LINE_LENGTH, position = 0;
    char **subargs = malloc(bufsize * sizeof(char *));
    char *subarg;

    if (!subargs) {
        fprintf(stderr, "lsh: allocation error\n");
        exit(EXIT_FAILURE);
    }

    // Split the line based on semicolon
    subarg = strtok(argument, " \t\n");
    while (subarg != NULL) {
        // Add the token to the list
        subargs[position] = subarg;
        position++;

        // Resize the buffer if necessary
        if (position >= bufsize) {
            bufsize += MAX_LINE_LENGTH;
            subargs = realloc(subargs, bufsize * sizeof(char *));
            if (!subargs) {
                fprintf(stderr, "lsh: allocation error\n");
                exit(EXIT_FAILURE);
            }
        }

        // Get the next token
        subarg = strtok(NULL, " \t\n");
    }
    subargs[position] = NULL; // Null-terminate the list
    return subargs;
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
        char *output = malloc(MAX_LINE_LENGTH * sizeof(char));
        read(fd[0], output, MAX_LINE_LENGTH);

        return output;
    }

    return NULL;
}

void redirect_output(char *args) {
    char **subargs = lsh_split_args(args);
    int pos = 0;

    // Find the position of ">"
    while (subargs[pos] != NULL && strcmp(subargs[pos], ">") != 0) {
        pos++;
    }

    if (subargs[pos] != NULL) {
        // Check if ">" was found
        if (subargs[pos + 1] != NULL) {
            // Extract the output file name
            char *output_file = subargs[pos + 1];

            // Extract the command before ">"
            char *command_args[pos + 1];
            for (int i = 0; i < pos; i++) {
                command_args[i] = subargs[i];
            }
            command_args[pos] = NULL; // Null-terminate the command arguments

            // Execute the command
            char *output = lsh_execute_external(command_args);
            if (output != NULL) {
                // Write the output to the file
                FILE *file = fopen(output_file, "w");
                if (file == NULL) {
                    perror("Error opening file");
                } else {
                    fprintf(file, "%s", output);
                    fclose(file);
                }
                free(output);
            }
        } else {
            printf("Missing output file after \">\n");
        }
    } else {
        printf("No output redirection found\n");
    }

    // Free the memory allocated for subargs
    free(subargs);
}

int lsh_execute(char **args, char **port, int *sockfd) {
    int i = 0;
    while (args[i] != NULL) {
        if (strcmp(args[i], "quit") == 0) {
            if (*sockfd != -1) {
                close(*sockfd);
            }
            return 0;
        } else if (strcmp(args[i], "prompt") == 0) {
            if (args[i + 1] != NULL) {
                set_custom_prompt(args[i + 1]);
            } else {
                printf("Usage: prompt <custom_prompt>\n");
            }
        } else if (strcmp(args[i], "help") == 0) {
            if (*sockfd != -1) {
                char mess[MAX_LINE_LENGTH];
                strcpy(mess, args[i]);
                strcat(mess, " ");
                send_message(*sockfd, mess);
                char message[MAX_PROMPT_LENGTH];
                memset(message, 0, sizeof(message));
                ssize_t num_bytes = recv(*sockfd, message, sizeof(message), 0);
                if (num_bytes > 0) {
                    message[num_bytes] = '\0';
                    printf("%s\n", message);
                }
            } else {
                fprintf(stderr, "No connection to server\n");
                return 1;
            }
        } else if (strcmp(args[i], "fork") == 0) {
            pid_t pid = fork();
            if (pid == 0) {
                printf("This is the child process.\n");
                exit(EXIT_SUCCESS);
            } else if (pid > 0) {
                printf("This is the parent process.\n");
            } else {
                perror("lsh");
            }
        } else if (strstr(args[i], "-p") != NULL) {
            char **subargs = lsh_split_args(args[i]);
            int j = 0;
            while (subargs[j] != NULL) {
                if (strcmp(subargs[j], "-p") == 0) {
                    if (subargs[j + 1] != NULL) {
                        char *new_port = realloc(*port, (strlen(subargs[j + 1]) + 1) * sizeof(char));
                        if (new_port == NULL) {
                            fprintf(stderr, "Memory allocation failed\n");
                            exit(EXIT_FAILURE);
                        }
                        *port = new_port;
                        strcpy(*port, subargs[j + 1]);
                        if (*sockfd != -1) {
                            close(*sockfd);
                        }
                        *sockfd = connect_to_server(port);
                    } else {
                        fprintf(stderr, "Missing port number after -p option\n");
                        return 1;
                    }
                }
                j++;
            }
            free(subargs);
        } else {
            //send_message(*sockfd, args[i]);
            if (strstr(args[i], ">")!= NULL){
                redirect_output(args[i]);
            }
            else{
                // Execute the command with its arguments (Nechat tu len send_message a ostatne parsovat az na serveri)!!!!!//
                char **cmd_args = lsh_split_args(args[i]);
                char *output = lsh_execute_external(cmd_args);
                if (output != NULL) {
                    // Print the command's output to the console
                    printf("%s\n", output);
                    free(output);
                }
                free(cmd_args);
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
    // Create a buffer for receiving messages from the server
    char buffer[MAX_LINE_LENGTH];

    // Create and initialize a pthread attribute object
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    if ((*sockfd)!=-1) pthread_create(&receive_thread, &attr, check_halt, (void *) sockfd);

    do {
        // Read user input
        create_prompt();
        line = lsh_read_line();
        if (halt_flag) {
            break;
        }
        args = lsh_split_line(line);

        // Execute user command
        status = lsh_execute(args, port, sockfd);

        // Check if sockfd has been updated in lsh_execute
        if (*sockfd != -1 && pthread_equal(receive_thread, pthread_self()) == 0) {
            // If sockfd is not -1 and the current thread is not the receive thread,
            // create the receive thread.
            pthread_create(&receive_thread, &attr, check_halt, (void *) sockfd);
        }

        // Free allocated memory
        free(line);
        free(args);

        // Check if halt signal received from server
    } while (status);

    // Wait for the receive thread to finish
    pthread_join(receive_thread, NULL);

    // Destroy the pthread attribute object
    pthread_attr_destroy(&attr);

    // Close the socket if it's open before exiting
    if (*sockfd != -1) {
        close(*sockfd);
    }
}