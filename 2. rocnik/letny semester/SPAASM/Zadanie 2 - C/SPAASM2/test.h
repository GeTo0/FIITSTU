#ifndef TEST_H
#define TEST_H

#include <pthread.h>

struct Node {
    char *word;
    struct Node *next;
};

/*Client*/
int connect_to_server(char **port);
void client_side(char **port, int *sockfd);
char *lsh_read_line(void);
char **lsh_split_line(char *line);
int lsh_execute(char **args, char **port, int *sockfd);
int send_message(int sockfd, char *message);

/*Server*/
int connect_to_client(char **port);
void server_side(char **port, char *socket_path);
void *handle_client(void *arg);
char *arg_help();
void send_halt_to_clients(int *active_clients, int *num_active_clients, int *halt_signal_sent, pthread_mutex_t *active_clients_mutex);

/* Functions */
void create_prompt();
void set_custom_prompt(const char *new_prompt);
void print_help();
char* help_message();
char **lsh_split_args(char *argument);
void print_to_file(const char *output, const char *filename);

#endif /* TEST_H */