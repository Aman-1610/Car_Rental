<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">Booking Confirmed!</h4>
                    </div>
                    <div class="card-body">
                        <%
                            String bookingId = request.getParameter("bookingId");
                            if (bookingId != null && !bookingId.isEmpty()) {
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");
                                    
                                    String sql = "SELECT b.*, c.make, c.model, c.year, c.color, d.address, d.city, d.state, d.postal_code " +
                                                "FROM bookings b " +
                                                "JOIN cars c ON b.car_id = c.id " +
                                                "JOIN delivery_details d ON b.id = d.booking_id " +
                                                "WHERE b.id = ?";
                                    
                                    PreparedStatement ps = con.prepareStatement(sql);
                                    ps.setInt(1, Integer.parseInt(bookingId));
                                    ResultSet rs = ps.executeQuery();
                                    
                                    if (rs.next()) {
                        %>
                                        <h5>Booking Reference: <span class="text-primary">#<%= rs.getInt("id") %></span></h5>
                                        
                                        <div class="row mt-4">
                                            <div class="col-md-6">
                                                <h6 class="fw-bold">Car Details</h6>
                                                <p>
                                                    <%= rs.getString("make") %> <%= rs.getString("model") %> (<%= rs.getInt("year") %>)<br>
                                                    Color: <%= rs.getString("color") %>
                                                </p>
                                                
                                                <h6 class="fw-bold mt-3">Rental Period</h6>
                                                <p>
                                                    Pickup: <%= rs.getDate("pickup_date") %><br>
                                                    Return: <%= rs.getDate("return_date") %>
                                                </p>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <h6 class="fw-bold">Delivery Address</h6>
                                                <p>
                                                    <%= rs.getString("address") %><br>
                                                    <%= rs.getString("city") %>, <%= rs.getString("state") %><br>
                                                    <%= rs.getString("postal_code") %>
                                                </p>
                                                
                                                <h6 class="fw-bold mt-3">Total Amount</h6>
                                                <p class="fs-5">₹<%= rs.getDouble("total_amount") %></p>
                                            </div>
                                        </div>
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6 class="fw-bold">What happens next?</h6>
                                            <p>Our team will contact you shortly to confirm the delivery time. The car will be delivered to your provided address on the pickup date.</p>
                                            <p>You can track your booking status in your profile dashboard.</p>
                                        </div>
                                        
                                        <div class="mt-4 text-center">
                                            <a href="profile.jsp" class="btn btn-primary">Go to Dashboard</a>
                                            <a href="index.jsp" class="btn btn-outline-secondary ms-2">Return to Home</a>
                                        </div>
                        <%
                                    } else {
                        %>
                                        <div class="alert alert-danger">
                                            Booking information not found. Please contact customer support.
                                        </div>
                                        <a href="index.jsp" class="btn btn-primary">Return to Home</a>
                        <%
                                    }
                                    
                                    rs.close();
                                    ps.close();
                                    con.close();
                                    
                                } catch (Exception e) {
                                    e.printStackTrace();
                        %>
                                    <div class="alert alert-danger">
                                        An error occurred while retrieving booking details. Please contact customer support.
                                    </div>
                                    <a href="index.jsp" class="btn btn-primary">Return to Home</a>
                        <%
                                }
                            } else {
                        %>
                                <div class="alert alert-danger">
                                    Invalid booking reference. Please contact customer support.
                                </div>
                                <a href="index.jsp" class="btn btn-primary">Return to Home</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>