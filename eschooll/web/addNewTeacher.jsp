<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>

<%
String teacherName = request.getParameter("teacherName");
String qualification = request.getParameter("qualification");
String salary = request.getParameter("salary");
String experience = request.getParameter("experience");
String gender = request.getParameter("gender");
String teacherPassword = request.getParameter("password");
String hashedPassword = hashPassword(teacherPassword); // Call the hashPassword function

Connection con = null;
PreparedStatement userStatement = null;
PreparedStatement teacherStatement = null;
int generatedUserId = -1;

try {
    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/eschool";
    String username = "root";
    String dbPassword = "";

    con = DriverManager.getConnection(url, username, dbPassword);

    if (con != null) {
        con.setAutoCommit(false);

        String userQuery = "INSERT INTO users (password, role, name) VALUES (?, ?, ?)";
        userStatement = con.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS);
        userStatement.setString(1, hashedPassword);
        userStatement.setString(2, "teacher");
        userStatement.setString(3, teacherName);

        int userRowsAffected = userStatement.executeUpdate();

        if (userRowsAffected > 0) {
            ResultSet generatedKeys = userStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedUserId = generatedKeys.getInt(1);
            }
        }

        String teacherQuery = "INSERT INTO teacher (teacherName, qualification, salary, experience, gender, id) VALUES (?, ?, ?, ?, ?, ?)";
        teacherStatement = con.prepareStatement(teacherQuery);
        teacherStatement.setString(1, teacherName);
        teacherStatement.setString(2, qualification);
        teacherStatement.setString(3, salary);
        teacherStatement.setString(4, experience);
        teacherStatement.setString(5, gender);
        teacherStatement.setInt(6, generatedUserId);

        int teacherRowsAffected = teacherStatement.executeUpdate();

        if (userRowsAffected > 0 && teacherRowsAffected > 0) {
            con.commit();
            out.println("Teacher data INSERTED successfully.");
        } else {
            con.rollback();
            out.println("Failed to insert the teacher data.");
        }
    } else {
        out.println("Failed to establish a database connection.");
    }
} catch (SQLException | ClassNotFoundException e) {
    out.println("Error: " + e.getMessage());
    if (con != null) {
        try {
            con.rollback();
        } catch (SQLException ex) {
            out.println("Error while rolling back the transaction: " + ex.getMessage());
        }
    }
} finally {
    try {
        if (userStatement != null) {
            userStatement.close();
        }
        if (teacherStatement != null) {
            teacherStatement.close();
        }
        if (con != null) {
            con.setAutoCommit(true);
            con.close();
        }
    } catch (SQLException e) {
        out.println("Error while closing resources: " + e.getMessage());
    }
}

%>

<%!
// Method to hash the password
private String hashPassword(String password) {
    try {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] bytes = md.digest(password.getBytes());

        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    } catch (Exception e) {
        System.out.println("Error while hashing password: " + e.getMessage());
        return null;
    }
}
%>
