package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        List<Map<String, Object>> cartItems = new ArrayList<>();
        double totalBill = 0;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
           conn = DBUtil.getConnection();

            String sql = "SELECT c.id AS cart_id, p.name, p.price, c.quantity " +
                         "FROM cart c " +
                         "JOIN products p ON c.product_id = p.id " +
                         "JOIN users u ON c.user_id = u.id " +
                         "WHERE u.username = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                double price = rs.getDouble("price");
                int qty = rs.getInt("quantity");
                double subtotal = price * qty;

                item.put("cartId", rs.getInt("cart_id"));
                item.put("name", rs.getString("name"));
                item.put("price", price);
                item.put("quantity", qty);
                item.put("subtotal", subtotal);

                cartItems.add(item);
                totalBill += subtotal;
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalBill", totalBill);
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}