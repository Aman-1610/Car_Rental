<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verification - Car Rental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Document Verification</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <p>Your documents are being verified. This usually takes a few minutes.</p>
                            <p>In a real application, this step would involve actual verification by admin staff or an automated system.</p>
                        </div>
                        
                        <p>For demonstration purposes, click the button below to simulate successful verification:</p>
                        
                        <form action="verification" method="post">
                            <button type="submit" class="btn btn-success">Simulate Successful Verification</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>