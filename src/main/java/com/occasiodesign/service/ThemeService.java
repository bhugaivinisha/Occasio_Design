package com.occasiodesign.service;

import com.occasiodesign.dao.ThemeDAO;
import com.occasiodesign.model.Theme;
import java.util.List;


public class ThemeService {

    // This object talks to the database for theme-related things
    private ThemeDAO themeDAO;

    // Constructor: creates a ThemeDAO when ThemeService is created
    public ThemeService() {
        this.themeDAO = new ThemeDAO();
    }

    /**
     * Get all themes from the database.
     */
    public List<Theme> getAllThemes() {
        return themeDAO.getAllThemes();
    }

    /**
     * Add a new theme to the database.
     */
    public boolean addTheme(Theme theme) {
        // FIXED: addTheme returns int, convert to boolean
        int result = themeDAO.addTheme(theme);
        return result > 0; // true = added successfully, false = failed
    }

    /**
     * Update an existing theme.
     */
    public boolean updateTheme(Theme theme) {
        // FIXED: updateTheme returns int, convert to boolean
        int result = themeDAO.updateTheme(theme);
        return result > 0; // true = updated successfully, false = failed
    }

    /**
     * Delete a theme by its ID.
     */
    public boolean deleteTheme(int themeId) {
        // FIXED: deleteTheme returns int, convert to boolean
        int result = themeDAO.deleteTheme(themeId);
        return result > 0; // true = deleted successfully, false = not found or failed
    }

    /**
     * Get a specific theme by its ID.
     */
    public Theme getThemeById(int themeId) {
        return themeDAO.getThemeById(themeId);
    }
}