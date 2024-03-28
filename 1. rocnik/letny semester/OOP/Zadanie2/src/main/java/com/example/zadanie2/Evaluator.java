package com.example.zadanie2;

import java.util.Arrays;
import java.util.Objects;

public class Evaluator {
    private String funkcia;

    public Evaluator() {
    }

    public int evaluate(String vstupy, String funkcia) {
        int vysledokC = 0;
        String[] rozdeleny = funkcia.split("\\+");
        for (int i = 0; i < rozdeleny.length; i++) {
            int vysledokP = 1;
            for (int j = 0; j < rozdeleny[i].length(); j++) {
                char znak = rozdeleny[i].charAt(j);
                if (znak == '!') {
                    char znak2 = rozdeleny[i].charAt(j + 1);
                    int ascii = (int) znak2 - 65;
                    if (vstupy.charAt(ascii) == '0') {
                        vysledokP = 1;
                    } else {
                        vysledokP = 0;
                        break;
                    }
                    j++;
                } else {
                    int ascii = (int) znak - 65;
                    int hodnota = vstupy.charAt(ascii) - '0';
                    vysledokP = vysledokP * hodnota;
                    if (vysledokP == 0) break;
                }
            }
            vysledokC += vysledokP;
            if(vysledokC==1) break;
        }
        if (vysledokC > 1) vysledokC = 1;
        return vysledokC;
    }
}
