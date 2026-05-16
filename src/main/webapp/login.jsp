<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    /**
     * login.jsp - Login page with TWO role buttons like eVision.
     * User clicks "User Login" or "Admin Login" first,
     * then the correct form appears.
     */

    // Check which form to show — default is nothing (show buttons)
    String loginType = request.getParameter("type");
    if (loginType == null) loginType = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login - OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login_register.css"/>
    <style>
        /* ── TWO BIG BUTTONS (like eVision) ── */
        .role-chooser {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin: 40px 0 10px;
            flex-wrap: wrap;
        }

        .role-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 14px;
            width: 190px;
            height: 150px;
            border-radius: 16px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 700;
            font-family: 'Jost', sans-serif;
            cursor: pointer;
            border: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .role-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.25);
        }

        /* 🔵 User button — dark green (matches your theme) */
        .role-btn-user {
            background: #1a4a3a;
            color: #ffffff;
        }

        /* 🟠 Admin button — gold (matches your theme) */
        .role-btn-admin {
            background: #c9a84c;
            color: #1e1e1e;
        }

        .role-btn .btn-icon {
            font-size: 2.8rem;
            line-height: 1;
        }

        .role-btn .btn-label {
            font-size: 0.95rem;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        /* ── BACK LINK ── */
        .back-link {
            text-align: center;
            margin-top: 16px;
        }
        .back-link a {
            color: #1a4a3a;
            font-size: 0.88rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
        }
        .back-link a:hover { color: #c9a84c; text-decoration: underline; }

        /* ── ROLE BADGE shown inside form ── */
        .role-badge {
            text-align: center;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: 0.4px;
        }
        .badge-user  { background: #e6f4ef; color: #1a4a3a; }
        .badge-admin { background: #fdf4df; color: #92650a; }

        /* Chooser title */
        .chooser-title {
            text-align: center;
            font-family: 'Cormorant Garamond', Georgia, serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: #0f2e25;
            margin-bottom: 6px;
        }
        .chooser-sub {
            text-align: center;
            color: #7a8e87;
            font-size: 0.88rem;
            margin-bottom: 0;
        }
    </style>
</head>
<body>

<!-- ============ NAV ============ -->
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

<div class="form-page">
    <div class="form-container">

        <!-- Brand logo -->
        <div class="form-brand">
            <span class="brand-icon">✦</span>
            <h1>OccasioDesign</h1>
            <p class="tagline">Your Perfect Event, Beautifully Designed</p>
        </div>

        <%-- ============================================
             STEP 1: Show TWO buttons if no type chosen
             ============================================ --%>
        <% if (loginType.isEmpty()) { %>

            <p class="chooser-title">Welcome Back!</p>
            <p class="chooser-sub">Please select how you want to login</p>

            <div class="role-chooser">

                <!-- USER button → goes to login?type=user -->
                <a href="${pageContext.request.contextPath}/login?type=user"
                   class="role-btn role-btn-user">
                    <span class="btn-icon">👤</span>
                    <span class="btn-label">User Login</span>
                </a>

                <!-- ADMIN button → goes to login?type=admin -->
                <a href="${pageContext.request.contextPath}/login?type=admin"
                   class="role-btn role-btn-admin">
                    <span class="btn-icon">🛡️</span>
                    <span class="btn-label">Admin Login</span>
                </a>

            </div>

            <p class="link-text" style="margin-top:28px;">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Register here</a>
            </p>

        <%-- ============================================
             STEP 2: Show the LOGIN FORM for chosen role
             ============================================ --%>
        <% } else { %>

            <%-- Show role badge at top of form --%>
            <% if ("admin".equals(loginType)) { %>
                <div class="role-badge badge-admin">🛡️ Admin Login</div>
            <% } else { %>
                <div class="role-badge badge-user">👤 User Login</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <%-- Hidden field tells servlet which type was chosen --%>
                <input type="hidden" name="loginType" value="<%= loginType %>"/>

                <h2>
                    <%= "admin".equals(loginType) ? "Admin Sign In" : "Welcome Back" %>
                </h2>

                <%-- Error message --%>
                <% if (request.getAttribute("error") != null) { %>
                <p class="error-msg"><%= request.getAttribute("error") %></p>
                <% } %>

                <%-- Success message --%>
                <% if (request.getAttribute("success") != null) { %>
                <p class="success-msg"><%= request.getAttribute("success") %></p>
                <% } %>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email"
                           placeholder="<%= "admin".equals(loginType) ? "admin@occasio.com" : "your@email.com" %>"
                           required/>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password"
                           placeholder="Enter your password" required/>
                </div>

                <button type="submit" class="btn-primary">
                    <%= "admin".equals(loginType) ? "🛡️ Admin Login" : "🔐 User Login" %>
                </button>

            </form>

            <%-- Back button to go back to role chooser --%>
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/login">← Choose different login</a>
            </div>

            <% if (!"admin".equals(loginType)) { %>
            <p class="link-text">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Register here</a>
            </p>
            <% } %>

        <% } %>

    </div>
</div>

</body>
</html>