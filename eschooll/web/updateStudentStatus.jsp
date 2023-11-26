<%--<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
// Get the roll_number parameter from the request
String rollNumber = request.getParameter("roll_number");

// Initialize the student ID to -1
int studentId = -1;

// Database connection parameters
String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
String jdbcUsername = "root";
String jdbcPassword = "";

try {
    // Establish a database connection
    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

    // Prepare SQL query to retrieve the student ID based on roll_number
    String getStudentIdQuery = "SELECT id FROM student WHERE roll_number = ?";
    PreparedStatement studentIdStatement = connection.prepareStatement(getStudentIdQuery);
    studentIdStatement.setString(1, rollNumber);

    // Execute the query to retrieve the student ID
    ResultSet studentIdResult = studentIdStatement.executeQuery();

    if (studentIdResult.next()) {
        // Get the student ID from the result
        studentId = studentIdResult.getInt("id");
    }

    // Close the ResultSet and PreparedStatement for getting the student ID
    studentIdResult.close();
    studentIdStatement.close();

    // If a valid student ID was found, update the enabled field in the users table
    if (studentId != -1) {
        String updateQuery = "UPDATE users SET Enabled = ? WHERE id = ?";
        PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
        
        // Set the value of "enabled" (0 to disable, 1 to enable)
        int enabledValue = 0; 
        updateStatement.setInt(1, enabledValue);
        updateStatement.setInt(2, studentId);

        // Execute the update query
        int rowsUpdated = updateStatement.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("User's enabled state updated successfully.");
        } else {
            out.println("Failed to update user's enabled state.");
        }

        // Close the PreparedStatement for the update
        updateStatement.close();
    } else {
        out.println("Student with roll number '" + rollNumber + "' not found.");
    }

    // Close the database connection
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("An error occurred while processing your request: " + e.getMessage());
}
%>--%>

<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
// Get the roll_number parameter from the request
String rollNumber = request.getParameter("roll_number");

// Database connection parameters
String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
String jdbcUsername = "root";
String jdbcPassword = "";

try {
    // Establish a database connection
    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

    // Prepare SQL query to update the enabled field in the users table
    String updateQuery = "UPDATE Users SET Enabled = 1 - Enabled WHERE id IN (SELECT id FROM student WHERE roll_number = ?)";
    PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
    updateStatement.setString(1, rollNumber);

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

