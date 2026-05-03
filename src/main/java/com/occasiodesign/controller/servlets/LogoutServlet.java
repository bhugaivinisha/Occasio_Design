package com.occasiodesign.controller.servlets;

import java.io.IOException;

import com.occasiodesign.utilities.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * LogoutServlet - Destroys the user session and redirects to login.
 * URL: /logout
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Destroy the session (log out the user)
    	SessionUtil.invalidateSession(request);
    	response.sendRedirect(request.getContextPath() + "/login");
    }
}