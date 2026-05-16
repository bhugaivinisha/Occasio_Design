<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String fullName = (String) session.getAttribute("fullName");
    String email    = (String) session.getAttribute("email");
    String phone    = (String) session.getAttribute("phone");
    String address  = (String) session.getAttribute("address");
    if (fullName == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Profile - OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>

<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<div class="form-page">
    <div class="form-container">

        <div class="form-brand">
            <span class="brand-icon">✦</span>
            <h1>Edit My Profile</h1>
            <p class="tagline">Update your personal information</p>
        </div>

        <!-- Success or Error message show...  -->
        <% if (request.getAttribute("success") != null) { %>
        <p class="success-msg"><%= request.getAttribute("success") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <!-- Profile update form -->
        <form action="${pageContext.request.contextPath}/editProfile" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName"
                       value="<%= fullName != null ? fullName : "" %>" required/>
            </div>

            <div class="form-group">
                <label>Email (cannot change)</label>
                <!-- Email change garna milena ---- security ko lagi -->
                <input type="email" value="<%= email != null ? email : "" %>" disabled/>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone"
                       value="<%= phone != null ? phone : "" %>" required/>
            </div>

            <div class="form-group">
                <label>Address</label>
                <input type="text" name="address"
                       value="<%= address != null ? address : "" %>"/>
            </div>

            <button type="submit" class="btn-primary">Save Changes</button>
            <p class="link-text" style="margin-top:14px;">
                <a href="${pageContext.request.contextPath}/userDashboard">← Back to Dashboard</a>
            </p>
        </form>
    </div>
</div>

</body>
</html>