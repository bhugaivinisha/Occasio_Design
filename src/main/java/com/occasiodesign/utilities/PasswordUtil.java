package com.occasiodesign.utilities;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil - Provides password hashing and verification.
 * Uses BCrypt algorithm for secure password storage.
 */
public class PasswordUtil {

    // Cost factor: higher = more secure but slower. 10-12 is recommended.
    private static final int COST = 10;

    /**
     * Hashes a plain text password using BCrypt.
     * @param inputPassword the plain text password
     * @return the hashed password string
     */
    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    /**
     * Checks if a typed password matches the stored hashed password.
     * @param passwordTyped the password entered by the user
     * @param hashedPassword the stored hashed password from database
     * @return true if passwords match, false otherwise
     */
    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }
}