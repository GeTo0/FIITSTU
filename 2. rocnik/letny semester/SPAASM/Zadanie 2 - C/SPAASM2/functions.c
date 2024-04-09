#include "common.h"

char *custom_prompt = NULL; // Global variable to store the custom prompt

void create_prompt() {
    // ANSI escape code for setting text color to green
    printf("\033[0;32m");

    //Get information for default prompt
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    char hostname[256];
    gethostname(hostname, sizeof(hostname));
    uid_t uid = getuid();
    struct passwd *pw = getpwuid(uid);

    if (custom_prompt != NULL) {
        // If custom_prompt is set, use it
        printf("%s", custom_prompt);
    } else {
        // Otherwise, use the default prompt
        printf("\n%02d:%02d %s@%s>", tm.tm_hour, tm.tm_min, pw->pw_name, hostname);
    }

    // ANSI escape code for resetting text color to default
    printf("\033[0m");
}

void set_custom_prompt(const char *new_prompt) {
    if (strcmp(new_prompt, "reset")==0) { //if argument after prompt is reset, reset to default
        custom_prompt = NULL;
    }
    else if(custom_prompt==NULL){ //else set custom prompt
        custom_prompt = strdup(new_prompt);
    }
    else if(custom_prompt!=NULL){ //if custom prompt is present, remove it and set new
        free(custom_prompt);
        custom_prompt=NULL;
        custom_prompt=strdup(new_prompt);
    }
}

char* useful_commands(){
    //Prints message of useful commands to test in my program
    char *com_mes = ("Here are commands you can try running in my program to test all use-cases\n"
                     "cat subor.txt\n"
                     "cat subor.txt>temp.txt\n"
                     "help\n"
                     "help>temp.txt\n"
                     "wc -l subor.txt\n"
                     "wc -l < subor.txt\n"
                     "cat < subor.txt\n"
                     "help;cat subor.txt;date;quit\n"
                     "!commands.txt\n"
                     "help#print help;date #date\n"
                     "stat (only on server side)\n"
                     "halt (only on server side)\n"
                     "Try being inactive on client side for 60 seconds, it will disconnect you\n"
                     "port 50000;help;help>temp.txt#prints help to file;date;wc -l subor.txt > temp.txt;quit\n"
            );
    return com_mes;
}

char* help_message(){
    //Prints help message that contains basic information about the program
    char* help_mes= ("Author: Dominik Zaťovič\n"
     "Subject: SPAASM, 2. Assignment\n"
     "Compile: gcc -o zadanie2 main.c user.c server.c functions.c"
     "Help message: ./zadanie2 -h\n"
     "Start as Server: ./zadanie2 -s -p <port>\n"
     "Start as Client: ./zadanie2 -c [-p <port>]\n"
     "--------------------------------------------\n"
     "Internal Commands:\n"
     "help                      Display this help message\n"
     "port <port>               Connect to new port\n"
     "quit                      Terminate client side program\n"
     "halt                      Terminate server side program\n"
     "prompt [<prompt> | reset] Create custom prompt/reset to default\n"
     "<command> > <file>        Redirect output to file\n"
     "<command> < <file>        Redirect input from file into command\n"
     "<command> #<commentary>   Ability to write commentary\n"
     "<command>;<command>       More commands at once\n"
     "!commands.txt             Run commands from file called commands.txt (you can rename it)\n"
     "stat (only on server)     Prints all current connections\n"
     "--------------------------------------------\n"
     "External Commands:\n"
     "date                      Prints current date\n"
     "ls                        Prints files in dir\n"
     "cat <file>                Prints file content\n"
     "--------------------------------------------\n"
     "IMPORTANT:\n"
     "You are unfortunately unable to use # in prompt. You can use it, but it wont display correctly\n"
     "Don´t use command 'cd', as it would get us away from working dir, making program unusable\n"
     "Beware of spaces, as it matter where you put them\n"
     "Right command: cat subor.txt>output.txt\n"
     "Wrong command: cat subor.txt > output.txt\n"
     "Right use-cases are written above in this help message\n"
     "To list useful commands to try do '-commands'\n"
    );
    return help_mes;
}

void send_halt_to_clients(int *active_clients, int *num_active_clients, int *halt_signal_sent, pthread_mutex_t *active_clients_mutex) {
    //Iterates through all clients
    pthread_mutex_lock(active_clients_mutex);
    for (int i = 0; i < *num_active_clients; ++i) {
        send(active_clients[i], "halt", strlen("halt"), 0); //sends halt to client
        close(active_clients[i]); //closes connection with client
    }
    *num_active_clients = 0; // Reset the number of active clients
    *halt_signal_sent = 1; //Set flag to 1
    pthread_mutex_unlock(active_clients_mutex);
}

char **lsh_split_args(char *argument) {
    //Function to split arguments based on space character
    int bufsize = MAX_LINE_LENGTH, position = 0;
    char **subargs = malloc(bufsize * sizeof(char *));
    char *subarg;

    if (!subargs) { //failed to allocate memory
        fprintf(stderr, "lsh: allocation error\n");
        exit(EXIT_FAILURE);
    }

    while (*argument != '\0') {
        // Skip leading spaces
        while (*argument == ' ' || *argument == '\t' || *argument == '\n')
            argument++;

        if (*argument == '\0')
            break;

        // Check if the token starts with a quote
        if (*argument == '"') {
            // Move to the next character (after the opening quote)
            argument++;
            subarg = argument;
            // Find the closing quote
            argument = strchr(argument, '"');
            if (!argument) {
                fprintf(stderr, "lsh: unterminated quoted string\n");
                exit(EXIT_FAILURE);
            }
            // Null-terminate the quoted string
            *argument = '\0';
            // Add the token to the list
            subargs[position++] = subarg;
            // Move to the next character (after the closing quote)
            argument++;
        } else {
            // Find the next space or end of string
            subarg = argument;
            while (*argument != ' ' && *argument != '\t' && *argument != '\n' && *argument != '\0')
                argument++;
            // Null-terminate the token
            if (*argument != '\0') {
                *argument = '\0';
                argument++;
            }
            // Add the token to the list
            subargs[position++] = subarg;
        }

        // Resize the buffer if necessary
        if (position >= bufsize) {
            bufsize += MAX_LINE_LENGTH;
            subargs = realloc(subargs, bufsize * sizeof(char *));
            if (!subargs) {
                fprintf(stderr, "lsh: allocation error\n");
                exit(EXIT_FAILURE);
            }
        }
    }
    subargs[position] = NULL; // Null-terminate the list

    return subargs;
}

void print_to_file(const char *output, const char *filename) {
    FILE *file = fopen(filename, "w"); // Open the file for writing
    if (file == NULL) {
        perror("Error opening file");
        return;
    }

    // Write the output to the file
    fprintf(file, "%s", output);

    fclose(file); // Close the file
}

time_t current_timestamp() {
    //function to get current time
    return time(NULL);
}

size_t array_length(char **array) {
    //Function to find the length of an array
    size_t length = 0;
    while (array[length] != NULL) {
        length++;
    }
    return length;
}