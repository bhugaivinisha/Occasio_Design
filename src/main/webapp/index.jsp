<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * index.jsp - Entry point of OccasioDesign application.
     * 
     * IMPORTANT: This file just redirects to HomeServlet.
     * HomeServlet loads the event types from the database
     * and forwards to the actual home page display.
     * Without this redirect, the home page would show empty event cards.
     */
    response.sendRedirect(request.getContextPath() + "/home");
%>
