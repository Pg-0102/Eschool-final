<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Assignments</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        h1 {
            background-color: #3498db;
            color: #fff;
            text-align: center;
            padding: 20px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            background-color: #fff;
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        a.download-link {
            text-decoration: none;
            color: #3498db;
        }

        a.download-link:hover {
            text-decoration: underline;
        }

        /* Additional styles for the "Download" link */
        a.download-link {
            display: inline-block;
            background-color: #3498db;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>Assignments</h1>
    <ul><%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.DriverManager" %>
              
        <%
            String jdbcUrl = "jdbc:mysql://localhost:3306/eschool";
            String dbUser = "root";
            String dbPassword = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                Statement statement = connection.createStatement();
                String sql = "SELECT name, file_path FROM assignments";
                ResultSet resultSet = statement.executeQuery(sql);

                while (resultSet.next()) {
                    String assignmentName = resultSet.getString("name");
                    String filePath = resultSet.getString("file_path");
        %>
        <li>
            <a class="download-link" href="DownloadAssignmentServlet?name=<%= assignmentName %>">Download</a>
            <%= assignmentName %>
        </li>
        <%
                }
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </ul>
</body>
</html>
