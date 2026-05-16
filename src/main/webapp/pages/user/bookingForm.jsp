<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.EventType, com.occasiodesign.model.Theme" %>
<%
    /**
     * bookingForm.jsp - Event booking form for logged-in users.
     * 
     * Users fill in:
     *   - Event type (pre-selected if they came from home page card)
     *   - Decoration theme
     *   - Event date
     *   - Event location
     *   - Number of guests
     *   - Special requests
     * 
     * This page is only accessible to logged-in users (enforced by AuthenticationFilter).
     * BookingServlet handles the form submission.
     */

    /* Get any pre-selected event type ID (passed from home page "Book Now" button) */
    String preSelectedEventId = request.getParameter("eventTypeId");
    if (preSelectedEventId == null) preSelectedEventId = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Book an Event - OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <style>
        /* Booking form page — colors from main.css vars */
        .booking-wrapper { max-width: 750px; margin: 50px auto; padding: 0 20px 60px; }
        .booking-card { background: white; border-radius: 22px; padding: 40px; box-shadow: var(--shadow-md); border-top: 5px solid var(--gold); }
        .booking-card h1 { color: var(--purple-dark); font-size: 1.7rem; margin-bottom: 6px; font-family: Georgia, serif; font-weight: 800; }
        .booking-card .subtitle { color: var(--text-light); margin-bottom: 28px; font-size: 0.95rem; }
        .price-preview {
            background: var(--purple-ghost); border: 1.5px solid #ddd6fe;
            border-radius: 12px; padding: 16px 20px; margin-bottom: 24px; border-left: 4px solid var(--gold);
        }
        .price-preview strong { color: var(--purple-dark); }
    </style>
</head>
<body>

<!-- ============ NAVIGATION BAR ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home"> Home</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a>
        <a href="${pageContext.request.contextPath}/booking" class="btn-nav">Book Event</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<!-- ============ BOOKING FORM ============ -->
<div class="booking-wrapper">
    <div class="booking-card">
        <h1> Book Your Event</h1>
        <p class="subtitle">Fill in the details below and our team will confirm your booking shortly.</p>

        <!-- Success message (e.g. booking submitted successfully) -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>

        <!-- Error message (e.g. missing fields or DB error) -->
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- Booking form — POST to BookingServlet -->
        <form action="${pageContext.request.contextPath}/booking" method="post">

            <!-- Hidden action field -->
            <input type="hidden" name="action" value="book"/>

            <!-- Event Type Dropdown -->
            <div class="form-group">
                <label>Event Type *</label>
                <select name="eventTypeId" id="eventTypeSelect" required>
                    <option value="">-- Choose your event type --</option>
                    <%
                        /* BookingServlet loads all event types into "eventTypes" attribute */
                        List<EventType> eventTypes = (List<EventType>) request.getAttribute("eventTypes");
                        if (eventTypes != null) {
                            for (EventType et : eventTypes) {
                                /* Pre-select the event if user came from a "Book Now" card */
                                boolean selected = preSelectedEventId.equals(String.valueOf(et.getEventTypeId()));
                    %>
                    <option value="<%= et.getEventTypeId() %>"
                        <%= selected ? "selected" : "" %>>
                        <%= et.getEventName() %> — Rs. <%= et.getBasePrice() %>
                    </option>
                    <% } } %>
                </select>
            </div>

            <!-- Decoration Theme Dropdown -->
            <div class="form-group">
                <label>Decoration Theme *</label>
                <select name="themeId" required>
                    <option value="">-- Choose a decoration theme --</option>
                    <%
                        /* BookingServlet loads all themes into "themes" attribute */
                        List<Theme> themes = (List<Theme>) request.getAttribute("themes");
                        if (themes != null) {
                            for (Theme t : themes) {
                    %>
                    <option value="<%= t.getThemeId() %>">
                        <%= t.getThemeName() %> (+Rs. <%= t.getExtraPrice() %>)
                    </option>
                    <% } } %>
                </select>
            </div>

            <!-- Two fields side by side: Event Date + Number of Guests -->
            <div style="display:flex; gap:18px; flex-wrap:wrap;">
                <div class="form-group" style="flex:1 1 200px;">
                    <label>Event Date *</label>
                    <input type="date" name="eventDate"
                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                           required/>
                    <!-- min="" prevents booking past dates -->
                </div>
                <div class="form-group" style="flex:1 1 150px;">
                    <label>Number of Guests *</label>
                    <input type="number" name="numberOfGuests" placeholder="e.g. 50"
                           min="1" max="10000" required/>
                </div>
            </div>

            <!-- Event Location -->
            <div class="form-group">
                <label>Event Location / Venue *</label>
                <input type="text" name="eventLocation"
                       placeholder="e.g. Banquet Hall, Thamel, Kathmandu" required/>
            </div>

            <!-- Special Requests (optional) -->
            <div class="form-group">
                <label>Special Requests (optional)</label>
                <textarea name="specialRequests" rows="3"
                          placeholder="Any special color preferences, arrangements, or requests..."
                          style="resize:vertical;"></textarea>
            </div>

            <!-- Price Info Box -->
            <div class="price-preview">
                <strong>💡 Pricing Info:</strong> The total price is calculated as:
                Event Base Price + Theme Extra Price.
                Our team will confirm the final amount when approving your booking.
            </div>

            <button type="submit" class="btn-primary">
                Submit Booking Request
            </button>

            <p class="link-text" style="margin-top:16px;">
                <a href="${pageContext.request.contextPath}/userDashboard">← Back to My Dashboard</a>
            </p>
        </form>
    </div>
</div>

<!-- ============ FOOTER ============ -->
<footer>
    <p><strong style="color: var(--gold);">✦ OccasioDesign</strong> — Pokhara, Nepal</p>
    <p style="margin-top: 8px;"> 9810000000 &nbsp;|&nbsp; info@occasiodesign.com.np</p>
    <p style="margin-top: 12px; font-size: 0.8rem;">© 2026 OccasioDesign. All rights reserved.</p>
</footer>

</body>
</html>
