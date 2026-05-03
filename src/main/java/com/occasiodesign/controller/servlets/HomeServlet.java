package com.occasiodesign.controller.servlets;

import java.io.IOException;
import java.util.List;

import com.occasiodesign.dao.EventTypeDAO;
import com.occasiodesign.model.EventType;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * HomeServlet - Handles the main home page.
 *
 * URL: /home
 *
 * Loads event types from the database and forwards to home.jsp.
 * This is why index.jsp redirects here — so the event cards always
 * have data from the database.
 *
 * Accessible by ALL visitors — logged in or not.
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    /* EventTypeDAO handles all database operations for event types */
    private EventTypeDAO eventTypeDAO = new EventTypeDAO();

    /**
     * GET request: load event types and show home page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            /* Load all event types from the database */
            List<EventType> eventTypes = eventTypeDAO.getAllEventTypes();

            /* Put the list into request attributes so home.jsp can use it */
            request.setAttribute("eventTypes", eventTypes);

        } catch (Exception e) {
            /* If DB fails, home page still shows — just with empty event list */
            System.err.println("HomeServlet: Could not load event types. " + e.getMessage());
        }

        /* Forward to home.jsp (NOT index.jsp — that would cause a redirect loop!) */
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}