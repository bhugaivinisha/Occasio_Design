package com.occasiodesign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.occasiodesign.dao.interfaces.UserDAOInterface;
import com.occasiodesign.model.User;
import com.occasiodesign.utilities.DBConfig;

/**
 * UserDAO - Performs all database operations for the User model.
 * Implements UserDAOInterface.
 */
public class UserDAO implements UserDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    // Constructor: establish database connection
    public UserDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("DB Connection Error: " + ex.getLocalizedMessage());
        }
    }

    /**
     * Inserts a new user into the database.
     * Checks for duplicate email and phone before inserting.
     * @param user the User object to insert
     * @return 1=success, 2=duplicate email/phone, 3=SQL error
     */
    @Override
    public int insertUser(User user) {
        try {
            // Check if email or phone already exists
            final String CHECK_DUPLICATE = "SELECT user_id FROM users WHERE email=? OR phone=?";
            PreparedStatement checkStmt = conn.prepareStatement(CHECK_DUPLICATE);
            checkStmt.setString(1, user.getEmail());
            checkStmt.setString(2, user.getPhone());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                return 2;  // Duplicate found
            }

            // Insert the new user
            final String INSERT_USER = "INSERT INTO users (full_name, email, phone, password, gender, date_of_birth, role, address) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement insertStmt = conn.prepareStatement(INSERT_USER);
            insertStmt.setString(1, user.getFullName());
            insertStmt.setString(2, user.getEmail());
            insertStmt.setString(3, user.getPhone());
            insertStmt.setString(4, user.getPassword());
            insertStmt.setString(5, user.getGender());
            insertStmt.setObject(6, user.getDateOfBirth());
            insertStmt.setString(7, "user");  // Default role is always "user"
            insertStmt.setString(8, user.getAddress());

            return insertStmt.executeUpdate();  // Returns 1 if successful

        } catch (SQLException ex) {
            System.out.println("insertUser Error: " + ex.getLocalizedMessage());
            return 3;
        }
    }

    /**
     * Retrieves a user by their email address. Used for login.
     * @param email the email to search for
     * @return User object or null if not found
     */
    @Override
    public User getUserByEmail(String email) {
        try {
            final String SELECT_USER = "SELECT * FROM users WHERE email=?";
            PreparedStatement stmt = conn.prepareStatement(SELECT_USER);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setDateOfBirth(rs.getObject("date_of_birth", LocalDate.class));
                user.setRole(rs.getString("role"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                return user;
            }
        } catch (SQLException ex) {
            System.out.println("getUserByEmail Error: " + ex.getLocalizedMessage());
        }
        return null;
    }

    /**
     * Retrieves a user by their ID.
     * @param userId the user's ID
     * @return User object or null
     */
    @Override
    public User getUserById(int userId) {
        try {
            final String SELECT_USER = "SELECT * FROM users WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(SELECT_USER);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setDateOfBirth(rs.getObject("date_of_birth", LocalDate.class));
                user.setRole(rs.getString("role"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                return user;
            }
        } catch (SQLException ex) {
            System.out.println("getUserById Error: " + ex.getLocalizedMessage());
        }
        return null;
    }

    /**
     * Returns a list of all users. Used by admin dashboard.
     * @return List of all User objects
     */
    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            final String SELECT_ALL = "SELECT * FROM users ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setGender(rs.getString("gender"));
                user.setDateOfBirth(rs.getObject("date_of_birth", LocalDate.class));
                user.setRole(rs.getString("role"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                users.add(user);
            }
        } catch (SQLException ex) {
            System.out.println("getAllUsers Error: " + ex.getLocalizedMessage());
        }
        return users;
    }

    /**
     * Updates a user's profile information.
     * @param user the User object with updated values
     * @return 1=success, 0=failed
     */
    @Override
    public int updateUser(User user) {
        try {
            final String UPDATE_USER = "UPDATE users SET full_name=?, phone=?, gender=?, date_of_birth=?, address=? WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(UPDATE_USER);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getGender());
            stmt.setObject(4, user.getDateOfBirth());
            stmt.setString(5, user.getAddress());
            stmt.setInt(6, user.getUserId());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("updateUser Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

//    /**----------------------
//     * Deletes a user by their ID. Admin only.
//     * @param userId the user's ID to delete
//     * @return 1=success, 0=failed
//     */
//    @Override
//    public int deleteUser(int userId) {
//        try {
//            final String DELETE_USER = "DELETE FROM users WHERE user_id=?";
//            PreparedStatement stmt = conn.prepareStatement(DELETE_USER);
//            stmt.setInt(1, userId);
//            return stmt.executeUpdate();
//        } catch (SQLException ex) {
//            System.out.println("deleteUser Error: " + ex.getLocalizedMessage());
//            return 0;
//        }---------------




        /** Returns all users from the database. */
        public List<User> getAllUsers1() {
            List<User> list = new ArrayList<>();
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            try (Connection conn = DBConfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setRole(rs.getString("role"));
                    u.setAddress(rs.getString("address"));
                    list.add(u);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }
        /** Deletes a user by ID.
         * @return */
        @Override
		public int deleteUser(int userId) {
            String sql = "DELETE FROM users WHERE user_id = ?";
            try (Connection conn = DBConfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
			return 0;
        }
        
        /** ---- Update profile of user ---   */
       
        public boolean updateProfile(int userId, String fullName, String phone, String address) {
            String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";
            try (java.sql.Connection conn = DBConfig.getConnection();
                 java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, fullName);
                ps.setString(2, phone);
                ps.setString(3, address);
                ps.setInt(4, userId);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
}




