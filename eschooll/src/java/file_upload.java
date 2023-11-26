import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "file_upload", urlPatterns = {"/file_upload"})
@MultipartConfig
public class file_upload extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Part part = request.getPart("file1");
        String fileName = getSubmittedFileName(part);

        // Additional code to save the file and path to the database
        String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
        String dbUser = "root";
        String dbPassword = "";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Assuming you have a table named "assignments" with columns "name" and "file_path"
            String insertSQL = "INSERT INTO assignments (name, file_path) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, fileName);
            preparedStatement.setString(2, "C:\\Netbeans8\\NetBeans 8.2\\upload" + File.separator + fileName);
            preparedStatement.executeUpdate();

            // Display a popup message using JavaScript
            out.println("<script>");
            out.println("alert('File uploaded successfully!');");
            out.println("window.location.href = 'teachers.jsp';"); // Replace with the actual page URL
            out.println("</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }
}
