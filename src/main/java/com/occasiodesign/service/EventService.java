package com.occasiodesign.service;

import com.occasiodesign.dao.EventTypeDAO;
import com.occasiodesign.model.EventType;
import java.util.List;


public class EventService {

    // This object talks to the database for event-related things
    private EventTypeDAO eventTypeDAO;

    // Constructor: creates an EventTypeDAO when EventService is created
    public EventService() {
        this.eventTypeDAO = new EventTypeDAO();
    }

    /**
     * Get all event types from the database.
     */
    public List<EventType> getAllEvents() {
        return eventTypeDAO.getAllEventTypes();
    }

    /**
     * Add a new event type to the database.
     */
    public boolean addEvent(EventType event) {
        // FIXED: Use addEventType (returns int), then convert to boolean
        int result = eventTypeDAO.addEventType(event);
        return result > 0; // true = added successfully, false = failed
    }

    /**
     * Update an existing event type.
     */
    public boolean updateEvent(EventType event) {
        // FIXED: Use updateEventType (returns int), then convert to boolean
        int result = eventTypeDAO.updateEventType(event);
        return result > 0; // true = updated successfully, false = failed
    }

    /**
     * Delete an event type by its ID.
     */
    public boolean deleteEvent(int eventId) {
        // FIXED: Use deleteEventType (returns int), then convert to boolean
        int result = eventTypeDAO.deleteEventType(eventId);
        return result > 0; // true = deleted successfully, false = not found or failed
    }

    /**
     * Get a specific event by its ID.
     */
    public EventType getEventById(int eventId) {
        return eventTypeDAO.getEventTypeById(eventId);
    }
}