#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define RC_D 15
#define MENO_D 20
#define MODUL_D 5
#define VELICINA_D 5
#define HODNOTA_D 12
#define CAS_D 6
#define DATUM_D 10

typedef struct zaznam {
    char rc[RC_D];
    char meno[MENO_D];
    char modul[MODUL_D];
    char velicina[VELICINA_D];
    char hodnota[HODNOTA_D];
    char cas[CAS_D];
    char datum[DATUM_D];
    struct zaznam *p_dalsi;
} ZAZNAM;

void dealloc(ZAZNAM ***prvy, int **total) {
    ZAZNAM *teraz = **prvy;     /*novy struct ktory sa rovna prvemu structu*/
    ZAZNAM *dalsi = NULL;
    for (int i = 0; i < **total; i++) {
        dalsi = teraz->p_dalsi;  /*do hodnoty dalsi dam pointer na dalsiu struct*/
        free(teraz);     /*dealokujem terajsi struct*/
        teraz = dalsi;            /*nastavenie pointeru na dalsiu hodnotu*/
    }
}

void k_funkcia(ZAZNAM **prvy, int *total) {
    ZAZNAM *teraz = *prvy;
    ZAZNAM *dalsi = NULL;
    for (int i = 0; i < *total; i++) {
        dalsi = teraz->p_dalsi;
        free(teraz);
        teraz = dalsi;
    }
}

void n_funkcia(FILE **f, ZAZNAM **prvy, int *total, int *n_was_open) {
    char znak2, nicota[5];
    if (*f == NULL) {
        *f = fopen("dataloger_V2.txt", "r");
    }
    if (*f == NULL) {
        printf("Zaznamy neboli nacitane\n");
    } else {
        *total = 1;
        while ((znak2 = fgetc(*f)) !=
               EOF) {                                   /*while zistuje, kolko riadkov sa nachádza v súbore pomocou zistonavania počtu znakov konca riadku*/
            if (znak2 == '\n') *total += 1;
        }
        *total = *total / 8;
        rewind(*f);
        if (*n_was_open == 1) {
            dealloc(&prvy, &total);
        }
        *prvy = malloc(sizeof(ZAZNAM));
        ZAZNAM *teraz = *prvy;
        ZAZNAM *dalsi = NULL;

        for (int n = 0; n < *total; n++) {
            for (int counter = 0; counter < 8; counter++) {
                if (counter == 0) fgets(nicota, 5, *f);   /*$$$*/
                else if (counter == 1) fgets(teraz->rc, RC_D, *f);   /*RC*/
                else if (counter == 2) fgets(teraz->meno, MENO_D, *f);   /*meno*/
                else if (counter == 3) fgets(teraz->modul, MODUL_D, *f);   /*modul*/
                else if (counter == 4) fgets(teraz->velicina, VELICINA_D, *f);   /*velicina*/
                else if (counter == 5) fgets(teraz->hodnota, HODNOTA_D, *f);   /*hodnota*/
                else if (counter == 6) fgets(teraz->cas, CAS_D, *f);   /*cas*/
                else if (counter == 7) {
                    fgets(teraz->datum, DATUM_D, *f);   /*datum*/
                    if (n == *total) {
                        teraz->datum[9] = '\n';
                    }
                }
            }
            if (n == *total) {
                teraz->p_dalsi = NULL;
            } else {
                dalsi = malloc(sizeof(ZAZNAM));
                teraz->p_dalsi = dalsi;
            }
            teraz = dalsi;
        }
        rewind(*f);
        *n_was_open = 1;
        printf("Podarilo sa nacitat <%d> zaznamov\n", *total);
    }
}

void v_funkcia(ZAZNAM **prvy, int *total, int *n_was_open, int *u_was_open) {
    if (*n_was_open == 0) {
        printf("Zaznamy neboli nacitane!\n");
    } else {
        ZAZNAM *teraz = *prvy;
        ZAZNAM *dalsi = NULL;
        if (*total > 0) {
            for (int i = 0; i < *total; i++) {
                printf("%d.\n", i + 1);
                printf("%s", teraz->rc);
                printf("%s", teraz->meno);
                printf("%s", teraz->modul);
                printf("%s", teraz->velicina);
                printf("%s", teraz->hodnota);
                printf("%s", teraz->cas);
                printf("%s\n", teraz->datum);
                teraz = teraz->p_dalsi;
            }
        }
    }
}

void p_funkcia(ZAZNAM **prvy, int *total, int *n_was_open) {
    char c1[10];
    fgets(c1, 10, stdin);
    int c;
    c = atoi(c1);
    if (c < 1) {
        printf("Neplatne cislo c (musi byt vacsie ako 0)");
    } else {
        ZAZNAM *novy;
        ZAZNAM *teraz = *prvy;
        ZAZNAM *dalsi = NULL;
        novy = malloc(sizeof(ZAZNAM));
        fgets(novy->rc, RC_D, stdin);
        fgets(novy->meno, MENO_D, stdin);
        fgets(novy->modul, MODUL_D, stdin);
        fgets(novy->velicina, VELICINA_D, stdin);
        fgets(novy->hodnota, HODNOTA_D, stdin);
        fgets(novy->cas, CAS_D, stdin);
        fgets(novy->datum, DATUM_D, stdin);

        ZAZNAM *docasny = NULL;
        if (c == 1) {
            novy->p_dalsi = *prvy;
            *prvy = novy;
        } else if (c > *total) {
            for (int i = 1; i < *total; i++) {
                teraz = teraz->p_dalsi;
            }
            teraz->p_dalsi = novy;
        } else {
            for (int i = 1; i < (c - 1); i++) {
                teraz = teraz->p_dalsi;
            }
            docasny = teraz->p_dalsi;
            teraz->p_dalsi = novy;
            novy->p_dalsi = docasny;
        }
        *total = (*total + 1);
    }
}

void h_funkcia(ZAZNAM **prvy, int *total, int *n_was_open) {
    char input[MODUL_D];
    fgets(input, 5, stdin);
    ZAZNAM *teraz = *prvy;
    int counter = 1;
    for (int i = 0; i < *total; i++) {
        if (strcmp(teraz->modul, input) == 0) {
            printf("%d.\n", counter);
            printf("%s", teraz->rc);
            printf("%s", teraz->meno);
            printf("%s", teraz->modul);
            printf("%s", teraz->velicina);
            printf("%s", teraz->hodnota);
            printf("%s", teraz->cas);
            printf("%s\n", teraz->datum);
            counter++;
        }
        teraz = teraz->p_dalsi;
    }
    if (counter == 1) {
        long long dlzka = strlen(input);
        input[dlzka - 1] = '\0';
        printf("Pre meraci modul %s niesu zaznamy", input);
    }
}

void r_funkcia(ZAZNAM **prvy, int *total, int *n_was_open) {
    char c1[10], c2[10];
    fgets(c1, 10, stdin);
    fgets(c2, 10, stdin);
    int c = atoi(c1);
    int cc = atoi(c2);
    int doc;
    if(cc<c){
        doc=c;
        c=cc;
        cc=doc;
    }
    if (((c < 1) || (c > *total)) || ((cc < 1) || (cc > *total))) {
        printf("Zaznamy na danych miestach sa nedaju vymenit\n");
    } else {
        ZAZNAM *teraz = *prvy;
        ZAZNAM *vymena1 = NULL;
        ZAZNAM *vymena2 = NULL;
        ZAZNAM *docasny = NULL;

        for (int i = 1; i <= *total; i++) {
            if (i == c) {
                vymena1 = teraz;
            }
            if (i == cc) {
                vymena2 = teraz;
            }
            teraz = teraz->p_dalsi;
        }
        teraz = *prvy;

        if (c == 1) {
            for (int i = 1; i <= *total; i++) {
                if (i == 1) {
                    *prvy = vymena2;
                    docasny = vymena2->p_dalsi;
                    vymena2->p_dalsi = teraz->p_dalsi;
                }
                if (i == (cc - 1)) {
                    teraz->p_dalsi = vymena1;
                    vymena1->p_dalsi = docasny;
                }
                teraz = teraz->p_dalsi;
            }

        } else {
            for (int i = 1; i <= *total; i++) {
                if (i == (c - 1)) {
                    teraz->p_dalsi = vymena2;
                    docasny = vymena2->p_dalsi;
                    vymena2->p_dalsi = vymena1->p_dalsi;
                }
                if (i == (cc - 1)) {
                    teraz->p_dalsi = vymena1;
                    vymena1->p_dalsi = docasny;
                }
                teraz = teraz->p_dalsi;
            }
        }
    }
}

void z_funkcia(ZAZNAM **prvy, int *total, int *n_was_open) {
    ZAZNAM *teraz = *prvy;
    char input[RC_D];
    fgets(input, RC_D, stdin);
    int counter = 0, index[*total];

    for (int i = 1; i <= *total; i++) {
        if (strncmp(teraz->rc, input, 10) == 0) {
            index[counter] = (i - counter);
            counter++;
        }
        teraz = teraz->p_dalsi;
    }

    *total = *total - counter;
    for (int k = 0; k < counter; k++) {
        teraz = *prvy;
        ZAZNAM *predosly = *prvy;
        if (index[k] == 0) {
            *prvy = teraz->p_dalsi;
            free(teraz);
            teraz = NULL;
        } else {
            for (int j = 1; j <= index[k]; j++) {
                predosly = teraz;
                teraz = teraz->p_dalsi;
            }
            (predosly->rc)[10] = '\0';
            (predosly->modul)[3] = '\0';
            printf("Zaznam pre ID: <%s> pre modul <%s> bol vymazany.\n", predosly->rc, predosly->modul);
            predosly->p_dalsi = teraz->p_dalsi;
            free(teraz);
            teraz = NULL;
        }
    }
}

void u_funkcia(ZAZNAM **prvy, int *total, int *u_was_open) {
    *u_was_open = 1;
    ZAZNAM *teraz;
    ZAZNAM *vymena1 = NULL;
    ZAZNAM *vymena2 = NULL;
    ZAZNAM *predosly = NULL;
    char datcas[DATUM_D + CAS_D], datcas2[DATUM_D + CAS_D], buffer1[DATUM_D + CAS_D], buffer2[DATUM_D + CAS_D];
    int pravdivost = 1;
    while (pravdivost == 1) {
        teraz=*prvy;
        pravdivost=0;
        for (int i = 1; i < *total; i++) {
            strcpy(buffer1, teraz->datum);
            strcpy(buffer2, teraz->cas);
            strcpy(datcas, strcat(buffer1, buffer2));

            strcpy(buffer1, teraz->p_dalsi->datum);
            strcpy(buffer2, teraz->p_dalsi->cas);
            strcpy(datcas2, strcat(buffer1, buffer2));
            long long c1, c2;
            c1 = atoll(datcas);
            c2 = atoll(datcas2);
            if (c1 > c2) {
                pravdivost=1;
                vymena1 = teraz;
                vymena2 = teraz->p_dalsi;
                if (i == 1) {
                    *prvy = vymena2;
                    vymena1->p_dalsi = vymena2->p_dalsi;
                    vymena2->p_dalsi = vymena1;
                    break;
                } else if (i == (*total - 1)) {
                    predosly->p_dalsi = vymena2;
                    vymena2->p_dalsi = vymena1;
                    vymena1->p_dalsi = NULL;
                    break;
                } else {
                    predosly->p_dalsi = vymena2;
                    vymena1->p_dalsi = vymena2->p_dalsi;
                    vymena2->p_dalsi = vymena1;
                    break;
                }
            }
            predosly = teraz;
            teraz = teraz->p_dalsi;
        }
    }
}


int main() {
    FILE *f = NULL;
    int n_was_open = 0, v_was_open = 0, u_was_open = 0, total = 0, kontrola = 1;
    char znak[10];

    ZAZNAM *prvy, *dalsi;

    while (kontrola == 1) {
        fgets(znak, 10, stdin);
        switch (znak[0]) {
            case 'n':
                n_funkcia(&f, &prvy, &total, &n_was_open);
                break;
            case 'v':
                v_funkcia(&prvy, &total, &n_was_open,&u_was_open);
                break;
            case 'p':
                p_funkcia(&prvy, &total, &n_was_open);
                break;
            case 'k':
                k_funkcia(&prvy, &total);
                kontrola = 0;
                break;
            case 'h':
                h_funkcia(&prvy, &total, &n_was_open);
                break;
            case 'r':
                r_funkcia(&prvy, &total, &n_was_open);
                break;
            case 'z':
                z_funkcia(&prvy, &total, &n_was_open);
                break;
            case 'u':
                u_funkcia(&prvy, &total, &u_was_open);
                break;
        }
    }
    return 0;
}
