<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.Theme" %>
<%
    /**
     * manageThemes.jsp - Admin page to manage Decoration Themes.
     * 
     * Admin can:
     *   - View all themes (READ)
     *   - Add a new theme (CREATE)
     *   - Edit an existing theme (UPDATE)
     *   - Delete a theme (DELETE)
     * 
     * This page is only accessible to admins (enforced by AuthenticationFilter).
     */

    /* Check if we are in edit mode — admin clicked "Edit" on a theme */
    Theme editTheme = (Theme) request.getAttribute("editTheme");
    boolean isEditMode = (editTheme != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Manage Themes - OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>

<!-- ============ NAVIGATION BAR (Admin version) ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/adminDashboard">✦ OccasioDesign Admin</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home"> Home</a>
        <a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers">Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents">Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes">Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings">Bookings</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<!-- ============ DASHBOARD LAYOUT ============ -->
<div class="dashboard-wrapper">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-title">Admin Menu</div>
        <a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers"> Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents"> Manage Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes" class="active">Manage Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings">Manage Bookings</a>
        <div class="sidebar-title" style="margin-top:24px;">General</div>
        <a href="${pageContext.request.contextPath}/home">View Home Page</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="dashboard-main">
        <div class="dashboard-header">
            <h1> Manage Decoration Themes</h1>
            <p>Add, edit, or remove the decoration themes available for booking.</p>
        </div>

        <!-- Success/Error messages -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- ===== ADD / EDIT THEME FORM ===== -->
        <div class="table-wrapper" style="padding:24px; margin-bottom:28px;">
            <h3 style="color:var(--purple-dark); margin-bottom:18px;">
                <%= isEditMode ? "✏️ Edit Theme" : "➕ Add New Theme" %>
            </h3>

            <form action="${pageContext.request.contextPath}/manageThemes" method="post">

                <!-- Hidden action field -->
                <input type="hidden" name="action" value="<%= isEditMode ? "update" : "add" %>"/>

                <!-- Hidden ID (only when editing) -->
                <% if (isEditMode) { %>
                <input type="hidden" name="themeId" value="<%= editTheme.getThemeId() %>"/>
                <% } %>

                <div style="display:flex; flex-wrap:wrap; gap:18px;">
                    <!-- Theme Name -->
                    <div class="form-group" style="flex:1 1 200px;">
                        <label>Theme Name</label>
                        <input type="text" name="themeName" placeholder="e.g. Rainbow Birthday"
                               value="<%= isEditMode ? editTheme.getThemeName() : "" %>" required/>
                    </div>
                    <!-- Extra Price -->
                    <div class="form-group" style="flex:1 1 150px;">
                        <label>Extra Price (Rs.)</label>
                        <input type="number" name="extraPrice" placeholder="e.g. 1500" min="0"
                               value="<%= isEditMode ? editTheme.getExtraPrice() : "" %>" required/>
                    </div>
                    <!-- Event Type ID -->
                    <div class="form-group" style="flex:1 1 150px;">
                        <label>Event Type ID</label>
                        <input type="number" name="eventTypeId" placeholder="e.g. 1" min="1"
                               value="<%= isEditMode ? editTheme.getEventTypeId() : "" %>" required/>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"
                              placeholder="Describe this decoration theme..."
                              style="resize:vertical;"><%= isEditMode && editTheme.getDescription() != null ? editTheme.getDescription() : "" %></textarea>
                </div>

                <div style="display:flex; gap:12px;">
                    <button type="submit" class="btn btn-success">
                        <%= isEditMode ? " Save Changes" : "➕ Add Theme" %>
                    </button>
                    <% if (isEditMode) { %>
                    <a href="${pageContext.request.contextPath}/manageThemes"
                       class="btn btn-secondary"> Cancel</a>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- ===== THEMES LIST TABLE ===== -->
        <h2 style="color:var(--purple-dark); margin-bottom:16px; font-size:1.2rem;">All Decoration Themes</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Theme Name</th>
                        <th>Event Type ID</th>
                        <th>Description</th>
                        <th>Extra Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* ManageThemesServlet loads all themes into "themes" attribute */
                        List<Theme> themes = (List<Theme>) request.getAttribute("themes");
                        if (themes != null && !themes.isEmpty()) {
                            for (Theme t : themes) {
                    %>
                    <tr>
                        <td>#<%= t.getThemeId() %></td>
                        <td><strong><%= t.getThemeName() %></strong></td>
                        <td>Event #<%= t.getEventTypeId() %></td>
                        <td style="max-width:220px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <%= t.getDescription() != null ? t.getDescription() : "-" %>
                        </td>
                        <td>Rs. <%= t.getExtraPrice() %></td>
                        <td>
                            <!-- EDIT: loads this theme's data into the form above -->
                            <a href="${pageContext.request.contextPath}/manageThemes?action=edit&id=<%= t.getThemeId() %>"
                               class="btn btn-warning">Edit</a>

                            <!-- DELETE: submits form with action=delete -->
                            <form method="post" action="${pageContext.request.contextPath}/manageThemes"
                                  style="display:inline">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="themeId" value="<%= t.getThemeId() %>"/>
                                <button class="btn btn-danger"
                                        onclick="return confirm('Delete theme: <%= t.getThemeName() %>?')">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" style="text-align:center; color:var(--text-light); padding:30px;">
                            No themes yet. Add your first decoration theme using the form above!
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
