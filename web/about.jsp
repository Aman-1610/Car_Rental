<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - CarRent</title>
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

        .about-content {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .about-content h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .about-content p {
            margin-bottom: 1rem;
        }

        .team-section {
            margin-top: 2rem;
        }

        .team-section h3 {
            text-align: center;
            margin-bottom: 1rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .team-member {
            text-align: center;
        }

        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 0.5rem;
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
        <div class="about-content">
            <h2>About CarRent</h2>
            <p>CarRent is a premium car rental service dedicated to providing our customers with the best driving experience possible. Founded in 2010, we have grown to become one of the leading car rental companies in the country.</p>
            <p>Our mission is to make renting a car as easy and enjoyable as possible. We offer a wide range of vehicles, from economy cars to luxury sports cars, ensuring that we have the perfect vehicle for every occasion and budget.</p>
            <p>At CarRent, we pride ourselves on our commitment to customer satisfaction, top-notch vehicle maintenance, and competitive pricing. Our team of dedicated professionals works tirelessly to ensure that every aspect of your rental experience exceeds your expectations.</p>
            
            <div class="team-section">
                <h3>Our Team</h3>
                <div class="team-grid">
                    <div class="team-member">
                        <img src="https://source.unsplash.com/150x150/?portrait,man" alt="John Doe">
                        <h4>John Doe</h4>
                        <p>CEO</p>
                    </div>
                    <div class="team-member">
                        <img src="https://source.unsplash.com/150x150/?portrait,woman" alt="Jane Smith">
                        <h4>Jane Smith</h4>
                        <p>Operations Manager</p>
                    </div>
                    <div class="team-member">
                        <img src="https://source.unsplash.com/150x150/?portrait,person" alt="Mike Johnson">
                        <h4>Mike Johnson</h4>
                        <p>Customer Service Manager</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2023 CarRent. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>