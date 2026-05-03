<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.EventType" %>
<%
    /**
     * manageEvents.jsp - Admin page to manage Event Types.
     * 
     * Admin can:
     *   - View all event types (READ)
     *   - Add a new event type (CREATE)
     *   - Edit an existing event type (UPDATE)
     *   - Delete an event type (DELETE)
     * 
     * This page is only accessible to admins (enforced by AuthenticationFilter).
     */

    /* Check if we are in edit mode — admin clicked "Edit" on an event */
    EventType editEvent = (EventType) request.getAttribute("editEvent");
    boolean isEditMode = (editEvent != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Manage Events - OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>

<!-- ============ NAVIGATION BAR (Admin version) ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/adminDashboard">✦ OccasioDesign Admin</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
        <a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers">Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents">Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes">Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings">Bookings</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
</nav>

<!-- ============ DASHBOARD LAYOUT (Sidebar + Main Content) ============ -->
<div class="dashboard-wrapper">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-title">Admin Menu</div>
        <a href="${pageContext.request.contextPath}/adminDashboard">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers">👥 Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents" class="active">🎉 Manage Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes">🎨 Manage Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings">📋 Manage Bookings</a>
        <div class="sidebar-title" style="margin-top:24px;">General</div>
        <a href="${pageContext.request.contextPath}/home">🏠 View Home Page</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="dashboard-main">
        <div class="dashboard-header">
            <h1>🎉 Manage Event Types</h1>
            <p>Add, edit, or remove the event types shown on the home page.</p>
        </div>

        <!-- Success/Error messages -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- ===== ADD / EDIT EVENT FORM ===== -->
        <div class="table-wrapper" style="padding:24px; margin-bottom:28px;">
            <h3 style="color:var(--brown-dark); margin-bottom:18px;">
                <%= isEditMode ? "✏️ Edit Event Type" : "➕ Add New Event Type" %>
            </h3>

            <!--
                If editing: action=update with hidden eventTypeId
                If adding: action=add
                Both go to /manageEvents servlet
            -->
            <form action="${pageContext.request.contextPath}/manageEvents" method="post">

                <!-- Hidden field to tell the servlet what action to take -->
                <input type="hidden" name="action" value="<%= isEditMode ? "update" : "add" %>"/>

                <!-- Hidden ID field (only needed when editing) -->
                <% if (isEditMode) { %>
                <input type="hidden" name="eventTypeId" value="<%= editEvent.getEventTypeId() %>"/>
                <% } %>

                <div style="display:flex; flex-wrap:wrap; gap:18px;">
                    <!-- Event Name -->
                    <div class="form-group" style="flex:1 1 200px;">
                        <label>Event Name</label>
                        <input type="text" name="eventName" placeholder="e.g. Birthday Party"
                               value="<%= isEditMode ? editEvent.getEventName() : "" %>" required/>
                    </div>
                    <!-- Base Price -->
                    <div class="form-group" style="flex:1 1 150px;">
                        <label>Base Price (Rs.)</label>
                        <input type="number" name="basePrice" placeholder="e.g. 5000" min="0"
                               value="<%= isEditMode ? editEvent.getBasePrice() : "" %>" required/>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"
                              placeholder="Short description of this event type..."
                              style="resize:vertical;"><%= isEditMode && editEvent.getDescription() != null ? editEvent.getDescription() : "" %></textarea>
                </div>

                <div style="display:flex; gap:12px;">
                    <button type="submit" class="btn btn-success">
                        <%= isEditMode ? "💾 Save Changes" : "➕ Add Event" %>
                    </button>
                    <% if (isEditMode) { %>
                    <!-- Cancel edit — go back to just viewing the list -->
                    <a href="${pageContext.request.contextPath}/manageEvents"
                       class="btn btn-secondary">✖ Cancel</a>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- ===== EVENT TYPES LIST TABLE ===== -->
        <h2 style="color:var(--brown-dark); margin-bottom:16px; font-size:1.2rem;">All Event Types</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Event Name</th>
                        <th>Description</th>
                        <th>Base Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* ManageEventsServlet loads all event types into "eventTypes" attribute */
                        List<EventType> eventTypes = (List<EventType>) request.getAttribute("eventTypes");
                        if (eventTypes != null && !eventTypes.isEmpty()) {
                            for (EventType et : eventTypes) {
                    %>
                    <tr>
                        <td>#<%= et.getEventTypeId() %></td>
                        <td><strong><%= et.getEventName() %></strong></td>
                        <td style="max-width:280px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <%= et.getDescription() != null ? et.getDescription() : "-" %>
                        </td>
                        <td>Rs. <%= et.getBasePrice() %></td>
                        <td>
                            <!-- EDIT button: goes to /manageEvents?action=edit&id=X -->
                            <a href="${pageContext.request.contextPath}/manageEvents?action=edit&id=<%= et.getEventTypeId() %>"
                               class="btn btn-warning">✏️ Edit</a>

                            <!-- DELETE button: POST form to delete -->
                            <form method="post" action="${pageContext.request.contextPath}/manageEvents"
                                  style="display:inline">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="eventTypeId" value="<%= et.getEventId() %>"/>
                                <button class="btn btn-danger"
                                        onclick="return confirm('Delete event type: <%= et.getEventName() %>?')">
                                    🗑️ Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center; color:var(--text-light); padding:30px;">
                            No event types yet. Add your first one using the form above!
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
