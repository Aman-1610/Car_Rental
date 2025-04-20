package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cars")
public class CarDisplayServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                List<Car> cars = new ArrayList<>();
                String category = request.getParameter("category");
                
                String sql = "SELECT * FROM cars WHERE is_available = true";
                if (category != null && !category.isEmpty()) {
                    sql += " AND category = ?";
                }

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    if (category != null && !category.isEmpty()) {
                        ps.setString(1, category);
                    }

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Car car = new Car();
                            car.setId(rs.getInt("id"));
                            car.setMake(rs.getString("make"));
                            car.setModel(rs.getString("model"));
                            car.setYear(rs.getInt("year"));
                            car.setColor(rs.getString("color"));
                            car.setDailyRate(rs.getDouble("daily_rate"));
                            car.setImageUrl(rs.getString("image_url"));
                            car.setDescription(rs.getString("description"));
                            car.setCategory(rs.getString("category"));
                            car.setCapacity(rs.getInt("capacity"));
                            car.setTransmission(rs.getString("transmission"));
                            car.setFuelType(rs.getString("fuelType"));
                            cars.add(car);
                        }
                    }
                }

                request.setAttribute("cars", cars);

                // Forward to category-specific JSP
                if ("Sports".equalsIgnoreCase(category)) {
                    request.getRequestDispatcher("sports-cars.jsp").forward(request, response);
                } else if ("Sedan".equalsIgnoreCase(category)) {
                    request.getRequestDispatcher("sedan-cars.jsp").forward(request, response);
                } else if ("SUV".equalsIgnoreCase(category)) {
                    request.getRequestDispatcher("suv-cars.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("carList.jsp").forward(request, response);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
