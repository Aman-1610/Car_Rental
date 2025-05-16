<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.carrental.Car" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suv Cars - CarRent</title>
    <style>
        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .car-card {
            background-color: var(--card-bg);
            border-radius: 0.75rem;
            border: 1px solid var(--card-border);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }

        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }

        .car-image {
            height: 200px;
            position: relative;
            overflow: hidden;
        }

        .car-image-bg {
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            transition: transform 0.5s ease;
        }

        .car-card:hover .car-image-bg {
            transform: scale(1.1);
        }

        .car-image-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, 
                rgba(236, 72, 153, 0.2), 
                transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        [data-theme="dark"] .car-image-overlay {
            background: linear-gradient(to top, 
                rgba(126, 34, 206, 0.4), 
                transparent);
        }

        .car-card:hover .car-image-overlay {
            opacity: 1;
        }

        .car-info {
            padding: 1.5rem;
        }

        .car-info h3 {
            margin-bottom: 0.5rem;
            font-size: 1.25rem;
            transition: color 0.3s ease;
        }

        .car-card:hover .car-info h3 {
            color: var(--primary-color);
        }

        .car-info p {
            color: var(--text-muted);
            margin-bottom: 1rem;
        }

        .car-price {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 0.375rem;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            text-align: center;
            font-weight: 500;
        }

        .btn:hover {
            background-color: var(--primary-hover);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <main class="container">
        <h1 class="page-title">Our Family SUVs</h1>
        <div class="car-grid">

        <%
            List<Car> carList = (List<Car>) request.getAttribute("carList");
            if (carList != null) {
                for (Car car : carList) {
                    if ("SUV".equalsIgnoreCase(car.getCategory())) {
        %>
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('<%= car.getImageUrl() %>');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3><%= car.getMake() %> <%= car.getModel() %></h3>
                    <p><%= car.getDescription() %></p>
                    <div class="car-price">₹<%= car.getDailyRate() %>/day</div>
                    <a href="book?carId=<%= car.getId() %>" class="btn">Rent Now</a>
                </div>
            </div>
        <%
                    }
                }
            } else {
        %>
            <p>No SUV cars available right now.</p>
        <%
            }
        %>

        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>