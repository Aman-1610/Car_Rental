<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - CarRent</title>
    <style>
        
        /* Profile Content Styles */
        .profile-content {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            border-radius: 1rem;
            margin: 3rem auto;
            max-width: 600px;
            width: 100%;
            transition: box-shadow 0.3s ease;
        }
        
        .profile-content:hover {
            box-shadow: var(--card-hover-shadow);
        }

        .profile-content h2 {
            margin-bottom: 1.5rem;
            text-align: center;
            color: var(--primary-color);
            font-size: 1.8rem;
        }

        .profile-info {
            display: grid;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .profile-info p {
            display: flex;
            justify-content: space-between;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--card-border);
        }

        .profile-info span:first-child {
            font-weight: bold;
            color: var(--text-muted);
        }

        .profile-info span:last-child {
            color: var(--text-color);
        }

       
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <main class="container">
        <div class="profile-content">
            <h2>User Profile</h2>
            <div class="profile-info">
                <p>
                    <span>Name:</span> 
                    <span><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Guest" %></span>
                </p>
                <p>
                    <span>Email:</span> 
                    <span><%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "Not Available" %></span>
                </p>
                <p>
                    <span>Member Since:</span>
                    <span>April 2023</span>
                </p>
            </div>
            <form action="edit-profile.jsp" method="get">
                <button type="submit" class="btn">Edit Profile</button>
            </form>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>