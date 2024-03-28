#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void v_funkcia(FILE **f, char ***rc, char ***modul, char ***velicina, char ***hodnota, char ***cas, char ***datum,
               int *n_was_open, int *v_was_open, int *total, int *z_was_open, int *zcounter) {
    *v_was_open = 1;
    char line[1000];                                    /*sluzi na zapisanie riadku do premennej*/
    int counter = 1;                         /*pocita na ktorej informacii v subore sme*/
    char znak;
    int pc = 0;
    if (*f == NULL) {                                   /*zisti, ci bol file uz otvoreny*/
        *f = fopen("dataloger.txt", "r"); /*ak nie, tak ho otvori*/
    }
    if (*f == NULL) {                                   /* ak sa nepodarilo otvorit, vypise print*/
        printf("Neotvoreny subor");
    } else {
        if (*n_was_open == 1) {                         /*ak uz bola zavolana funkcia n*/
            if (*z_was_open == 1) {                     /*ak uz bola zavolana funkcia z*/
                for (int n = 0; n < (*total - (*zcounter)); n++) {
                    printf("ID Cislo mer. osoby %s", (*rc)[n]);
                    printf("Mer. modul: %s", (*modul)[n]);
                    printf("Typ mer. veliciny: %s", (*velicina)[n]);
                    printf("Hodnota: %s", (*hodnota)[n]);
                    printf("Cas merania: %s", (*cas)[n]);
                    printf("Datum: %s", (*datum)[n]);
                    printf("\n");
                }
            } else {
                for (int n = 0; n <
                                *total; n++) {                      /*v range total (pocet "stróf databazy = 57)*/ /*printujeme nacitane udaje z alokovanych poli*/
                    printf("ID Cislo mer. osoby %s", (*rc)[n]);
                    printf("Mer. modul: %s", (*modul)[n]);
                    printf("Typ mer. veliciny: %s", (*velicina)[n]);
                    printf("Hodnota: %s", (*hodnota)[n]);
                    printf("Cas merania: %s", (*cas)[n]);
                    printf("Datum: %s", (*datum)[n]);
                    printf("\n");
                }
            }
        } else {                                        /*ak nebola zavolana N funkcia*/
            while ((znak = (fgetc(*f))) != EOF) {   /*kym nie sme na konci subora*/
                if (pc == 0) ungetc(znak, *f);
                pc += 1;
                if (counter != 7) {
                    switch (counter) {
                        case 1: {
                            fscanf(*f, "%[^\n]", line);
                            printf("ID Cislo mer. osoby: %s\n", line);
                        }
                            break;
                        case 2: {
                            fscanf(*f, "%[^\n]", line);
                            printf("Mer. modul: %s\n", line);
                        }
                            break;
                        case 3: {
                            fscanf(*f, "%[^\n]", line);
                            printf("Typ mer. veliciny: %s\n", line);
                        }
                            break;
                        case 4: {
                            fscanf(*f, "%[^\n]", line);
                            printf("Hodnota: %s\n", line);
                        }
                            break;
                        case 5: {
                            fscanf(*f, "%[^\n]", line);
                            printf("Cas merania: %s\n", line);
                        }
                            break;
                        case 6: {
                            fscanf(*f, "%[^\n]", line);
                            printf("Datum: %s\n", line);
                            printf("\n");
                        }
                            break;
                    }
                    counter++;
                } else {               /*ak sa counter dostane na 7, tak sa zresetuje na 1*/
                    counter = 1;
                }
            }
        }
    }
    rewind(*f);             /*vratenie pointeru na zaciatok subora*/
}

void n_funkcia(FILE **f, char ***rc, char ***modul, char ***velicina, char ***hodnota, char ***cas, char ***datum,
               int *n_was_open, int *v_was_open, int *total) {
    char znak2;
    if (*v_was_open == 0) {                             /*ak V fukncia nebola zavolana*/
        printf("Neotvoreny subor\n");
    } else {
        *total = 0; /*pocet "stróf" vo file*/

        while ((znak2 = fgetc(*f)) !=
               EOF) {                                   /*while zistuje, kolko riadkov sa nachádza v súbore pomocou zistonavania počtu znakov konca riadku*/
            if (znak2 == '\n') *total += 1;
        }
        *total = (*total / 7) +
                 1;                        /*celkovy pocet riadkov vydelime 7mimi, kedze kazda strofa obsahuje 6 informacii + prazdny riadok a dam +1 kvoli poslednej strófe informacii, kde sa nenachadza posledny volny riadok, a teda po vydeleni sa to zaokruhli na cislo o 1 mensie nez potrebujeme*/
        rewind(*f);

        if (*n_was_open == 1) {                         /*Ak n funkcia uz bola zavolana, dealokujeme uz nacitanu pamat*/
            for (int i = 0;
                 i <
                 *total; i++) {                     /*najprv dealokujem "mensie" prvky, teda tie co sa nachadzaju v "poli"*/
                free((*rc)[i]);
                free((*modul)[i]);
                free((*velicina)[i]);
                free((*hodnota)[i]);
                free((*cas)[i]);
                free((*datum)[i]);
            }
            free(*rc);                          /*potom dealokujem samotne "polia"*/
            free(*modul);
            free(*velicina);
            free(*hodnota);
            free(*cas);
            free(*datum);
        }

        *rc = (char **) malloc(*total *
                               sizeof(char *));        /*kazdemu polu naalokujem pamat o velkosti total (kolko krat sa dana informacia nachadza vo file a teda budeme potrebovat tolko miesta) vynasobene velkostou characteru*/
        *modul = (char **) malloc(*total * sizeof(char *));
        *velicina = (char **) malloc(*total * sizeof(char *));
        *hodnota = (char **) malloc(*total * sizeof(char *));
        *cas = (char **) malloc(*total * sizeof(char *));
        *datum = (char **) malloc(*total * sizeof(char *));
        for (int i = 0; i < *total; i++) {
            (*rc)[i] = (char *) malloc(12 *
                                       sizeof(char));           /*kazdemu prvku v poli naalokujem pamat o velkosti 12*velkost characteru (12 preto, lebo v hocijakom riadku je max 10 znakov + znak konca riadku*/
            (*modul)[i] = (char *) malloc(12 * sizeof(char));
            (*velicina)[i] = (char *) malloc(12 * sizeof(char));
            (*hodnota)[i] = (char *) malloc(12 * sizeof(char));
            (*cas)[i] = (char *) malloc(12 * sizeof(char));
            (*datum)[i] = (char *) malloc(12 * sizeof(char));
        }
        int n = 0;
        char buffer[4096];

        while (n <
               *total) {                                    /*while cyklus na vpisovanie informacii z filu na prislusne miesta v poli*/
            fgets(buffer, 12, *f);
            strcpy((*rc)[n], buffer);

            fgets(buffer, 12, *f);
            strcpy((*modul)[n], buffer);

            fgets(buffer, 12, *f);
            strcpy((*velicina)[n], buffer);

            fgets(buffer, 12, *f);
            strcpy((*hodnota)[n], buffer);

            fgets(buffer, 12, *f);
            strcpy((*cas)[n], buffer);

            fgets(buffer, 12, *f);
            strcpy((*datum)[n], buffer);

            n++;
            while ((fgetc(*f) != '\n') && (n !=
                                           *total));  /*posununtie na novy riadok vo file, nefungovalo pri konci suboru a preto druha podmienka*/
        }
        *n_was_open = 1;
    }
    rewind(*f);
}

void r_funkcia(FILE **f, char ***cas, int *n_was_open, int *total) {
    char **polec;
    polec = (char **) malloc((*total) * sizeof(char *));
    int pocitadlo = 0;          /*pocet prvkov v novom poli (polec) ktore bude obsahovat vsetky case len 1x*/
    if (*n_was_open == 0) {
        printf("Polia nie su vytvorene");
    } else {
        for (int n = 0; n < *total; n++) {      /*prechadza vsetky casy z filu*/
            int pravdivost = 1;
            for (int j = 0; j < pocitadlo; j++) {
                if (strncmp((*cas)[n], polec[j], 4) ==
                    0) {     /*ak sa najde prvok ktory uz je zapisany vo file, pravdivost sa zmeni na 0, tym padom sa nevykona dalsia podmienka nizsie*/
                    pravdivost = 0;
                    break;
                }
            }
            if (pravdivost ==
                1) {                              /*ak sa nasiel prvok ktory este nie je zapisany v poli polec, tak sa don zapise*/
                (polec)[pocitadlo] = (char *) malloc(12 * sizeof(char));
                strcpy(polec[pocitadlo], (*cas)[n]);
                pocitadlo++;
            }                                                   /* v tomto momente polec obsahuje vsetky casy iba 1x*/
        }
        int poleh[pocitadlo], polem[pocitadlo], pp[pocitadlo];  /* vytvorim polia oddelene pre hodiny, minuty*/
        for (int i = 0; i < pocitadlo; i++) {
            int cislo = atoi(
                    polec[i]);                     /* z unikatneho cisla v poli spravim hodinu a minuty a zapisem do pola*/
            poleh[i] = (cislo / 100);
            polem[i] = (cislo % 100);
        }
        for (int counter = 1; counter < 25; counter++) {
            int pravdivost = 0;
            for (int j = 0; j <
                            pocitadlo; j++) {           /*ak sa v poli nachadza hodina rovna counteru (ide od 0hodiny po 24 hodinu)*/
                if (poleh[j] == counter) {
                    printf("%d:", poleh[j]);
                    pravdivost = 1;
                    break;
                }
            }
            for (int i = 0; i < pocitadlo; i++)
                if ((poleh[i]) == counter) {
                    if (polem[i] < 10) {
                        printf("0%d,", polem[i]);
                    } else {
                        printf("%d,", polem[i]);
                    }
                }
            if (pravdivost == 1) {
                printf("\n");
            }
        }

    }
}

void h_funkcia(char ***velicina, char ***hodnota, int *n_was_open, int *total) {
    char buffer[3];
    float hodnoty[*total];
    float maximum = 0;
    int interval;
    int pocitadlo = 0;
    if (*n_was_open == 0) {
        printf("Polia nie su vytvorene");
    } else {
        scanf("%s", buffer);
        getchar();
        for (int n = 0; n < *total; n++) {
            if (strncmp(buffer, ((*velicina)[n]), 2) == 0) {
                float cislo = atof((*hodnota)[n]);
                if (cislo > maximum)
                    maximum = cislo;               /*zistujem ake najvacsie cislo je vo fily aby som podla toho mohol spravit intervaly po 5tich*/
                hodnoty[pocitadlo] = cislo;                         /*pole hodnoty obsahuje vsetky hodnoty*/
                pocitadlo += 1;
            }
        }
        maximum += 5;
        int max = (int) maximum;
        interval = max / 5;
        int phodnot[interval];                                      /*pole phodnot pocita kolkokrat sa nachadza hodnota z filu v danom range (na pozicii 0 je 0-5, na pozicii 1 5-10...*/
        memset(phodnot, 0, sizeof(phodnot));            /*nastavim vsetky hodnoty na 0*/
        for (int i = 0; i < pocitadlo; i++) {
            int k = 5;
            int pozicia = 0;
            for (int j = 0;
                 j < max; j += 5) {                      /*tu budem zistovat do akeho rangu patri nasa najdena hodnota*/
                float cislo = hodnoty[i];
                if ((j < cislo) && (cislo <
                                    k)) {                   /*ak sa hodnota nachadza v danom rangy, tak v phodnot na prislusnom poli sa pripocita +1 na counter, ak sa nenachadza, forcyklus ide dalej a meni sa range aj pozicia*/
                    phodnot[pozicia]++;
                } else {
                    k += 5;
                    pozicia++;
                }
            }
        }
        printf("%s     Pocetnost\n", buffer);
        for (int i = 0; i < interval; i++) {
            int kn = 5 * i, qn = 5 * (i + 1);
            if (phodnot[i] != 0) {
                printf("<%d - %d>   %d\n", kn, qn, phodnot[i]);
            }
        }
    }
}

void c_funkcia(FILE **f, int *v_was_open) {
    char line[1000], znak;
    int counter = 1;
    int wc = 0;
    int pc = 0, p1zle = 0, p2zle = 1, p3zle = 0;
    int p1 = 1, p2 = 1, p3 = 1, p5 = 1, p6 = 1;
    if (*v_was_open == 0) {
        printf("Neotvoreny subor");
    } else {
        while ((znak = (fgetc(*f))) != EOF) {               /*kym nie sme na konci subora*/
            if (pc == 0)
                ungetc(znak,
                       *f);              /*kedze fgetc nas posunie na zaciatku o 1 znak dalej, tak sa musime vratit naspat ale iba jeden krat, takze premenna pc to zabezpeci*/
            pc++;
            if (counter != 7) {
                switch (counter) {
                    case 1: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        int size = strlen(line);
                        if (size != 10) {
                            p1 = 0;
                            p1zle = wc;
                        }
                        long long cislo = atoll(line);
                        if ((cislo % 11) != 0) {
                            p1 = 0;
                            p1zle = wc;
                        }
                        break;
                    }
                    case 2: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        for (int n = 0; n < 3; n++) {
                            if (n == 0) {
                                if ((line[n] > 64) && (line[n] < 91));
                                else {
                                    p2zle = wc;
                                    p2 = 0;
                                }
                            }
                            if ((n == 1) || (n == 2)) {

                                if ((line[n] > 47) && (line[n]) < 58);
                                else {
                                    p2zle = wc;
                                    p2 = 0;
                                }
                            }
                        }
                        break;
                    }
                    case 3: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        char *phod[9] = {"R1", "U1", "A1", "R2", "U2", "A2", "R4", "U4", "A4"};
                        int rov = 0;
                        for (int j = 0; j < 9; j++) {
                            if (strncmp(line, phod[j], 2) == 0)
                                rov++;
                        }
                        if (rov != 1) p3 = 0;
                        break;
                    }
                    case 4: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        break;
                    }
                    case 5: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        int size = strlen(line);
                        if (size != 4) p5 = 0;
                        else {
                            int icas = atoi(line);
                            int hodina = (icas / 100);
                            int minuta = (icas % 100);
                            if ((hodina > -1) && (hodina < 25));
                            else p5 = 0;
                            if ((minuta > -1) && (minuta < 61));
                            else p5 = 0;
                        }
                        break;
                    }
                    case 6: {
                        fscanf(*f, "%[^\n]", line);
                        wc++;
                        int daatum = atoi(line);
                        int size = strlen(line);
                        for (int i = 0; i < size; i++) {
                            if ((line[i] > 47) && (line[i] < 58));
                            else p6 = 0;
                        }
                        int rok = (daatum / 10000);
                        int mesiac = ((daatum % 10000) / 100);
                        int den = ((daatum % 10000) % 100);
                        if ((rok > 1900) && (rok < 2023));
                        else p6 = 0;
                        if ((mesiac > 0) && (mesiac < 13));
                        else p6 = 0;
                        if ((den > 0) && (den < 32));
                        else p6 = 0;
                        break;
                    }
                }
                counter++;
            } else counter = 1;
        }
        if (p1 == 0) printf("Nekorektne zadany vstup: ID cislo mer. osoby\n");
        if (p2 == 0) printf("Nekorektne zadany vstup: Mer. modul\n");
        if (p3 == 0) printf("Nekorektne zadany vstup: Typ mer. veliciny\n");
        if (p5 == 0) printf("Nekorektne zadany vstup: Cas merania\n");
        if (p6 == 0) printf("Nekorektne zadany vstup: Datum\n");
        if ((p1 == 1) && (p2 == 1) && (p3 == 1) && (p5 == 1) && (p6 == 1)) printf("Data su korektne");
    }
    rewind(*f);
}

void z_funkcia(FILE **f, char ***rc, char ***modul, char ***velicina, char ***hodnota, char ***cas, char ***datum,
               int *n_was_open, int *total, int *z_was_open, int *zcounter) {
    *z_was_open = 1;
    char buffer[12];
    int counter = 0;
    if (*n_was_open == 0) printf("Polia nie su vytvorene");
    else {
        scanf("%s", buffer);
        for (int n = 0; n < *total; n++) {
            if (strncmp(buffer, ((*rc)[n]), 10) ==
                0) {                     /*ak sa najdena hodnota rovna zadanej, tak sa vsetky tieto hodnoty na danej pozicii prepisu na NULL*/
                strncpy((*rc)[n], "NULL", 12);
                strncpy((*modul)[n], "NULL", 12);
                strncpy((*velicina)[n], "NULL", 12);
                strncpy((*hodnota)[n], "NULL", 12);
                strncpy((*cas)[n], "NULL", 12);
                strncpy((*datum)[n], "NULL", 12);
                counter++;
            }
        }
        int premena = 0;
        for (int n = 0; n < *total; n++) {
            if (strncmp((*rc)[n], "NULL", 4) ==
                0);         /*idem v range vsetkych nameranych (57), ak sa hodnota na pozicii [i] nerovna NULL, tak sa ponecha na danom mieste, ak sa rovna NULL, tak sa na jej poziciu prepise hodnota z*/
            else {                                                /*[i+1] - tym docielime ze vsetky NULL hodnoty sa dostanu na koniec pola (poslednych <counter> pozicii*/
                strncpy((*rc)[premena], (*rc)[n], 12);
                strncpy((*modul)[premena], (*modul)[n], 12);
                strncpy((*velicina)[premena], (*velicina)[n], 12);
                strncpy((*hodnota)[premena], (*hodnota)[n], 12);
                strncpy((*cas)[premena], (*cas)[n], 12);
                strncpy((*datum)[premena], (*datum)[n], 12);
                premena++;
            }
        }
        *rc = realloc(*rc, (*total - *zcounter) *
                           sizeof(char *));              /* potom reallocujeme na pocet total (57) - counter (pocet, ktory sme vymazali)*/
        *modul = realloc(*modul, (*total - *zcounter) * sizeof(char *));
        *velicina = realloc(*velicina, (*total - *zcounter) * sizeof(char *));
        *hodnota = realloc(*hodnota, (*total - *zcounter) * sizeof(char *));
        *cas = realloc(*cas, (*total - *zcounter) * sizeof(char *));
        *datum = realloc(*datum, (*total - *zcounter) * sizeof(char *));
        printf("vymazalo sa %d zaznamov", counter);
        *zcounter += counter;
    }
}

void s_funkcia(FILE **f, int *n_was_open, int *total, char ***modul, char ***velicina, char ***hodnota, char ***datum,
               char ***cas) {
    char bufferM[4], bufferV[3], znak, line[13];
    int counter = 0, pocitadlo = 0;
    if (*n_was_open == 0) {
        printf("Polia nie su  vytvorene");
    } else {
        scanf("%s %s", bufferM, bufferV);
        getchar();
        for (int n = 0; n < *total; n++) {
            if ((strncmp(bufferM, (*modul)[n], 3) == 0) && (strncmp(bufferV, (*velicina)[n], 2) ==
                                                            0))  /*zistim kolko takych mer modulov a velicin sa nachadza v poli co splnaju podmienky*/
                pocitadlo++;
        }
        if (pocitadlo == 0) printf("Pre dany vstup neexistuju zaznamy");
        else {
            char datcas[pocitadlo][14], phodnot[pocitadlo][11];         /*vytvorim polia pre datumacas a pre ich hodnoty*/
            for (int n = 0; n < *total; n++) {
                if ((strncmp(bufferM, (*modul)[n], 3) == 0) && (strncmp(bufferV, (*velicina)[n], 2) == 0)) {
                    char premenna[14];                          /*string o dlzke 14*/
                    for (int j = 0; j <
                                    12; j++) {              /*prvych o znakov to bude brat z datumu, dalsie 4 z casu a tak vznikne string spojenych datumov a casu (nevedno o funkcii strcat)*/
                        if (j < 8) {
                            premenna[j] = ((*datum)[n])[j];
                        }
                        if (j > 7) {
                            premenna[j] = ((*cas)[n])[j - 8];
                        }
                    }
                    premenna[13] = '\0';
                    strncpy(datcas[counter], premenna, 14);
                    strncpy(phodnot[counter], (*hodnota)[n], 11);
                    counter++;
                }
            }
            int button = 0;
            while (button == 0) {               /*while cyklus sluziaci na vymenu datcasov do vzostupneho poradia*/
                button = 1;
                for (int j = 0; j < counter; j++) {
                    long long cisloZ = atoll(datcas[j]);
                    for (int k = (j + 1); k < (counter); k++) {
                        long long cisloK = atoll(datcas[k]);
                        if (cisloZ > cisloK) {
                            button = 0;
                            char temp[14], temph[11];
                            strncpy(temp, datcas[j], 14);
                            strncpy(datcas[j], datcas[k], 14);
                            strncpy(datcas[k], temp, 14);

                            strncpy(temph, phodnot[j], 11);
                            strncpy(phodnot[j], phodnot[k], 11);
                            strncpy(phodnot[k], temph, 11);
                        }
                    }
                }
            }
            FILE *fs;
            fs = fopen("vystup_S.txt", "w");
            for (int j = 0; j < counter; j++) {
                fprintf(fs, "%s  ", datcas[j]);
                fprintf(fs, "%s", phodnot[j]);
            }
            fclose(fs);
            printf("Pre dany vstup je vytvoreny txt subor");
        }
    }
}

void o_funkcia(FILE **f, int *n_was_open, int *total, char ***modul, char ***velicina, char ***hodnota, char ***datum,
               char ***cas, int *v_was_open) {

    char bufferM[4], bufferV[3], znak, line[13];
    int counter = 0, pocitadlo = 0;
    if (*v_was_open == 0) printf("Neotvoreny subor");
    else {
        if (*n_was_open ==
            0) {                         /*na tuto poslednu cast projektu (vypisovanie priamo zo suboru) nezostal cas, ale z dynamickych poli som stihol*/
            printf("Polia nie su  vytvorene");
        } else {
            scanf("%s %s", bufferM, bufferV);
            getchar();
            for (int n = 0; n < *total; n++) {
                if ((strncmp(bufferM, (*modul)[n], 3) == 0) && (strncmp(bufferV, (*velicina)[n], 2) == 0))
                    pocitadlo++;
            }
            if (pocitadlo == 0) printf("Pre dany vstup neexistuju zaznamy");
            else {
                char datcas[pocitadlo][14], phodnot[pocitadlo][11];
                char dat[pocitadlo][10], pcas[pocitadlo][6];
                for (int n = 0; n < *total; n++) {
                    if ((strncmp(bufferM, (*modul)[n], 3) == 0) && (strncmp(bufferV, (*velicina)[n], 2) == 0)) {
                        char premenna[14];
                        for (int j = 0; j < 12; j++) {
                            if (j < 8) {
                                premenna[j] = ((*datum)[n])[j];
                            }
                            if (j > 7) {
                                premenna[j] = ((*cas)[n])[j - 8];
                            }
                        }
                        premenna[13] = '\0';
                        strncpy(datcas[counter], premenna, 14);
                        strncpy(phodnot[counter], (*hodnota)[n], 11);
                        phodnot[counter][9] = '\0';

                        strncpy(dat[counter], (*datum)[n], 10);
                        dat[counter][8] = '\0';
                        strncpy(pcas[counter], (*cas)[n], 6);
                        pcas[counter][4] = '\0';
                        counter++;
                    }
                }
                int button = 0;
                while (button == 0) {
                    button = 1;
                    for (int j = 0; j < counter; j++) {
                        long long cisloZ = atoll(datcas[j]);
                        for (int k = (j + 1); k < (counter); k++) {
                            long long cisloK = atoll(datcas[k]);
                            if (cisloZ > cisloK) {
                                button = 0;
                                char temp[14], temph[11], tempd[10], tempc[6];
                                strncpy(temp, datcas[j], 14);
                                strncpy(datcas[j], datcas[k], 14);
                                strncpy(datcas[k], temp, 14);

                                strncpy(tempd, dat[j], 10);
                                strncpy(dat[j], dat[k], 10);
                                strncpy(dat[k], tempd, 10);

                                strncpy(tempc, pcas[j], 6);
                                strncpy(pcas[j], pcas[k], 6);
                                strncpy(pcas[k], tempc, 6);

                                strncpy(temph, phodnot[j], 11);
                                strncpy(phodnot[j], phodnot[k], 11);
                                strncpy(phodnot[k], temph, 11);


                            }
                        }
                    }
                }
                for (int j = 0; j < counter; j++) {
                    printf("%s   ", bufferM);
                    printf("%s   ", bufferV);
                    printf("%s   ", dat[j]);
                    printf("%s   ", pcas[j]);
                    printf("%s", phodnot[j]);
                }
            }
        }

    }
}

void x_funkcia(FILE **f, int *n_was_open, int *total, char ***modul, char ***velicina, char ***hodnota, char ***datum,
               char ***cas, int *v_was_open) {
    int k1 = 0;
    scanf("%d", &k1);
    int pocznak[26];
    char znaky[26];
    memset(pocznak, 0, 26);
    if (k1 > 0) {
        int counter = 0;
        for (int k = 65; k < 96; k++) {
            for (int i = 0; i < *total; i++) {
                if(i%k1==0) {
                    if ((k == (*velicina)[i][0]) || (k == (*modul)[i][0])) {
                        znaky[counter] = k;
                        counter++;
                        break;
                    }
                }
            }
        }
        for (int k = 0; k < 26; k++) {
            for (int i = 0; i < *total; i++) {
                if (i % k1 == 0) {
                    if ((znaky[k] == (*velicina)[i][0]) || (znaky[k] == (*modul)[i][0])) {
                        pocznak[k]++;
                    }
                }
            }
        }

        int size = 0;
        for (int b = 0; b < 26; b++) { ;
            if ((znaky[b]) == 0) break;
            else size++;
        }

        printf("cislice:\t");
        for (int k = 0; k < size; k++) {
            printf("%c\t", znaky[k]);
        }
        printf("\n");
        printf("pocetnost:\t");
        for (int k = 0; k < size; k++) {
            printf("%d\t", pocznak[k]);
        }
    } else printf("Neplatne cislo k");
}

void j_funkcia(FILE **f, int *n_was_open, int *total, char ***modul, char ***velicina, char ***hodnota, char ***datum,
               char ***cas, int *v_was_open) {

    char bufferM[4], bufferM2[4], bufferV[3];
    scanf("%s %s %s", bufferM, bufferM2, bufferV);
    getchar();
    float maximum=-999;
    float minimum=999;
    for (int n = 0; n < *total; n++) {
        if (strncmp(bufferM, ((*modul)[n]), 2) == 0) {
            float cislo = atof((*hodnota)[n]);
            if (cislo > maximum)
                maximum = cislo;
            if(cislo<minimum)
                minimum=cislo;

        }
    }
    printf("modul: %s\tmin.hodnota=%.4f\tmax.hodnota=%.4f\n",bufferM,minimum,maximum);

    maximum=-999;
    minimum=999;
    for (int n = 0; n < *total; n++) {
        if (strncmp(bufferM2, ((*modul)[n]), 2) == 0) {
            float cislo = atof((*hodnota)[n]);
            if (cislo > maximum)
                maximum = cislo;
            if(cislo<minimum)
                minimum=cislo;

        }
    }
    printf("modul: %s\tmin.hodnota=%.4f\tmax.hodnota=%.4f",bufferM2,minimum,maximum);
}

int main() {
    FILE *f = NULL;
    int n_was_open = 0;
    int v_was_open = 0;
    int z_was_open = 0;
    int zcounter = 0;
    char **rc;
    char **modul;
    char **velicina;
    char **hodnota;
    char **cas;
    char **datum;
    char znak;
    int total = 0;

    while (scanf("%c", &znak) != EOF) {
        switch (znak) {
            case 'v':
                v_funkcia(&f, &rc, &modul, &velicina, &hodnota, &cas, &datum, &n_was_open, &v_was_open, &total,
                          &z_was_open, &zcounter);
                break;

            case 'n':
                n_funkcia(&f, &rc, &modul, &velicina, &hodnota, &cas, &datum, &n_was_open, &v_was_open, &total);
                break;

            case 'k': {
                if (n_was_open == 1) {
                    for (int i = 0; i < total; i++) {
                        free((rc)[i]);
                        free((modul)[i]);
                        free((velicina)[i]);
                        free((hodnota)[i]);
                        free((cas)[i]);
                        free((datum)[i]);
                    }
                    free(rc);
                    free(modul);
                    free(velicina);
                    free(hodnota);
                    free(cas);
                    free(datum);
                    rc = NULL;
                    modul = NULL;
                    velicina = NULL;
                    hodnota = NULL;
                    cas = NULL;
                    datum = NULL;
                }

                if (v_was_open == 1) {
                    fclose(f);
                }
                exit(0);
            }

            case 'r':
                r_funkcia(&f, &cas, &n_was_open, &total);
                break;
            case 'h':
                h_funkcia(&velicina, &hodnota, &n_was_open, &total);
                break;
            case 'c':
                c_funkcia(&f, &v_was_open);
                break;
            case 'z':
                z_funkcia(&f, &rc, &modul, &velicina, &hodnota, &cas, &datum, &n_was_open, &total, &z_was_open,
                          &zcounter);
                break;
            case 's':
                s_funkcia(&f, &n_was_open, &total, &modul, &velicina, &hodnota, &datum, &cas);
                break;
            case 'o':
                o_funkcia(&f, &n_was_open, &total, &modul, &velicina, &hodnota, &datum, &cas, &v_was_open);
                break;
            case 'x':
                x_funkcia(&f, &n_was_open, &total, &modul, &velicina, &hodnota, &datum, &cas, &v_was_open);
                break;
            case 'j':
                j_funkcia(&f, &n_was_open, &total, &modul, &velicina, &hodnota, &datum, &cas, &v_was_open);
                break;
        }
    }

    return 0;
}
