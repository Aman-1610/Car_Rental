package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental"; // Change if needed
    private static final String JDBC_USER = "root"; // Your MySQL username
    private static final String JDBC_PASSWORD = "root"; // Your MySQL password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = con.prepareStatement(
                         "SELECT * FROM admins WHERE username = ? AND password = ?")) {

                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // Admin login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("adminLoggedIn", true);
                        session.setAttribute("adminUsername", username); // Optional: store username
                        response.sendRedirect("adminDashboard.jsp");
                    } else {
                        // Invalid credentials
                        response.sendRedirect("adminLogin.jsp?error=1");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
