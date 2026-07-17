package com.shopkart;

import java.io.*;
import java.sql.*;
import java.util.UUID;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import javax.mail.*;
import javax.mail.internet.*;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String plainPassword = request.getParameter("password");

        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        String verificationToken = UUID.randomUUID().toString();

        Connection conn = null;
        PreparedStatement pstmt = null;

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
           conn = DBUtil.getConnection();
            String sql = "INSERT INTO users (username, email, password, verification_token, is_verified) VALUES (?, ?, ?, ?, 0)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, hashedPassword);
            pstmt.setString(4, verificationToken);

            pstmt.executeUpdate();

            sendVerificationEmail(email, verificationToken);

            out.println("<h3>Signup Successful!</h3>");
            out.println("<p>We've sent a verification link to " + email + ". Please verify before logging in.</p>");
            out.println("<a href='login.jsp'>Go to Login</a>");

        } catch (Exception e) {
            out.println("<h3>Signup Failed!</h3>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }

    private void sendVerificationEmail(String toEmail, String token) {
        String fromEmail = "akanksha052013@gmail.com";
        String appPassword = "aooh gyoz uwzf dcxe" ;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Verify your ShopKart account");

            String link = "http://localhost:8080/shopkart/verifyEmail?token=" + token;
            message.setText("Welcome to ShopKart!\n\nPlease click the link below to verify your account:\n" + link);

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}