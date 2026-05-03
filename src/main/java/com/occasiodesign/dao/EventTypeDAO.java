package com.occasiodesign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.occasiodesign.dao.interfaces.EventTypeDAOInterface;
import com.occasiodesign.model.EventType;
import com.occasiodesign.utilities.DBConfig;

/**
 * EventTypeDAO - Handles all database operations for event types.
 */
public class EventTypeDAO implements EventTypeDAOInterface {

    private Connection conn;

    public EventTypeDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("DB Connection Error: " + ex.getLocalizedMessage());
        }
    }

    @Override
    public int insertEventType(EventType eventType) {
        try {
            final String INSERT = "INSERT INTO event_types (event_name, description, category, base_price, max_guests, location, duration_hours, status) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(INSERT);
            stmt.setString(1, eventType.getEventName());
            stmt.setString(2, eventType.getDescription());
            stmt.setString(3, eventType.getCategory());
            stmt.setBigDecimal(4, eventType.getBasePrice());
            stmt.setInt(5, eventType.getMaxGuests());
            stmt.setString(6, eventType.getLocation());
            stmt.setInt(7, eventType.getDurationHours());
            stmt.setString(8, "active");
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("insertEventType Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public List<EventType> getAllEventTypes() {
        List<EventType> list = new ArrayList<>();
        try {
            final String SELECT_ALL = "SELECT * FROM event_types WHERE status='active' ORDER BY event_name";
            PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                EventType et = mapRow(rs);
                list.add(et);
            }
        } catch (SQLException ex) {
            System.out.println("getAllEventTypes Error: " + ex.getLocalizedMessage());
        }
        return list;
    }

    @Override
    public EventType getEventTypeById(int eventId) {
        try {
            final String SELECT = "SELECT * FROM event_types WHERE event_id=?";
            PreparedStatement stmt = conn.prepareStatement(SELECT);
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException ex) {
            System.out.println("getEventTypeById Error: " + ex.getLocalizedMessage());
        }
        return null;
    }

    @Override
    public int updateEventType(EventType eventType) {
        try {
            final String UPDATE = "UPDATE event_types SET event_name=?, description=?, category=?, base_price=?, max_guests=?, location=?, duration_hours=? WHERE event_id=?";
            PreparedStatement stmt = conn.prepareStatement(UPDATE);
            stmt.setString(1, eventType.getEventName());
            stmt.setString(2, eventType.getDescription());
            stmt.setString(3, eventType.getCategory());
            stmt.setBigDecimal(4, eventType.getBasePrice());
            stmt.setInt(5, eventType.getMaxGuests());
            stmt.setString(6, eventType.getLocation());
            stmt.setInt(7, eventType.getDurationHours());
            stmt.setInt(8, eventType.getEventId());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("updateEventType Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public int deleteEventType(int eventId) {
        try {
            final String DELETE = "UPDATE event_types SET status='inactive' WHERE event_id=?";
            PreparedStatement stmt = conn.prepareStatement(DELETE);
            stmt.setInt(1, eventId);
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("deleteEventType Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    // Helper method to map a ResultSet row to an EventType object
    private EventType mapRow(ResultSet rs) throws SQLException {
        EventType et = new EventType();
        et.setEventId(rs.getInt("event_id"));
        et.setEventName(rs.getString("event_name"));
        et.setDescription(rs.getString("description"));
        et.setCategory(rs.getString("category"));
        et.setBasePrice(rs.getBigDecimal("base_price"));
        et.setMaxGuests(rs.getInt("max_guests"));
        et.setLocation(rs.getString("location"));
        et.setDurationHours(rs.getInt("duration_hours"));
        et.setStatus(rs.getString("status"));
        et.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
        return et;
    }

    public int addEventType(EventType eventType) {
        return insertEventType(eventType);
    }
}