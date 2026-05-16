package com.occasiodesign.utilities;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/*", asyncSupported = true)
public class AuthenticationFilter implements Filter {

    // Public pages seen without login
    private static final String[] PUBLIC_URLS = {
        "/login", "/register", "/home", "/about", "/contact", "/index.jsp", "/"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // CSS, JS, images , let them go ...
        if (uri.endsWith(".css") || uri.endsWith(".js") ||
            uri.endsWith(".png") || uri.endsWith(".jpg") ||
            uri.endsWith(".jpeg") || uri.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        // Public pages , let them go ...
        for (String publicUrl : PUBLIC_URLS) {
            if (uri.equals(contextPath + publicUrl) || uri.endsWith(publicUrl)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Session check — if no login , go login ... 
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // Admin pages — only admin can see 
        if (uri.contains("/adminDashboard") || uri.contains("/manageBookings") ||
            uri.contains("/manageEvents") || uri.contains("/manageThemes") ||
            uri.contains("/manageUsers")) {
            String role = (String) session.getAttribute("role");
            if (!"admin".equals(role)) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}