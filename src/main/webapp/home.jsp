<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.EventType" %>
<%
    /**
     * home.jsp - Main home/landing page of OccasioDesign.
     * 
     * This page is shown to ALL visitors (logged in or not).
     * It displays event types loaded by HomeServlet from the database.
     * Clicking "Book Now" on an event card goes to the booking form.
     */

    // Get the logged-in user's role from session (null if not logged in)
    String role = (String) session.getAttribute("role");
    String fullName = (String) session.getAttribute("fullName");
    boolean isLoggedIn = (role != null);
    boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OccasioDesign - Your Perfect Event</title>
    <!-- Link to our main stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <style>
        /* Extra styles just for home page */
        .hero { 
            background: linear-gradient(135deg, var(--brown-dark) 0%, var(--brown-mid) 60%, var(--brown-light) 100%);
            color: white; padding: 90px 40px; text-align: center; 
        }
        .hero h1 { font-size: 2.8rem; font-weight: 700; margin-bottom: 14px; text-shadow: 0 2px 8px rgba(0,0,0,0.3); }
        .hero p { font-size: 1.15rem; opacity: 0.9; max-width: 580px; margin: 0 auto 28px; }
        .hero-buttons { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }
        .btn-hero-primary {
            display: inline-block; padding: 13px 34px; background: var(--gold);
            color: var(--brown-dark); border-radius: 8px; text-decoration: none;
            font-size: 1rem; font-weight: 700; transition: all 0.2s;
            box-shadow: 0 4px 15px rgba(212,168,83,0.4);
        }
        .btn-hero-primary:hover { background: var(--gold-dark); color: white; transform: translateY(-2px); }
        .btn-hero-secondary {
            display: inline-block; padding: 13px 34px; background: transparent;
            color: white; border: 2px solid rgba(255,255,255,0.6); border-radius: 8px;
            text-decoration: none; font-size: 1rem; font-weight: 600; transition: all 0.2s;
        }
        .btn-hero-secondary:hover { background: rgba(255,255,255,0.15); border-color: white; }

        /* Theme preview strip */
        .theme-strip { background: #F5EBE5; padding: 28px 0; }
        .theme-strip-inner { max-width: 1100px; margin: 0 auto; padding: 0 24px; }
        .theme-strip h2 { color: var(--brown-dark); margin-bottom: 14px; font-size: 1.1rem; font-weight: 600; }
        .theme-images { display: flex; gap: 12px; overflow-x: auto; padding: 8px 0; }
        .theme-img-card { 
            min-width: 190px; border-radius: 12px; overflow: hidden; 
            box-shadow: 0 4px 12px rgba(107,58,42,0.15); transition: transform 0.25s; cursor: pointer;
        }
        .theme-img-card:hover { transform: scale(1.04); }
        .theme-img-card img { width: 190px; height: 130px; object-fit: cover; display: block; }
        .theme-img-caption { background: var(--brown-dark); color: white; font-size: 0.78rem; padding: 6px 10px; text-align: center; }

        /* Event cards section */
        .events-section { max-width: 1100px; margin: 0 auto; padding: 50px 24px 60px; }
        .events-section h2 { color: var(--brown-dark); margin-bottom: 8px; font-size: 1.75rem; font-weight: 700; }
        .section-sub { color: var(--text-light); margin-bottom: 28px; font-size: 1rem; }
        .event-card {
            background: white; border-radius: 14px; overflow: hidden;
            box-shadow: 0 4px 16px rgba(74,44,23,0.12); flex: 1 1 240px;
            transition: transform 0.25s, box-shadow 0.25s; display: flex; flex-direction: column;
        }
        .event-card:hover { transform: translateY(-5px); box-shadow: 0 8px 28px rgba(74,44,23,0.2); }
        .event-card img { width: 100%; height: 160px; object-fit: cover; display: block; }
        .event-card-body { padding: 18px; flex: 1; display: flex; flex-direction: column; }
        .event-card-body h3 { color: var(--brown-dark); margin-bottom: 6px; font-size: 1.05rem; }
        .event-card-body p { color: var(--text-light); font-size: 0.87rem; flex: 1; line-height: 1.5; }
        .event-card-body .price { color: var(--brown-mid); font-weight: 700; margin: 10px 0; font-size: 0.95rem; }
        .book-btn {
            display: block; text-align: center; padding: 10px;
            background: var(--brown-mid); color: white; text-decoration: none;
            border-radius: 8px; font-size: 0.9rem; font-weight: 600; transition: background 0.2s;
        }
        .book-btn:hover { background: var(--brown-dark); }
    </style>
</head>
<body>

<!-- ============ NAVIGATION BAR (same on every public page) ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <%
            /* Show different nav links based on login status */
            if (isLoggedIn) {
                if (isAdmin) {
        %>
            <a href="${pageContext.request.contextPath}/adminDashboard">Admin Panel</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <%  } else { %>
            <a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a>
            <a href="${pageContext.request.contextPath}/booking" class="btn-nav">Book Event</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <%  } } else { %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-nav">Register</a>
        <% } %>
    </div>
</nav>

<!-- ============ HERO SECTION ============ -->
<div class="hero">
    <h1>Your Perfect Event,<br>Beautifully Designed</h1>
    <p>Professional decoration services for every occasion in Nepal — birthdays, weddings, festivals & more</p>
    <div class="hero-buttons">
        <% if (!isLoggedIn) { %>
        <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">Book Your Event →</a>
        <a href="${pageContext.request.contextPath}/about" class="btn-hero-secondary">Learn More</a>
        <% } else if (!isAdmin) { %>
        <a href="${pageContext.request.contextPath}/booking" class="btn-hero-primary">Book New Event →</a>
        <a href="${pageContext.request.contextPath}/userDashboard" class="btn-hero-secondary">My Bookings</a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/adminDashboard" class="btn-hero-primary">Admin Dashboard →</a>
        <% } %>
    </div>
</div>

<!-- ============ THEME PREVIEW STRIP ============ -->
<div class="theme-strip">
    <div class="theme-strip-inner">
        <h2>✨ Our Decoration Themes</h2>
        <div class="theme-images">
            <!-- Static theme preview images -->
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/birthday_rainbow.jpg" alt="Birthday"/>
                <div class="theme-img-caption">Rainbow Birthday</div>
            </div>
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/anniversary_golden.jpg" alt="Anniversary"/>
                <div class="theme-img-caption">Golden Anniversary</div>
            </div>
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/engagement.jpg" alt="Engagement"/>
                <div class="theme-img-caption">Elegant Proposal</div>
            </div>
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/babyshower_pastel.jpg" alt="Baby Shower"/>
                <div class="theme-img-caption">Pastel Baby Shower</div>
            </div>
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/festival_glow.jpg" alt="Festival"/>
                <div class="theme-img-caption">Festive Glow</div>
            </div>
            <div class="theme-img-card">
                <img src="${pageContext.request.contextPath}/images/themes/graduation_glow.jpg" alt="Graduation"/>
                <div class="theme-img-caption">Graduation Glow</div>
            </div>
        </div>
    </div>
</div>

<!-- ============ EVENT TYPES SECTION (loaded from DB by HomeServlet) ============ -->
<div class="events-section">
    <h2>Our Event Services</h2>
    <p class="section-sub">Choose your occasion — we handle all the decoration magic ✨</p>

    <div class="card-grid" style="display:flex; flex-wrap:wrap; gap:22px;">
        <%
            /* 
             * HomeServlet loads event types from the database
             * and puts them in request attribute "eventTypes".
             * We loop through each event type and show a card.
             */
            List<EventType> eventTypes = (List<EventType>) request.getAttribute("eventTypes");
            
            /* Image names matching our themes folder */
            String[] themeImages = {
                "birthday_rainbow", "anniversary_golden", "engagement",
                "babyshower_pastel", "graduation_glow", "corporate_minimal",
                "festival_glow", "farewell_memory"
            };

            if (eventTypes != null && !eventTypes.isEmpty()) {
                int i = 0;
                for (EventType et : eventTypes) {
                    /* Pick image — cycle through if more events than images */
                    String img = themeImages[i % themeImages.length];
        %>
        <div class="event-card">
            <img src="${pageContext.request.contextPath}/images/themes/<%= img %>.jpg"
                 alt="<%= et.getEventName() %>"
                 onerror="this.src='${pageContext.request.contextPath}/images/themes/birthday_rainbow.jpg'"/>
            <div class="event-card-body">
                <h3><%= et.getEventName() %></h3>
                <p><%= et.getDescription() != null ? et.getDescription() : "Beautiful decoration for your special day." %></p>
                <p class="price">From Rs. <%= et.getBasePrice() %></p>
                <%
                    /* 
                     * If user is logged in as regular user → go to booking form with event pre-selected.
                     * If not logged in → go to register page first.
                     */
                    if (!isLoggedIn) {
                %>
                <a href="${pageContext.request.contextPath}/register" class="book-btn">Book Now</a>
                <% } else if (!isAdmin) { %>
                <a href="${pageContext.request.contextPath}/booking?eventTypeId=<%= et.getEventId() %>" class="book-btn">Book Now</a>
                <% } %>
            </div>
        </div>
        <%
                    i++;
                }
            } else {
        %>
        <!-- Show message if no events loaded from database yet -->
        <p style="color: var(--text-light); padding: 30px;">
            No event types available yet. Admin can add them from the Admin Dashboard.
        </p>
        <% } %>
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
