package com.carrental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String myemail = req.getParameter("email");
        String mypass = req.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental", "root", "root");
            PreparedStatement ps = con.prepareStatement("SELECT name, email FROM users WHERE email=? AND password=?");
            ps.setString(1, myemail);
            ps.setString(2, mypass);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                HttpSession session = req.getSession();
                session.setAttribute("userName", name);
                session.setAttribute("userEmail", myemail);
                resp.sendRedirect("profile.jsp");
            } else {
                resp.sendRedirect("LoginForm.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("LoginForm.jsp?error=server");
        }
    }
}