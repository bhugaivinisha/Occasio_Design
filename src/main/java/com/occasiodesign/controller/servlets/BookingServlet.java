package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.dao.EventTypeDAO;
import com.occasiodesign.dao.ThemeDAO;
import com.occasiodesign.model.Booking;
import com.occasiodesign.model.EventType;
import com.occasiodesign.model.Theme;
import com.occasiodesign.utilities.SessionUtil;
import com.occasiodesign.utilities.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * BookingServlet - Handles creating new bookings.
 * GET /booking: shows booking form with themes for selected event
 * POST /booking: saves the new booking
 * GET /booking?action=cancel&id=X: cancels a booking
 * URL: /booking
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Cancel a booking
        if ("cancel".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int bookingId = Integer.parseInt(idStr);
                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.updateBookingStatus(bookingId, "cancelled");
            }
            response.sendRedirect(request.getContextPath() + "/userDashboard");
            return;
        }

        // Load themes for a selected event
        String eventIdStr = request.getParameter("eventId");
        if (eventIdStr != null) {
            int eventId = Integer.parseInt(eventIdStr);
            ThemeDAO themeDAO = new ThemeDAO();
            EventTypeDAO eventTypeDAO = new EventTypeDAO();

            List<Theme> themes = themeDAO.getThemesByEventId(eventId);
            EventType selectedEvent = eventTypeDAO.getEventTypeById(eventId);

            request.setAttribute("themes", themes);
            request.setAttribute("selectedEvent", selectedEvent);
        }

        // Load all event types for the dropdown
        EventTypeDAO eventTypeDAO = new EventTypeDAO();
        request.setAttribute("eventTypes", eventTypeDAO.getAllEventTypes());

        request.getRequestDispatcher("pages/user/bookingForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form values
        String eventIdStr = request.getParameter("eventId");
        String themeIdStr = request.getParameter("themeId");
        String eventDateStr = request.getParameter("eventDate");
        String eventLocation = request.getParameter("eventLocation");
        String guestsStr = request.getParameter("numberOfGuests");
        String specialRequest = request.getParameter("specialRequest");

        // Validate inputs
        String error = "";
        if (ValidationUtil.isNullOrEmpty(eventIdStr)) {
			error += "Event is required. ";
		}
        if (ValidationUtil.isNullOrEmpty(themeIdStr)) {
			error += "Theme is required. ";
		}
        if (ValidationUtil.isNullOrEmpty(eventDateStr)) {
			error += "Event date is required. ";
		}
        if (ValidationUtil.isNullOrEmpty(eventLocation)) {
			error += "Location is required. ";
		}
        if (ValidationUtil.isNullOrEmpty(guestsStr)) {
			error += "Number of guests is required. ";
		}

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            doGet(request, response);
            return;
        }

        // Parse values
        int eventId = Integer.parseInt(eventIdStr);
        int themeId = Integer.parseInt(themeIdStr);
        int numberOfGuests = Integer.parseInt(guestsStr);
        LocalDate eventDate = LocalDate.parse(eventDateStr);

        // Calculate total price (event base price + theme price)
        EventTypeDAO eventTypeDAO = new EventTypeDAO();
        ThemeDAO themeDAO = new ThemeDAO();
        EventType event = eventTypeDAO.getEventTypeById(eventId);
        Theme theme = themeDAO.getThemeById(themeId);

        BigDecimal totalPrice = event.getBasePrice().add(theme.getPrice());

        // Get logged-in user ID from session
        int userId = (int) SessionUtil.getAttribute(request, "userId");

        // Create and save the booking
        Booking booking = new Booking();
        booking.setUserId(userId);
        booking.setEventId(eventId);
        booking.setThemeId(themeId);
        booking.setEventDate(eventDate);
        booking.setEventLocation(eventLocation);
        booking.setNumberOfGuests(numberOfGuests);
        booking.setTotalPrice(totalPrice);
        booking.setSpecialRequest(specialRequest != null ? specialRequest : "");

        BookingDAO bookingDAO = new BookingDAO();
        int result = bookingDAO.insertBooking(booking);

        if (result == 1) {
            request.setAttribute("success", "Booking created successfully!");
        } else {
            request.setAttribute("error", "Failed to create booking. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/userDashboard");
    }
}