package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
  private static Connection conn;

  public static Connection getConn() {
    if (conn == null) {
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url  = System.getenv("jdbc:mysql://sql5.freesqldatabase.com:3306/sql5789259?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
        String user = System.getenv("sql5789259");
        String pass = System.getenv("RKwW7AUxsf");

        conn = DriverManager.getConnection(url, user, pass);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return conn;
  }
}
