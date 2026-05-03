package com.occasiodesign.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Theme - Model class representing a row in the 'themes' table.
 * Each theme belongs to one EventType.
 */
public class Theme {

    private int themeId;
    private String themeName;
    private int eventId;            // Foreign key to event_types
    private String colorScheme;
    private String decorationType;
    private BigDecimal price;
    private String availabilityStatus;  // "available" or "unavailable"
    private String description;
    private String imagePath;
    private LocalDateTime createdAt;

    // Empty constructor
    public Theme() {
    }

    // ===== GETTERS AND SETTERS =====

    public int getThemeId() {
        return themeId;
    }

    public void setThemeId(int themeId) {
        this.themeId = themeId;
    }

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getColorScheme() {
        return colorScheme;
    }

    public void setColorScheme(String colorScheme) {
        this.colorScheme = colorScheme;
    }

    public String getDecorationType() {
        return decorationType;
    }

    public void setDecorationType(String decorationType) {
        this.decorationType = decorationType;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public int getEventTypeId() {
        return getEventId();
    }

    public void setEventTypeId(int eventTypeId) {
        setEventId(eventTypeId);
    }

    public java.math.BigDecimal getExtraPrice() {
        return getPrice();
    }

    public void setExtraPrice(double extraPrice) {
        setPrice(java.math.BigDecimal.valueOf(extraPrice));
    }
}