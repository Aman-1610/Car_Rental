package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String myname = req.getParameter("name");
        String myemail = req.getParameter("email");
        String mypassword = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm-password");

        if (!mypassword.equals(confirmPassword)) {
            resp.sendRedirect("RegForm.jsp?error=password_mismatch");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");
            
            PreparedStatement ps = con.prepareStatement("INSERT INTO users VALUES(?, ?, ?, ?, ?)");
            ps.setNull(1, java.sql.Types.INTEGER); // Auto-increment ID
            ps.setString(2, myname);
            ps.setString(3, myemail);
            ps.setString(4, mypassword);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            
            int count = ps.executeUpdate();
            if (count > 0) {
                resp.sendRedirect("LoginForm.jsp?registered=true");
            } else {
                resp.sendRedirect("RegForm.jsp?error=server");
            }
        } catch (Exception e) {
            if (e.getMessage().contains("Duplicate entry")) {
                resp.sendRedirect("RegForm.jsp?error=email_exists");
            } else {
                e.printStackTrace();
                resp.sendRedirect("RegForm.jsp?error=server");
            }
        }
    }
}