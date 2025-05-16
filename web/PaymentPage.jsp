<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Payment</h4>
                    </div>
                    <div class="card-body">
                        <h5>Booking #${bookingId}</h5>
                        <h3>Total Amount: ₹${amount}</h3>
                        
                        <hr>
                        
                        <form action="payment" method="post" id="paymentForm">
                            <div class="mb-3">
                                <label class="form-label">Select Payment Method</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="credit_card" checked>
                                    <label class="form-check-label" for="creditCard">
                                        Credit Card
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="debitCard" value="debit_card">
                                    <label class="form-check-label" for="debitCard">
                                        Debit Card
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="upi" value="upi">
                                    <label class="form-check-label" for="upi">
                                        UPI
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Credit Card Form (shown by default) -->
                            <div id="creditCardForm">
                                <div class="mb-3">
                                    <label for="cardNumber" class="form-label">Card Number</label>
                                    <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="expiryDate" class="form-label">Expiry Date</label>
                                        <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="cvv" class="form-label">CVV</label>
                                        <input type="text" class="form-control" id="cvv" placeholder="123">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="nameOnCard" class="form-label">Name on Card</label>
                                    <input type="text" class="form-control" id="nameOnCard">
                                </div>
                            </div>
                            
                            <!-- UPI Form (hidden by default) -->
                            <div id="upiForm" style="display: none;">
                                <div class="mb-3">
                                    <label for="upiId" class="form-label">UPI ID</label>
                                    <input type="text" class="form-control" id="upiId" placeholder="example@upi">
                                </div>
                            </div>
                            
                            <div class="alert alert-info">
                                <p><strong>Note:</strong> This is a demonstration. No actual payment will be charged.</p>
                                <p>In a real application, you would integrate with a payment gateway like Razorpay, PayU, or PayTM.</p>
                            </div>
                            
                            <button type="submit" class="btn btn-success btn-lg mt-3">Pay Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
   
</body>
</html>