package com.occasiodesign.controller.servlets;

import java.io.IOException;

import com.occasiodesign.dao.UserDAO;
import com.occasiodesign.model.User;
import com.occasiodesign.utilities.PasswordUtil;
import com.occasiodesign.utilities.SessionUtil;
import com.occasiodesign.utilities.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * LoginServlet - Handles user login (GET shows form, POST processes login).
 * URL: /login
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    /**
     * GET: Show the login page (login.jsp)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    /**
     * POST: Process login form submission.
     * Validates credentials, starts session, redirects to correct dashboard.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String typedPassword = request.getParameter("password");

        // Basic validation: check fields not empty
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(typedPassword)) {
            request.setAttribute("error", "Email and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Look up user by email
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            // No user found with that email
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Check if typed password matches the stored hashed password
        boolean matched = PasswordUtil.checkPassword(typedPassword, user.getPassword());
//-----------------------------
        if (matched) {
            // Get which button they clicked (admin or user)
            String loginType = request.getParameter("loginType");

            // ❌ If they clicked Admin button but they are NOT admin → show error!
            if ("admin".equals(loginType) && !"admin".equals(user.getRole())) {
                request.setAttribute("error", "You do not have admin access!");
                request.getRequestDispatcher("login.jsp?type=admin").forward(request, response);
                return;
            }

            // ❌ If they clicked User button but they ARE admin → show error!
            if ("user".equals(loginType) && "admin".equals(user.getRole())) {
                request.setAttribute("error", "Please use Admin Login instead!");
                request.getRequestDispatcher("login.jsp?type=user").forward(request, response);
                return;
            }

            // All good! Save session and redirect
            SessionUtil.setAttribute(request, "userId", user.getUserId());
            SessionUtil.setAttribute(request, "fullName", user.getFullName());
            SessionUtil.setAttribute(request, "role", user.getRole());

            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        	//----------------------
        } else {
            // Wrong password
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}