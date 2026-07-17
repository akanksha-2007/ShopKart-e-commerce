package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> productList = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
           conn = DBUtil.getConnection();

            String categoryId = request.getParameter("category");
            String search = request.getParameter("search");

            String sql = "SELECT p.id, p.name, p.brand, p.price, p.quantity, p.image, c.name AS category_name " +
                         "FROM products p JOIN categories c ON p.category_id = c.id WHERE 1=1";

            if (categoryId != null && !categoryId.isEmpty()) {
                sql += " AND p.category_id = ?";
            }
            if (search != null && !search.isEmpty()) {
                sql += " AND (p.name LIKE ? OR p.brand LIKE ?)";
            }
String sort = request.getParameter("sort");
if ("low".equals(sort)) {
    sql += " ORDER BY p.price ASC";
} else if ("high".equals(sort)) {
    sql += " ORDER BY p.price DESC";
}
            pstmt = conn.prepareStatement(sql);

            int paramIndex = 1;
            if (categoryId != null && !categoryId.isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(categoryId));
            }
            if (search != null && !search.isEmpty()) {
                pstmt.setString(paramIndex++, "%" + search + "%");
                pstmt.setString(paramIndex++, "%" + search + "%");
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("id"));
                product.put("name", rs.getString("name"));
                product.put("brand", rs.getString("brand"));
                product.put("price", rs.getDouble("price"));
                product.put("quantity", rs.getInt("quantity"));
                product.put("image", rs.getString("image"));
                product.put("category", rs.getString("category_name"));
                productList.add(product);
            }

            request.setAttribute("products", productList);
            request.getRequestDispatcher("products.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error: " + e.getMessage());
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}