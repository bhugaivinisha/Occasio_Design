<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * contact.jsp - Contact Us page of OccasioDesign.
     * Provides a form for users to send inquiries.
     * Uses same navbar and brown theme as all other pages.
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
    <title>Contact Us - OccasioDesign</title>
    <!-- Same stylesheet as every other page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <style>
        /* Extra styles for the contact form */
        .contact-grid {
            display: flex; gap: 32px; flex-wrap: wrap; margin-top: 24px;
        }
        .contact-form-box {
            flex: 2 1 320px;
        }
        .contact-info-box {
            flex: 1 1 220px;
        }
        .info-item {
            display: flex; align-items: flex-start; gap: 12px; 
            padding: 16px; background: var(--cream); border-radius: 10px; 
            margin-bottom: 14px; border-left: 3px solid var(--brown-light);
        }
        .info-item .icon { font-size: 1.5rem; }
        .info-item strong { color: var(--brown-dark); display: block; margin-bottom: 3px; }
        .info-item span { color: var(--text-light); font-size: 0.9rem; }
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
        <h1>📬 Contact Us</h1>
        <p>Have a question or want to discuss your event? Send us a message — we reply within 24 hours!</p>

        <!-- Success / Error message from ContactServlet -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <div class="contact-grid">

            <!-- Contact Form -->
            <div class="contact-form-box">
                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="form-group">
                        <label>Your Full Name</label>
                        <input type="text" name="name" placeholder="e.g. Ram Bahadur Thapa" required/>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="your@email.com" required/>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject" placeholder="e.g. Birthday event inquiry"/>
                    </div>
                    <div class="form-group">
                        <label>Your Message</label>
                        <!-- Textarea for longer messages -->
                        <textarea name="message" rows="5"
                                  placeholder="Tell us about your event, date, number of guests..." 
                                  style="resize:vertical;" required></textarea>
                    </div>
                    <button type="submit" class="btn-primary">📤 Send Message</button>
                </form>
            </div>

            <!-- Contact Info -->
            <div class="contact-info-box">
                <h3 style="color:var(--brown-dark); margin-bottom:16px;">Other Ways to Reach Us</h3>
                
                <div class="info-item">
                    <span class="icon">📞</span>
                    <div>
                        <strong>Phone</strong>
                        <span>9810000000</span>
                    </div>
                </div>
                <div class="info-item">
                    <span class="icon">✉</span>
                    <div>
                        <strong>Email</strong>
                        <span>info@occasiodesign.com.np</span>
                    </div>
                </div>
                <div class="info-item">
                    <span class="icon">📍</span>
                    <div>
                        <strong>Location</strong>
                        <span>Kathmandu, Nepal</span>
                    </div>
                </div>
                <div class="info-item">
                    <span class="icon">🕐</span>
                    <div>
                        <strong>Working Hours</strong>
                        <span>Sunday – Friday, 9am – 6pm</span>
                    </div>
                </div>
            </div>
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
