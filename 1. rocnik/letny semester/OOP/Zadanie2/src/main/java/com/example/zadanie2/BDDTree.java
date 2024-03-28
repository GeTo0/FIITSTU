package com.example.zadanie2;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.*;
import java.util.HashMap;

public class BDDTree {
    private static char myChar;
    Node root;
    int varCount;

    HashMap<String, Node> map = new HashMap<>();
    public Node nula = findHash(new Node("0"));
    public Node jedna = findHash(new Node("1"));


    public BDDTree() {
    }

    public void BDD_create(String bfunkcia, List<String> order, int index) {
        this.root = findHash(new Node(bfunkcia));
        this.root.index = order.get(index);
        BDDcreate(root, bfunkcia, order, index);
    }

    public boolean zeroAndOne(String funkcia) {
        if (funkcia.length() == 4) {
            char pismenko = funkcia.charAt(3);
            int count = 0;

            for (int i = 0; i < funkcia.length(); i++) {
                if (funkcia.charAt(i) == pismenko) {
                    count++;
                }
            }

            if ((count == 2) && (funkcia.contains("!")) && (funkcia.contains("+"))) {
                return true;
            }
        }
        return false;
    }

    public void BDDcreate(Node currentNode, String bfunkcia, List<String> order, int index) {
        if ((currentNode.funkcia.equals("0") || (currentNode.funkcia.equals("1")))) {
            return;
        }
        if (zeroAndOne(bfunkcia)) {
            currentNode.left_child = jedna;
            currentNode.right_child = jedna;
            currentNode.index=order.get(index);
            return;
        }
        String[] rozdeleny = bfunkcia.split("\\+");
        char myChar = order.get(index).charAt(0);

        List<String> lchild = create_left_child(rozdeleny, myChar);
        List<String> rchild = create_right_child(rozdeleny, myChar);
        Collections.sort(lchild);
        Collections.sort(rchild);

        if (Objects.equals(lchild, rchild)) {
            if (currentNode.parent == null) {
                map.remove(currentNode.funkcia);
                BDD_create((String.join("+", lchild)), order, index);
                return;
            } else {
                currentNode.index = order.get(index);
                Node newchild = findHash(new Node(String.join("+", lchild)));
                newchild.funkcia = String.join("+", lchild);
                newchild.parent = currentNode.parent;
                if (newchild.funkcia.equals("0")) {
                    newchild = nula;
                    if (Objects.equals(currentNode.parent.left_child, currentNode)) {
                        currentNode.parent.left_child = newchild;
                    } else {
                        currentNode.parent.right_child = newchild;
                    }
                    return;
                } else if (newchild.funkcia.equals("1")) {
                    newchild = jedna;
                    if (Objects.equals(currentNode.parent.left_child, currentNode)) {
                        currentNode.parent.left_child = newchild;
                    } else {
                        currentNode.parent.right_child = newchild;
                    }
                    return;
                } else newchild.index = order.get(index + 1);
                if (Objects.equals(currentNode.parent.left_child, currentNode)) {
                    currentNode.parent.left_child = newchild;
                } else {
                    currentNode.parent.right_child = newchild;
                }
                if (currentNode.funkcia.indexOf(myChar) != -1) {
                    map.remove(currentNode.funkcia);
                }
                currentNode = newchild;
                index++;
                BDDcreate(currentNode, currentNode.funkcia, order, index);
            }
        } else {
            currentNode.index = order.get(index);
            if (lchild.get(0).equals("0")) {
                currentNode.left_child = nula;
            } else if (lchild.get(0).equals("1")) {
                currentNode.left_child = jedna;
            } else currentNode.left_child = findHash(new Node(String.join("+", lchild)));

            if (rchild.get(0).equals("0")) {
                currentNode.right_child = nula;
            } else if (rchild.get(0).equals("1")) {
                currentNode.right_child = jedna;
            } else currentNode.right_child = findHash(new Node(String.join("+", rchild)));

            currentNode.left_child.parent = currentNode;
            currentNode.right_child.parent = currentNode;
            BDDcreate(currentNode.left_child, currentNode.left_child.funkcia, order, index + 1);
            BDDcreate(currentNode.right_child, currentNode.right_child.funkcia, order, index + 1);
        }
    }

    public Node findHash(Node node) {
        if (map.containsKey(node.funkcia)) {
            return map.get(node.funkcia);
        } else {
            map.put(node.funkcia, node);
            return node;
        }
    }

    public List<String> create_left_child(String[] rozdeleny, char MyChar) {
        List<String> left_child = new ArrayList<>();
        for (int j = 0; j < rozdeleny.length; j++) {//rozdeleny string
            if (rozdeleny[j].equals('!' + (Character.toString(MyChar)))) {
                List<String> result = new ArrayList<>();
                result.add("1");
                return result;
            }
            int index = rozdeleny[j].indexOf(MyChar);
            if (index == -1) {
                left_child.add(rozdeleny[j]);
            } else {
                try {//ked sme na zaciatku stringu (hladane pismeno je na indexe 0)
                    char vykricnik = rozdeleny[j].charAt(index - 1);
                    if (vykricnik == '!') {
                        String noveslovo = rozdeleny[j].replace("!" + MyChar, "");
                        left_child.add(noveslovo);
                    }
                } catch (StringIndexOutOfBoundsException e) {
                    continue;
                }
            }
        }
        if (left_child.isEmpty()) {
            left_child.add("0");
        }
        return left_child;
    }

    public List<String> create_right_child(String[] rozdeleny, char MyChar) {
        List<String> right_child = new ArrayList<>();
        for (int j = 0; j < rozdeleny.length; j++) {//rozdeleny string
            if (Character.toString(MyChar).equals(rozdeleny[j])) {
                List<String> result = new ArrayList<>();
                result.add("1");
                return result;
            }
            int index = rozdeleny[j].indexOf(MyChar);
            if (index == -1) {
                right_child.add(rozdeleny[j]);
            } else {
                try {
                    char vykricnik = rozdeleny[j].charAt(index - 1);
                    if (vykricnik != '!') {
                        String noveslovo = rozdeleny[j].replace(Character.toString(MyChar), "");
                        right_child.add(noveslovo);
                    }
                } catch (StringIndexOutOfBoundsException e) {
                    String noveslovo = rozdeleny[j].replace(Character.toString(MyChar), "");
                    right_child.add(noveslovo);
                }
            }
        }
        if (right_child.isEmpty()) {
            right_child.add("0");

        }
        return right_child;
    }

    public List<String> BDD_create_with_best_order(String bfunkcia, List<String> order, int pocet) {
        //List<List<String>> arrangements = randomArrangements(order, (int) Math.pow(2,pocet));
        List<List<String>> arrangements = randomArrangements(order, pocet);
        int lowestNodes = Integer.MAX_VALUE;
        List<String> bestOrder = new ArrayList<String>(order);
        for (int i = 0; i < arrangements.size(); i++) {
            BDD_create(bfunkcia, arrangements.get(i), 0);
            if (map.size() < lowestNodes) {
                lowestNodes = map.size();
                bestOrder = arrangements.get(i);
            }
            map.clear();
            map.put("0",nula);
            map.put("1",jedna);
        }
        return bestOrder;
    }

    public String BDD_use(Node currentNode, String vstupy, List<String> order) {
        if (vstupy.length() != order.size()) return "-1";
        return BDDuse(currentNode, vstupy);
    }

    public String BDDuse(Node currentNode, String vstupy) {
        if ((Objects.equals(currentNode.funkcia, "1")) || (Objects.equals(currentNode.funkcia, "0"))) {
            return currentNode.funkcia;
        }
        int asciiO = (int) currentNode.index.charAt(0) - 65;
        if (vstupy.charAt(asciiO) == '1') {
            return BDDuse(currentNode.right_child, vstupy);
        } else {
            return BDDuse(currentNode.left_child, vstupy);
        }
    }

    public List<List<String>> randomArrangements(List<String> letters, int numArrangements) {
        List<List<String>> arrangements = new ArrayList<>();

        for (int i = 0; i < numArrangements; i++) {
            List<String> shuffledLetters = new ArrayList<>(letters);
            Collections.shuffle(shuffledLetters);
            arrangements.add(shuffledLetters);
        }

        return arrangements;
    }
}