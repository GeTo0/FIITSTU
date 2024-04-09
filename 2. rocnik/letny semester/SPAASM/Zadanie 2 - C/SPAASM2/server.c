#include "common.h"


pthread_mutex_t active_clients_mutex = PTHREAD_MUTEX_INITIALIZER;

typedef struct {
    int client_socket;
    char **port;
    int user_number;
} ClientData;

typedef struct {
    int client_socket;
    char client_address[INET_ADDRSTRLEN]; // Store client address
    int client_port; // Store client port
    int user_number; // Store user number
    time_t last_activity_time;
} ClientInfo;

typedef struct {
    char *command;
    char *output_file;
} RedirectArgs;

typedef struct {
    char *command1;
    char *command2;
} RedirectInputArgs;


int active_clients[MAX_CLIENTS];
int num_active_clients = 0;
int halt_signal_sent = 0;
int next_user_number = 1; // Initial user number

ClientInfo active_connections[MAX_CLIENTS];
pthread_t server_thread;

void send_halt_to_client(int client_socket) {
    // Send "halt" message to the client socket
    send(client_socket, "halt", strlen("halt"), 0);
}

void check_inactive_clients() {
    //Function to check if any client is inactivte for longer than they should, if so, disconnect them
    while (!halt_signal_sent) {
        // Sleep for 1 second
        sleep(1);

        // Get the current timestamp
        time_t current_time = current_timestamp();

        pthread_mutex_lock(&active_clients_mutex);
        for (int i = 0; i < num_active_clients; ++i) {
            // Calculate time difference in seconds
            time_t time_diff = current_time - active_connections[i].last_activity_time;

            // Check if the client is inactive for more than 1 minute
            if (time_diff >= INACTIVE_TIMEOUT) {
                // Send halt signal to the client
                send_halt_to_client(active_clients[i]);
                printf("User %d was disconnected due to inactivity\n", active_connections[i].user_number);

                // Remove the client from the list of active clients
                // Shift remaining elements to the left
                for (int j = i; j < num_active_clients - 1; ++j) {
                    active_clients[j] = active_clients[j + 1];
                    active_connections[j] = active_connections[j + 1];
                }
                num_active_clients--;
            }
        }
        pthread_mutex_unlock(&active_clients_mutex);
    }
}

void handle_interrupt(int signum) {
    //Handle that CTRL+C is treated as sending "halt"
    if (signum == SIGINT) {
        send_halt_to_clients(active_clients, &num_active_clients, &halt_signal_sent, &active_clients_mutex);
        printf("Sent halt command to all clients.\n");
        exit(EXIT_SUCCESS); // Exit the program after sending halt command
    }
}

void stat_argument() {
    //print statistics for each connected client
    printf("Active Connections:\n");
    for (int i = 0; i < num_active_clients; i++) {
        printf("User %d: Socket: %d, IP: %s, Port: %d\n",
               active_connections[i].user_number,
               active_connections[i].client_socket,
               active_connections[i].client_address,
               active_connections[i].client_port);
    }
}

void *server_task(void *arg) {
    // Thread for server, good for sending commands such as halt or stat
    while (1) {
        char command[MAX_LINE_LENGTH];
        fgets(command, sizeof(command), stdin);
        command[strcspn(command, "\n")] = '\0'; // Remove newline character
        if (strcmp(command, "halt") == 0) {
            send_halt_to_clients(active_clients, &num_active_clients, &halt_signal_sent, &active_clients_mutex);
            printf("Sent halt command to all clients.\n");
            break;
        }
        else if(strcmp(command, "stat")==0){
            stat_argument();
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
    //Function to run bash built-in commands
    pid_t pid;
    int fd[2];
    pipe(fd);

    pid = fork();
    if (pid == 0) {
        // Child process
        dup2(fd[1], STDOUT_FILENO); // Redirect stdout to the pipe
        dup2(fd[1], STDERR_FILENO); // Redirect stderr to the pipe
        close(fd[0]); // Close the read end of the pipe

        // Execute the command
        if (execvp(args[0], args) == -1) {
            perror("Execution failed");
            exit(EXIT_FAILURE);
        }
    } else if (pid < 0) {
        perror("Fork failed");
        exit(EXIT_FAILURE);
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

RedirectInputArgs redirect_input_argument(char *arg){
    RedirectInputArgs args;

    // Initialize the fields to NULL
    args.command1 = NULL;
    args.command2 = NULL;

    // Find the position of '>'
    char *pos = strchr(arg, '<');
    if (pos == NULL) {
        // No output redirection, set command only
        args.command1 = strdup(arg);
    } else {
        // Output redirection found, split the argument
        *pos = '\0'; // Null-terminate the command
        args.command1 = strdup(arg);
        args.command2 = strdup(pos + 1); // Set the output file
    }

    // Trim leading and trailing whitespace from filenames
    if (args.command1 != NULL) {
        while (*args.command1 && isspace(*args.command1)) {
            args.command1++;
        }
        char *end = args.command1 + strlen(args.command1) - 1;
        while (end > args.command1 && isspace(*end)) {
            *end-- = '\0';
        }
    }
    if (args.command2 != NULL) {
        while (*args.command2 && isspace(*args.command2)) {
            args.command2++;
        }
        char *end = args.command2 + strlen(args.command2) - 1;
        while (end > args.command2 && isspace(*end)) {
            *end-- = '\0';
        }
    }

    return args;
}

void handle_arguments(char *argument, int client_socket) {
    //Function to check for different characters in argument sent by client
    if (strstr(argument, ">") != NULL) { //redirection output argument is present
        RedirectArgs args = redirect_argument(argument); //retrieve arguments from function, in type of struct
        if (strcmp(args.command, "help") == 0) {//special case if command is help
            print_to_file(help_message(), args.output_file);
        } else {//any other command
            char **command = lsh_split_args(args.command);//split argument based on spaces and append into array
            char *output = lsh_execute_external(command); //send array to function to get output
            print_to_file(output, args.output_file); //print output to file
            free(output); //free dynamically allocated memory
            free(command);
        }
        send(client_socket, "1", 2, 0); //send to client that all is done and he can continue
    } else if(strstr(argument, "<")!= NULL){//redirection input argument is present
        RedirectInputArgs args = redirect_input_argument(argument); //retrieve arguments from function, in type of struct
        char **command1 = lsh_split_args(args.command1); //anything before < is command 1
        char **command2 = lsh_split_args(args.command2); //anything after > is command 2
        char **command = malloc((MAX_LINE_LENGTH + 1) * sizeof(char *));//represents final command
        char filename[] = "/tmp/tempfileXXXXXX"; //name for temporary file if needed

        int temp_created=0; //flag is temp file was needed
        int k=0;
        while (command1[k] != NULL) {//copy command1 to command
            command[k] = strdup(command1[k]);
            k++;
        }
        if(array_length(command2)==1 && strstr(command2[0], ".txt")!= NULL){
            //special case where after < is only name of file from which to redirect input
            command[k]=command2[0];
        }
        else{
            // Create a temporary file, write output of command2 in it, and send file to command
            temp_created=1;
            int temp_fd = mkstemp(filename); // Create the temporary file
            if (strcmp(args.command2, "help") == 0) { // special case where after < is only "help"
                print_to_file(help_message(),filename);
            }
            else{ //if command2 is bash command
            char *output2 = lsh_execute_external(command2); //execute command2
            if (output2 != NULL) {//if theres any output present
                print_to_file(output2, filename); //print output to temporary file
                free(output2);//free memory
            }
            command[k]=strdup(filename); //append name of file into final command
            }
        }
        command[k+1]= NULL; //Null-terminate the final command at the end
        char *output = lsh_execute_external(command);//send final command to function and get final output
        send(client_socket, output, strlen(output), 0); //send final output to client
        if(temp_created) unlink(filename); //if temp file was created, delete it
        free(output); //free any dynamically allocated memory
        free(command);
        free(command1);
        free(command2);
    } else {//no special character present
        char **command = lsh_split_args(argument); //split argument based on spaces and get array of commands
        char *output = lsh_execute_external(command); //get output by sending command to function
        if (output != NULL) {
            send(client_socket, output, strlen(output), 0); //send output to client
            free(output); //free memory
        } else {
            send(client_socket, "Wrong command", strlen("Wrong command"), 0); //if wrong command
        }
    }
}

void *handle_client(void *arg) {//function to handle each client separately
    ClientData *data = (ClientData *) arg; //get data for client
    int client_socket = data->client_socket; //assign socket
    char **port = data->port; //assign port
    int user_number = data->user_number; // Assign user number from data

    struct sockaddr_in client_addr;
    //Functions to get user IP in user-readable data
    socklen_t client_addr_len = sizeof(client_addr);
    getpeername(client_socket, (struct sockaddr *) &client_addr, &client_addr_len);
    char client_ip[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &client_addr.sin_addr, client_ip, INET_ADDRSTRLEN);
    //

    pthread_mutex_lock(&active_clients_mutex);
    //Assign information to each client
    active_connections[num_active_clients].client_socket = client_socket;  //Socket
    strncpy(active_connections[num_active_clients].client_address, client_ip, INET_ADDRSTRLEN); //Address
    active_connections[num_active_clients].client_port = ntohs(client_addr.sin_port); //Port
    active_connections[num_active_clients].user_number = user_number; //Number
    active_connections[num_active_clients].last_activity_time = current_timestamp(); //Last activity time

    active_clients[num_active_clients++] = client_socket;
    pthread_mutex_unlock(&active_clients_mutex);

    char buffer[MAX_LINE_LENGTH];
    time_t last_activity_time = current_timestamp();
    // Print user connected message
    printf("User %d connected.\n", user_number);

    // Receive messages from the client
    while (!halt_signal_sent) {
        ssize_t num_bytes = recv(client_socket, buffer, sizeof(buffer), 0);
        if (num_bytes < 0) {
            perror("Receive failed");
            break;
        } else if (num_bytes == 0) {
            // Connection closed by client
            printf("User %d disconnected\n", user_number);
            // Close the connection with the client
            close(client_socket);
            break;
        } else {
            // Null-terminate the received data to treat it as a string
            buffer[num_bytes] = '\0';
            active_connections[num_active_clients - 1].last_activity_time = current_timestamp();

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

    if (num_active_clients == 0)  {//No active clients left
        printf("All clients disconnected. Exiting server.\n");
        pthread_cancel(server_thread); // Cancel the server thread
        exit(EXIT_SUCCESS);
    }
    return NULL;
}

void server_side(char **port) {
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

    // Create a thread to check inactive clients
    pthread_t inactive_clients_thread;
    if (pthread_create(&inactive_clients_thread, NULL, (void *(*)(void *)) check_inactive_clients, NULL) != 0) {
        perror("Failed to create thread for checking inactive clients");
        exit(EXIT_FAILURE);
    }

    // Accept incoming connections and handle them in separate threads
    while (1) {
        int client_socket;
        if ((client_socket = accept(server_fd, (struct sockaddr *) &address, (socklen_t * ) & addrlen)) < 0) {
            perror("Connection failed");
            continue;
        }

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
        data->user_number = next_user_number++; // Assign user number and increment for next user

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
