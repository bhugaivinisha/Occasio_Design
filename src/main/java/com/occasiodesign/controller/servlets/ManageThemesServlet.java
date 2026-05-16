package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.util.List;

import com.occasiodesign.dao.ThemeDAO;
import com.occasiodesign.model.Theme;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * ManageThemesServlet - Controls CRUD operations for Decoration Themes.
 *
 * URL: /manageThemes
 *
 * GET /manageThemes                     → show all themes list
 * GET /manageThemes?action=edit&id=X    → pre-fill form with theme X's data
 * POST /manageThemes (action=add)       → insert new theme into DB
 * POST /manageThemes (action=update)    → update existing theme in DB
 * POST /manageThemes (action=delete)    → delete theme from DB
 *
 * Only admins can access this page (enforced by AuthenticationFilter).
 */
@WebServlet(name = "ManageThemes" , urlPatterns = {"/manageThemes"})
public class ManageThemesServlet extends HttpServlet {

    /* ThemeDAO handles all database operations for themes */
    private ThemeDAO themeDAO = new ThemeDAO();

    /**
     * GET request handler.
     * Shows the list of all themes.
     * If action=edit, also loads the theme to edit.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        /* Load all themes from the database */
        List<Theme> themes = themeDAO.getAllThemes();
        request.setAttribute("themes", themes);

        /* If admin clicked "Edit", load that theme's data */
        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Theme editTheme = themeDAO.getThemeById(id);
                if (editTheme != null) {
                    /* Put into request so the form shows existing values */
                    request.setAttribute("editTheme", editTheme);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid theme ID.");
            }
        }

        /* Handle URL success/error messages (e.g. after delete redirect) */
        if ("deleted".equals(request.getParameter("success"))) {
            request.setAttribute("success", "✅ Theme deleted successfully!");
        }

        /* Forward to JSP */
        request.getRequestDispatcher("/pages/admin/manageThemes.jsp")
               .forward(request, response);
    }

    /**
     * POST request handler.
     * Handles add, update, delete actions.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(request, response);
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
        } else if ("delete".equals(action)) {
            handleDelete(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manageThemes");
        }
    }

    /**
     * Handles adding a new decoration theme.
     */
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            Theme theme = new Theme();
            theme.setThemeName(request.getParameter("themeName"));
            theme.setEventTypeId(Integer.parseInt(request.getParameter("eventTypeId")));
            theme.setExtraPrice(Double.parseDouble(request.getParameter("extraPrice")));
            theme.setDescription(request.getParameter("description"));

            // simple defaults because the form does not collect these
            theme.setColorScheme("Default");
            theme.setDecorationType("Standard");
            theme.setAvailabilityStatus("available");
            theme.setImagePath("");

            themeDAO.addTheme(theme);
            response.sendRedirect(request.getContextPath() + "/manageThemes?success=added");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manageThemes?error=invalid");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("themeId"));
            Theme theme = themeDAO.getThemeById(id);
            if (theme == null) {
                response.sendRedirect(request.getContextPath() + "/manageThemes?error=invalid");
                return;
            }

            theme.setThemeName(request.getParameter("themeName"));
            theme.setEventTypeId(Integer.parseInt(request.getParameter("eventTypeId")));
            theme.setExtraPrice(Double.parseDouble(request.getParameter("extraPrice")));
            theme.setDescription(request.getParameter("description"));

            themeDAO.updateTheme(theme);
            response.sendRedirect(request.getContextPath() + "/manageThemes?success=updated");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manageThemes?error=invalid");
        }
    }

    /**
     * Handles deleting a theme.
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String themeIdStr = request.getParameter("themeId");

        try {
            int themeId = Integer.parseInt(themeIdStr);
            themeDAO.deleteTheme(themeId);
            /* Redirect to prevent resubmission on refresh */
            response.sendRedirect(request.getContextPath() + "/manageThemes?success=deleted");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manageThemes?error=invalid");
        }
    }

    /**
     * Helper to show an error and reload the themes list.
     */
    private void showErrorAndList(HttpServletRequest request, HttpServletResponse response,
                                   String errorMsg) throws ServletException, IOException {
        request.setAttribute("error", errorMsg);
        request.setAttribute("themes", themeDAO.getAllThemes());
        request.getRequestDispatcher("/pages/admin/manageThemes.jsp").forward(request, response);
    }
}
