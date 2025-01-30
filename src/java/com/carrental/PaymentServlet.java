package com.carrental;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/process-payment")
public class PaymentServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Long bookingId = (Long) session.getAttribute("bookingId");
        
        if (bookingId == null) {
            response.sendRedirect("error.jsp?message=Invalid booking");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // In a real application, you would process the payment here
                // For this example, we'll just update the booking status
                String sql = "UPDATE bookings SET status = 'CONFIRMED' WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setLong(1, bookingId);
                    pstmt.executeUpdate();
                }
                
                // Clear the booking ID from session
                session.removeAttribute("bookingId");
                
                // Redirect to confirmation page
                response.sendRedirect("booking-confirmation.jsp?id=" + bookingId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Payment failed");
        }
    }
}