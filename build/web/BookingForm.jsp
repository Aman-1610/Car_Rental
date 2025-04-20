<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book a Car - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
   <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4">
                    <img src="${car.image_url}" class="card-img-top" alt="${car.make} ${car.model}">
                    <div class="card-body">
                        <h5 class="card-title">${car.make} ${car.model} (${car.year})</h5>
                        <p class="card-text">
                            <strong>Color:</strong> ${car.color}<br>
                            <strong>Daily Rate:</strong> ₹${car.daily_rate}
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <h2>Booking Details</h2>
                
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger">
                        <% if(request.getParameter("error").equals("invalid_pan")) { %>
                            Invalid PAN Card format. Please enter a valid PAN.
                        <% } else if(request.getParameter("error").equals("invalid_license")) { %>
                            Please enter a valid driving license number.
                        <% } else if(request.getParameter("error").equals("invalid_date")) { %>
                            Pickup date must be today or later.
                        <% } else if(request.getParameter("error").equals("invalid_return_date")) { %>
                            Return date must be after pickup date.
                        <% } else { %>
                            An error occurred. Please try again.
                        <% } %>
                    </div>
                <% } %>
                
                <form action="book" method="post">
                    <input type="hidden" name="carId" value="${car.id}">
                    
                    <div class="mb-3">
                        <label for="panCard" class="form-label">PAN Card Number</label>
                        <input type="text" class="form-control" id="panCard" name="panCard" pattern="[A-Z]{5}[0-9]{4}[A-Z]{1}" required>
                        <div class="form-text">Format: ABCDE1234F</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="drivingLicense" class="form-label">Driving License Number</label>
                        <input type="text" class="form-control" id="drivingLicense" name="drivingLicense" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pickupDate" class="form-label">Pickup Date</label>
                        <input type="date" class="form-control" id="pickupDate" name="pickupDate" required min="<%= java.time.LocalDate.now() %>">
                    </div>
                    
                    <div class="mb-3">
                        <label for="returnDate" class="form-label">Return Date</label>
                        <input type="date" class="form-control" id="returnDate" name="returnDate" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pickupLocation" class="form-label">Pickup Location</label>
                        <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Continue to Verification</button>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>