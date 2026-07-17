package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CancelOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Connection conn = null;

        try {
           conn = DBUtil.getConnection();
            PreparedStatement itemsStmt = conn.prepareStatement(
                "SELECT product_id, quantity FROM order_items WHERE order_id = ?"
            );
            itemsStmt.setInt(1, orderId);
            ResultSet rs = itemsStmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int qty = rs.getInt("quantity");

                PreparedStatement restoreStmt = conn.prepareStatement(
                    "UPDATE products SET quantity = quantity + ? WHERE id = ?"
                );
                restoreStmt.setInt(1, qty);
                restoreStmt.setInt(2, productId);
                restoreStmt.executeUpdate();
                restoreStmt.close();
            }
            rs.close();
            itemsStmt.close();

            PreparedStatement updateStmt = conn.prepareStatement(
                "UPDATE orders SET status = 'Cancelled' WHERE id = ?"
            );
            updateStmt.setInt(1, orderId);
            updateStmt.executeUpdate();
            updateStmt.close();

            response.sendRedirect("orderHistory");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}