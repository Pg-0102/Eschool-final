<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
// Retrieve the logged-in student's ID from the session
HttpSession sessions = request.getSession();
String userId = (String) sessions.getAttribute("userId");

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/eschool";
String username = "root";
String dbPassword = "";

// Initialize a map to store the student details
Map<String, String> studentDetails = new HashMap<>();

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(url, username, dbPassword);

    // Query to fetch student details based on ID
    String selectQuery = "SELECT roll_number, course, branch, name, fatherName, gender FROM student WHERE id = ?";
    PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
    preparedStatement.setString(1, userId);

    ResultSet resultSet = preparedStatement.executeQuery();

    if (resultSet.next()) {
        // Populate the map with the fetched student details
        studentDetails.put("roll_number", resultSet.getString("roll_number"));
        studentDetails.put("course", resultSet.getString("course"));
        studentDetails.put("branch", resultSet.getString("branch"));
        studentDetails.put("name", resultSet.getString("name"));
        studentDetails.put("fatherName", resultSet.getString("fatherName"));
        studentDetails.put("gender", resultSet.getString("gender"));
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
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
     <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #007bff;
            color: #fff;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .profile-card {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            max-width: 400px;
            width: 100%;
            text-align: center;
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-gap: 10px;
            justify-items: center;
        }

        h2 {
            color: #007bff;
            grid-column: span 2;
        }

        .details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-gap: 10px;
            margin-top: 20px;
        }

        .details p {
            margin: 10px 0;
            color: #000;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="profile-card">
        <h2>Student Profile</h2>
        <div class="details">
            <p><strong>Roll Number:</strong></p>
            <p><%= studentDetails.get("roll_number") %></p>

            <p><strong>Course:</strong></p>
            <p><%= studentDetails.get("course") %></p>

            <p><strong>Branch:</strong></p>
            <p><%= studentDetails.get("branch") %></p>

            <p><strong>Name:</strong></p>
            <p><%= studentDetails.get("name") %></p>

            <p><strong>Father's Name:</strong></p>
            <p><%= studentDetails.get("fatherName") %></p>

            <p><strong>Gender:</strong></p>
            <p><%= studentDetails.get("gender") %></p>
        </div>
    </div>
</body>
</html>