package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE cart SET quantity = ? WHERE id = ?");
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, cartId);
            pstmt.executeUpdate();
            pstmt.close();

            response.sendRedirect("cart");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}