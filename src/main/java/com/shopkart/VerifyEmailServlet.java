package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class VerifyEmailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        Connection conn = null;
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            conn = DBUtil.getConnection();

            PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT id FROM users WHERE verification_token = ?"
            );
            checkStmt.setString(1, token);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE users SET is_verified = 1 WHERE verification_token = ?"
                );
                updateStmt.setString(1, token);
                updateStmt.executeUpdate();
                updateStmt.close();

                out.println("<h2>Email Verified Successfully!</h2>");
                out.println("<p>Your account is now active. You can log in.</p>");
                out.println("<a href='login.jsp'>Go to Login</a>");
            } else {
                out.println("<h2>Invalid or Expired Link</h2>");
                out.println("<a href='signup.jsp'>Sign Up Again</a>");
            }
            rs.close();
            checkStmt.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}