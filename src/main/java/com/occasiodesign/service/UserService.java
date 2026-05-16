package com.occasiodesign.service;

import com.occasiodesign.dao.UserDAO;
import com.occasiodesign.model.User;
import java.util.List;

/**
 * UserService - Middleman between the Servlet and the UserDAO (database).
 */
public class UserService {

    // This object talks to the database for user-related things
    private UserDAO userDAO;

    // Constructor: creates a UserDAO when UserService is created
    public UserService() {
        this.userDAO = new UserDAO();
    }

    /**
     * Get all users from the database.
     */
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    /**
     * Delete a user by their userId.
     */
    public boolean deleteUser(int userId) {
        // FIXED: Store int result and convert to boolean
        int rowsDeleted = userDAO.deleteUser(userId);
        return rowsDeleted > 0; // true = deleted, false = not found or failed
    }

    /**
     * Update a user's profile (name, email, phone).
     */
    public boolean updateProfile(int userId, String name, String email, String phone) {
        return userDAO.updateProfile(userId, name, email, phone);
    }

    /**
     * Find a user by their email address.
     */
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
}