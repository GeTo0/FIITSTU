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
#include <signal.h>


#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024

char *custom_prompt = NULL; // Global variable to store the custom prompt

void create_prompt() {
    // ANSI escape code for setting text color to green
    printf("\033[0;32m");

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
    if (strcmp(new_prompt, "reset")==0) {
        custom_prompt = NULL;
    }
    else if(custom_prompt==NULL){
        custom_prompt = strdup(new_prompt);
    }
    else if(custom_prompt!=NULL){
        free(custom_prompt);
        custom_prompt=NULL;
        custom_prompt=strdup(new_prompt);
    }
}

char* help_message(){
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
     "<command> #<commentary>   Ability to write commentary\n"
     "<command>;<command>       More commands at once\n"
     "stat (only on server)     Prints all current connections\n"
     "--------------------------------------------\n"
     "External Commands:\n"
     "date                      Prints current date\n"
     "ls                        Prints files in dir\n"
     "cat <file>                Prints file content\n"
     "--------------------------------------------\n"
     "IMPORTANT:\n"
     "Don´t use command 'cd', as it would get us away from working dir, making program unusable\n"
     "Beware of spaces, as it matter where you put them\n"
     "Right command: cat subor.txt>output.txt\n"
     "Wrong command: cat subor.txt > output.txt\n"
     "Right use-cases are written above in this help message\n"
     "Test this command (./zadanie2 -c): 'port <port>;help;cat subor.txt>output.txt;help>help.txt;quit'\n"
    );
    return help_mes;
}

void send_halt_to_clients(int *active_clients, int *num_active_clients, int *halt_signal_sent, pthread_mutex_t *active_clients_mutex) {
    pthread_mutex_lock(active_clients_mutex);
    for (int i = 0; i < *num_active_clients; ++i) {
        send(active_clients[i], "halt", strlen("halt"), 0);
        close(active_clients[i]);
    }
    *num_active_clients = 0; // Reset the number of active clients
    *halt_signal_sent = 1;
    pthread_mutex_unlock(active_clients_mutex);
}

char **lsh_split_args(char *argument) {
    int bufsize = MAX_LINE_LENGTH, position = 0;
    char **subargs = malloc(bufsize * sizeof(char *));
    char *subarg;

    if (!subargs) {
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
    int k = 0;
    while (subargs[k] != NULL) {
        printf("%d %s\n", k, subargs[k]);
        k++;
    }
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

void remove_input_redirection(char *argument) {
    if (argument == NULL || argument[0] == '\0') {
        return; // Nothing to remove
    }

    // Find the position of the first non-whitespace character after '<'
    char *start = argument;
    while (*start != '\0' && isspace((unsigned char)*start)) {
        start++;
    }

    // Shift characters to the left to remove '<' and following whitespace
    size_t len = strlen(start);
    memmove(argument, start, len + 1); // Include null terminator
}
