<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sedan Cars - CarRent</title>
    <style>
        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .car-card {
            background-color: var(--card-bg);
            border-radius: 0.75rem;
            border: 1px solid var(--card-border);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }

        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }

        .car-image {
            height: 200px;
            position: relative;
            overflow: hidden;
        }

        .car-image-bg {
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            transition: transform 0.5s ease;
        }

        .car-card:hover .car-image-bg {
            transform: scale(1.1);
        }

        .car-image-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, 
                rgba(236, 72, 153, 0.2), 
                transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        [data-theme="dark"] .car-image-overlay {
            background: linear-gradient(to top, 
                rgba(126, 34, 206, 0.4), 
                transparent);
        }

        .car-card:hover .car-image-overlay {
            opacity: 1;
        }

        .car-info {
            padding: 1.5rem;
        }

        .car-info h3 {
            margin-bottom: 0.5rem;
            font-size: 1.25rem;
            transition: color 0.3s ease;
        }

        .car-card:hover .car-info h3 {
            color: var(--primary-color);
        }

        .car-info p {
            color: var(--text-muted);
            margin-bottom: 1rem;
        }

        .car-price {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 0.375rem;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            text-align: center;
            font-weight: 500;
        }

        .btn:hover {
            background-color: var(--primary-hover);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <main class="container">
        <h1 class="page-title">Our Luxury Sedans</h1>
        <div class="car-grid">
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('Mercedes-Benz S-Class.jpg');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3>Mercedes-Benz S-Class</h3>
                    <p>Experience ultimate luxury and comfort</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('BMW 7 series.jpeg');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3>BMW 7 Series</h3>
                    <p>Cutting-edge technology meets elegance</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('Audi A8.jpeg');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3>Audi A8</h3>
                    <p>Sophisticated design with advanced features</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('Lexus LS.jpeg');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3>Lexus LS</h3>
                    <p>Japanese luxury with exceptional craftsmanship</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
                <div class="car-image">
                    <div class="car-image-bg" style="background-image: url('Genesis g90.jpeg');"></div>
                    <div class="car-image-overlay"></div>
                </div>
                <div class="car-info">
                    <h3>Genesis G90</h3>
                    <p>Korean luxury redefined</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
            <div class="car-card">
            <div class="car-image">
                <div class="car-image-bg" style="background-image: url('Jaguar XJ.jpeg');"></div>
                <div class="car-image-overlay"></div>
            </div>
                <div class="car-info">
                    <h3>Jaguar XJ</h3>
                    <p>British elegance with powerful performance</p>
                    <div class="car-price">₹5000/day</div>
                    <a href="#" class="btn">Rent Now</a>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>