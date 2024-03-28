#ifndef TEST_H
#define TEST_H

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

/* Functions */
void create_prompt();
void print_help();

#endif /* TEST_H */