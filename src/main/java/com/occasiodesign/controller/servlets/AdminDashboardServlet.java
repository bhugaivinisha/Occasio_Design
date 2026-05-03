package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.util.List;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.dao.EventTypeDAO;
import com.occasiodesign.dao.ThemeDAO;
import com.occasiodesign.dao.UserDAO;
import com.occasiodesign.model.Booking;
import com.occasiodesign.model.EventType;
import com.occasiodesign.model.Theme;
import com.occasiodesign.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * AdminDashboardServlet - Shows the admin dashboard with all data.
 * URL: /adminDashboard
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load summary data for admin dashboard
        UserDAO userDAO = new UserDAO();
        BookingDAO bookingDAO = new BookingDAO();
        EventTypeDAO eventTypeDAO = new EventTypeDAO();
        ThemeDAO themeDAO = new ThemeDAO();

        List<User> allUsers = userDAO.getAllUsers();
        List<Booking> allBookings = bookingDAO.getAllBookings();
        List<EventType> allEventTypes = eventTypeDAO.getAllEventTypes();
        List<Theme> allThemes = themeDAO.getAllThemes();

        // Pass counts and lists to JSP
        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("totalBookings", allBookings.size());
        request.setAttribute("totalEvents", allEventTypes.size());
        request.setAttribute("totalThemes", allThemes.size());
        request.setAttribute("recentBookings", allBookings);

        request.getRequestDispatcher("pages/admin/adminDashboard.jsp").forward(request, response);
    }
}