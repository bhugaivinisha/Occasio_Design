package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.util.List;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet for admin to view and update all bookings.
 */

public class ManageBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookings();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/pages/admin/manageBookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");

        if (bookingIdStr != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            BookingDAO bookingDAO = new BookingDAO();
            if ("confirm".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "confirmed");
            } else if ("cancel".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "cancelled");
            }
        }
        response.sendRedirect(request.getContextPath() + "/manageBookings");
    }
}