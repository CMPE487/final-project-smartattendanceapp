// Java implementation of  Server side
// It contains two classes : Server and ClientHandler
// Save file as Server.java
import java.io.*;
import java.util.*;
import java.net.*;
import java.util.concurrent.Semaphore;

// Server class
public class Server2 {

    public static boolean isFinished = true;
    public static HashMap<String,String> ipToStID;
    public static ArrayList<String> attendance;
    public static String lecturerMAC;

    public static void main(String[] args) {
        // server is listening on port 5056
        ServerSocket ss = null;
        try {
            ss = new ServerSocket(5056);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // running infinite loop for getting
        // client request
        while (true) {
            Socket s;

            try {
                // socket object to receive incoming client requests
                s = ss.accept();

                System.out.println("A new client is connected : " + s);

                // obtaining input and out streams
                System.out.println("Assigning new thread for this client");

                // create a new thread object
                new ClientHandle(s).start();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

// ClientHandler class
class ClientHandle extends Thread {
    Socket socket;
    BufferedReader in;
    BufferedWriter out;
    Semaphore mutex;


    // Constructor
    public ClientHandle(Socket socket) {
        this.socket = socket;
        System.out.println("ClientHandler constructed successfully.");
    }

    private void sendReply(String msg) {
        try {
            out.write(msg);
            out.newLine();
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void sendFail() {
        sendReply("Fail");
    }

    public void addAttendance(String stID, String IP) {
        try {
            mutex.acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Server2.attendance.add(stID);
        Server2.ipToStID.put(IP, stID);
        mutex.release();
    }

    /** Requesy policies:
    *   start_session;<MAC>
    *   attend;<MAC>;<local_ip>;<student_ID>
    *   get_list
    *   finish_session
    */

    private void handleMsg(String msg) {
        String[] input = msg.split(";");
        System.out.println("Gelen istek: "+msg);
        try {
            switch (input[0]) {
                case "start_session":
                    Server2.isFinished = false;
                    Server2.ipToStID = new HashMap<>();
                    Server2.attendance = new ArrayList<>();
                    Server2.lecturerMAC = input[1];
                    sendReply("Session started successfully");
                    break;

                case "attend": // students giving attendance
                    if(Server2.isFinished) {
                        sendReply("No active session was found.");
                        break;
                    }
                    if(!input[1].equals(Server2.lecturerMAC)) {
                        sendReply("You are not authorized to attend.");
                        break;
                    }
                    if(Server2.ipToStID.containsKey(input[2])) {
                        sendReply("You are trying to attend multiple times.");
                    }
                    else{
                        addAttendance(input[3], input[2]);
                        sendReply("You are successfully attended!");
                    }
                    break;

                case "get_list":
                    sendReply(String.join(";", Server2.attendance));
                    break;

                case "finish_session":
                    Server2.isFinished = true;
                    sendReply(String.join(";", Server2.attendance));
                    break;
                default:
                    sendFail();
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public void run() {
        System.out.println("ClientHandler started successfully.");
        try {
            in = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));
            out = new BufferedWriter(
                    new OutputStreamWriter(socket.getOutputStream()));
            mutex = new Semaphore(1);

            System.out.println("Buffereds successful.");

            String msg = in.readLine();
            System.out.println("Gelen istek: "+msg);
            handleMsg(msg);

            in.close();
            out.close();
            socket.close();

        } catch (Exception e) {
            System.out.println("Exception'a dustuk");
            e.printStackTrace();
        }
    }
}

