<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - CarRent</title>
    <style>
        .payment-form {
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
        }
        
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-form">
            <h2>Payment Details</h2>
            <form action="process-payment" method="post" id="payment-form">
                <div class="form-group">
                    <label for="cardName">Name on Card:</label>
                    <input type="text" id="cardName" name="cardName" required>
                </div>
                
                <div class="form-group">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" required 
                           pattern="[0-9]{16}" title="Please enter a valid 16-digit card number">
                </div>
                
                <div class="form-group">
                    <label for="expiryDate">Expiry Date:</label>
                    <input type="text" id="expiryDate" name="expiryDate" required 
                           pattern="(0[1-9]|1[0-2])\/([0-9]{2})" placeholder="MM/YY" 
                           title="Please enter a valid expiry date (MM/YY)">
                </div>
                
                <div class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv" required 
                           pattern="[0-9]{3,4}" title="Please enter a valid CVV">
                </div>
                
                <button type="submit" class="submit-btn">Pay Now</button>
            </form>
        </div>
    </div>

    <script>
        // Format expiry date input
        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.slice(0,2) + '/' + value.slice(2);
            }
            e.target.value = value;
        });

        // Format card number with spaces
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            e.target.value = value;
        });
    </script>
</body>
</html>