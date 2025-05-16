package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/verify-booking")
public class VerifyBookingServlet extends HttpServlet {
    
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("id");
        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            response.sendRedirect("adminDashboard.jsp?error=invalid_id");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = con.prepareStatement(
                     "UPDATE bookings SET license_verified = true, booking_status = 'verified' WHERE id = ?")) {
                
                ps.setInt(1, bookingId);
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    response.sendRedirect("adminDashboard.jsp?success=verified");
                } else {
                    response.sendRedirect("adminDashboard.jsp?error=verification_failed");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=exception");
        }
    }
}
