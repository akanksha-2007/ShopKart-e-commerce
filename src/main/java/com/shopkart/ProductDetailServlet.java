package com.shopkart;

import java.io.*;
import java.sql.*;
// removed unused import java.util.*
import javax.servlet.*;
import javax.servlet.http.*;

public class ProductDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;

        try {
            conn = DBUtil.getConnection();

            String sql = "SELECT p.*, c.name AS category_name FROM products p " +
                         "JOIN categories c ON p.category_id = c.id WHERE p.id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("brand", rs.getString("brand"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("price", rs.getDouble("price"));
                request.setAttribute("quantity", rs.getInt("quantity"));
                request.setAttribute("image", rs.getString("image"));
                request.setAttribute("category", rs.getString("category_name"));
            }
            rs.close();
            pstmt.close();

            request.getRequestDispatcher("productDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}