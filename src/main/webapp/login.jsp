<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * login.jsp - Login page of OccasioDesign.
     * Users enter email and password here.
     * LoginServlet handles the form submission.
     */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login - OccasioDesign</title>
    <!-- Main stylesheet for the brown theme -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>

<!-- ============ NAVIGATION BAR ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-nav">Register</a>
    </div>
</nav>

<!-- ============ LOGIN FORM ============ -->
<!-- form-page class centers the form on screen (see main.css) -->
<div class="form-page">
    <div class="form-container">

        <!-- Brand logo at top of form -->
        <div class="form-brand">
            <span class="brand-icon">✦</span>
            <h1>OccasioDesign</h1>
            <p class="tagline">Your Perfect Event, Beautifully Designed</p>
        </div>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <h2>Welcome Back</h2>

            <!-- Show success message (e.g. after registration) -->
            <% if (request.getAttribute("success") != null) { %>
            <p class="success-msg"><%= request.getAttribute("success") %></p>
            <% } %>

            <!-- Show error message (e.g. wrong password) -->
            <% if (request.getAttribute("error") != null) { %>
            <p class="error-msg"><%= request.getAttribute("error") %></p>
            <% } %>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="your@email.com" required/>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required/>
            </div>

            <button type="submit" class="btn-primary">🔐 Log In</button>

            <p class="link-text">Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Register here</a>
            </p>
            <p class="link-text">
                <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
            </p>
        </form>
    </div>
</div>

</body>
</html>
