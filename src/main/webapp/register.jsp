<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * register.jsp - User registration page of OccasioDesign.
     * Users fill in their details to create an account.
     * RegisterServlet handles the form submission.
     */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register - OccasioDesign</title>
    <!-- Main stylesheet for the brown theme -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    
    <style>
        /* Register page has a wider form because more fields */
        .form-container { max-width: 520px; }
    </style>
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

<!-- ============ REGISTER FORM ============ -->

<div class="form-page">
    <div class="form-container">

        <!-- Brand logo at top -->
        <div class="form-brand">
            <span class="brand-icon">✦</span>
            <h1>OccasioDesign</h1>
            <p class="tagline">Create your free account</p>
        </div>

        <!-- Action = /register, RegisterServlet processes this POST -->
        <form action="${pageContext.request.contextPath}/register" method="post">
            <h2>Create Account</h2>

            <!-- General error message -->
            <% if (request.getAttribute("error") != null) { %>
            <p class="error-msg"><%= request.getAttribute("error") %></p>
            <% } %>

            <!-- Full Name field -->
            <div class="form-group">
                <label>Full Name</label>
                <!-- Keep entered value on error (RegisterServlet puts it back as attribute) -->
                <input type="text" name="fullName" placeholder="Your full name"
                       value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                       required/>
                <% if (request.getAttribute("errorFullName") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorFullName") %></span>
                <% } %>
            </div>

            <!-- Email field -->
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="your@email.com"
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       required/>
                <% if (request.getAttribute("errorEmail") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorEmail") %></span>
                <% } %>
            </div>

            <!-- Phone field -->
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="98XXXXXXXX"
                       value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                       required/>
                <% if (request.getAttribute("errorPhone") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorPhone") %></span>
                <% } %>
            </div>

            <!-- Password field -->
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password"
                       placeholder="Min 8 chars, 1 uppercase, 1 number, 1 symbol" required/>
                <% if (request.getAttribute("errorPassword") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorPassword") %></span>
                <% } %>
            </div>

            <!-- Confirm Password field -->
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="Re-enter password" required/>
                <% if (request.getAttribute("errorConfirm") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorConfirm") %></span>
                <% } %>
            </div>

            <!-- Gender dropdown -->
            <div class="form-group">
                <label>Gender</label>
                <select name="gender">
                    <option value="">-- Select Gender --</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
                <% if (request.getAttribute("errorGender") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorGender") %></span>
                <% } %>
            </div>

            <!-- Date of Birth field -->
            <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" name="dateOfBirth" required/>
                <% if (request.getAttribute("errorDob") != null) { %>
                <span class="field-error"><%= request.getAttribute("errorDob") %></span>
                <% } %>
            </div>

            <!-- Address field -->
            <div class="form-group">
                <label>Address (optional)</label>
                <input type="text" name="address" placeholder="City, Nepal"
                       value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>"/>
            </div>

            <button type="submit" class="btn-primary">Create Account</button><br><br>

            <p class="link-text">Already have an account?
               <a href="${pageContext.request.contextPath}/login" class="btn-secondary">Login here</a>
            </p>
        </form>
    </div>
</div>

</body>
</html>
