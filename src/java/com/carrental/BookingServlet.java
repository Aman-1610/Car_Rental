package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("userEmail") == null) {
            // User not logged in
            response.sendRedirect("LoginForm.jsp?error=login_required");
            return;
        }
        
        String carId = request.getParameter("carId");
        if (carId == null || carId.isEmpty()) {
            response.sendRedirect("cars");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM cars WHERE id = ? AND is_available = true")) {
                
                ps.setInt(1, Integer.parseInt(carId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Car car = new Car();
                        car.setId(rs.getInt("id"));
                        car.setMake(rs.getString("make"));
                        car.setModel(rs.getString("model"));
                        car.setYear(rs.getInt("year"));
                        car.setColor(rs.getString("color"));
                        car.setDailyRate(rs.getDouble("daily_rate"));
                        car.setImageUrl(rs.getString("image_url"));
                        car.setCategory(rs.getString("category"));
                        
                        request.setAttribute("car", car);
                        request.getRequestDispatcher("bookingForm.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("cars?error=car_not_available");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("userEmail") == null) {
            response.sendRedirect("LoginForm.jsp?error=login_required");
            return;
        }
        
        String userEmail = (String) session.getAttribute("userEmail");
        int carId = Integer.parseInt(request.getParameter("carId"));
        String panCard = request.getParameter("panCard");
        String drivingLicense = request.getParameter("drivingLicense");
        LocalDate pickupDate = LocalDate.parse(request.getParameter("pickupDate"));
        LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));
        String pickupLocation = request.getParameter("pickupLocation");
        
        // Validate input data
        if (panCard == null || !panCard.matches("[A-Z]{5}[0-9]{4}[A-Z]{1}")) {
            response.sendRedirect("book?carId=" + carId + "&error=invalid_pan");
            return;
        }
        
        if (drivingLicense == null || drivingLicense.trim().isEmpty()) {
            response.sendRedirect("book?carId=" + carId + "&error=invalid_license");
            return;
        }
        
        if (pickupDate.isBefore(LocalDate.now())) {
            response.sendRedirect("book?carId=" + carId + "&error=invalid_date");
            return;
        }
        
        if (returnDate.isBefore(pickupDate)) {
            response.sendRedirect("book?carId=" + carId + "&error=invalid_return_date");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // Get user ID
                int userId;
                try (PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE email = ?")) {
                    ps.setString(1, userEmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            response.sendRedirect("LoginForm.jsp");
                            return;
                        }
                        userId = rs.getInt("id");
                    }
                }
                
                // Get car details and calculate total amount
                double dailyRate;
                try (PreparedStatement ps = con.prepareStatement("SELECT daily_rate FROM cars WHERE id = ?")) {
                    ps.setInt(1, carId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            response.sendRedirect("cars?error=car_not_found");
                            return;
                        }
                        dailyRate = rs.getDouble("daily_rate");
                    }
                }
                
                // Calculate number of days and total amount
                long days = ChronoUnit.DAYS.between(pickupDate, returnDate) + 1;
                double totalAmount = days * dailyRate;
                
                // Create booking record
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings (user_id, car_id, pan_card, driving_license, pickup_date, return_date, pickup_location, total_amount) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS)) {
                    
                    ps.setInt(1, userId);
                    ps.setInt(2, carId);
                    ps.setString(3, panCard);
                    ps.setString(4, drivingLicense);
                    ps.setObject(5, pickupDate);
                    ps.setObject(6, returnDate);
                    ps.setString(7, pickupLocation);
                    ps.setDouble(8, totalAmount);
                    
                    int result = ps.executeUpdate();
                    if (result > 0) {
                        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int bookingId = generatedKeys.getInt(1);
                                session.setAttribute("bookingId", bookingId);
                                session.setAttribute("totalAmount", totalAmount);
                                response.sendRedirect("verification");
                            } else {
                                throw new RuntimeException("Failed to get booking ID");
                            }
                        }
                    } else {
                        response.sendRedirect("book?carId=" + carId + "&error=booking_failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}