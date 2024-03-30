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


#define MAX_LINE_LENGTH 100
#define MAX_PROMPT_LENGTH 1024

void create_prompt() {
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    char hostname[256];
    gethostname(hostname, sizeof(hostname));
    uid_t uid = getuid();
    struct passwd *pw = getpwuid(uid);
    printf("%02d:%02d %s@%s>\n",tm.tm_hour, tm.tm_min, pw->pw_name,hostname);
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
    printf("  -p port           Specify port number\n");
}

char *arg_help(){
    char *help_message="Author: Dominik Zaťovič\n"
                       "Subject: SPAASM, 2. Assignment\n"
                       "Usage: ./zadanie2 [-s | -c] [-p port | -u socket_path]\n"
                       "Usage Client: [-h | -quit]\n"
                       "Options:\n"
                       "  -h                Display this help message\n"
                       "  -s                Run as server\n"
                       "  -c                Run as client\n"
                       "  -p port           Specify port number\n";
    return help_message;
}

