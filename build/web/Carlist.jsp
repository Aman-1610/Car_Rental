<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Cars - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <h2>Available Cars</h2>
        
        <div class="row mb-4">
            <div class="col-md-6">
                <form action="cars" method="get" class="d-flex">
                    <select name="category" class="form-select me-2">
                        <option value="">All Categories</option>
                        <option value="Economy">Economy</option>
                        <option value="Compact">Compact</option>
                        <option value="Luxury">Luxury</option>
                        <option value="SUV">SUV</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Filter</button>
                </form>
            </div>
        </div>
        
        <div class="row">
            <c:forEach var="car" items="${cars}">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="${car.imageUrl}" class="card-img-top" alt="${car.make} ${car.model}">
                        <div class="card-body">
                            <h5 class="card-title">${car.make} ${car.model} (${car.year})</h5>
                            <p class="card-text">
                                <strong>Color:</strong> ${car.color}<br>
                                <strong>Category:</strong> ${car.category}<br>
                                <strong>Transmission:</strong> ${car.transmission}<br>
                                <strong>Fuel Type:</strong> ${car.fuelType}<br>
                                <strong>Capacity:</strong> ${car.capacity} persons<br>
                                <strong>Daily Rate:</strong> ₹${car.daily_rate}
                            </p>
                            <a href="book?carId=${car.id}" class="btn btn-primary">Book Now</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty cars}">
                <div class="col-12">
                    <div class="alert alert-info">
                        No cars available matching your criteria. Please try different filters.
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>