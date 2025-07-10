package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
  private static Connection conn;

  public static Connection getConn() {
    if (conn == null) {
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String instanceConnName = System.getenv("myjava-465513:us-central1:myhospital");
                  String dbName = System.getenv("hospital");
                  String dbUser = System.getenv("admin");
                  String dbPass = System.getenv("Abcd1234$");

String jdbcUrl = String.format(
    "jdbc:mysql:///%s"
  + "?cloudSqlInstance=%s"
  + "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
  + "&useSSL=false",
    dbName, instanceConnName
);

Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return conn;
  }
}
