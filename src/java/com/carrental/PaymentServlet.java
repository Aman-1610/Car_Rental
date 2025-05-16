package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        
        if (bookingId == null || totalAmount == null) {
            response.sendRedirect("cars");
            return;
        }
        
        // Set attributes needed for payment page
        request.setAttribute("bookingId", bookingId);
        request.setAttribute("amount", totalAmount);
        
        // Forward to payment page
        request.getRequestDispatcher("PaymentPage.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        
        if (bookingId == null || totalAmount == null) {
            response.sendRedirect("cars");
            return;
        }
        
        // In a real application, you would integrate with a payment gateway like Stripe or PayPal
        // For this example, we'll simulate a successful payment
        
        // Generate a random transaction ID
        String transactionId = UUID.randomUUID().toString();
        String paymentMethod = request.getParameter("paymentMethod"); // e.g., "credit_card", "upi"
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // Begin transaction
                con.setAutoCommit(false);
                
                try {
                    // Update booking status
                    try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE bookings SET booking_status = 'payment_completed', payment_id = ? WHERE id = ?")) {
                        ps.setString(1, transactionId);
                        ps.setInt(2, bookingId);
                        ps.executeUpdate();
                    }
                    
                    // Record payment transaction
                    try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO payment_transactions (booking_id, transaction_id, amount, payment_method, payment_status) VALUES (?, ?, ?, ?, ?)")) {
                        ps.setInt(1, bookingId);
                        ps.setString(2, transactionId);
                        ps.setDouble(3, totalAmount);
                        ps.setString(4, paymentMethod);
                        ps.setString(5, "completed");
                        ps.executeUpdate();
                    }
                    
                    // Get car ID from booking
                    int carId;
                    try (PreparedStatement ps = con.prepareStatement("SELECT car_id FROM bookings WHERE id = ?")) {
                        ps.setInt(1, bookingId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) {
                                throw new RuntimeException("Booking not found");
                            }
                            carId = rs.getInt("car_id");
                        }
                    }
                    
                    // Update car availability
                    try (PreparedStatement ps = con.prepareStatement("UPDATE cars SET is_available = false WHERE id = ?")) {
                        ps.setInt(1, carId);
                        ps.executeUpdate();
                    }
                    
                    // Commit transaction
                    con.commit();
                    
                    // Now redirect to delivery information page
                    response.sendRedirect("delivery?bookingId=" + bookingId);
                    
                } catch (Exception e) {
                    // Rollback in case of error
                    con.rollback();
                    throw e;
                } finally {
                    con.setAutoCommit(true);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Payment processing failed");
        }
    }
}