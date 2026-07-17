package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminOrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Sirf admin hi ye page dekh sake
        if (session == null || role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> orders = new ArrayList<>();
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopkart_db", "root", "Mvas@9897"
            );

            String sql = "SELECT o.id, u.username, o.total_amount, o.status, o.order_date " +
                         "FROM orders o JOIN users u ON o.user_id = u.id " +
                         "ORDER BY o.order_date DESC";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("orderId", rs.getInt("id"));
                order.put("username", rs.getString("username"));
                order.put("totalAmount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                order.put("orderDate", rs.getTimestamp("order_date"));
                orders.add(order);
            }
            rs.close();
            pstmt.close();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("adminOrders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}