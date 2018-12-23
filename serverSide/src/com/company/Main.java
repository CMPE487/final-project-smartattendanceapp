package com.company;

import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        try {
            Server.main(new String[0]);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
