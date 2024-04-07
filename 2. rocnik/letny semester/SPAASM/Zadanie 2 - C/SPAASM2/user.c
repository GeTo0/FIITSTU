#include "test.h"

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
        return 0; // Return 0 on success
    }
}

char *read_command_from_file(char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return NULL;
    }

    char *buffer = NULL;
    size_t buffer_size = 0;
    ssize_t bytes_read;

    // Read the contents of the file into buffer
    bytes_read = getline(&buffer, &buffer_size, file);

    fclose(file);

    if (bytes_read == -1) {
        if (feof(file)) {
            // End of file reached
            printf("End of file reached\n");
        } else {
            perror("Error reading from file");
        }
        free(buffer);
        return NULL;
    }

    // Trim newline character
    if (bytes_read > 0 && buffer[bytes_read - 1] == '\n') {
        buffer[bytes_read - 1] = '\0';
    }

    return buffer;
}

char *hashtag_argument(char *token) {
    // Find the position of #
    char *hash_pos = strchr(token, '#');
    if (hash_pos != NULL) {
        // Calculate the length of the token before #
        int length_before_hash = hash_pos - token;

        // Allocate memory for the processed token
        char *processed_token = malloc((length_before_hash + 1) * sizeof(char));
        if (processed_token == NULL) {
            fprintf(stderr, "Memory allocation error\n");
            exit(EXIT_FAILURE);
        }

        // Copy characters before # to the processed token
        strncpy(processed_token, token, length_before_hash);
        processed_token[length_before_hash] = '\0'; // Null-terminate the processed token

        // Trim trailing whitespace from the processed token
        char *end = processed_token + length_before_hash - 1;
        while (end > processed_token && isspace(*end)) {
            *end-- = '\0';
        }

        return processed_token;
    }

    // If # is not found, return NULL
    return NULL;
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

    // Split the line based on semicolon
    token = strtok(line, ";\n");
    while (token != NULL) {
        //Check if contains #//
        char *hash_pos = strchr(token, '#');
        if (hash_pos != NULL) {
            char *processed_token = hashtag_argument(token);
            if (processed_token != NULL) {
                // Add the processed token to the list
                tokens[position] = processed_token;
                position++;
            }
        } else {
            // Add the token to the list
            tokens[position] = token;
            position++;
        }
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
        token = strtok(NULL, ";\n");
    }
    tokens[position] = NULL; // Null-terminate the list
    return tokens;
}

int lsh_execute(char **args, char **port, int *sockfd) {
    int i = 0;
    while (args[i] != NULL) {
        if (strstr(args[i], "<") != NULL) {
            char *filename = strtok(args[i], "<");
            remove_input_redirection(args[i]);
            char *end = filename + strlen(filename) - 1;
            while (end > filename && isspace((unsigned char) *end)) end--;
            *(end + 1) = '\0';
            char *line = read_command_from_file(filename);
            if (line != NULL) {
                char **arguments = lsh_split_line(line);
                lsh_execute(arguments, port, sockfd);
                while (arguments[i] != NULL) {
                    if (strcmp(arguments[i], "quit") == 0) {
                        return 0;
                    }
                    i++;
                }
            }
        } else if (strcmp(args[i], "quit") == 0) {
            if (*sockfd != -1) {
                close(*sockfd);
            }
            return 0;
        } else if (strcmp(args[i], "help") == 0) {
            printf("%s", help_message());
        } else if (strstr(args[i], "prompt") != NULL) {
            char **subargs = lsh_split_args(args[i]);
            int j = 0;
            if ((strcmp(subargs[j], "prompt") == 0) && (subargs[j + 1] != NULL)) {
                set_custom_prompt(subargs[j + 1]);
            } else {
                printf("Usage: prompt <custom_prompt>\n");
            }
        } else if (strstr(args[i], "port") != NULL) {
            char **subargs = lsh_split_args(args[i]);
            int j = 0;
            while (subargs[j] != NULL) {
                if (strcmp(subargs[j], "port") == 0) {
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
                        fprintf(stderr, "Missing port number after port option\n");
                        return 1;
                    }
                }
                j++;
            }
            free(subargs);
        } else {
            if (*sockfd != -1) {
                char mess[MAX_LINE_LENGTH];
                strcpy(mess, args[i]);
                send_message(*sockfd, mess);
                char message[MAX_PROMPT_LENGTH];
                memset(message, 0, sizeof(message));
                ssize_t num_bytes = recv(*sockfd, message, sizeof(message), 0);
                if (num_bytes > 2) {
                    message[num_bytes] = '\0';
                    printf("%s\n", message);
                }
            } else {
                printf("No connection to the server");
                return 1;
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

    do {
        // Read user input
        create_prompt();
        line = lsh_read_line();

        if (*sockfd != -1) {
            ssize_t num_bytes = recv(*sockfd, buffer, sizeof(buffer), MSG_DONTWAIT);
            if (num_bytes > 0) {
                buffer[num_bytes] = '\0';
                if (strcmp(buffer, "halt") == 0) {
                    printf("\rReceived halt signal from server. Disconnecting from the server.\n");
                    break;
                }
            }
        }
        args = lsh_split_line(line);

        // Execute user command
        status = lsh_execute(args, port, sockfd);

        // Free allocated memory
        free(line);
        free(args);

        // Check if halt signal received from server
    } while (status);

    // Close the socket if it's open before exiting
    if (*sockfd != -1) {
        close(*sockfd);
    }
}