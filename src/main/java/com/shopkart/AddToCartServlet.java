package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopkart_db", "root", "Mvas@9897"
            );

            // Stock verify karo
            PreparedStatement stockStmt = conn.prepareStatement("SELECT quantity FROM products WHERE id = ?");
            stockStmt.setInt(1, productId);
            ResultSet stockRs = stockStmt.executeQuery();
            int availableStock = 0;
            if (stockRs.next()) {
                availableStock = stockRs.getInt("quantity");
            }
            stockRs.close();
            stockStmt.close();

            if (quantity > availableStock) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<h3>Sorry, only " + availableStock + " units available in stock!</h3>");
                response.getWriter().println("<a href='products'>Go Back</a>");
                return;
            }

            // Pehle username se user_id nikalo
            String getUserIdSql = "SELECT id FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(getUserIdSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt("id");
            }

            // Cart mein insert karo
            String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, productId);
            insertStmt.setInt(3, quantity);
            insertStmt.executeUpdate();
            insertStmt.close();

            response.sendRedirect("products");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}