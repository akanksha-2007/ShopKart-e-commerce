package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class BuyNowServlet extends HttpServlet {

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

        try {
           conn = DBUtil.getConnection();

            PreparedStatement getUserStmt = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
            getUserStmt.setString(1, username);
            ResultSet userRs = getUserStmt.executeQuery();
            int userId = 0;
            if (userRs.next()) userId = userRs.getInt("id");
            userRs.close();
            getUserStmt.close();

            PreparedStatement productStmt = conn.prepareStatement("SELECT price, quantity FROM products WHERE id = ?");
            productStmt.setInt(1, productId);
            ResultSet productRs = productStmt.executeQuery();
            double price = 0;
            int availableStock = 0;
            if (productRs.next()) {
                price = productRs.getDouble("price");
                availableStock = productRs.getInt("quantity");
            }
            productRs.close();
            productStmt.close();

            if (quantity > availableStock) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<h3>Sorry, only " + availableStock + " units available in stock!</h3>");
                response.getWriter().println("<a href='products'>Go Back</a>");
                return;
            }

            double totalAmount = price * quantity;

            PreparedStatement orderStmt = conn.prepareStatement(
                "INSERT INTO orders (user_id, total_amount, expected_delivery_date) VALUES (?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            java.sql.Date deliveryDate = new java.sql.Date(System.currentTimeMillis() + (5L * 24 * 60 * 60 * 1000));
            orderStmt.setDate(3, deliveryDate);
            orderStmt.executeUpdate();

            ResultSet keys = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (keys.next()) orderId = keys.getInt(1);
            keys.close();
            orderStmt.close();

            PreparedStatement itemStmt = conn.prepareStatement(
                "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)"
            );
            itemStmt.setInt(1, orderId);
            itemStmt.setInt(2, productId);
            itemStmt.setInt(3, quantity);
            itemStmt.setDouble(4, price);
            itemStmt.executeUpdate();
            itemStmt.close();

            PreparedStatement reduceStockStmt = conn.prepareStatement(
                "UPDATE products SET quantity = quantity - ? WHERE id = ?"
            );
            reduceStockStmt.setInt(1, quantity);
            reduceStockStmt.setInt(2, productId);
            reduceStockStmt.executeUpdate();
            reduceStockStmt.close();

            request.setAttribute("orderId", orderId);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("deliveryDate", deliveryDate);
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error: " + e.getMessage());
            } catch (IOException ex) {}
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}