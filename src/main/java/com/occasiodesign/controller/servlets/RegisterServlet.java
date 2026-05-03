package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.time.LocalDate;

import com.occasiodesign.dao.UserDAO;
import com.occasiodesign.model.User;
import com.occasiodesign.utilities.PasswordUtil;
import com.occasiodesign.utilities.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * RegisterServlet - Handles user registration.
 * GET: shows form. POST: validates and saves new user.
 * URL: /register
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * GET: Show the registration form (register.jsp)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * POST: Process registration form.
     * Validates all fields, hashes password, saves user to database.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all form values
        final String fullName = request.getParameter("fullName");
        final String email = request.getParameter("email");
        final String phone = request.getParameter("phone");
        final String password = request.getParameter("password");
        final String confirmPassword = request.getParameter("confirmPassword");
        final String gender = request.getParameter("gender");
        final String dobStr = request.getParameter("dateOfBirth");
        final String address = request.getParameter("address");

        // ===== SERVER-SIDE VALIDATION =====
        String errorFullName = "";
        String errorEmail = "";
        String errorPhone = "";
        String errorPassword = "";
        String errorConfirm = "";
        String errorDob = "";
        String errorGender = "";

        // 1. Full Name: only letters and spaces, not empty
        if (ValidationUtil.isNullOrEmpty(fullName) || !ValidationUtil.isValidFullName(fullName)) {
            errorFullName = "Full name must contain only letters!";
        }

        // 2. Email: valid format
        if (!ValidationUtil.isValidEmail(email)) {
            errorEmail = "Please enter a valid email address!";
        }

        // 3. Phone: 10 digits starting with 98
        if (!ValidationUtil.isValidPhoneNumber(phone)) {
            errorPhone = "Phone must be 10 digits starting with 98!";
        }

        // 4. Password: strong password
        if (!ValidationUtil.isValidPassword(password)) {
            errorPassword = "Password must be 8+ chars with 1 uppercase, 1 number, 1 symbol!";
        }

        // 5. Confirm Password: must match
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errorConfirm = "Passwords do not match!";
        }

        // 6. Gender: valid value
        if (ValidationUtil.isNullOrEmpty(gender) || !ValidationUtil.isValidGender(gender)) {
            errorGender = "Please select a valid gender!";
        }

        // 7. Date of birth: must be at least 16 years old
        LocalDate dob = null;
        if (ValidationUtil.isNullOrEmpty(dobStr)) {
            errorDob = "Date of birth is required!";
        } else {
            try {
                dob = LocalDate.parse(dobStr);
                if (!ValidationUtil.isAgeAtLeast16(dob)) {
                    errorDob = "You must be at least 16 years old to register!";
                }
            } catch (Exception e) {
                errorDob = "Invalid date format!";
            }
        }

        // Combine all errors
        String allErrors = errorFullName + " " + errorEmail + " " + errorPhone + " "
                + errorPassword + " " + errorConfirm + " " + errorGender + " " + errorDob;

        // Set individual error attributes for showing next to fields
        request.setAttribute("errorFullName", errorFullName);
        request.setAttribute("errorEmail", errorEmail);
        request.setAttribute("errorPhone", errorPhone);
        request.setAttribute("errorPassword", errorPassword);
        request.setAttribute("errorConfirm", errorConfirm);
        request.setAttribute("errorGender", errorGender);
        request.setAttribute("errorDob", errorDob);

        if (!allErrors.trim().isEmpty() && allErrors.contains("!")) {
            // Has errors: go back to register form, keep filled values
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.setAttribute("address", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // ===== ALL VALID: Save to database =====
        String hashedPassword = PasswordUtil.getHashPassword(password);

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(hashedPassword);
        user.setGender(gender);
        user.setDateOfBirth(dob);
        user.setAddress(address);

        UserDAO userDAO = new UserDAO();
        int result = userDAO.insertUser(user);

        switch (result) {
            case 1:
                // Success: go to login
                request.setAttribute("success", "Registration successful! Please log in.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case 2:
                // Duplicate email or phone
                request.setAttribute("error", "An account with this email or phone already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            default:
                // Server error
                request.setAttribute("error", "Server error. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
        }
    }
}