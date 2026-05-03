package com.occasiodesign.dao.interfaces;

import java.util.List;

import com.occasiodesign.model.Booking;

/**
 * BookingDAOInterface - Defines database operations for bookings.
 */
public interface BookingDAOInterface {
    int insertBooking(Booking booking);
    List<Booking> getAllBookings();                  // Admin: all bookings
    List<Booking> getBookingsByUserId(int userId);  // User: their bookings
    Booking getBookingById(int bookingId);
    void updateBookingStatus(int bookingId, String status);
    int deleteBooking(int bookingId);
}