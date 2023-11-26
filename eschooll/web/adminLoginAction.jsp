<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Base64" %>

<%
String id = request.getParameter("id");
String enteredPassword = request.getParameter("password");

// Hash the entered password
String hashedPassword = hashPassword(enteredPassword);

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/eschool";
String username = "root";
String dbPassword = "";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(url, username, dbPassword);

    String selectQuery = "SELECT role, Enabled, name FROM users WHERE id = ? AND password = ?";
PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
preparedStatement.setString(1, id);
preparedStatement.setString(2, hashedPassword); // Assuming 'hashedPassword' contains the hashed password

ResultSet resultSet = preparedStatement.executeQuery();

if (resultSet.next()) {
    // ResultSet is not empty; retrieve the role and enabled values
    String role = resultSet.getString("role");
    int enabled = resultSet.getInt("Enabled");
    String name = resultSet.getString("name");


    // Check if enabled is 0
    if (enabled == 0) {
        System.out.println("User is not enabled.");
        response.sendRedirect("index.html");

    } else {
        HttpSession sessions = request.getSession();
                    sessions.setAttribute("userId", id);
                    sessions.setAttribute("studentName", name);

        
        if ("student".equals(role)) {
                // Redirect to the student dashboard
                response.sendRedirect("student_dashboard.jsp");
            } else if ("admin".equals(role)) {
                // Redirect to the admin dashboard
                response.sendRedirect("adminHome.jsp");
            } else if ("teacher".equals(role)) {
                // Redirect to the teacher dashboard
                response.sendRedirect("teacher_dashboard.jsp");
            } else {
                // Handle other roles or scenarios
                    response.sendRedirect("index.html");

            
        }
        // You can put additional logic here for handling an enabled user
    }
    
} else {
    // ResultSet is empty; handle the case where the user is not found
    System.out.println("User not found or password does not match.");
         response.sendRedirect("index.html");


}

    // Close database resources
    resultSet.close();
    preparedStatement.close();
    connection.close();
} catch (Exception e) {
    // Handle exceptions (e.g., database errors)
    e.printStackTrace();
}
%>

<%!
private String hashPassword(String password) {
    try {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] bytes = md.digest(password.getBytes());

        // Convert bytes to a hexadecimal representation
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    } catch (NoSuchAlgorithmException e) {
        return null;
    }
}
%>
