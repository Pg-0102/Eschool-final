<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; 
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>Result</title>
</head>
<body>

<%@ page import="java.sql.*" %>

<%
Connection con = null;
ResultSet rs = null;

try {
    // Establish a database connection
    Class.forName("com.mysql.jdbc.Driver"); // Adjust the driver class for your database
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eschool", "root", "");

    // Create a SQL query to retrieve data
    String query = "SELECT * FROM result";
    Statement st = con.createStatement();
    rs = st.executeQuery(query);

    // Display the data
    out.println("<html><body><table border='1'>");
    out.println("<tr><th>Roll Number</th><th>Engg Physics</th><th>Engg Chemistry</th><th>Engg Mathematics</th><th>Basic Electrical Engg</th><th>Electronic Engg</th><th>Engg Chemistry Lab</th><th>Engg Physics Lab</th></tr>");

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("roll_number") + "</td>");
        out.println("<td>" + rs.getString("engg_physics") + "</td>");
        out.println("<td>" + rs.getString("engg_chemistry") + "</td>");
        out.println("<td>" + rs.getString("engg_mathematics") + "</td>");
        out.println("<td>" + rs.getString("basic_electrical_engg") + "</td>");
        out.println("<td>" + rs.getString("electronic_engg") + "</td>");
        out.println("<td>" + rs.getString("engg_chemistry_lab") + "</td>");
        out.println("<td>" + rs.getString("engg_physics_lab") + "</td>");
        out.println("</tr>");
    }

    out.println("</table></body></html>");

} catch (SQLException ex) {
    out.println("An error occurred: " + ex.getMessage());
    ex.printStackTrace();
} finally {
    // Close the database connection and result set in the 'finally' block to ensure they're closed even in case of an exception
    if (rs != null) {
        rs.close();
    }
    if (con != null) {
        con.close();
    }
}
%>


