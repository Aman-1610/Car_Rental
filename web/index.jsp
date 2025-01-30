<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CarRent - Your Premium Car Rental Service</title>
    
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

        .hero {
            position: relative;
            height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
            overflow: hidden;
        }

        .hero video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        .hero-content {
            background-color: rgba(0, 0, 0, 0.6);
            padding: 2rem;
            border-radius: 10px;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .btn {
            display: inline-block;
            background-color: #ffd700;
            color: #1a1a1a;
            padding: 0.8rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #e6c200;
        }

        .featured-cars {
            padding: 4rem 0;
        }

        .featured-cars h2 {
            text-align: center;
            margin-bottom: 2rem;
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .car-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .car-card:hover {
            transform: translateY(-5px);
        }

        .car-image {
            height: 200px;
            background-size: cover;
            background-position: center;
        }

        .car-info {
            padding: 1rem;
        }

        .car-info h3 {
            margin-bottom: 0.5rem;
        }

        footer {
            background-color: var(--header-bg);
            color: var(--header-text);
            text-align: center;
            padding: 1rem 0;
        }
    </style>
</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">CarRent</div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="#cars">Cars</a></li>
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

    <main>
        <section class="hero" id="home">
            <video autoplay muted loop class="hero-video">
                <source src="Ferrari.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            <div class="hero-content">
                <h1>Drive Your Dreams</h1>
                <p>Experience luxury and comfort with our premium car rental service</p>
                <a href="#cars" class="btn">Explore Cars</a>
            </div>
        </section>

        <section class="featured-cars container" id="cars">
            <h2>Featured Cars</h2>
            <div class="car-grid">
                <div class="car-card">
                    <div class="car-image" style="background-image: url('sportscar.jpg');"></div>
                    <div class="car-info">
                        <h3>Sports Car</h3>
                        <p>Experience the thrill of speed</p>
                        <a href="sports-cars.jsp" class="btn">Rent Now</a>
                    </div>
                </div>
                <div class="car-card">
                    <div class="car-image" style="background-image: url('luxurysedan.jpg');"></div>
                    <div class="car-info">
                        <h3>Luxury Sedan</h3>
                        <p>Travel in style and comfort</p>
                        <a href="sedan-cars.jsp" class="btn">Rent Now</a>
                    </div>
                </div>
                <div class="car-card">
                    <div class="car-image" style="background-image: url('suv.jpg');"></div>
                    <div class="car-info">
                        <h3>Family SUV</h3>
                        <p>Perfect for family trips</p>
                        <a href="suv-cars.jsp" class="btn">Rent Now</a>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2023 CarRent. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>