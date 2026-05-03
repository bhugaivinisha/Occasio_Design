<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.User" %>
<%
    /**
     * manageUsers.jsp - Admin page to manage Users.
     * 
     * Admin can:
     *   - View all registered users (READ)
     *   - Delete a user (DELETE)
     *   Note: Admin cannot delete themselves (their own account is protected)
     * 
     * This page is only accessible to admins (enforced by AuthenticationFilter).
     */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Manage Users - OccasioDesign</title>
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

<!-- ============ DASHBOARD LAYOUT ============ -->
<div class="dashboard-wrapper">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-title">Admin Menu</div>
        <a href="${pageContext.request.contextPath}/adminDashboard">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers" class="active">👥 Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents">🎉 Manage Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes">🎨 Manage Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings">📋 Manage Bookings</a>
        <div class="sidebar-title" style="margin-top:24px;">General</div>
        <a href="${pageContext.request.contextPath}/home">🏠 View Home Page</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="dashboard-main">
        <div class="dashboard-header">
            <h1>👥 Manage Users</h1>
            <p>View and manage all registered users in the system.</p>
        </div>

        <!-- Success/Error messages -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- ===== USERS TABLE ===== -->
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Address</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* ManageUsersServlet loads all users into "users" attribute */
                        List<User> users = (List<User>) request.getAttribute("users");
                        if (users != null && !users.isEmpty()) {
                            for (User u : users) {
                    %>
                    <tr>
                        <td>#<%= u.getUserId() %></td>
                        <td><strong><%= u.getFullName() %></strong></td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getPhone() != null ? u.getPhone() : "-" %></td>
                        <td>
                            <% if ("admin".equals(u.getRole())) { %>
                            <span class="badge badge-active">Admin</span>
                            <% } else { %>
                            <span class="badge badge-confirmed">User</span>
                            <% } %>
                        </td>
                        <td><%= u.getAddress() != null ? u.getAddress() : "-" %></td>
                        <td>
                            <%
                                /* Admin accounts cannot be deleted for safety */
                                if (!"admin".equals(u.getRole())) {
                            %>
                            <form method="post" action="${pageContext.request.contextPath}/manageUsers"
                                  style="display:inline">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="userId" value="<%= u.getUserId() %>"/>
                                <button class="btn btn-danger"
                                        onclick="return confirm('Delete user: <%= u.getFullName() %>? This will also delete their bookings!')">
                                    🗑️ Delete
                                </button>
                            </form>
                            <% } else { %>
                            <!-- Admin row — cannot delete -->
                            <span style="color:var(--text-light); font-size:0.85rem;">Protected</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align:center; color:var(--text-light); padding:30px;">
                            No users registered yet.
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
