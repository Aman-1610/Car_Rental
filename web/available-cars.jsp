<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Cars - CarRent</title>
    <style>
        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        
        .car-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .car-card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        
        .car-details {
            margin-bottom: 15px;
        }
        
        .price {
            font-size: 1.2em;
            color: #2c5282;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .book-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .book-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header>
        <!-- Include your header here -->
    </header>

    <main>
        <div class="container">
            <h1>Available Cars</h1>
            <div class="car-grid">
                <c:forEach var="car" items="${cars}">
                    <div class="car-card">
                        <h3>${car.make} ${car.model}</h3>
                        <div class="car-details">
                            <p>Year: ${car.year}</p>
                            <p class="price">$${car.dailyRate} per day</p>
                        </div>
                        <a href="booking.jsp?carId=${car.id}" class="book-button">Book Now</a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <footer>
        <!-- Include your footer here -->
    </footer>
</body>
</html>