package com.occasiodesign.controller.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Form bata data lau
        String fullName = request.getParameter("fullName"); // "fullName" — JSP sanga match!
        String email    = request.getParameter("email");
        String subject  = request.getParameter("subject");
        String message  = request.getParameter("message");

        // Validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            message  == null || message.trim().isEmpty()) {

            request.setAttribute("error", "❌ Please fill in all required fields!");

        } else {
            // Success!
            request.setAttribute("success",
                "Thank you, " + fullName.trim() + "! Your message has been received. We will contact you within 24 hours.");
        }

        // Same page ma wapas jaa message sanga
        request.getRequestDispatcher("contact.jsp")
               .forward(request, response);
    }
}