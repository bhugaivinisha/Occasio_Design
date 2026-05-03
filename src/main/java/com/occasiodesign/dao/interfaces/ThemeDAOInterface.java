package com.occasiodesign.dao.interfaces;

import java.util.List;

import com.occasiodesign.model.Theme;

/**
 * ThemeDAOInterface - Defines database operations for themes.
 */
public interface ThemeDAOInterface {
    int insertTheme(Theme theme);
    List<Theme> getAllThemes();
    List<Theme> getThemesByEventId(int eventId);   // Get themes for a specific event
    Theme getThemeById(int themeId);
    int updateTheme(Theme theme);
    int deleteTheme(int themeId);
}