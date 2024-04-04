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

int main(int argc, char **argv) {
    char *port = NULL;
    char *mode = NULL;
    char *socket_path = NULL;
    int sockfd = -1;
    int i;

    for (i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-c") == 0) {
            mode = argv[i];
            if (argv[i + 1] != NULL) {
                if (strcmp(argv[i + 1], "-p") == 0) {
                    port = (char *) malloc((strlen(argv[i + 2]) + 1) * sizeof(char));
                    strcpy(port, argv[i + 2]);
                }
                if (port == NULL) {
                    fprintf(stderr, "Missing port argument (-p <port>)\n");
                    return EXIT_FAILURE;
                }
            }
        } else if (strcmp(argv[i], "-s") == 0) {
            mode = argv[i];
            if (strcmp(argv[i + 1], "-u") == 0) {
                strcpy(socket_path, argv[i + 2]);
            }
            if (strcmp(argv[i + 1], "-p") == 0) {
                port = (char *) malloc((strlen(argv[i + 2]) + 1) * sizeof(char));
                strcpy(port, argv[i + 2]);
            }
            if (socket_path == NULL && port == NULL) {
                fprintf(stderr, "Missing local socket path (-u <path>)\n");
                return EXIT_FAILURE;
            }
        }
        else if (strcmp(argv[i], "-h")==0){
            printf("%s", help_message());
            return 1;
        }
    }

    /*ERROR HANDLING*/
    if (mode == NULL) {
        fprintf(stderr, "Missing mode argument (-s for server, -c for client)\n");
        return EXIT_FAILURE;
    }


    /*DECIDE WHICH SIDE*/
    if (strcmp(mode, "-s") == 0) {
        server_side(&port, socket_path);
    } else if (strcmp(mode, "-c") == 0) {
        if (port != NULL){
            sockfd = connect_to_server(&port);
        }
        client_side(&port, &sockfd);
    }
    free(port);

    // Perform any shutdown/cleanup.

    return EXIT_SUCCESS;
}