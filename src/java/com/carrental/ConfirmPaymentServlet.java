package com.carrental;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/confirm-payment")
public class ConfirmPaymentServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";
    private static final String STRIPE_SECRET_KEY = "your_stripe_secret_key_here";

    @Override
    public void init() throws ServletException {
        super.init();
        Stripe.apiKey = STRIPE_SECRET_KEY;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String paymentIntentId = request.getParameter("paymentIntentId");
        long bookingId = Long.parseLong(request.getParameter("bookingId"));

        try {
            PaymentIntent paymentIntent = PaymentIntent.retrieve(paymentIntentId);
            if ("succeeded".equals(paymentIntent.getStatus())) {
                updateBookingStatus(bookingId, "PAID");
                response.sendRedirect("booking-confirmation.jsp?bookingId=" + bookingId);
            } else {
                response.sendRedirect("payment.jsp?error=payment_failed");
            }
        } catch (StripeException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=true");
        }
    }

    private void updateBookingStatus(long bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setLong(2, bookingId);
            pstmt.executeUpdate();
        }
    }
}