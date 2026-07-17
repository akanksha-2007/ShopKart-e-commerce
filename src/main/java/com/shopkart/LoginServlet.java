package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String plainPassword = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
           conn = DBUtil.getConnection();

            // Username ya email dono se dhundo
            String sql = "SELECT * FROM users WHERE username = ? OR email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usernameOrEmail);
            pstmt.setString(2, usernameOrEmail);

            rs = pstmt.executeQuery();
if (rs.next()) {
    String storedHash = rs.getString("password");

    // Yahi asli check hai
    if (BCrypt.checkpw(plainPassword, storedHash)) {

        boolean isVerified = rs.getBoolean("is_verified");
        if (!isVerified) {
            out.println("<h3>Login Failed!</h3>");
            out.println("<p>Please verify your email before logging in. Check your inbox.</p>");
            return;
        }

        // Session banao - login yaad rakhne ke liye
        HttpSession session = request.getSession();
        session.setAttribute("username", rs.getString("username"));
        session.setAttribute("role", rs.getString("role"));
                    response.sendRedirect("dashboard.jsp");
                    return;
                } else {
                    out.println("<h3>Login Failed!</h3>");
                    out.println("<p>Incorrect password.</p>");
                }
            } else {
                out.println("<h3>Login Failed!</h3>");
                out.println("<p>No user found with this username/email.</p>");
            }

        } catch (Exception e) {
            out.println("<h3>Error!</h3>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}