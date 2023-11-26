<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard - Upload Attendance</title>
    <link rel="stylesheet" type="text/css" href="assets/css/styles.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="menu-toggle" id="menuToggle">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
        </div>
        <div class="content">
            <header>
                <h1>Teacher Dashboard - Upload Attendance</h1>
            </header>
            <div class="main-content">
                <h2> Add Attendance</h2>
                <form  id="attendanceForm" method="post">
                    <label for="studentName">Student Name:</label>
                    <select name="studentName" id="studentName">
                        <%
                            try {
                                String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
                                String jdbcUsername = "root";
                                String jdbcPassword = "";
                                Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                                String sql = "SELECT roll_number, name FROM student";
                                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                                ResultSet resultSet = preparedStatement.executeQuery();

                                while (resultSet.next()) {
                                    String roll = resultSet.getString("roll_number");
                                    String studentName = resultSet.getString("name");
                        %>
                        <option value="<%= roll %>"><%= studentName %></option>
                        <%
                            }
                            resultSet.close();
                            preparedStatement.close();
                            connection.close();
                        } catch (SQLException e) {
                            out.println("Error retrieving student names from the database. Please try again later.");
                            e.printStackTrace();
                        }
                        %>
                    </select>
                    <label for="attendancePercentage">Attendance Percentage:</label>
                    <input type="text" id="attendancePercentage" name="attendancePercentage" required>
                    <input type="submit" value="Add Attendance">
                </form>

                <%
                    if ("POST".equals(request.getMethod())) {
                        String studentRoll = request.getParameter("studentName");
                        double attendancePercentage = Double.parseDouble(request.getParameter("attendancePercentage"));

                        try {
                            String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
                            String jdbcUsername = "root";
                            String jdbcPassword = "";
                            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                            // Check if attendance record already exists for the student
                            String checkSQL = "SELECT * FROM student WHERE roll_number = ?";
                            try (PreparedStatement checkStatement = connection.prepareStatement(checkSQL)) {
                                checkStatement.setString(1, studentRoll);
                                ResultSet checkResultSet = checkStatement.executeQuery();

                                if (checkResultSet.next()) {
                                    // Update existing attendance record
                                    String updateSQL = "UPDATE student SET attendance = ? WHERE roll_number = ?";
                                    try (PreparedStatement updateStatement = connection.prepareStatement(updateSQL)) {
                                        updateStatement.setDouble(1, attendancePercentage);
                                        updateStatement.setString(2, studentRoll);
                                        int rowsAffected = updateStatement.executeUpdate();

                                        if (rowsAffected > 0) {
                                            request.setAttribute("message", "Attendance updated successfully for " + studentRoll);
                                        } else {
                                            request.setAttribute("message", "Failed to update attendance for " + studentRoll);
                                        }
                                    }
                                } else {
                                    // Insert new attendance record
                                    String insertSQL = "INSERT INTO student (roll_number, attendance) VALUES (?, ?)";
                                    try (PreparedStatement insertStatement = connection.prepareStatement(insertSQL)) {
                                        insertStatement.setString(1, studentRoll);
                                        insertStatement.setDouble(2, attendancePercentage);
                                        int rowsAffected = insertStatement.executeUpdate();

                                        if (rowsAffected > 0) {
                                            request.setAttribute("message", "Attendance added successfully for " + studentRoll);
                                        } else {
                                            request.setAttribute("message", "Failed to add attendance for " + studentRoll);
                                        }
                                    }
                                }

                                checkResultSet.close();
                            }
                            connection.close();
                        } catch (SQLException e) {
                            request.setAttribute("message", "Error updating/inserting attendance in the database. Please try again later.");
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
