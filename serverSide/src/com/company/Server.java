package com.company;
// Java implementation of  Server side
// It contains two classes : Server and ClientHandler
// Save file as Server.java

import java.io.*;
import java.text.*;
import java.util.*;
import java.net.*;

// Server class
public class Server {

    public static HashMap<String,String> ipToStID;
    public static ArrayList<String> attendance;
    public static ServerSocket ss;

    public static void main(String[] args) throws IOException {
        // server is listening on port 5056
        ss = new ServerSocket(5056);

        // running infinite loop for getting
        // client request
        while (true) {
            Socket s = null;
            ipToStID = new HashMap<>();
            attendance = new ArrayList<>();

            try {
                // socket object to receive incoming client requests
                s = ss.accept();

                System.out.println("A new client is connected : " + s);

                // obtaining input and out streams
                DataInputStream dis = new DataInputStream(s.getInputStream());
                DataOutputStream dos = new DataOutputStream(s.getOutputStream());

                System.out.println("Assigning new thread for this client");

                // create a new thread object
                Thread t = new ClientHandler(s, dis, dos);

                // Invoking the start() method
                t.start();

            }
            catch (Exception e){
                s.close();
                e.printStackTrace();
            }
        }
    }

    public void setup() throws IOException {
        ss = new ServerSocket(5056);
        ipToStID = new HashMap<>();
        attendance = new ArrayList<>();
    }

}

// ClientHandler class
class ClientHandler extends Thread {
    final DataInputStream dis;
    final DataOutputStream dos;
    final Socket s;

    // Constructor
    public ClientHandler(Socket s, DataInputStream dis, DataOutputStream dos) {
        this.s = s;
        this.dis = dis;
        this.dos = dos;
    }

    @Override
    public void run() {
        String received;
        String toreturn;
        while (true) {
            try {

                String addr = s.getInetAddress().toString();
                System.out.println("Connected on address: "+addr);

                // receive the answer from client
                received = dis.readUTF();
                // parse the contents of the answer
                String[] input = received.split(";");

                if(received.equals("Exit")) {
                    System.out.println("Client " + this.s + " sends exit...");
                    System.out.println("Closing this connection.");
                    this.s.close();
                    System.out.println("Connection closed");
                    break;
                }

                // write on output stream based on the
                // answer from the client
                switch (input[0]) {
                    case "s_login": // students registering their IPs
                        Server.ipToStID.put(input[1], input[2]);
                        dos.writeUTF("Success");
                        break;

                    case "attend": // students giving attendance
                        Server.attendance.add(input[2]);
                        dos.writeUTF("Success");
                        break;

                    case "get_list": // lecturers get the list of students who attended the lecture
                        String ret = String.join(";", Server.attendance);
                        dos.writeUTF(ret);
                        break;

                    default:
                        dos.writeUTF("Invalid input");
                        break;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        try {
            // closing resources
            this.dis.close();
            this.dos.close();

        } catch(IOException e){
            e.printStackTrace();
        }
    }
}
