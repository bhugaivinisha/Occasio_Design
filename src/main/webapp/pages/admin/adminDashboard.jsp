<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.occasiodesign.model.Booking" %>
<%
    /**
     * adminDashboard.jsp - Main admin control panel.
     * 
     * Shows:
     *   - Stats (total users, bookings, events, themes)
     *   - Quick links to all management pages
     *   - Recent bookings table
     * 
     * This page is only accessible to admins (enforced by AuthenticationFilter).
     */
    String adminName = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard - OccasioDesign</title>
    <!-- Main stylesheet for the brown theme -->
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
        <!-- "active" class highlights current page link -->
        <a href="${pageContext.request.contextPath}/adminDashboard" class="active">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageUsers">👥 Manage Users</a>
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
            <h1>Welcome, <%= adminName != null ? adminName : "Admin" %>! 👋</h1>
            <p>Here is an overview of your OccasioDesign system today.</p>
        </div>

        <!-- ===== STATS CARDS ===== -->
        <div class="stats">
            <div class="stat-card">
                <div class="number">
                    <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %>
                </div>
                <div class="label">👥 Total Users</div>
            </div>
            <div class="stat-card">
                <div class="number">
                    <%= request.getAttribute("totalBookings") != null ? request.getAttribute("totalBookings") : 0 %>
                </div>
                <div class="label">📋 Total Bookings</div>
            </div>
            <div class="stat-card">
                <div class="number">
                    <%= request.getAttribute("totalEvents") != null ? request.getAttribute("totalEvents") : 0 %>
                </div>
                <div class="label">🎉 Event Types</div>
            </div>
            <div class="stat-card">
                <div class="number">
                    <%= request.getAttribute("totalThemes") != null ? request.getAttribute("totalThemes") : 0 %>
                </div>
                <div class="label">🎨 Themes</div>
            </div>
        </div>

        <!-- ===== QUICK ACTION LINKS ===== -->
        <div style="display:flex; flex-wrap:wrap; gap:14px; margin-bottom:32px;">
            <a href="${pageContext.request.contextPath}/manageUsers"
               style="padding:12px 22px; background:var(--brown-mid); color:white; border-radius:8px; text-decoration:none; font-weight:600; transition:background 0.2s;"
               onmouseover="this.style.background='var(--brown-dark)'"
               onmouseout="this.style.background='var(--brown-mid)'">
                👥 Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/manageEvents"
               style="padding:12px 22px; background:var(--brown-mid); color:white; border-radius:8px; text-decoration:none; font-weight:600; transition:background 0.2s;"
               onmouseover="this.style.background='var(--brown-dark)'"
               onmouseout="this.style.background='var(--brown-mid)'">
                🎉 Manage Events
            </a>
            <a href="${pageContext.request.contextPath}/manageThemes"
               style="padding:12px 22px; background:var(--brown-mid); color:white; border-radius:8px; text-decoration:none; font-weight:600; transition:background 0.2s;"
               onmouseover="this.style.background='var(--brown-dark)'"
               onmouseout="this.style.background='var(--brown-mid)'">
                🎨 Manage Themes
            </a>
            <a href="${pageContext.request.contextPath}/manageBookings"
               style="padding:12px 22px; background:var(--brown-mid); color:white; border-radius:8px; text-decoration:none; font-weight:600; transition:background 0.2s;"
               onmouseover="this.style.background='var(--brown-dark)'"
               onmouseout="this.style.background='var(--brown-mid)'">
                📋 Manage Bookings
            </a>
        </div>

        <!-- ===== RECENT BOOKINGS TABLE ===== -->
        <h2 style="color:var(--brown-dark); margin-bottom:16px; font-size:1.3rem;">📋 Recent Bookings</h2>

        <!-- Success/Error messages from actions -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>User ID</th>
                        <th>Event Date</th>
                        <th>Location</th>
                        <th>Guests</th>
                        <th>Total (Rs.)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* Get recent bookings list from AdminDashboardServlet */
                        List<Booking> bookings = (List<Booking>) request.getAttribute("recentBookings");
                        if (bookings != null && !bookings.isEmpty()) {
                            int count = 0;
                            for (Booking b : bookings) {
                                if (count >= 10) break; /* Show max 10 recent bookings */
                                count++;
                    %>
                    <tr>
                        <td>#<%= b.getBookingId() %></td>
                        <td>User #<%= b.getUserId() %></td>
                        <td><%= b.getEventDate() %></td>
                        <td><%= b.getEventLocation() %></td>
                        <td><%= b.getNumberOfGuests() %></td>
                        <td>Rs. <%= b.getTotalPrice() %></td>
                        <td>
                            <%
                                /* Color-coded status badge */
                                String status = b.getStatus();
                                if ("confirmed".equals(status)) {
                            %>
                            <span class="badge badge-confirmed">Confirmed</span>
                            <% } else if ("cancelled".equals(status)) { %>
                            <span class="badge badge-cancelled">Cancelled</span>
                            <% } else { %>
                            <span class="badge badge-pending">Pending</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align:center; color:var(--text-light); padding:30px;">
                            No bookings yet. When users book events, they will appear here.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Link to see all bookings -->
        <div style="margin-top:14px; text-align:right;">
            <a href="${pageContext.request.contextPath}/manageBookings"
               style="color:var(--brown-mid); text-decoration:none; font-weight:600; font-size:0.9rem;">
                View All Bookings →
            </a>
        </div>
    </div>
</div>

</body>
</html>
