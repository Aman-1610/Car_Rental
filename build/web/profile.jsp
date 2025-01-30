<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - CarRent</title>
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

        .profile-content {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-content h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .profile-info {
            display: grid;
            gap: 1rem;
        }

        .profile-info p {
            display: flex;
            justify-content: space-between;
        }

        .profile-info span:first-child {
            font-weight: bold;
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
            font-size: 1rem;
        }

        .btn:hover {
            background-color: #e6c200;
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
                <%
                    if (session.getAttribute("userEmail") != null) {
                %>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="logout">Logout</a></li>
                <%
                    } else {
                %>
                    <li><a href="LoginForm.jsp">Login</a></li>
                <%
                    }
                %>
            </ul>
        </nav>
    </header>

    <main class="container">
        <div class="profile-content">
            <h2>User Profile</h2>
            <div class="profile-info">
                <p><span>Name:</span> <span><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Guest" %></span></p>
                <p><span>Email:</span> <span><%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "Not Available" %></span></p>
            </div>
            <form action="edit-profile.jsp" method="get">
                <button type="submit" class="btn">Edit Profile</button>
            </form>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2023 CarRent. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>