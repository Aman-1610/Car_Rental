package com.carrental.util; // Or wherever your DB connection logic is

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Define keys for environment variables
    private static final String ENV_DB_URL = "DB_URL";
    private static final String ENV_DB_USER = "DB_USER";
    private static final String ENV_DB_PASSWORD = "DB_PASSWORD";

    // Default values for local development (if environment variables are not set)
    private static final String DEFAULT_DB_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String DEFAULT_DB_USER = "root";
    private static final String DEFAULT_DB_PASSWORD = "root"; // Your local password

    private static String dbUrl;
    private static String dbUser;
    private static String dbPassword;

    static {
        // Load the MySQL JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Or com.mysql.jdbc.Driver for older versions
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
            // Consider throwing a runtime exception or handling this more gracefully
        }

        // Read from environment variables
        dbUrl = System.getenv(ENV_DB_URL);
        dbUser = System.getenv(ENV_DB_USER);
        dbPassword = System.getenv(ENV_DB_PASSWORD);

        // Use defaults if environment variables are not set (for local testing)
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = DEFAULT_DB_URL;
            System.out.println("Using default DB_URL for local development.");
        }
        if (dbUser == null || dbUser.isEmpty()) {
            dbUser = DEFAULT_DB_USER;
            System.out.println("Using default DB_USER for local development.");
        }
        if (dbPassword == null) { // Password can be an empty string
            dbPassword = DEFAULT_DB_PASSWORD;
            System.out.println("Using default DB_PASSWORD for local development.");
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dbUrl == null || dbUser == null || dbPassword == null) {
            throw new SQLException("Database configuration is incomplete. Check environment variables.");
        }
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    // Optional: main method to test connection locally
    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("Successfully connected to the database!");
            } else {
                System.out.println("Failed to connect to the database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}