#include "common.h"


int main(int argc, char **argv) {
    char *port = NULL;
    char *mode = NULL;
    int sockfd = -1;
    int i;

    for (i = 1; i < argc; i++) {//for loop to iterate through arguments
        if (strcmp(argv[i], "-c") == 0) {
            mode = argv[i]; //set mode to client
            if (argv[i + 1] != NULL) {
                if (strcmp(argv[i + 1], "-p") == 0) { //if port argument is present and port number as well, set port
                    port = (char *) malloc((strlen(argv[i + 2]) + 1) * sizeof(char));
                    strcpy(port, argv[i + 2]);
                }
                if (port == NULL) {//if port argument is present but port is missing, print error
                    fprintf(stderr, "Missing port argument (-p <port>)\n");
                    return EXIT_FAILURE;
                }
            }
        } else if (strcmp(argv[i], "-s") == 0) {
            mode = argv[i];//set mode to server
            if (strcmp(argv[i + 1], "-p") == 0) {//if port argument is present and port number as well, set port
                port = (char *) malloc((strlen(argv[i + 2]) + 1) * sizeof(char));
                strcpy(port, argv[i + 2]);
            }
        } else if (strcmp(argv[i], "-h") == 0) {//if argument is h, print help message
            printf("%s", help_message());
            return 1;
        }
    }

    //Decide which function to enter based on mode (server/client)
    if (mode == NULL) {
        client_side(&port, &sockfd);
    } else if (strcmp(mode, "-s") == 0) {
        server_side(&port);
    } else if (strcmp(mode, "-c") == 0) {
        if (port != NULL) {
            sockfd = connect_to_server(&port);
        }
        client_side(&port, &sockfd);
    }
    free(port); //free dynamically allocated memory

    return EXIT_SUCCESS;
}