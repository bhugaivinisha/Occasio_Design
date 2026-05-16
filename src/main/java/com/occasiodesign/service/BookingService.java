package com.occasiodesign.service;

import com.occasiodesign.dao.BookingDAO;
import com.occasiodesign.model.Booking;
import java.util.List;


public class BookingService {

    // This object talks to the database for booking-related things
    private BookingDAO bookingDAO;

    // Constructor: when BookingService is created, it also creates a BookingDAO
    public BookingService() {
        this.bookingDAO = new BookingDAO();
    }

    /**
     * Get ALL bookings from the database.
     */
    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    /**
     * Get bookings that belong to a specific user (by their userId).
     */
    public List<Booking> getBookingsByUser(int userId) {
        // FIXED: Changed "getBookingsByUser" to "getBookingsByUserId"
        return bookingDAO.getBookingsByUserId(userId);
    }

    /**
     * Create (insert) a new booking into the database.
     */
    public boolean createBooking(Booking booking) {
        // FIXED: Changed "createBooking" to "insertBooking" and check if insert succeeded
        int rowsInserted = bookingDAO.insertBooking(booking);
        return rowsInserted > 0; // true = success, false = failed
    }

    /**
     * Update the status of a booking (e.g., "Pending" -> "Confirmed").
     */
    public boolean updateStatus(int bookingId, String status) {
        try {
            // FIXED: Call the void method first, then return true manually
            bookingDAO.updateBookingStatus(bookingId, status);
            return true; // If we reach here, no exception happened = success
        } catch (Exception e) {
            // Something went wrong (e.g., database error)
            e.printStackTrace();
            return false; // Return false to signal failure
        }
    }
}