import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "DownloadAssignmentServlet", urlPatterns = {"/DownloadAssignmentServlet"})
public class DownloadAssignmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String assignmentName = request.getParameter("name");

        String jdbcURL = "jdbc:mysql://localhost:3306/eschool";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            Statement statement = connection.createStatement();
            String sql = "SELECT file_path FROM assignments WHERE name = '" + assignmentName + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                String filePath = resultSet.getString("file_path");
                File file = new File(filePath);

                // Set response headers
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());

                // Write the file to the response
                FileInputStream fileInputStream = new FileInputStream(file);
                OutputStream out = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }

                fileInputStream.close();
                out.flush();
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle errors
        }
    }
}
