<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
     * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            /* Light mode variables */
            --bg-gradient-from: #fdf2f8;
            --bg-gradient-to: #ffffff;
            --header-bg: rgba(255, 255, 255, 0.8);
            --header-border: #fce7f3;
            --text-color: #333333;
            --text-muted: #666666;
            --card-bg: #ffffff;
            --card-border: #fce7f3;
            --card-shadow: 0 10px 15px -3px rgba(236, 72, 153, 0.1), 0 4px 6px -2px rgba(236, 72, 153, 0.05);
            --card-hover-shadow: 0 20px 25px -5px rgba(236, 72, 153, 0.1), 0 10px 10px -5px rgba(236, 72, 153, 0.04);
            --primary-color: #ec4899;
            --primary-hover: #db2777;
            --link-hover: #ec4899;
            --footer-bg: #ffffff;
            --footer-border: #fce7f3;
            --toggle-bg: #f3e8ff;
            --toggle-icon: #ec4899;
        }

        [data-theme="dark"] {
            /* Dark mode variables */
            --bg-gradient-from: #3b0764;
            --bg-gradient-to: #000000;
            --header-bg: rgba(0, 0, 0, 0.8);
            --header-border: #581c87;
            --text-color: #ffffff;
            --text-muted: #d1d5db;
            --card-bg: #111111;
            --card-border: #581c87;
            --card-shadow: 0 10px 15px -3px rgba(126, 34, 206, 0.1), 0 4px 6px -2px rgba(126, 34, 206, 0.05);
            --card-hover-shadow: 0 20px 25px -5px rgba(126, 34, 206, 0.1), 0 10px 10px -5px rgba(126, 34, 206, 0.04);
            --primary-color: #a855f7;
            --primary-hover: #9333ea;
            --link-hover: #c084fc;
            --footer-bg: #000000;
            --footer-border: #581c87;
            --toggle-bg: #581c87;
            --toggle-icon: #c084fc;
        }

        body {
            line-height: 1.6;
            color: var(--text-color);
            background: linear-gradient(to bottom right, var(--bg-gradient-from), var(--bg-gradient-to));
            min-height: 100vh;
            transition: all 0.3s ease;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        header {
            background-color: var(--header-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--header-border);
            position: sticky;
            top: 0;
            z-index: 100;
            transition: all 0.3s ease;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(to right, var(--primary-color), var(--primary-hover));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .logo-icon {
            color: var(--primary-color);
        }
        .logo-img {
    height: 40px;
    width: auto;
    border-radius: 0.5rem; /* optional: rounded corners */
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
<header>
       <nav class="container">
           <div class="logo">
    <img src="logo.png" alt="CarRent Logo" class="logo-img" />
    CarRent
</div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="sports-cars">Cars</a></li>
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
<!--    <li><a href="LoginForm.jsp" class="login-btn">User Login</a></li>
    <li><a href="adminLogin.jsp" class="login-btn">Admin Login</a></li>-->
<%
    }
%>

            </ul>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <button id="themeToggle" class="theme-toggle" aria-label="Toggle theme">
                    <svg id="moonIcon" class="icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display: block;">
                        <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <svg id="sunIcon" class="icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <circle cx="12" cy="12" r="5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <%
                    if (session.getAttribute("userEmail") == null) {
                %>
                    <a href="LoginForm.jsp" class="login-btn">Login</a>
                    <a href="adminLogin.jsp" class="login-btn">Admin Login</a>
                <%
                    }
                %>
            </div>
        </nav>
    </header>
