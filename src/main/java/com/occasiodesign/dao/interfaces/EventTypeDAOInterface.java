package com.occasiodesign.dao.interfaces;

import java.util.List;

import com.occasiodesign.model.EventType;

/**
 * EventTypeDAOInterface - Defines database operations for event types.
 */
public interface EventTypeDAOInterface {
    int insertEventType(EventType eventType);
    List<EventType> getAllEventTypes();
    EventType getEventTypeById(int eventId);
    int updateEventType(EventType eventType);
    int deleteEventType(int eventId);
}