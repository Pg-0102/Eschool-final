<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.PreparedStatement" %>

<%
// Retrieve form data
String teacherId = request.getParameter("teacherId");
String className = request.getParameter("className");
String subject = request.getParameter("subject");

// Database connection parameters
String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
String jdbcUsername = "root";
String jdbcPassword = "";

try {
    // Establish a database connection
    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

    // SQL query to insert timetable data
    String insertQuery = "INSERT INTO teacher_time_table (teacherId, className, subject) VALUES (?, ?, ?)";
    PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);

    // Set values for the prepared statement
    preparedStatement.setString(1, teacherId);
    preparedStatement.setString(2, className);
    preparedStatement.setString(3, subject);

    // Execute the query
    int rowsInserted = preparedStatement.executeUpdate();
    preparedStatement.close();

    if (rowsInserted > 0) {
        // Successfully inserted data
        out.println("Timetable added successfully.");
    } else {
        // Failed to insert data
        out.println("Failed to add timetable.");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.println("An error occurred while processing your request.");
}
%>
