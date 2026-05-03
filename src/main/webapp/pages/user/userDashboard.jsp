<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.occasiodesign.model.Booking" %>
<%
    /**
     * userDashboard.jsp - Dashboard for regular logged-in users.
     * 
     * Users can see:
     *   - Welcome message with their name
     *   - All their bookings with status
     *   - Cancel a booking (if not already cancelled)
     * 
     * This page is only accessible to logged-in users (enforced by AuthenticationFilter).
     */
    String fullName = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Dashboard - OccasioDesign</title>
    <!-- Main stylesheet — same as every other page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>

<!-- ============ NAVIGATION BAR ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a>
        <a href="${pageContext.request.contextPath}/booking" class="btn-nav">Book Event</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<!-- ============ DASHBOARD LAYOUT ============ -->
<div class="dashboard-wrapper">

    <!-- USER SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-title">My Account</div>
        <a href="${pageContext.request.contextPath}/userDashboard" class="active">📋 My Bookings</a>
        <a href="${pageContext.request.contextPath}/booking">🎉 New Booking</a>
        <div class="sidebar-title" style="margin-top:24px;">Browse</div>
        <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
        <a href="${pageContext.request.contextPath}/about">ℹ️ About Us</a>
        <a href="${pageContext.request.contextPath}/contact">📬 Contact</a>
        <div class="sidebar-title" style="margin-top:24px;">Account</div>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>

    <!-- MAIN CONTENT AREA -->
    <div class="dashboard-main">

        <!-- Welcome Banner -->
        <div style="background:white; padding:22px 26px; border-radius:12px; margin-bottom:26px; 
                    border-left:5px solid var(--brown-mid); box-shadow:var(--shadow-sm);">
            <h1 style="margin:0; font-size:1.5rem; color:var(--brown-dark);">
                👋 Welcome, <%= fullName != null ? fullName : "User" %>!
            </h1>
            <p style="color:var(--text-light); margin-top:6px;">
                Manage your event bookings here. Need something new?
                <a href="${pageContext.request.contextPath}/booking"
                   style="color:var(--brown-mid); font-weight:600; text-decoration:none;">Book an event →</a>
            </p>
        </div>

        <!-- Success/Error messages -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- Bookings Section Header -->
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
            <h2 style="color:var(--brown-dark); font-size:1.3rem; margin:0;">📋 My Bookings</h2>
            <a href="${pageContext.request.contextPath}/booking"
               class="btn btn-warning">+ New Booking</a>
        </div>

        <!-- ===== MY BOOKINGS TABLE ===== -->
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Event Date</th>
                        <th>Location</th>
                        <th>Guests</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* UserDashboardServlet loads this user's bookings into "myBookings" */
                        List<Booking> bookings = (List<Booking>) request.getAttribute("myBookings");
                        if (bookings != null && !bookings.isEmpty()) {
                            for (Booking b : bookings) {
                    %>
                    <tr>
                        <td>#<%= b.getBookingId() %></td>
                        <td><%= b.getEventDate() %></td>
                        <td><%= b.getEventLocation() %></td>
                        <td><%= b.getNumberOfGuests() %> people</td>
                        <td>Rs. <%= b.getTotalPrice() %></td>
                        <td>
                            <%
                                /* Color-coded status badge */
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
                            <%
                                /* User can cancel only if booking is not already cancelled */
                                if (!"cancelled".equals(b.getStatus())) {
                            %>
                            <!-- GET request to cancel — BookingServlet handles action=cancel -->
                            <a href="${pageContext.request.contextPath}/booking?action=cancel&id=<%= b.getBookingId() %>"
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to cancel booking #<%= b.getBookingId() %>?')">
                                Cancel
                            </a>
                            <% } else { %>
                            <span style="color:var(--text-light); font-size:0.85rem;">No actions</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align:center; color:var(--text-light); padding:36px;">
                            You have no bookings yet!
                            <a href="${pageContext.request.contextPath}/booking"
                               style="color:var(--brown-mid); font-weight:600; text-decoration:none; margin-left:6px;">
                                Book your first event →
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ============ FOOTER ============ -->
<footer>
    <p><strong style="color: var(--gold);">✦ OccasioDesign</strong> — Kathmandu, Nepal</p>
    <p style="margin-top: 8px;">📞 9810000000 &nbsp;|&nbsp; ✉ info@occasiodesign.com.np</p>
    <p style="margin-top: 12px; font-size: 0.8rem;">© 2026 OccasioDesign. All rights reserved.</p>
</footer>

</body>
</html>
