<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
    <link rel="stylesheet" type="text/css" href="assets/css/styles.css">
    <style>
        /* Add CSS for hiding the assignment form by default */
        #assignmentForm {
            display: none;
        }

        /* Style for the student details table */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Style for the filter input and button */
        #studentNameFilter {
            margin-top: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="menu-toggle" id="menuToggle">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
            <nav class="nav-menu">
                <ul>
                    <li><a href="#">Dashboard</a></li>
                    <li><a href="uploadAttandance.jsp">Upload Attendance</a></li>
                    <li><a href="teacher.html">Upload Assignment</a></li>
                    <li><a href="uploadResult.jsp">Upload Result</a></li>
                    <li><a href="index.html">Logout</a></li>


                </ul>
            </nav>
        </div>
        <div class="content">
        <header>
            <h1>Teacher Dashboard</h1>
        </header>
        <div class="main-content">
            <h2>Student List</h2>
            <input type="text" id="studentNameFilter" placeholder="Filter by Name" oninput="filterStudents()">

            <table id="studentTable">
                <thead>
                    <tr>
                        <th>Course</th>
                        <th>Branch</th>
                        <th>Roll Number</th>
                        <th>Name</th>
                        <th>Father Name</th>
                        <th>Gender</th>
                    </tr>
                </thead>
                <tbody>
                    <%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
                    <%
                        try {
                            String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
                            String jdbcUsername = "root";
                            String jdbcPassword = "";
                            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                            Statement statement = connection.createStatement();
                            String sql = "SELECT * FROM student";
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) {
                                String course = resultSet.getString("course");
                                String branch = resultSet.getString("branch");
                                String rollNumber = resultSet.getString("roll_number");
                                String studentName = resultSet.getString("name");
                                String fatherName = resultSet.getString("fatherName");
                                String gender = resultSet.getString("gender");
                    %>
                    <tr>
                        <td><%= course %></td>
                        <td><%= branch %></td>
                        <td><%= rollNumber %></td>
                        <td><%= studentName %></td>
                        <td><%= fatherName %></td>
                        <td><%= gender %></td>
                    </tr>
                    <%
                            }
                            resultSet.close();
                            statement.close();
                            connection.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterStudents() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("studentNameFilter");
            filter = input.value.toUpperCase();
            table = document.getElementById("studentTable");
            tr = table.getElementsByTagName("tr");
            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3]; // Updated index to 3 for the student name
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>
</body>
</html>
