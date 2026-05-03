package com.occasiodesign.dao.interfaces;

import java.util.List;

import com.occasiodesign.model.User;

/**
 * UserDAOInterface - Defines the contract for all user database operations.
 */
public interface UserDAOInterface {
    int insertUser(User user);           // Returns 1=success, 2=already exists, 3=error
    User getUserByEmail(String email);   // Login by email
    User getUserById(int userId);        // Get user by ID
    List<User> getAllUsers();            // Admin: get all users
    int updateUser(User user);           // Update user profile
    int deleteUser(int userId);          // Admin: delete a user
}