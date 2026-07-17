package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        response.setContentType("text/html;charset=UTF-8");

        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().println("<h3>Passwords do not match!</h3>");
            response.getWriter().println("<a href='forgotPassword.jsp'>Try Again</a>");
            return;
        }

        Connection conn = null;

        try {
           conn = DBUtil.getConnection();

            PreparedStatement checkStmt = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                response.getWriter().println("<h3>No account found with this email.</h3>");
                response.getWriter().println("<a href='forgotPassword.jsp'>Try Again</a>");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
            updateStmt.setString(1, hashedPassword);
            updateStmt.setString(2, email);
            updateStmt.executeUpdate();
            updateStmt.close();

            response.getWriter().println("<h3>Password reset successful!</h3>");
            response.getWriter().println("<a href='login.jsp'>Login Now</a>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}