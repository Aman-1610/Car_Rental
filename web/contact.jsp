<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - CarRent</title>
    <style>
        
        .contact-form {
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    box-shadow: var(--card-shadow);
    padding: 2rem;
    border-radius: 1rem;
    margin: 2rem auto;
    max-width: 600px;
    width: 100%;
}

.contact-form h2 {
    margin-bottom: 1.5rem;
    text-align: center;
    color: var(--primary-color);
}

.form-group {
    margin-bottom: 1rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: var(--text-muted);
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid var(--card-border);
    border-radius: 0.5rem;
    background-color: var(--card-bg);
    color: var(--text-color);
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input:hover,
.form-group textarea:hover,
.form-group input:focus,
.form-group textarea:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(236, 72, 153, 0.2);
    outline: none;
}

button[type="submit"] {
    width: 100%;
    background-color: var(--primary-color);
    color: white;
    padding: 0.75rem;
    border: none;
    border-radius: 0.5rem;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
    background-color: #be185d;
}
/* Contact Info */
.contact-info {
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    box-shadow: var(--card-shadow);
    padding: 2rem;
    border-radius: 1rem;
    margin: 2rem auto;
    max-width: 600px;
    width: 100%;
    color: var(--text-color);
    line-height: 1.6;
}

.contact-info h3 {
    margin-bottom: 1rem;
    text-align: center;
    color: var(--primary-color);
}

.contact-info p {
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--text-muted);
}

.contact-info p svg {
    color: var(--primary-color);
    flex-shrink: 0;
}
    </style>
</head>
<body>
    
    <jsp:include page="header.jsp"/>
    <main class="container">
        <form class="contact-form" action="contact" method="post">
            <h2>Contact Us</h2>
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="subject">Subject</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="message">Message</label>
                <textarea id="message" name="message" required></textarea>
            </div>
            <button type="submit" class="btn">Send Message</button>
        </form>
       <div class="contact-info">
    <h3>Our Contact Information</h3>
    <p>
        <svg class="icon" viewBox="0 0 24 24">
            <path d="M4 4h16v16H4z" fill="none" />
            <path d="M4 4l8 8 8-8" stroke="currentColor" stroke-width="2" fill="none" />
        </svg>
        Email: <a href="mailto:info@carrent.com" style="color: var(--primary-color); text-decoration: none;">amandiv2345@gmail.com</a>
    </p>
    <p>
        <svg class="icon" viewBox="0 0 24 24">
            <path d="M3 5h2l3 7-1.5 2.5c.5.5 1 1 1.5 1.5l2.5-1.5 7 3v2a1 1 0 0 1-1 1A17 17 0 0 1 3 5z" fill="none" stroke="currentColor" stroke-width="2"/>
        </svg>
        Phone: +91 7061545199
    </p>
    <p>
        <svg class="icon" viewBox="0 0 24 24">
            <path d="M12 2C8 2 5 5 5 9c0 7 7 13 7 13s7-6 7-13c0-4-3-7-7-7z" fill="none" stroke="currentColor" stroke-width="2"/>
        </svg>
        Address: CSWT BSF Camp Indore
    </p>
</div>

    </main>

    <jsp:include page="footer.jsp"/>
</body>
</html>