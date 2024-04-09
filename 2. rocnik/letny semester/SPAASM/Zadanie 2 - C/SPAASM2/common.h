#ifndef COMMON_H
#define COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <ctype.h>
#include <signal.h>
#include <fcntl.h>
#include <time.h>
#include <pwd.h>
#include <stdbool.h>

#define MAX_PROMPT_LENGTH 1024
#define MAX_LINE_LENGTH 1024
#define MAX_CLIENTS 10
#define INACTIVE_TIMEOUT 60

/*MAIN*/
int connect_to_server(char **port);
void client_side(char **port, int *sockfd);
void server_side(char **port);

/* Functions */
void create_prompt();
void set_custom_prompt(const char *new_prompt);
char* useful_commands();
char* help_message();
void send_halt_to_clients(int *active_clients, int *num_active_clients, int *halt_signal_sent, pthread_mutex_t *active_clients_mutex);
char **lsh_split_args(char *argument);
void print_to_file(const char *output, const char *filename);
time_t current_timestamp();
size_t array_length(char **array);

#endif /* COMMON_H */