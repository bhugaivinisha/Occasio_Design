<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * about.jsp - About page of OccasioDesign.
     * Shows information about the company/institution.
     * Uses same navbar and theme as all other pages.
     */
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (role != null);
    boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>About Us - OccasioDesign</title>
    <!-- Same stylesheet as every other page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
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

<!-- ============ PAGE CONTENT ============ -->
<div class="page-content">
    <div class="content-card">
        <h1>✦ About OccasioDesign</h1>

        <p>
            <strong>OccasioDesign</strong> is a Kathmandu-based professional event decoration service
            dedicated to helping families, businesses, and communities create beautiful, 
            unforgettable moments. We specialize in birthdays, weddings, anniversaries, 
            baby showers, graduations, festivals, corporate events, and much more.
        </p>

        <p>
            Our mission is simple — to make every occasion truly special. We offer a wide 
            range of hand-crafted decoration themes designed by our experienced team, 
            all tailored to your personal taste and budget.
        </p>

        <p>
            Whether you are planning an intimate family celebration or a grand corporate event, 
            OccasioDesign has you covered. Simply choose your event type, pick a decoration theme, 
            tell us your date and guest count — and we will handle everything else.
        </p>

        <!-- Info cards row -->
        <div style="display:flex; flex-wrap:wrap; gap:20px; margin-top:32px;">
            <div style="flex:1 1 180px; background:var(--brown-pale); border-radius:10px; padding:22px; text-align:center;">
                <div style="font-size:2.2rem;">🎂</div>
                <h3 style="color:var(--brown-dark); margin:8px 0 4px;">5+ Years</h3>
                <p style="color:var(--text-light); font-size:0.88rem;">Of decoration experience</p>
            </div>
            <div style="flex:1 1 180px; background:var(--brown-pale); border-radius:10px; padding:22px; text-align:center;">
                <div style="font-size:2.2rem;">🎉</div>
                <h3 style="color:var(--brown-dark); margin:8px 0 4px;">500+ Events</h3>
                <p style="color:var(--text-light); font-size:0.88rem;">Successfully decorated</p>
            </div>
            <div style="flex:1 1 180px; background:var(--brown-pale); border-radius:10px; padding:22px; text-align:center;">
                <div style="font-size:2.2rem;">✨</div>
                <h3 style="color:var(--brown-dark); margin:8px 0 4px;">20+ Themes</h3>
                <p style="color:var(--text-light); font-size:0.88rem;">Unique decoration styles</p>
            </div>
            <div style="flex:1 1 180px; background:var(--brown-pale); border-radius:10px; padding:22px; text-align:center;">
                <div style="font-size:2.2rem;">📍</div>
                <h3 style="color:var(--brown-dark); margin:8px 0 4px;">Kathmandu</h3>
                <p style="color:var(--text-light); font-size:0.88rem;">Nepal based service</p>
            </div>
        </div>

        <!-- Contact info -->
        <div style="margin-top:32px; padding:20px; background:var(--cream); border-radius:10px; border-left:4px solid var(--brown-mid);">
            <h3 style="color:var(--brown-dark); margin-bottom:10px;">📬 Get In Touch</h3>
            <p>📞 Phone: <strong>9810000000</strong></p>
            <p>✉ Email: <strong>info@occasiodesign.com.np</strong></p>
            <p>📍 Address: <strong>Kathmandu, Nepal</strong></p>
        </div>

        <!-- Call to action -->
        <div style="margin-top:28px; text-align:center;">
            <a href="${pageContext.request.contextPath}/contact"
               style="display:inline-block; padding:12px 30px; background:var(--brown-mid); color:white; 
                      text-decoration:none; border-radius:8px; font-weight:600; margin-right:12px;">
                Contact Us
            </a>
            <a href="${pageContext.request.contextPath}/home"
               style="display:inline-block; padding:12px 30px; background:var(--brown-pale); color:var(--brown-dark); 
                      text-decoration:none; border-radius:8px; font-weight:600; border:1px solid var(--brown-light);">
                View Events
            </a>
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
