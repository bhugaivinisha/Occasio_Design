package com.occasiodesign.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * EventType - Model class representing a row in the 'event_types' table.
 * Examples: Birthday Party, Wedding, etc.
 */
public class EventType {

    private int eventId;
    private String eventName;
    private String description;
    private String category;
    private BigDecimal basePrice;
    private int maxGuests;
    private String location;
    private int durationHours;
    private LocalDateTime createdAt;
    private String status;  // "active" or "inactive"

    // Empty constructor
    public EventType() {
    }

    // ===== GETTERS AND SETTERS =====

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public int getMaxGuests() {
        return maxGuests;
    }

    public void setMaxGuests(int maxGuests) {
        this.maxGuests = maxGuests;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getDurationHours() {
        return durationHours;
    }

    public void setDurationHours(int durationHours) {
        this.durationHours = durationHours;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getEventTypeId() {
        return getEventId();
    }

    public void setEventTypeId(int eventTypeId) {
        setEventId(eventTypeId);
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = java.math.BigDecimal.valueOf(basePrice);
    }
}