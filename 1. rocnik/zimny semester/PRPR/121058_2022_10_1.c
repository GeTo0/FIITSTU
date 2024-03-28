#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NAZOV_D 15
#define VYROBCA_D 20
#define KUSY_D 10
#define CENA_D 10

typedef struct zaznam {
    char nazov[NAZOV_D];
    char vyrobca[VYROBCA_D];
    char kusy[KUSY_D];
    char cena[CENA_D];
    struct zaznam *p_dalsi;
} ZAZNAM;

int main() {
    char znak[1];
    int total = 0, pravdivost = 1;
    ZAZNAM *prvy;
    ZAZNAM *dalsi = NULL;
    ZAZNAM *docasny = NULL;
    ZAZNAM *teraz = NULL;
    prvy = malloc(sizeof(ZAZNAM));
    while (pravdivost == 1) {
        fgets(znak, 3, stdin);
        switch (znak[0]) {
            case 'a': {
                if (total == 0) {
                    for (int counter = 0; counter < 5; counter++) {
                        if (counter == 0) fgets(prvy->nazov, NAZOV_D, stdin);
                        else if (counter == 1) fgets(prvy->vyrobca, VYROBCA_D, stdin);
                        else if (counter == 2) fgets(prvy->kusy, KUSY_D, stdin);
                        else if (counter == 3) fgets(prvy->cena, CENA_D, stdin);
                        else if (counter == 4) {
                            dalsi = malloc(sizeof(ZAZNAM));
                            prvy->p_dalsi = dalsi;
                            total++;
                            docasny = prvy;
                        }
                    }
                } else {
                    teraz = docasny->p_dalsi;
                    for (int counter = 0; counter < 5; counter++) {
                        if (counter == 0) fgets(teraz->nazov, NAZOV_D, stdin);
                        else if (counter == 1) fgets(teraz->vyrobca, VYROBCA_D, stdin);
                        else if (counter == 2) fgets(teraz->kusy, KUSY_D, stdin);
                        else if (counter == 3) fgets(teraz->cena, CENA_D, stdin);
                        else if (counter == 4) {
                            dalsi = malloc(sizeof(ZAZNAM));
                            teraz->p_dalsi = dalsi;
                        }
                    }
                    docasny = teraz;
                    total++;
                }
                printf("Nacitane\n");
                break;
            }
            case 'v': {
                teraz = prvy;
                dalsi = NULL;
                if (total > 0) {
                    for (int i = 0; i < total; i++) {
                        printf("%d.\n",(i+1));
                        printf("%s", teraz->nazov);
                        printf("%s", teraz->vyrobca);
                        printf("%s", teraz->kusy);
                        printf("%s\n", teraz->cena);
                        teraz = teraz->p_dalsi;
                    }
                }
                break;
            }
            case 'k':
                pravdivost = 0;
                break;
        }
    }

    return 0;
}
