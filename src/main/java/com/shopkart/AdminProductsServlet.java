package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (session == null || role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> products = new ArrayList<>();
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopkart_db", "root", "Mvas@9897"
            );

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM products");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("id"));
                product.put("name", rs.getString("name"));
                product.put("brand", rs.getString("brand"));
                product.put("price", rs.getDouble("price"));
                product.put("quantity", rs.getInt("quantity"));
                products.add(product);
            }
            rs.close();
            pstmt.close();

            request.setAttribute("products", products);
            request.getRequestDispatcher("adminProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}