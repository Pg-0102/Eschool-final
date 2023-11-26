<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
String teacherId = request.getParameter("teacherId");

// Database connection parameters
String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
String jdbcUsername = "root";
String jdbcPassword = "";

try {
    // Establish a database connection
    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

    // Prepare SQL query to update the Enabled field in the teacher table
    String updateQuery = "UPDATE users SET Enabled = 1 - Enabled WHERE id IN (SELECT id FROM teacher WHERE teacherId = ?)";
    PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
    updateStatement.setString(1, teacherId);

    // Execute the update query
    int rowsUpdated = updateStatement.executeUpdate();

    if (rowsUpdated > 0) {
        out.println("success"); // Return 'success' if the update is successful
    } else {
        out.println("failed");  // Return 'failed' if the update fails
    }

    // Close the PreparedStatement and the database connection
    updateStatement.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("An error occurred while processing your request: " + e.getMessage());
}
%>