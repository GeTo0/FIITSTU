package com.example.zadanie2;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import static com.example.zadanie2.BDDTree.*;


public class Testing {
    public Testing() {
    }

    int mapS;

    public void tests() throws IOException {
        BDDTree strom = new BDDTree();
        Evaluator evaluator = new Evaluator();
        List<String> order;
        int pocet;
        for (int i = 0; i < 3; i++) {//pocet premennych 13,14,15
            BufferedReader funkciainput;
            long timeBDD = 0;
            long timeUSE = 0;
            if (i == 0) {
                funkciainput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testBfunc13.txt"));
                order = new ArrayList<String>(Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"));
                pocet = order.size();
            } else if (i == 1) {
                funkciainput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testBfunc14.txt"));
                order = new ArrayList<String>(Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N"));
                pocet = order.size();
            } else {
                funkciainput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testBfunc15.txt"));
                order = new ArrayList<String>(Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O"));
                pocet = order.size();
            }
            String funkcia = funkciainput.readLine();
            long startTime = System.currentTimeMillis();
            try {
                //precita funkciu
                while (funkcia != null) {
                    BufferedReader vstupyinput;
                    if (i == 0)
                        vstupyinput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testvalues13.txt"));
                    else if (i == 1)
                        vstupyinput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testvalues14.txt"));
                    else
                        vstupyinput = new BufferedReader(new FileReader("C:\\Users\\domin\\IdeaProjects\\Zadanie2\\src\\main\\resources\\testvalues15.txt"));
                    String vstupy = vstupyinput.readLine();
                    List<String> bestOrder = strom.BDD_create_with_best_order(funkcia, order, pocet);
                    //System.out.println(bestOrder);
                    strom.BDD_create(funkcia, order, 0);
                    long endTime = System.currentTimeMillis();
                    long elapsedTime = endTime - startTime;
                    timeBDD += elapsedTime;
                    long useTime = System.currentTimeMillis();
                    while (vstupy != null) {//pre vsetky inputy
                        String vysledok = strom.BDD_use(strom.root, vstupy, order);
                        int vys = Integer.parseInt(vysledok);
                        int what = evaluator.evaluate(vstupy, funkcia);
                        if (vys != what) System.out.println("Evaluator a program ukazal iny vysledok");
                        vstupy = vstupyinput.readLine();
                    }
                    long useendTime = System.currentTimeMillis();
                    long useelapsedTime = useendTime - useTime;
                    timeUSE += useelapsedTime;
                    vstupyinput.close();
                    funkcia = funkciainput.readLine();
                    mapS += strom.map.size();
                    strom.map.clear();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            funkciainput.close();
            long BDDave = timeBDD / 100;
            long BDDuse = timeUSE / 100;
            System.out.println(order.size());
            System.out.println(BDDave);
            System.out.println(BDDuse);
            mapS = mapS / 100;
            double redukcia = mapS / Math.pow(2, order.size() + 1) + 1;
            System.out.println(redukcia + "\n");

        }
    }
}
