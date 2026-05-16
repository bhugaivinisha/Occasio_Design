package com.occasiodesign.controller.servlets;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.model.Booking;
import com.occasiodesign.utilities.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// FIXED: was "/userashboard" (typo) — now "/userDashboard"
@WebServlet(name = "UserDashboardServlet", urlPatterns = {"/userDashboard"})
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Session check — if not login , send login 
        String role = (String) SessionUtil.getAttribute(request, "role");
        if (role == null || !role.equals("user")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Step 2: lode user booking 
        try {
            Integer userId = (Integer) SessionUtil.getAttribute(request, "userId");
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> myBookings = bookingDAO.getBookingsByUserId(userId);
            request.setAttribute("myBookings", myBookings);
        } catch (Exception e) {
            request.setAttribute("error", "Could not load your bookings.");
        }

        // Step 3: forward to JSP
        request.getRequestDispatcher("pages/user/userDashboard.jsp")
               .forward(request, response);
    }
}