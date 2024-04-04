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
        printf("\n%s", custom_prompt);
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

void print_help() {
    printf("Author: Dominik Zaťovič\n");
    printf("Subject: SPAASM, 2. Assignment\n");
    printf("Usage: ./zadanie2 [-s | -c] [-p port | -u socket_path]\n");
    printf("Usage Client: [-h | -quit]\n");
    printf("Options:\n");
    printf("  -h                Display this help message\n");
    printf("  -s                Run as server\n");
    printf("  -c                Run as client\n");
    printf("  -p port           Specify port number");
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

