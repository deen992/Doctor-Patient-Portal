package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection conn;

    public static Connection getConn() {
        try {
            // Step 1: Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Connect to the remote iFastNet MySQL server
            conn = DriverManager.getConnection(
                "jdbc:mysql://sql5.freesqldatabase.com:3306/sql5789259", // Update sqlNN
                "sql5789259", // Replace with your cPanel-created MySQL username
                "RKwW7AUxsf"  // Replace with your password
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }
}
