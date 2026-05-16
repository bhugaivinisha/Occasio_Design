<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    
    <style>
        /* Simple & Clean About Page Styles */
        .about-hero {
            background: linear-gradient(135deg, var(--emerald-dark), var(--emerald));
            color: white;
            text-align: center;
            padding: 80px 20px;
        }
        .about-hero h1 {
            font-size: 2.8rem;
            margin-bottom: 15px;
        }
        .about-wrapper {
            max-width: 1100px;
            margin: 0 auto;
            padding: 50px 20px;
        }
        .section {
            margin-bottom: 70px;
        }
        .story-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: center;
        }
        .visual-box {
            background: linear-gradient(145deg, var(--emerald-dark), var(--emerald-mid));
            padding: 40px;
            border-radius: 20px;
            color: white;
            text-align: center;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-top: 4px solid var(--gold);
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--emerald);
        }
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        .value-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .contact-bar {
            background: var(--emerald-dark);
            color: white;
            padding: 40px;
            border-radius: 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        @media (max-width: 768px) {
            .story-grid, .contact-bar {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        
        <% if (isLoggedIn) { %>
            <% if (isAdmin) { %>
                <a href="${pageContext.request.contextPath}/adminDashboard">Admin Panel</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a>
                <a href="${pageContext.request.contextPath}/booking" class="btn-nav">Book Event</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-nav">Register</a>
        <% } %>
    </div>
</nav>

<!-- Hero -->
<section class="about-hero">
    <h1>About OccasioDesign</h1>
    <p>A Pokhara-based decoration service dedicated to making every occasion beautiful and memorable.</p>
</section>

<div class="about-wrapper">

    <!-- Story Section -->
    <div class="section story-grid">
        <div>
            <h2>Turning Occasions into Memories</h2>
            <p>OccasioDesign was founded with one simple belief — every celebration deserves to look extraordinary.</p>
            <p>We specialize in beautiful event decorations for birthdays, weddings, anniversaries, baby showers, graduations, festivals, and corporate events.</p>
        </div>
        
        <div class="visual-box">
            <h3 style="font-size:1.6rem; margin-bottom:15px;">"Every occasion deserves a decoration that speaks before anyone says a word."</h3>
            <p>— The OccasioDesign Team, Pokhara</p>
        </div>
    </div>

    <!-- Stats -->
    <div class="section">
        <h2 style="text-align:center; margin-bottom:30px;">Our Journey So Far</h2>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">5+</div>
                <p>Years of Experience</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">500+</div>
                <p>Events Decorated</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">20+</div>
                <p>Unique Themes</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">100%</div>
                <p>Client Satisfaction</p>
            </div>
        </div>
    </div>

    <!-- Values -->
    <div class="section">
        <h2 style="text-align:center; margin-bottom:30px;">Our Core Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <h3>Exceptional Quality</h3>
                <p>We use premium materials and hand-crafted decorations that look stunning in real life and in photos.</p>
            </div>
            <div class="value-card">
                <h3>Client First</h3>
                <p>Your vision is our priority. We listen carefully and customize everything to match your taste.</p>
            </div>
            <div class="value-card">
                <h3>Reliable Service</h3>
                <p>We respect your time. Every setup is delivered on schedule with full professionalism.</p>
            </div>
        </div>
    </div>

    <!-- Contact Bar -->
    <div class="contact-bar">
        <div>
            <h2>Ready to Plan Your Event?</h2>
            <p>Reach out to us and let us make your next occasion truly special.</p>
        </div>
        <div>
            <p><strong>Phone:</strong> 9810000000</p>
            <p><strong>Email:</strong> info@occasiodesign.com.np</p>
            <p><strong>Location:</strong> Pokhara, Nepal</p>
        </div>
    </div>

    <!-- CTA -->
    <div style="text-align:center; margin-top:40px;">
        <a href="${pageContext.request.contextPath}/contact" class="btn-primary">Contact Us</a>
       <a href="${pageContext.request.contextPath}/home#event-services" class="btn-secondary" style="margin-left:15px;">View Our Events</a>
    </div>

</div>

<!-- Footer -->
<footer>
    <p><strong>✦ OccasioDesign</strong> — Pokhara, Nepal</p>
    <p>9810000000 &nbsp;|&nbsp; info@occasiodesign.com.np</p>
    <p>&copy; 2026 OccasioDesign. All rights reserved.</p>
</footer>

</body>
</html>