package com.occasiodesign.controller.servlets;

import com.occasiodesign.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/editProfile"})
public class EditProfileServlet extends HttpServlet {

    /* GET request — form dekhau */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("pages/user/editProfile.jsp").forward(request, response);
    }

    /* POST request — form submit bhayo, database update gara */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");

        /* Simple check — empty xaina */
        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Name and phone cannot be empty!");
            request.getRequestDispatcher("pages/user/editProfile.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.updateProfile(userId, fullName.trim(), phone.trim(),
                                                address != null ? address.trim() : "");

        if (updated) {
            /* Session update gara — nav bar ma naya naam dekhiyos */
            session.setAttribute("fullName", fullName.trim());
            session.setAttribute("phone", phone.trim());
            session.setAttribute("address", address != null ? address.trim() : "");
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Update failed. Try again.");
        }

        request.getRequestDispatcher("pages/user/editProfile.jsp").forward(request, response);
    }
}