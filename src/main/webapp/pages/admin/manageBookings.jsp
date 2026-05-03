<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.Booking" %>
<%
    /**
     * manageBookings.jsp - Admin page to manage all Bookings.
     * 
     * Admin can:
     *   - View all bookings from all users (READ)
     *   - Confirm a booking (UPDATE status to "confirmed")
     *   - Cancel a booking (UPDATE status to "cancelled")
     * 
     * This page is only accessible to admins (enforced by AuthenticationFilter).
     */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Manage Bookings - OccasioDesign</title>
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
        <a href="${pageContext.request.contextPath}/manageUsers">👥 Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageEvents">🎉 Manage Events</a>
        <a href="${pageContext.request.contextPath}/manageThemes">🎨 Manage Themes</a>
        <a href="${pageContext.request.contextPath}/manageBookings" class="active">📋 Manage Bookings</a>
        <div class="sidebar-title" style="margin-top:24px;">General</div>
        <a href="${pageContext.request.contextPath}/home">🏠 View Home Page</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="dashboard-main">
        <div class="dashboard-header">
            <h1>📋 Manage Bookings</h1>
            <p>Review all event bookings and confirm or cancel them.</p>
        </div>

        <!-- Success/Error messages -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- ===== BOOKINGS TABLE ===== -->
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
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* ManageBookingsServlet loads all bookings into "bookings" attribute */
                        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                        if (bookings != null && !bookings.isEmpty()) {
                            for (Booking b : bookings) {
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
                                /* Show color-coded status badge */
                                String status = b.getStatus();
                                if ("confirmed".equals(status)) {
                            %>
                            <span class="badge badge-confirmed">✅ Confirmed</span>
                            <% } else if ("cancelled".equals(status)) { %>
                            <span class="badge badge-cancelled">❌ Cancelled</span>
                            <% } else { %>
                            <span class="badge badge-pending">⏳ Pending</span>
                            <% } %>
                        </td>
                        <td>
                            <!-- CONFIRM button — only show if not already confirmed -->
                            <% if (!"confirmed".equals(b.getStatus())) { %>
                            <form method="post" action="${pageContext.request.contextPath}/manageBookings"
                                  style="display:inline">
                                <input type="hidden" name="action" value="confirm"/>
                                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"/>
                                <button class="btn btn-success">✅ Confirm</button>
                            </form>
                            <% } %>

                            <!-- CANCEL button — only show if not already cancelled -->
                            <% if (!"cancelled".equals(b.getStatus())) { %>
                            <form method="post" action="${pageContext.request.contextPath}/manageBookings"
                                  style="display:inline">
                                <input type="hidden" name="action" value="cancel"/>
                                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"/>
                                <button class="btn btn-danger"
                                        onclick="return confirm('Cancel this booking?')">❌ Cancel</button>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" style="text-align:center; color:var(--text-light); padding:30px;">
                            No bookings yet. When users book events, they will appear here.
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
