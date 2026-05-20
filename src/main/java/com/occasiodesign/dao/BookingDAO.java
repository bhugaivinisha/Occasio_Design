package com.occasiodesign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.occasiodesign.dao.interfaces.BookingDAOInterface;
import com.occasiodesign.model.Booking;
import com.occasiodesign.utilities.DBConfig;

/**
 * BookingDAO - Handles all database operations for bookings.
 */
public class BookingDAO implements BookingDAOInterface {

    private Connection conn;

    public BookingDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("DB Connection Error: " + ex.getLocalizedMessage());
        }
    }

    @Override
    public int insertBooking(Booking booking) {
        try {
            final String INSERT = "INSERT INTO bookings (user_id, event_id, theme_id, event_date, "
            		+ "event_location, number_of_guests, total_price, status, "
            		+ "special_request) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(INSERT);
            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getEventId());
            stmt.setInt(3, booking.getThemeId());
            stmt.setObject(4, booking.getEventDate());
            stmt.setString(5, booking.getEventLocation());
            stmt.setInt(6, booking.getNumberOfGuests());
            stmt.setBigDecimal(7, booking.getTotalPrice());
            stmt.setString(8, "pending");  // New bookings always start as pending
            stmt.setString(9, booking.getSpecialRequest());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("insertBooking Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    /** Returns all bookings from the database. */
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setEventId(rs.getInt("event_id"));
             // ✅ NEW - correct fix
                b.setEventDate(rs.getDate("event_date").toLocalDate());
                b.setEventLocation(rs.getString("event_location"));
                b.setNumberOfGuests(rs.getInt("number_of_guests"));
                b.setTotalPrice(rs.getBigDecimal("total_price"));
                b.setStatus(rs.getString("status"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        try {
            final String SELECT = "SELECT * FROM bookings WHERE user_id=? ORDER BY booking_date DESC";
            PreparedStatement stmt = conn.prepareStatement(SELECT);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException ex) {
            System.out.println("getBookingsByUserId Error: " + ex.getLocalizedMessage());
        }
        return list;
    }

    @Override
    public Booking getBookingById(int bookingId) {
        try {
            final String SELECT = "SELECT * FROM bookings WHERE booking_id=?";
            PreparedStatement stmt = conn.prepareStatement(SELECT);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException ex) {
            System.out.println("getBookingById Error: " + ex.getLocalizedMessage());
        }
        return null;
    }

    @Override
    /** Updates the status of a booking (confirmed / cancelled). */
    public void updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int deleteBooking(int bookingId) {
        try {
            final String DELETE = "DELETE FROM bookings WHERE booking_id=?";
            PreparedStatement stmt = conn.prepareStatement(DELETE);
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("deleteBooking Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setEventId(rs.getInt("event_id"));
        b.setThemeId(rs.getInt("theme_id"));
        b.setEventDate(rs.getObject("event_date", LocalDate.class));
        b.setBookingDate(rs.getObject("booking_date", LocalDateTime.class));
        b.setEventLocation(rs.getString("event_location"));
        b.setNumberOfGuests(rs.getInt("number_of_guests"));
        b.setTotalPrice(rs.getBigDecimal("total_price"));
        b.setStatus(rs.getString("status"));
        b.setSpecialRequest(rs.getString("special_request"));
        return b;
    }
}