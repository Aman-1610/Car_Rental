<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.carrental.Car" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sports Cars - CarRent</title>
  <style>
    :root {
      --bg-color: #f5f5f5;
      --text-color: #1a1a1a;
      --card-bg: #ffffff;
      --card-shadow: rgba(0, 0, 0, 0.1);
      --primary: #007bff;
      --hover: #0056b3;
    }

    [data-theme="dark"] {
      --bg-color: #121212;
      --text-color: #ffffff;
      --card-bg: #1e1e1e;
      --card-shadow: rgba(255, 255, 255, 0.05);
      --primary: #00bfff;
      --hover: #0088cc;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      transition: background-color 0.3s, color 0.3s;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: var(--bg-color);
      color: var(--text-color);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    header {
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: var(--card-bg);
      box-shadow: 0 2px 4px var(--card-shadow);
    }

    .logo {
      font-size: 1.5rem;
      font-weight: bold;
      color: var(--primary);
    }

    nav {
      display: flex;
      gap: 1.5rem;
    }

    nav a {
      text-decoration: none;
      color: var(--text-color);
      font-weight: 500;
    }

    .login-btn, .theme-toggle {
      padding: 0.5rem 1rem;
      background-color: var(--primary);
      border: none;
      border-radius: 5px;
      color: #fff;
      cursor: pointer;
    }

    .theme-toggle {
      margin-left: 1rem;
    }

    main {
      flex-grow: 1;
      padding: 2rem;
    }

    .page-title {
      font-size: 1.8rem;
      margin-bottom: 1.5rem;
      text-align: center;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .car-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 1.5rem;
    }

    .car-card {
      background-color: var(--card-bg);
      box-shadow: 0 4px 8px var(--card-shadow);
      border-radius: 10px;
      overflow: hidden;
      transition: transform 0.3s ease;
    }

    .car-card:hover {
      transform: translateY(-5px);
    }

    .car-image img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .car-details {
      padding: 1rem;
    }

    .car-details h3 {
      margin-bottom: 0.5rem;
    }

    .car-details p {
      font-size: 0.9rem;
      margin: 0.25rem 0;
    }

    footer {
      padding: 1rem 2rem;
      background-color: var(--card-bg);
      text-align: center;
      box-shadow: 0 -2px 4px var(--card-shadow);
    }

    @media (max-width: 600px) {
      header, footer {
        flex-direction: column;
        text-align: center;
        gap: 1rem;
      }

      nav {
        flex-direction: column;
        gap: 0.5rem;
      }

      .theme-toggle {
        margin-left: 0;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
    <div class="container">
      <%
          List<Car> cars = (List<Car>) request.getAttribute("carList");
          if (cars == null || cars.isEmpty()) {
      %>
        <h2 class="page-title">No sports cars available at the moment.</h2>
      <%
          } else {
      %>
        <h2 class="page-title">Available Sports Cars</h2>
        <div class="car-grid">
        <% for (Car car : cars) { %>
            <div class="car-card">
              <div class="car-image">
                <img src="<%= car.getImageUrl() %>" alt="Car Image">
              </div>
              <div class="car-details">
               <h3><%= car.getMake() %> <%= car.getModel() %></h3>
<p><strong>Type:</strong> <%= car.getCategory() %></p>
<p><strong>Price:</strong> ₹<%= car.getDailyRate() %> /day</p>

                <p><strong>Fuel:</strong> <%= car.getFuelType() %></p>
              </div>
            </div>
        <% } %>
        </div>
      <%
          }
      %>
    </div>
  </main>

 <jsp:include page="footer.jsp" />
</body>
</html>
