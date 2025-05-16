package com.carrental;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userEmail") == null) {
            response.sendRedirect("LoginForm.jsp?error=login_required");
            return;
        }

        String carIdParam = request.getParameter("carId");
        if (carIdParam == null || carIdParam.isEmpty()) {
            response.sendRedirect("cars.jsp");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdParam);
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = con.prepareStatement(
                         "SELECT id, make, model, year, color, daily_rate, image_url, category FROM cars WHERE id = ? AND is_available = true")) {

                ps.setInt(1, carId);
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
                        request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("cars.jsp?error=car_not_available");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userEmail") == null) {
            response.sendRedirect("LoginForm.jsp?error=login_required");
            return;
        }

        try {
            int carId = Integer.parseInt(request.getParameter("carId"));
            String panCard = request.getParameter("panCard");
            String drivingLicense = request.getParameter("drivingLicense");
            LocalDate pickupDate = LocalDate.parse(request.getParameter("pickupDate"));
            LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));
            String pickupLocation = request.getParameter("pickupLocation");
            String userEmail = (String) session.getAttribute("userEmail");

            // Input Validations
            if (panCard == null || !panCard.matches("[A-Z]{5}[0-9]{4}[A-Z]{1}")) {
                response.sendRedirect("book?carId=" + carId + "&error=invalid_pan");
                return;
            }
            if (drivingLicense == null || drivingLicense.trim().isEmpty()) {
                response.sendRedirect("book?carId=" + carId + "&error=invalid_license");
                return;
            }
            if (pickupDate.isBefore(LocalDate.now())) {
                response.sendRedirect("book?carId=" + carId + "&error=invalid_pickup_date");
                return;
            }
            if (returnDate.isBefore(pickupDate)) {
                response.sendRedirect("book?carId=" + carId + "&error=invalid_return_date");
                return;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                // Fetch user ID
                int userId = -1;
                try (PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE email = ?")) {
                    ps.setString(1, userEmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            userId = rs.getInt("id");
                        } else {
                            response.sendRedirect("LoginForm.jsp");
                            return;
                        }
                    }
                }

                // Fetch car daily rate
                double dailyRate = 0;
                try (PreparedStatement ps = con.prepareStatement("SELECT daily_rate FROM cars WHERE id = ?")) {
                    ps.setInt(1, carId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            dailyRate = rs.getDouble("daily_rate");
                        } else {
                            response.sendRedirect("cars.jsp?error=car_not_found");
                            return;
                        }
                    }
                }

                long rentalDays = ChronoUnit.DAYS.between(pickupDate, returnDate) + 1;
                double totalAmount = rentalDays * dailyRate;

                // Insert booking
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO bookings (user_id, car_id, pan_card, driving_license, pickup_date, return_date, pickup_location, total_amount) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, carId);
                    ps.setString(3, panCard);
                    ps.setString(4, drivingLicense);
                    ps.setDate(5, Date.valueOf(pickupDate));
                    ps.setDate(6, Date.valueOf(returnDate));
                    ps.setString(7, pickupLocation);
                    ps.setDouble(8, totalAmount);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int bookingId = generatedKeys.getInt(1);
                                session.setAttribute("bookingId", bookingId);
                                session.setAttribute("totalAmount", totalAmount);
                                response.sendRedirect("VerificationPage.jsp");
                            } else {
                                throw new SQLException("Creating booking failed, no ID obtained.");
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
