package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delivery")
public class DeliveryServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookingIdParam = request.getParameter("bookingId");
        if (bookingIdParam == null) {
            HttpSession session = request.getSession();
            Integer sessionBookingId = (Integer) session.getAttribute("bookingId");
            if (sessionBookingId == null) {
                response.sendRedirect("profile.jsp");
                return;
            }
            bookingIdParam = sessionBookingId.toString();
        }
        
        request.setAttribute("bookingId", bookingIdParam);
        request.getRequestDispatcher("DeliveryForm.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        
        // Validate inputs
        if (address == null || address.trim().isEmpty() || 
            city == null || city.trim().isEmpty() ||
            state == null || state.trim().isEmpty() ||
            postalCode == null || postalCode.trim().isEmpty()) {
            
            response.sendRedirect("delivery?bookingId=" + bookingId + "&error=missing_fields");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // Insert delivery details
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO delivery_details (booking_id, address, city, state, postal_code) VALUES (?, ?, ?, ?, ?)")) {
                    
                    ps.setInt(1, bookingId);
                    ps.setString(2, address);
                    ps.setString(3, city);
                    ps.setString(4, state);
                    ps.setString(5, postalCode);
                    
                    int result = ps.executeUpdate();
                    
                    if (result > 0) {
                        // Update booking status to confirmed
                        try (PreparedStatement updatePs = con.prepareStatement(
                            "UPDATE bookings SET booking_status = 'confirmed' WHERE id = ?")) {
                            updatePs.setInt(1, bookingId);
                            updatePs.executeUpdate();
                        }
                        
                        // Clear session booking data
                        HttpSession session = request.getSession();
                        session.removeAttribute("bookingId");
                        session.removeAttribute("totalAmount");
                        
                        // Redirect to confirmation page
                        response.sendRedirect("BookingConfirmation.jsp?bookingId=" + bookingId);
                    } else {
                        response.sendRedirect("delivery?bookingId=" + bookingId + "&error=failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}