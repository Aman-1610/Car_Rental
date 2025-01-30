<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Car - CarRent</title>
    <style>
        .booking-form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .car-details {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        
        .total-amount {
            font-size: 1.2em;
            font-weight: bold;
            margin: 20px 0;
        }
        
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        
        .submit-btn:hover {
            background-color: #45a049;
        }
        
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="booking-form">
            <h2>Book a Car</h2>
            
            <%
                String carId = request.getParameter("carId");
                if (carId != null) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");
                        String sql = "SELECT * FROM cars WHERE id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, carId);
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
            %>
                            <div class="car-details">
                                <h3><%= rs.getString("make") %> <%= rs.getString("model") %></h3>
                                <p>Year: <%= rs.getInt("year") %></p>
                                <p>Daily Rate: $<%= rs.getDouble("daily_rate") %></p>
                            </div>
                            
                            <form action="booking" method="post" onsubmit="return calculateTotal();">
                                <input type="hidden" name="carId" value="<%= carId %>">
                                <input type="hidden" name="dailyRate" value="<%= rs.getDouble("daily_rate") %>">
                                
                                <div class="form-group">
                                    <label for="startDate">Start Date:</label>
                                    <input type="date" id="startDate" name="startDate" required 
                                           min="<%= java.time.LocalDate.now() %>" onchange="calculateTotal()">
                                </div>
                                
                                <div class="form-group">
                                    <label for="endDate">End Date:</label>
                                    <input type="date" id="endDate" name="endDate" required 
                                           min="<%= java.time.LocalDate.now() %>" onchange="calculateTotal()">
                                </div>
                                
                                <div class="total-amount">
                                    Total Amount: $<span id="totalAmount">0.00</span>
                                    <input type="hidden" name="totalAmount" id="totalAmountInput">
                                </div>
                                
                                <button type="submit" class="submit-btn">Proceed to Payment</button>
                            </form>
            <%
                        } else {
            %>
                            <p class="error-message">Car not found.</p>
            <%
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
            %>
                        <p class="error-message">An error occurred. Please try again later.</p>
            <%
                    }
                }
            %>
        </div>
    </div>

    <script>
        function calculateTotal() {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            const dailyRate = parseFloat(document.querySelector('input[name="dailyRate"]').value);
            
            if (startDate && endDate && startDate <= endDate) {
                const days = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
                const total = days * dailyRate;
                document.getElementById('totalAmount').textContent = total.toFixed(2);
                document.getElementById('totalAmountInput').value = total.toFixed(2);
                return true;
            } else if (endDate < startDate) {
                alert('End date cannot be before start date');
                return false;
            }
            return false;
        }

        // Set minimum dates
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('startDate').min = today;
        document.getElementById('endDate').min = today;
    </script>
</body>
</html>