package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class WishlistServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        List<Map<String, Object>> items = new ArrayList<>();

        Connection conn = null;

        try {
           conn = DBUtil.getConnection();

            String sql = "SELECT w.id AS wishlist_id, p.id AS product_id, p.name, p.price, p.image " +
                         "FROM wishlist w JOIN products p ON w.product_id = p.id " +
                         "JOIN users u ON w.user_id = u.id " +
                         "WHERE u.username = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("wishlistId", rs.getInt("wishlist_id"));
                item.put("productId", rs.getInt("product_id"));
                item.put("name", rs.getString("name"));
                item.put("price", rs.getDouble("price"));
                item.put("image", rs.getString("image"));
                items.add(item);
            }
            rs.close();
            pstmt.close();

            request.setAttribute("wishlistItems", items);
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}