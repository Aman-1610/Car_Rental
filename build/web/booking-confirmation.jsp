<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - CarRent</title>
    <style>
        .confirmation {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .confirmation h2 {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        
        .booking-details {
            margin-top: 20px;
        }
        
        .booking-details p {
            margin: 10px 0;
        }
        
        .home-btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
        
        .home-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation">
            <h2>Booking Confirmed!</h2>
            
            <%
                String bookingId = request.getParameter("id");
                if (bookingId != null) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");
                        
                        String sql = "SELECT b.*, c.make, c.model, c.year FROM bookings b " +
                                   "JOIN cars c ON b.car_id = c.id WHERE b.id = ?";
                        
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, bookingId);
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
            %>
                            <div class="booking-details">
                                <p><strong>Booking Reference:</strong> #<%= bookingId %></p>
                                <p><strong>Car:</strong> <%= rs.getString("make") %> <%= rs.getString("model") %> <%= rs.getInt("year") %></p>
                                <p><strong>Start Date:</strong> <%= rs.getDate("start_date") %></p>
                                <p><strong>End Date:</strong> <%= rs.getDate("end_date") %></p>
                                <p><strong>Total Amount:</strong> $<%= rs.getDouble("total_amount") %></p>
                                <p><strong>Status:</strong> <%= rs.getString("status") %></p>
                            </div>
                            
                            <p>A confirmation email has been sent to your registered email address.</p>
                            <a href="index.jsp" class="home-btn">Return to Home</a>
            <%
                        } else {
            %>
                            <p>Booking not found.</p>
            <%
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
            %>
                        <p>An error occurred while retrieving booking details.</p>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>