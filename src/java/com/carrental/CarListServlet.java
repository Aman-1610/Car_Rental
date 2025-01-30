package com.carrental;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cars")
public class CarListServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Car> cars = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                String sql = "SELECT * FROM cars WHERE is_available = true";
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(sql)) {
                    
                    while (rs.next()) {
                        Car car = new Car();
                        car.setId(rs.getInt("id"));
                        car.setMake(rs.getString("make"));
                        car.setModel(rs.getString("model"));
                        car.setYear(rs.getInt("year"));
                        car.setDailyRate(rs.getDouble("daily_rate"));
                        car.setAvailable(rs.getBoolean("is_available"));
                        cars.add(car);
                    }
                }
            }
            
            request.setAttribute("cars", cars);
            request.getRequestDispatcher("/available-cars.jsp").forward(request, response);
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

// Car class to hold car data
class Car {
    private int id;
    private String make;
    private String model;
    private int year;
    private double dailyRate;
    private boolean available;
    
    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getMake() { return make; }
    public void setMake(String make) { this.make = make; }
    
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    
    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }
    
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
}