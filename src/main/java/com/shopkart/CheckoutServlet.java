package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            PreparedStatement getUserStmt = conn.prepareStatement(
                "SELECT id FROM users WHERE username = ?"
            );
            getUserStmt.setString(1, username);
            ResultSet userRs = getUserStmt.executeQuery();
            int userId = 0;
            if (userRs.next()) {
                userId = userRs.getInt("id");
            }
            userRs.close();
            getUserStmt.close();

            PreparedStatement cartStmt = conn.prepareStatement(
                "SELECT c.product_id, c.quantity, p.price " +
                "FROM cart c JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ?"
            );
            cartStmt.setInt(1, userId);
            ResultSet cartRs = cartStmt.executeQuery();

            double totalAmount = 0;
            java.util.List<int[]> productQuantities = new java.util.ArrayList<>();
            java.util.List<Double> productPrices = new java.util.ArrayList<>();

            while (cartRs.next()) {
                int productId = cartRs.getInt("product_id");
                int qty = cartRs.getInt("quantity");
                double price = cartRs.getDouble("price");

                totalAmount += price * qty;
                productQuantities.add(new int[]{productId, qty});
                productPrices.add(price);
            }
            cartRs.close();
            cartStmt.close();

            if (productQuantities.isEmpty()) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<h3>Your cart is empty!</h3>");
                response.getWriter().println("<a href='products'>Continue Shopping</a>");
                return;
            }

            PreparedStatement orderStmt = conn.prepareStatement(
                "INSERT INTO orders (user_id, total_amount, expected_delivery_date) VALUES (?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);

            java.sql.Date deliveryDate = new java.sql.Date(
                System.currentTimeMillis() + (5L * 24 * 60 * 60 * 1000)
            );
            orderStmt.setDate(3, deliveryDate);

            orderStmt.executeUpdate();

            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }
            generatedKeys.close();
            orderStmt.close();

            for (int i = 0; i < productQuantities.size(); i++) {
                int[] pq = productQuantities.get(i);
                PreparedStatement itemStmt = conn.prepareStatement(
                    "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)"
                );
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, pq[0]);
                itemStmt.setInt(3, pq[1]);
                itemStmt.setDouble(4, productPrices.get(i));
                itemStmt.executeUpdate();
                itemStmt.close();

                PreparedStatement reduceStockStmt = conn.prepareStatement(
                    "UPDATE products SET quantity = quantity - ? WHERE id = ?"
                );
                reduceStockStmt.setInt(1, pq[1]);
                reduceStockStmt.setInt(2, pq[0]);
                reduceStockStmt.executeUpdate();
                reduceStockStmt.close();
            }

            PreparedStatement clearCartStmt = conn.prepareStatement(
                "DELETE FROM cart WHERE user_id = ?"
            );
            clearCartStmt.setInt(1, userId);
            clearCartStmt.executeUpdate();
            clearCartStmt.close();

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