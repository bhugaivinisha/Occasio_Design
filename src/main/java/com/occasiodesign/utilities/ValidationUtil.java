package com.occasiodesign.utilities;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;

/**
 * ValidationUtil - Provides reusable validation methods.
 * Used in servlets to validate form input before processing.
 */
public class ValidationUtil {

    /**
     * Checks if a value is null or empty (blank).
     * @param value the string to check
     * @return true if null or empty
     */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Checks if a string contains only letters (and spaces for full names).
     * @param value the string to check
     * @return true if alphabetic only
     */
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z ]+$");
    }

    /**
     * Validates a full name: only letters and spaces, at least 2 characters.
     * @param name the full name to validate
     * @return true if valid
     */
    public static boolean isValidFullName(String name) {
        return name != null && name.matches("^[a-zA-Z ]{2,}$");
    }

    /**
     * Validates email format.
     * @param email the email to validate
     * @return true if valid email
     */
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    /**
     * Validates phone number: must be 10 digits starting with 98.
     * @param number the phone number to validate
     * @return true if valid
     */
    public static boolean isValidPhoneNumber(String number) {
        return number != null && number.matches("^98\\d{8}$");
    }

    /**
     * Validates password: at least 8 characters, 1 uppercase, 1 number, 1 symbol.
     * @param password the password to validate
     * @return true if valid
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    /**
     * Checks if two passwords match.
     * @param password the password
     * @param retypePassword the re-typed password
     * @return true if they match
     */
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    /**
     * Checks if a date of birth makes the person at least 16 years old.
     * @param dob the date of birth
     * @return true if age is 16 or more
     */
    public static boolean isAgeAtLeast16(LocalDate dob) {
        if (dob == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        return Period.between(dob, today).getYears() >= 16;
    }

    /**
     * Validates gender: must be "Male", "Female", or "Other".
     * @param value the gender value
     * @return true if valid
     */
    public static boolean isValidGender(String value) {
        return value != null && (value.equalsIgnoreCase("Male")
            || value.equalsIgnoreCase("Female")
            || value.equalsIgnoreCase("Other"));
    }
}