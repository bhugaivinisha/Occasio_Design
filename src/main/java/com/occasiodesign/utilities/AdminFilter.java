package com.occasiodesign.utilities;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * AdminFilter - Security guard for all admin pages.
 * If someone tries to open /adminDashboard without being admin,
 * they get sent back to login page immediately!
 */
@WebFilter(urlPatterns = {"/adminDashboard", "/adminDashboard/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nothing needed here
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Convert to HTTP request/response
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the current session (don't create a new one)
        HttpSession session = httpRequest.getSession(false);

        // Get the role from session
        String role = null;
        if (session != null) {
            role = (String) session.getAttribute("role");
        }

        // Check: is this person an admin?
        if ("admin".equals(role)) {
            // YES - they are admin, let them through!
            chain.doFilter(request, response);
        } else {
            //  NO - not admin! Send them to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Nothing needed here
    }
}