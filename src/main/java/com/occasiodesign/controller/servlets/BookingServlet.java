package com.occasiodesign.controller.servlets;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.dao.EventTypeDAO;
import com.occasiodesign.dao.ThemeDAO;
import com.occasiodesign.model.Booking;
import com.occasiodesign.utilities.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
// java.sql.Date import HATAU — yo nai problem thiyo!

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // --- Cancel booking ---
        if ("cancel".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                new BookingDAO().updateBookingStatus(id, "cancelled");
            } catch (Exception e) {
                // ignore cancel error
            }
            response.sendRedirect(request.getContextPath() + "/userDashboard");
            return;
        }

        // --- Load booking form ---
        try {
            EventTypeDAO eventTypeDAO = new EventTypeDAO();
            ThemeDAO themeDAO = new ThemeDAO();

            // Sabai event types load gara (dropdown ko lagi)
            request.setAttribute("eventTypes", eventTypeDAO.getAllEventTypes());

            // KEY FIX: eventId aayo bhane tyo event ko themes, 
            //          xaina bhane SABAI themes load gara
            String eventIdStr = request.getParameter("eventId");
            if (eventIdStr != null && !eventIdStr.trim().isEmpty()) {
                int eventId = Integer.parseInt(eventIdStr);
                request.setAttribute("themes", themeDAO.getThemesByEventId(eventId));
            } else {
                // Sabai themes load gara — yahi fix ho!
                request.setAttribute("themes", themeDAO.getAllThemes());
            }

        } catch (Exception e) {
            request.setAttribute("error", "Could not load booking options. Please try again.");
        }

        request.getRequestDispatcher("pages/user/bookingForm.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Session bata userId lau
            Integer userId = (Integer) SessionUtil.getAttribute(request, "userId");
            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Form bata data lau
            int eventId      = Integer.parseInt(request.getParameter("eventTypeId"));
            int themeId      = Integer.parseInt(request.getParameter("themeId"));
            String eventDate = request.getParameter("eventDate");   // "2026-06-15" format
            String location  = request.getParameter("eventLocation");
            int guests       = Integer.parseInt(request.getParameter("numberOfGuests"));
            String special   = request.getParameter("specialRequests");
            if (special == null) special = "";

            // Price calculate gara
            EventTypeDAO eventTypeDAO = new EventTypeDAO();
            ThemeDAO themeDAO         = new ThemeDAO();
            BigDecimal basePrice  = eventTypeDAO.getEventTypeById(eventId).getBasePrice();
            BigDecimal themePrice = themeDAO.getThemeById(themeId).getPrice();
            BigDecimal total      = basePrice.add(themePrice);

            // Booking object banau
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setEventId(eventId);
            booking.setThemeId(themeId);
            booking.setEventDate(java.time.LocalDate.parse(eventDate)); // 
            booking.setEventLocation(location);
            booking.setNumberOfGuests(guests);
            booking.setTotalPrice(total);
            booking.setSpecialRequest(special);
            booking.setStatus("pending");

            // Database ma save gara
            new BookingDAO().insertBooking(booking);

            // Success — dashboard pathau
            response.sendRedirect(request.getContextPath() + "/userDashboard");

        } catch (Exception e) {
            // Error aayo bhane form wapas dekhaau
            try {
                request.setAttribute("error", "Booking failed: " + e.getMessage());
                request.setAttribute("eventTypes", new EventTypeDAO().getAllEventTypes());
                request.setAttribute("themes", new ThemeDAO().getAllThemes());
                request.getRequestDispatcher("pages/user/bookingForm.jsp")
                       .forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        }
    }
}