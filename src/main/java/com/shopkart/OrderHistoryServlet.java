package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class OrderHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        List<Map<String, Object>> orders = new ArrayList<>();

        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            // Step 1: user_id nikalo
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

            // Step 2: Us user ke saare orders nikalo
            PreparedStatement orderStmt = conn.prepareStatement(
                "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC"
            );
            orderStmt.setInt(1, userId);
            ResultSet orderRs = orderStmt.executeQuery();

            while (orderRs.next()) {
                Map<String, Object> order = new HashMap<>();
                int orderId = orderRs.getInt("id");

                order.put("orderId", orderId);
                order.put("totalAmount", orderRs.getDouble("total_amount"));
                order.put("status", orderRs.getString("status"));
                order.put("orderDate", orderRs.getTimestamp("order_date"));
                order.put("expectedDelivery", orderRs.getDate("expected_delivery_date"));

                // Step 3: Isi order ke andar ke products bhi nikalo
                PreparedStatement itemStmt = conn.prepareStatement(
                    "SELECT p.name, oi.quantity, oi.price_at_purchase " +
                    "FROM order_items oi JOIN products p ON oi.product_id = p.id " +
                    "WHERE oi.order_id = ?"
                );
                itemStmt.setInt(1, orderId);
                ResultSet itemRs = itemStmt.executeQuery();

                List<Map<String, Object>> items = new ArrayList<>();
                while (itemRs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("name", itemRs.getString("name"));
                    item.put("quantity", itemRs.getInt("quantity"));
                    item.put("price", itemRs.getDouble("price_at_purchase"));
                    items.add(item);
                }
                itemRs.close();
                itemStmt.close();

                order.put("items", items);
                orders.add(order);
            }
            orderRs.close();
            orderStmt.close();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}