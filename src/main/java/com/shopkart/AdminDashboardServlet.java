package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (session == null || role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopkart_db", "root", "Mvas@9897"
            );

            Statement stmt = conn.createStatement();

            ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) AS total FROM users");
            rs1.next();
            request.setAttribute("totalUsers", rs1.getInt("total"));
            rs1.close();

            ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) AS total FROM products");
            rs2.next();
            request.setAttribute("totalProducts", rs2.getInt("total"));
            rs2.close();

            ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) AS total FROM orders");
            rs3.next();
            request.setAttribute("totalOrders", rs3.getInt("total"));
            rs3.close();

            ResultSet rs4 = stmt.executeQuery("SELECT COALESCE(SUM(total_amount),0) AS total FROM orders WHERE status != 'Cancelled'");
            rs4.next();
            request.setAttribute("totalSales", rs4.getDouble("total"));
            rs4.close();

            stmt.close();

            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}