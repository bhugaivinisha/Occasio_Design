package com.occasiodesign.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConfig - Handles database connection setup.
 * All DAOs use this class to get a database connection.
 */
public class DBConfig {

    private static final String DB_NAME = "occasio_design";
    private static final String URL = "jdbc:mysql://localhost:3306/occasio_design";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // your XAMPP MySQL password (usually blank)

    /**
     * Returns a connection to the MySQL database.
     * @return Connection object
     * @throws SQLException if connection fails
     * @throws ClassNotFoundException if driver not found
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}