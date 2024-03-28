#ifndef TEST_H
#define TEST_H

/*Client*/
int connect_to_server(char **port);
char *lsh_read_line(void);
char **lsh_split_line(char *line);
int lsh_execute(char **args, char **port, int *sockfd);
void client_side(char **port);

/*Server*/
int connect_to_client(char **port);
int send_message(int sockfd, char *message);
void server_side(char **port, char *socket_path);

/* Functions */
void create_prompt();
void print_help();

#endif /* TEST_H */