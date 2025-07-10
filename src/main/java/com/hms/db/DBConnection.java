package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection conn;

    public static Connection getConn() {
        if (conn == null) {
            try {
                // 1) load the driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 2) read connection info from env-vars
                String url  = System.getenv("jdbc:mysql://sv32.byethost32.org:3306/malays10_hospital"+"?useSSL=false"+"&allowPublicKeyRetrieval=true"+"&serverTimezone=UTC";);
                String user = System.getenv("malays10_admin_hospital");
                String pass = System.getenv("G-JLIQS5hPMCzpOp");

                conn = DriverManager.getConnection(url, user, pass);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return conn;
    }
}
