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
 * ManageEventsServlet - Controls CRUD operations for EventTypes.
 *
 * URL: /manageEvents
 *
 * GET /manageEvents           → show all events list
 * GET /manageEvents?action=edit&id=X  → show edit form pre-filled with event X's data
 * POST /manageEvents (action=add)     → insert new event type into DB
 * POST /manageEvents (action=update)  → update existing event type in DB
 * POST /manageEvents (action=delete)  → delete event type from DB
 *
 * Only admins can access this page (enforced by AuthenticationFilter).
 */
@WebServlet("/manageEvents")
public class ManageEventsServlet extends HttpServlet {

    /* EventTypeDAO handles all database operations for event types */
    private EventTypeDAO eventTypeDAO = new EventTypeDAO();

    /**
     * GET request handler.
     * Shows the list of all event types.
     * If action=edit, also loads the event to edit into request attributes.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        /* Load all event types from the database */
        List<EventType> eventTypes = eventTypeDAO.getAllEventTypes();
        request.setAttribute("eventTypes", eventTypes);

        /* If admin clicked "Edit" on an event, load that event's data */
        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                EventType editEvent = eventTypeDAO.getEventTypeById(id);
                if (editEvent != null) {
                    /* Put into request so manageEvents.jsp fills the form with this data */
                    request.setAttribute("editEvent", editEvent);
                }
            } catch (NumberFormatException e) {
                /* Invalid ID — just show the list without edit mode */
                request.setAttribute("error", "Invalid event ID.");
            }
        }

        /* Forward to the JSP page */
        request.getRequestDispatcher("/pages/admin/manageEvents.jsp")
               .forward(request, response);
    }

    /**
     * POST request handler.
     * Handles add, update, delete actions.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* Set encoding so Nepali/special characters work properly */
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            /* ---- ADD NEW EVENT TYPE ---- */
            handleAdd(request, response);

        } else if ("update".equals(action)) {
            /* ---- UPDATE EXISTING EVENT TYPE ---- */
            handleUpdate(request, response);

        } else if ("delete".equals(action)) {
            /* ---- DELETE EVENT TYPE ---- */
            handleDelete(request, response);

        } else {
            /* Unknown action — just redirect to the list */
            response.sendRedirect(request.getContextPath() + "/manageEvents");
        }
    }

    /**
     * Handles adding a new event type to the database.
     */
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            EventType event = new EventType();
            event.setEventName(request.getParameter("eventName"));
            event.setBasePrice(Double.parseDouble(request.getParameter("basePrice")));
            event.setDescription(request.getParameter("description"));

            // simple defaults because the form does not collect these
            event.setCategory("General");
            event.setMaxGuests(1000);
            event.setLocation("Kathmandu");
            event.setDurationHours(4);
            event.setStatus("active");

            eventTypeDAO.addEventType(event);
            response.sendRedirect(request.getContextPath() + "/manageEvents?success=added");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manageEvents?error=invalid");
        }
    }

    /**
     * Handles updating an existing event type in the database.
     */

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("eventTypeId"));
            EventType event = eventTypeDAO.getEventTypeById(id);
            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/manageEvents?error=invalid");
                return;
            }

            event.setEventName(request.getParameter("eventName"));
            event.setBasePrice(Double.parseDouble(request.getParameter("basePrice")));
            event.setDescription(request.getParameter("description"));

            eventTypeDAO.updateEventType(event);
            response.sendRedirect(request.getContextPath() + "/manageEvents?success=updated");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manageEvents?error=invalid");
        }
    }




    /**
     * Handles deleting an event type from the database.
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String eventTypeIdStr = request.getParameter("eventTypeId");

        try {
            int eventTypeId = Integer.parseInt(eventTypeIdStr);
            eventTypeDAO.deleteEventType(eventTypeId);
            /* Redirect after delete to prevent form resubmission on refresh */
            response.sendRedirect(request.getContextPath() + "/manageEvents?success=deleted");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manageEvents?error=invalid");
        }
    }

    /**
     * Helper: show error message and reload the events list.
     */
    private void showErrorAndList(HttpServletRequest request, HttpServletResponse response,
                                   String errorMsg) throws ServletException, IOException {
        request.setAttribute("error", errorMsg);
        request.setAttribute("eventTypes", eventTypeDAO.getAllEventTypes());
        request.getRequestDispatcher("/pages/admin/manageEvents.jsp").forward(request, response);
    }
}
