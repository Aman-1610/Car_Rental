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

@WebServlet("/verification")
public class VerificationServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        
        if (bookingId == null) {
            response.sendRedirect("cars");
            return;
        }
        
        // In a real application, you would probably have an admin panel to verify documents
        // For demonstration purposes, we'll simulate verification with a form
        request.getRequestDispatcher("VerificationPage.jsp").forward(request, response);

    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        
        if (bookingId == null) {
            response.sendRedirect("cars");
            return;
        }
        
        // In a real application, this would be done by an admin
        // For now, we'll assume verification is successful
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = con.prepareStatement(
                     "UPDATE bookings SET license_verified = true, booking_status = 'verified' WHERE id = ?")) {
                
                ps.setInt(1, bookingId);
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    // For demo purposes, we'll redirect to payment page
                    response.sendRedirect("payment");
                } else {
                    response.sendRedirect("error.jsp?message=Verification failed");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}