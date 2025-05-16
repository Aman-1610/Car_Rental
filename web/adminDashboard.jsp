<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<jsp:include page="header.jsp" />

<%
    // Check Admin Session
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<div class="container mt-5">
    <h2 class="text-center mb-4">Admin Dashboard - Pending Verifications</h2>

    <%
        String JDBC_URL = "jdbc:mysql://localhost:3306/car_rental"; // Update if needed
        String JDBC_USER = "root"; // Update if needed
        String JDBC_PASSWORD = "root"; // Update if needed

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            PreparedStatement ps = con.prepareStatement(
                "SELECT b.id, u.email, b.pan_card, b.driving_license, b.pickup_date, b.return_date, b.pickup_location, b.total_amount " +
                "FROM bookings b JOIN users u ON b.user_id = u.id WHERE b.license_verified = false"
            );

            ResultSet rs = ps.executeQuery();
    %>

    <table class="table table-bordered table-hover">
        <thead class="table-primary">
            <tr>
                <th>Booking ID</th>
                <th>User Email</th>
                <th>PAN Card</th>
                <th>Driving License</th>
                <th>Pickup Date</th>
                <th>Return Date</th>
                <th>Pickup Location</th>
                <th>Total Amount (₹)</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("pan_card") %></td>
                <td><%= rs.getString("driving_license") %></td>
                <td><%= rs.getDate("pickup_date") %></td>
                <td><%= rs.getDate("return_date") %></td>
                <td><%= rs.getString("pickup_location") %></td>
                <td><%= rs.getDouble("total_amount") %></td>
                <td>
                    <a href="verify-booking?id=<%= rs.getInt("id") %>" class="btn btn-success btn-sm mb-1">Approve</a>
                    <a href="reject-booking?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm">Reject</a>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
    %>
        <div class="alert alert-danger">Error fetching pending bookings!</div>
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
