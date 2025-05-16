<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CarRent</title>
    <style>
      

        /* Login Form Specific Styles */
        .login-form {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            border-radius: 1rem;
            margin: 3rem auto;
            max-width: 450px;
            width: 100%;
            transition: box-shadow 0.3s ease;
        }
        
        .login-form:hover {
            box-shadow: var(--card-hover-shadow);
        }

        .login-form h2 {
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

        .error-message[style*="green"] {
            background-color: rgba(34, 197, 94, 0.1);
            color: #22c55e;
        }

       
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <main class="container">
        <form class="login-form" action="login" method="post">
            <h2>Login to CarRent</h2>
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    if (error.equals("invalid")) {
            %>
                        <p class="error-message">Invalid email or password</p>
            <%
                    } else if (error.equals("server")) {
            %>
                        <p class="error-message">Server error occurred. Please try again later.</p>
            <%
                    }
                }
                
                String registered = request.getParameter("registered");
                if (registered != null && registered.equals("true")) {
            %>
                    <p class="error-message" style="color: green;">Registration successful. Please log in.</p>
            <%
                }
            %>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="form-footer">
                <p>Don't have an account? <a href="RegForm.jsp">Register here</a></p>
            </div>
        </form>
    </main>
            <jsp:include page="footer.jsp"/>
</body>
</html>