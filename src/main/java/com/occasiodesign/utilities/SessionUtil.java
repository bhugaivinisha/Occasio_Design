package com.occasiodesign.utilities;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * SessionUtil - Utility class for managing HTTP sessions.
 * Used to store, retrieve, and remove session attributes.
 */
public class SessionUtil {

    /**
     * Sets an attribute in the current session.
     * @param request the HTTP request
     * @param key the attribute name
     * @param value the attribute value
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setAttribute(key, value);
    }

    /**
     * Gets an attribute from the current session.
     * Returns null if session doesn't exist or attribute not found.
     * @param request the HTTP request
     * @param key the attribute name
     * @return the attribute value or null
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    /**
     * Removes an attribute from the session.
     * @param request the HTTP request
     * @param key the attribute name to remove
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates (destroys) the current session. Used for logout.
     * @param request the HTTP request
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}