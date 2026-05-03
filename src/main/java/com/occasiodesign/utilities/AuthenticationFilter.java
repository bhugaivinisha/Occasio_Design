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

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

    private static final String LOGIN    = "/login";
    private static final String REGISTER = "/register";
    private static final String HOME     = "/home";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
    	System.out.println("Filteriing.....");

        HttpServletRequest  req = (HttpServletRequest)  request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // ✅ Always allow: static files, home, login, register
        if (uri.endsWith(".css") || uri.endsWith(".js")
                || uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg")
                || uri.endsWith(HOME) || uri.endsWith("/")
                || uri.endsWith(LOGIN) || uri.endsWith(REGISTER)
                || uri.endsWith("/about") || uri.endsWith("/contact")) {
            chain.doFilter(request, response);
            return;
        }

//        // Check if user is logged in (userId stored in session)
//        boolean isLoggedIn = SessionUtil.getAttribute(req, "userId") != null;
//
//        if (!isLoggedIn) {
//            // Not logged in → send to login page
//            res.sendRedirect(req.getContextPath() + LOGIN);
//        } else {
//            // Logged in → check role for admin pages
//            Object role = SessionUtil.getAttribute(req, "role");
//
//            if (uri.contains("/admin") || uri.endsWith("/adminDashboard")
//                    || uri.endsWith("/manageUsers") || uri.endsWith("/manageBookings")) {
//
//                if (role != null && "admin".equals(role.toString())) {
//                    chain.doFilter(request, response); // ✅ admin allowed
//                } else {
//                    res.sendRedirect(req.getContextPath() + "/userDashboard"); // not admin
//                }
//            } else {
//                chain.doFilter(request, response); // ✅ normal logged-in user
//            }
//        }
    }

    @Override
    public void destroy() { }
}