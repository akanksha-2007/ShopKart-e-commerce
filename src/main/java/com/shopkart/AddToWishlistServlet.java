package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToWishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        int productId = Integer.parseInt(request.getParameter("productId"));

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopkart_db", "root", "Mvas@9897"
            );

            PreparedStatement getUserStmt = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
            getUserStmt.setString(1, username);
            ResultSet rs = getUserStmt.executeQuery();
            int userId = 0;
            if (rs.next()) userId = rs.getInt("id");
            rs.close();
            getUserStmt.close();

            PreparedStatement insertStmt = conn.prepareStatement(
                "INSERT IGNORE INTO wishlist (user_id, product_id) VALUES (?, ?)"
            );
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, productId);
            insertStmt.executeUpdate();
            insertStmt.close();

            response.sendRedirect("products");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}