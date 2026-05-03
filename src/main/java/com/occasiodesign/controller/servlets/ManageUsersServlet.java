package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.util.List;

import com.occasiodesign.dao.UserDAO;
import com.occasiodesign.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet for admin to manage all users (view and delete).
 */
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/admin/manageUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        if ("delete".equals(action) && userIdStr != null) {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            userDAO.deleteUser(userId);
        }
        response.sendRedirect(request.getContextPath() + "/manageUsers");
    }
}