<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sedan Cars - CarRent</title>
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

        .page-title {
            text-align: center;
            padding: 2rem 0;
            font-size: 2.5rem;
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding-bottom: 4rem;
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

        .car-info p {
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
                <li><a href="sports-cars.jsp">Sports Cars</a></li>
                <li><a href="sedan-cars.jsp">Sedan Cars</a></li>
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
        <h1 class="page-title">Our Luxury Sedans</h1>
        <div class="car-grid">
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,mercedes');"></div>
                <div class="car-info">
                    <h3>Mercedes-Benz S-Class</h3>
                    <p>Experience ultimate luxury and comfort</p>
                    <p><strong>Price:</strong> $300/day</p>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,bmw');"></div>
                <div class="car-info">
                    <h3>BMW 7 Series</h3>
                    <p>Cutting-edge technology meets elegance</p>
                    <p><strong>Price:</strong> $280/day</p>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,audi');"></div>
                <div class="car-info">
                    <h3>Audi A8</h3>
                    <p>Sophisticated design with advanced features</p>
                    <p><strong>Price:</strong> $270/day</p>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,lexus');"></div>
                <div class="car-info">
                    <h3>Lexus LS</h3>
                    <p>Japanese luxury with exceptional craftsmanship</p>
                    <p><strong>Price:</strong> $260/day</p>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,jaguar');"></div>
                <div class="car-info">
                    <h3>Jaguar XJ</h3>
                    <p>British elegance with powerful performance</p>
                    <p><strong>Price:</strong> $250/day</p>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image" style="background-image: url('https://source.unsplash.com/500x300/?car,genesis');"></div>
                <div class="car-info">
                    <h3>Genesis G90</h3>
                    <p>Korean luxury redefined</p>
                    <p><strong>Price:</strong> $240/day</p>
                    <a href="#" class="btn">Rent Now</a>
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