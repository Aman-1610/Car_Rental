<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - CarRent</title>
    <style>
        
        .about-content {
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    box-shadow: var(--card-shadow);
    border-radius: 1rem;
    padding: 2rem;
    margin-top: 3rem;
    color: var(--text-color);
    transition: all 0.3s ease;
}

.about-content h2 {
    font-size: 2rem;
    margin-bottom: 1rem;
    color: var(--primary-color);
    text-align: center;
}

.about-content p {
    font-size: 1.1rem;
    margin-bottom: 1.2rem;
    line-height: 1.8;
}

.team-section {
    margin-top: 3rem;
}

.team-section h3 {
    font-size: 1.8rem;
    color: var(--primary-color);
    margin-bottom: 2rem;
    text-align: center;
}

.team-grid {
    display: flex;
    justify-content: center;
    gap: 2rem;
    flex-wrap: wrap;
}

.team-member {
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: 0.75rem;
    padding: 1rem;
    width: 200px;
    text-align: center;
    box-shadow: var(--card-shadow);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.team-member:hover {
    transform: translateY(-5px);
    box-shadow: var(--card-hover-shadow);
}

.team-member img {
    border-radius: 50%;
    margin-bottom: 1rem;
    width: 100px;
    height: 100px;
    object-fit: cover;
}

.team-member h4 {
    font-size: 1.2rem;
    margin-bottom: 0.3rem;
    color: var(--text-color);
}

.team-member p {
    font-size: 0.95rem;
    color: var(--text-muted);
}
        .team-section {
    margin-top: 3rem;
}

.team-grid {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 2rem;
}

.team-member {
    width: 200px;
    perspective: 1000px; /* Needed for 3D */
}

.card-inner {
    position: relative;
    width: 100%;
    height: 260px;
    transform-style: preserve-3d;
    transition: transform 0.6s;
}

.team-member:hover .card-inner {
    transform: rotateY(180deg);
}

.card-front, .card-back {
    position: absolute;
    width: 100%;
    height: 100%;
    backface-visibility: hidden;
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    box-shadow: var(--card-shadow);
    border-radius: 12px;
    padding: 1rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    transition: box-shadow 0.3s ease;
}

.card-front:hover {
    box-shadow: var(--card-hover-shadow);
    transform: scale(1.05) rotateX(2deg) rotateY(2deg);
}

.card-back {
    transform: rotateY(180deg);
    background-color: var(--primary-color);
    color: #fff;
}

.card-front img {
    border-radius: 50%;
    width: 100px;
    height: 100px;
    object-fit: cover;
    margin-bottom: 1rem;
}

.card-front h4,
.card-back h4 {
    margin: 0.5rem 0;
    font-size: 1.1rem;
}

.card-back p {
    font-size: 0.9rem;
    text-align: center;
    padding: 0 0.5rem;
}


        .nav-links {
            list-style: none;
            display: flex;
            align-items: center;
        }

        .nav-links li {
            margin-left: 2rem;
        }

        .nav-links a {
            color: var(--text-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--link-hover);
        }

        .theme-toggle {
            background: var(--toggle-bg);
            color: var(--toggle-icon);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .theme-toggle:hover {
            transform: rotate(15deg);
        }

        .login-btn {
            background: transparent;
            border: 1px solid var(--header-border);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .page-title {
            text-align: center;
            margin: 3rem 0;
            font-size: 2.5rem;
            color: var(--text-color);
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
    <jsp:include page="header.jsp"/>

    <main class="container">
        <div class="about-content">
            <h2>About CarRent</h2>
            <p>CarRent is a premium car rental service dedicated to providing our customers with the best driving experience possible. Founded in 2025, we have grown to become one of the leading car rental companies in the country.</p>
            <p>Our mission is to make renting a car as easy and enjoyable as possible. We offer a wide range of vehicles, from economy cars to luxury sports cars, ensuring that we have the perfect vehicle for every occasion and budget.</p>
            <p>At CarRent, we pride ourselves on our commitment to customer satisfaction, top-notch vehicle maintenance, and competitive pricing. Our team of dedicated professionals works tirelessly to ensure that every aspect of your rental experience exceeds your expectations.</p>
            
            <div class="team-section">
                <h3>Our Team</h3>
                <div class="team-grid">
                   <div class="team-member">
    <div class="card-inner">
        <div class="card-front">
            <img src="Alok.png" alt="Alok Kumar">
            <h4>Alok Kumar</h4>
            <b><strong><p>CEO</p></strong></b>
            <p>22100BTCSE11398</p>
        </div>
        <div class="card-back">
            <h4>Alok Kumar</h4>
            <p>Frontend Developer.</p>
        </div>
    </div>
</div>

<div class="team-member">
    <div class="card-inner">
        <div class="card-front">
            <img src="Ansh.png" alt="Ansh jaiswal">
            <h4>Ansh Jaiswal</h4>
            <b><strong><p>Investor</p></strong></b>
            <p>22100BTCSE11416</p>
        </div>
        <div class="card-back">
            <h4>Ansh Jaiswal</h4>
            <p>Frontend Developer.</p>
        </div>
    </div>
</div>

 <div class="team-member">
    <div class="card-inner">
        <div class="card-front">
            <img src="Sharma.png" alt="Aditya sharma">
            <h4>Aditya Sharma</h4>
            <b><strong><p>Supervisor</p></strong></b>
            <p>22100BTCSE11367</p>
        </div>
        <div class="card-back">
            <h4>Aditya Sharma</h4>
            <p>Backend Developer.</p>
        </div>
    </div>
</div>
<div class="team-member">
    <div class="card-inner">
        <div class="card-front">
            <img src="Tomar.png" alt="Aman Tomar">
            <h4>Aman Tomar</h4>
            <b><strong><p>Technician</p></strong></b>
            <p>22100BTCSE11404</p>
        </div>
        <div class="card-back">
            <h4>Aman Tomar</h4>
            <p>Backend Developer.</p>
        </div>
    </div>
</div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp"/>
</body>
</html>