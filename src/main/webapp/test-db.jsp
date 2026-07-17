<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h2>MySQL Connection Test</h2>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            // Step 1: Driver load karo
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Connection banao
            String url = "jdbc:mysql://localhost:3306/shopkart_db";
            String user = "root";
            String password = "Mvas@9897"; // apna MySQL root password daalo

            conn = DriverManager.getConnection(url, user, password);

            // Step 3: Query chalao
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM test_connection");

            out.println("<p style='color:green;'>Connection Successful!</p>");
            out.println("<table border='1'><tr><th>ID</th><th>Message</th></tr>");

            while(rs.next()) {
                out.println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("message") + "</td></tr>");
            }
            out.println("</table>");

        } catch (Exception e) {
            out.println("<p style='color:red;'>Connection Failed!</p>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
            if(conn != null) conn.close();
        }
    %>
</body>
</html>