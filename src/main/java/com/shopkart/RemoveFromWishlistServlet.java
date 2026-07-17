package com.shopkart;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RemoveFromWishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int wishlistId = Integer.parseInt(request.getParameter("wishlistId"));

        Connection conn = null;

        try {
            conn = DBUtil.getConnection();

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM wishlist WHERE id = ?");
            pstmt.setInt(1, wishlistId);
            pstmt.executeUpdate();
            pstmt.close();

            response.sendRedirect("wishlist");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}