package com.carrental;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        
        if (userEmail == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        int carId = Integer.parseInt(request.getParameter("carId"));
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // Start transaction
                conn.setAutoCommit(false);
                
                try {
                    // Check if car is still available
                    if (!isCarAvailable(conn, carId, startDate, endDate)) {
                        response.sendRedirect("booking.jsp?error=unavailable");
                        return;
                    }

                    // Insert booking record
                    long bookingId = insertBooking(conn, userEmail, carId, startDate, endDate, totalAmount);
                    
                    // Update car availability
                    updateCarAvailability(conn, carId, false);
                    
                    // Commit transaction
                    conn.commit();
                    
                    // Store booking ID in session for payment
                    session.setAttribute("bookingId", bookingId);
                    response.sendRedirect("payment.jsp");
                    
                } catch (SQLException e) {
                    conn.rollback();
                    throw e;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=true");
        }
    }

    private boolean isCarAvailable(Connection conn, int carId, LocalDate startDate, LocalDate endDate) 
            throws SQLException {
        String sql = "SELECT COUNT(*) FROM bookings WHERE car_id = ? AND status != 'CANCELLED' " +
                    "AND ((start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?))";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, carId);
            pstmt.setDate(2, Date.valueOf(startDate));
            pstmt.setDate(3, Date.valueOf(endDate));
            pstmt.setDate(4, Date.valueOf(startDate));
            pstmt.setDate(5, Date.valueOf(endDate));
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
        return false;
    }

    private long insertBooking(Connection conn, String userEmail, int carId, 
            LocalDate startDate, LocalDate endDate, double totalAmount) throws SQLException {
        String sql = "INSERT INTO bookings (user_email, car_id, start_date, end_date, total_amount, status) " +
                    "VALUES (?, ?, ?, ?, ?, 'PENDING')";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, userEmail);
            pstmt.setInt(2, carId);
            pstmt.setDate(3, Date.valueOf(startDate));
            pstmt.setDate(4, Date.valueOf(endDate));
            pstmt.setDouble(5, totalAmount);
            pstmt.executeUpdate();
            
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
                throw new SQLException("Creating booking failed, no ID obtained.");
            }
        }
    }

    private void updateCarAvailability(Connection conn, int carId, boolean isAvailable) 
            throws SQLException {
        String sql = "UPDATE cars SET is_available = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, carId);
            pstmt.executeUpdate();
        }
    }
}