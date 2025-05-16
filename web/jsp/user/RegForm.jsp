<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CarRent</title>
    <style>
        /* Register Form Specific Styles */
        .register-form {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            border-radius: 1rem;
            margin: 3rem auto;
            max-width: 500px;
            width: 100%;
            transition: box-shadow 0.3s ease;
        }
        
        .register-form:hover {
            box-shadow: var(--card-hover-shadow);
        }

        .register-form h2 {
            margin-bottom: 1.5rem;
            text-align: center;
            color: var(--primary-color);
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--card-border);
            border-radius: 0.5rem;
            background-color: var(--card-bg);
            color: var(--text-color);
            transition: border-color 0.3s, box-shadow 0.3s, transform 0.2s;
        }

        .form-group input:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(236, 72, 153, 0.2);
            outline: none;
            transform: translateY(-2px);
        }

        .form-footer {
            margin-top: 1.5rem;
            text-align: center;
            color: var(--text-muted);
        }

        .form-footer a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .form-footer a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        .error-message {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }

    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <main class="container">
        <form class="register-form" action="register" method="post">
            <h2>Create an Account</h2>
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    if (error.equals("email_exists")) {
            %>
                        <p class="error-message">Email already exists. Please use a different email.</p>
            <%
                    } else if (error.equals("password_mismatch")) {
            %>
                        <p class="error-message">Passwords do not match. Please try again.</p>
            <%
                    } else if (error.equals("server")) {
            %>
                        <p class="error-message">Server error occurred. Please try again later.</p>
            <%
                    }
                }
            %>
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Create a password">
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirm-password" required placeholder="Confirm your password">
            </div>
            <button type="submit" class="btn">Register</button>
            <div class="form-footer">
                <p>Already have an account? <a href="LoginForm.jsp">Login here</a></p>
            </div>
        </form>
    </main>

            <jsp:include page="footer.jsp"/>
</body>
</html>