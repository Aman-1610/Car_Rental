<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - CarRent</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        .profile-content {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            border-radius: 1rem;
            margin: 3rem auto;
            max-width: 700px;
            width: 100%;
            transition: box-shadow 0.3s ease;
        }
        .profile-content:hover {
            box-shadow: var(--card-hover-shadow);
        }
        .profile-content h2 {
            margin-bottom: 2rem;
            text-align: center;
            color: var(--primary-color);
            font-size: 2rem;
        }
        .profile-info, .booking-info {
            display: grid;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .profile-info p, .booking-info p {
            display: flex;
            justify-content: space-between;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--card-border);
        }
        .profile-info span:first-child, .booking-info span:first-child {
            font-weight: bold;
            color: var(--text-muted);
        }
        .profile-info span:last-child, .booking-info span:last-child {
            color: var(--text-color);
        }
        .edit-btn {
            display: block;
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            padding: 0.75rem;
            text-align: center;
            border: none;
            border-radius: 0.375rem;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .edit-btn:hover {
            background-color: var(--primary-hover);
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<main class="container">
    <%
        HttpSession userSession = request.getSession(false);
        if (userSession == null || userSession.getAttribute("userEmail") == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        String userName = (String) userSession.getAttribute("userName");
        String userEmail = (String) userSession.getAttribute("userEmail");

        String carName = "No booking yet";
        String pickupDate = "-";
        String returnDate = "-";
        int totalDays = 0;
        double totalAmount = 0.0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");

            // Fetch user's latest booking
            PreparedStatement ps = con.prepareStatement(
                "SELECT c.make, c.model, b.pickup_date, b.return_date, b.total_amount " +
                "FROM bookings b JOIN cars c ON b.car_id = c.id " +
                "JOIN users u ON b.user_id = u.id " +
                "WHERE u.email = ? ORDER BY b.id DESC LIMIT 1"
            );
            ps.setString(1, userEmail);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                carName = rs.getString("make") + " " + rs.getString("model");
                pickupDate = rs.getDate("pickup_date").toString();
                returnDate = rs.getDate("return_date").toString();
                totalAmount = rs.getDouble("total_amount");

                java.time.LocalDate pickup = java.time.LocalDate.parse(pickupDate);
                java.time.LocalDate returns = java.time.LocalDate.parse(returnDate);
                totalDays = (int) java.time.temporal.ChronoUnit.DAYS.between(pickup, returns) + 1;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="profile-content">
        <h2>User Profile</h2>

        <div class="profile-info">
            <p><span>Name:</span> <span><%= (userName != null) ? userName : "Guest" %></span></p>
            <p><span>Email:</span> <span><%= (userEmail != null) ? userEmail : "Not Available" %></span></p>
        </div>

        <h4 class="mb-3 text-primary">Latest Booking Details:</h4>
        <div class="booking-info">
            <p><span>Car Booked:</span> <span><%= carName %></span></p>
            <p><span>Pickup Date:</span> <span><%= pickupDate %></span></p>
            <p><span>Return Date:</span> <span><%= returnDate %></span></p>
            <p><span>Number of Days:</span> <span><%= totalDays %> days</span></p>
            <p><span>Total Amount:</span> <span>₹<%= totalAmount %></span></p>
        </div>

        <a href="edit-profile.jsp" class="edit-btn">Edit Profile</a>
    </div>
</main>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
