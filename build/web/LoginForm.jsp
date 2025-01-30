<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CarRent</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        :root {
            --bg-color: #fff;
            --text-color: #333;
            --header-bg: #1a1a1a;
            --header-text: #fff;
            --card-bg: #f4f4f4;
            --input-bg: #fff;
            --input-border: #ccc;
        }

        body {
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            background-color: var(--header-bg);
            color: var(--header-text);
            padding: 1rem 0;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            align-items: center;
        }

        .nav-links li {
            margin-left: 1.5rem;
        }

        .nav-links a {
            color: var(--header-text);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #ffd700;
        }

        .login-form {
            max-width: 400px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .login-form h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid var(--input-border);
            border-radius: 5px;
            background-color: var(--input-bg);
            color: var(--text-color);
        }

        .btn {
            display: inline-block;
            background-color: #ffd700;
            color: #1a1a1a;
            padding: 0.8rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
        }

        .btn:hover {
            background-color: #e6c200;
        }

        .form-footer {
            text-align: center;
            margin-top: 1rem;
        }

        .form-footer a {
            color: #ffd700;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff0000;
            text-align: center;
            margin-bottom: 1rem;
        }

        footer {
            background-color: var(--header-bg);
            color: var(--header-text);
            text-align: center;
            padding: 1rem 0;
            position: absolute;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">CarRent</div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="sports-cars.jsp">Sports Cars</a></li>
                <li><a href="sedan-cars.jsp">Sedan Cars</a></li>
                <li><a href="suv-cars.jsp">SUV Cars</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="LoginForm.jsp">Login</a></li>
            </ul>
        </nav>
    </header>

    <main class="container">
        <form class="login-form" action="login" method="post">
            <h2>Login</h2>
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
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="form-footer">
                <p>Don't have an account? <a href="RegForm.jsp">Register here</a></p>
            </div>
        </form>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2023 CarRent. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>