package com.example.irem.smartattendancestudentedition;

import android.Manifest;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.SupplicantState;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    EditText etStID;
    Button bAttend;
    public static String request, response;
    public static String TAG = "MainAct";
    public static boolean isOK = true;
    private String macAddress;

    public void showToast(String message) {
        showToast(message, Toast.LENGTH_SHORT);
    }

    public void showToast(String message, int toastLength) {
        Toast.makeText(MainActivity.this, message, toastLength).show();
    }

    private String getMacId() {
        Log.d(TAG, "getMacId called");
        WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        if(wifiManager != null) {
            Log.d(TAG, "getMacId: WifiManager olusturuldu");
            WifiInfo wifiInfo;
            try {
                wifiInfo = wifiManager.getConnectionInfo();
            }
            catch(Exception e) {
                e.printStackTrace();
                Log.d(TAG, "getMacId: Exception'a dustuk");
                return "";
            }
            String bssid = "";
            if (wifiInfo != null && wifiInfo.getSSID() != null) {
                Log.d(TAG, "getMacId: wifiInfo olusturuldu");
                bssid = wifiInfo.getBSSID();
                Log.d(TAG, "getMacId: wifiInfo olusturuldu");
            }
            Log.d(TAG, "getMacId: BSSID: " + bssid);
            return bssid;
        }
        Log.d(TAG, "getMacId: her seu null");
        return "";
    }


    private String getMacID(){
        WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        WifiInfo wifiInfo;
        String bssid = "";
        wifiInfo = wifiManager.getConnectionInfo();
        if (wifiInfo.getSupplicantState() == SupplicantState.COMPLETED) {
            bssid = wifiInfo.getBSSID();
        }
        return bssid;
    }

    public String getMac() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, 1);
        }
        WifiManager wifimanage = (WifiManager) getApplicationContext().getSystemService(WIFI_SERVICE);
        WifiInfo wifiinfo = wifimanage.getConnectionInfo();
        macAddress = wifiinfo.getBSSID();
        return macAddress;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case 1:
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    //permission granted keep going status
                    Log.d("mac", "PERMISSION GRANTED");
                    WifiManager wifimanage = (WifiManager) getApplicationContext().getSystemService(WIFI_SERVICE);
                    WifiInfo wifiinfo = wifimanage.getConnectionInfo();
                    macAddress = wifiinfo.getBSSID();//Get the mac address of the currently connected network;
                } else {
                    Log.d("mac", "PERMISSION DENIED");
                }
        }
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etStID = (EditText) findViewById(R.id.etStID);
        bAttend = (Button) findViewById(R.id.bAttend);

        macAddress = getMac();

        bAttend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String stID = etStID.getText().toString();
                //Log.d(TAG, "onClick: MAC Address: "+MacID());

                customDialog("Your ID", "You are sending an attendance with " +
                        "the following Student ID:\n"+stID);
            }
        });
    }

    class AttendTask extends AsyncTask<Void,Void,String> {

        AlertDialog dialog;
        public static final String TAG = "AttendTask";

        AttendTask() {  dialog = new ProgressDialog(MainActivity.this); }

        @Override
        protected void onPreExecute() {
            /*
            dialog.setMessage("Please wait");
            dialog.show();
            */
            Log.d(TAG, "onPreExecute: ");
        }

        @Override
        protected String doInBackground(Void... voids) {
            Log.d(TAG, "doInBackground: ");
            return TCPUtil.sendMessage(MainActivity.request);
        }

        @Override
        protected void onPostExecute(final String result) {
            Log.d(TAG, "onPostExecute: result: "+result);
            showToast(result);
            MainActivity.response = result;
        }
    }

    public void customDialog(String title, String message){
        TAG = "Popuptayiz";
        Log.d(TAG, "customDialog called: ");
        final android.support.v7.app.AlertDialog.Builder builderSingle = new android.support.v7.app.AlertDialog.Builder(this);
        builderSingle.setTitle(title);
        builderSingle.setMessage(message);

        builderSingle.setNegativeButton(
                "Cancel",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        isOK = false;
                        Log.d(TAG, "onClick: Cancel Called.");
                    }
                });

        builderSingle.setPositiveButton(
                "OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        isOK = true;
                        Log.d(TAG, "onClick: OK Called.");
                        String stID = etStID.getText().toString();
                        Log.d(TAG, "onClick: etSDID: "+stID);
                        request = "attend;"+macAddress+";"+stID;
                        showToast(request);
                        Log.d(TAG, "onClick: sending this request: "+request);
                        new AttendTask().execute();
                    }
                });
        builderSingle.show();
    }


}
