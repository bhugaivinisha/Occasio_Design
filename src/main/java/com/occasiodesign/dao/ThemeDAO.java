package com.occasiodesign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.occasiodesign.dao.interfaces.ThemeDAOInterface;
import com.occasiodesign.model.Theme;
import com.occasiodesign.utilities.DBConfig;

/**
 * ThemeDAO - Handles all database operations for themes.
 */
public class ThemeDAO implements ThemeDAOInterface {

    private Connection conn;

    public ThemeDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("DB Connection Error: " + ex.getLocalizedMessage());
        }
    }

    @Override
    public int insertTheme(Theme theme) {
        try {
            final String INSERT = "INSERT INTO themes (theme_name, event_id, color_scheme, decoration_type, price, availability_status, description, image_path) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(INSERT);
            stmt.setString(1, theme.getThemeName());
            stmt.setInt(2, theme.getEventId());
            stmt.setString(3, theme.getColorScheme());
            stmt.setString(4, theme.getDecorationType());
            stmt.setBigDecimal(5, theme.getPrice());
            stmt.setString(6, "available");
            stmt.setString(7, theme.getDescription());
            stmt.setString(8, theme.getImagePath());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("insertTheme Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public List<Theme> getAllThemes() {
        List<Theme> list = new ArrayList<>();
        try {
            final String SELECT_ALL = "SELECT * FROM themes ORDER BY theme_name";
            PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException ex) {
            System.out.println("getAllThemes Error: " + ex.getLocalizedMessage());
        }
        return list;
    }

    @Override
    public List<Theme> getThemesByEventId(int eventId) {
        List<Theme> list = new ArrayList<>();
        try {
            final String SELECT = "SELECT * FROM themes WHERE event_id=? AND availability_status='available'";
            PreparedStatement stmt = conn.prepareStatement(SELECT);
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException ex) {
            System.out.println("getThemesByEventId Error: " + ex.getLocalizedMessage());
        }
        return list;
    }

    @Override
    public Theme getThemeById(int themeId) {
        try {
            final String SELECT = "SELECT * FROM themes WHERE theme_id=?";
            PreparedStatement stmt = conn.prepareStatement(SELECT);
            stmt.setInt(1, themeId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException ex) {
            System.out.println("getThemeById Error: " + ex.getLocalizedMessage());
        }
        return null;
    }

    @Override
    public int updateTheme(Theme theme) {
        try {
            final String UPDATE = "UPDATE themes SET theme_name=?, color_scheme=?, decoration_type=?, price=?, description=?, availability_status=? WHERE theme_id=?";
            PreparedStatement stmt = conn.prepareStatement(UPDATE);
            stmt.setString(1, theme.getThemeName());
            stmt.setString(2, theme.getColorScheme());
            stmt.setString(3, theme.getDecorationType());
            stmt.setBigDecimal(4, theme.getPrice());
            stmt.setString(5, theme.getDescription());
            stmt.setString(6, theme.getAvailabilityStatus());
            stmt.setInt(7, theme.getThemeId());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("updateTheme Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public int deleteTheme(int themeId) {
        try {
            final String DELETE = "DELETE FROM themes WHERE theme_id=?";
            PreparedStatement stmt = conn.prepareStatement(DELETE);
            stmt.setInt(1, themeId);
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("deleteTheme Error: " + ex.getLocalizedMessage());
            return 0;
        }
    }

    private Theme mapRow(ResultSet rs) throws SQLException {
        Theme t = new Theme();
        t.setThemeId(rs.getInt("theme_id"));
        t.setThemeName(rs.getString("theme_name"));
        t.setEventId(rs.getInt("event_id"));
        t.setColorScheme(rs.getString("color_scheme"));
        t.setDecorationType(rs.getString("decoration_type"));
        t.setPrice(rs.getBigDecimal("price"));
        t.setAvailabilityStatus(rs.getString("availability_status"));
        t.setDescription(rs.getString("description"));
        t.setImagePath(rs.getString("image_path"));
        t.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
        return t;
    }

    public int addTheme(Theme theme) {
        return insertTheme(theme);
    }
}