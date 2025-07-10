package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn;

    public static synchronized Connection getConn() throws SQLException {
        // If never initialized or connection was closed, (re)open it
        if (conn == null || conn.isClosed()) {
            // Read from well-named environment variables
            String instanceConnName = System.getenv("myjava-465513:us-central1:myhospital");
            String dbName            = System.getenv("hospital");
            String dbUser            = System.getenv("admin");
            String dbPass            = System.getenv("Abcd1234$");

            if (instanceConnName == null || dbName == null ||
                dbUser == null || dbPass == null) {
                throw new SQLException(
                  "One or more required environment variables are not set: " +
                  "INSTANCE_CONNECTION_NAME, DB_NAME, DB_USER, DB_PASS"
                );
            }

            String jdbcUrl = String.format(
                "jdbc:mysql:///%s"
              + "?cloudSqlInstance=%s"
              + "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
              + "&useSSL=false",
                dbName, instanceConnName
            );

            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
        }
        return conn;
    }
}
