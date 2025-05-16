package com.carrental;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/sedan-cars")
public class SedanCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> carList = new ArrayList<>();

        Car car1 = new Car();
        car1.setId(10);
        car1.setMake("Mercedes-Benz");
        car1.setModel("S-Class");
        car1.setDescription("Experience ultimate luxury and comfort.");
        car1.setDailyRate(5000);
        car1.setCategory("Sedan");
        car1.setImageUrl("Mercedes-Benz S-Class.jpg");

        Car car2 = new Car();
        car2.setId(11);
        car2.setMake("BMW");
        car2.setModel("7 Series");
        car2.setDescription("Cutting-edge technology meets elegance.");
        car2.setDailyRate(5000);
        car2.setCategory("Sedan");
        car2.setImageUrl("BMW 7 series.jpeg");

        Car car3 = new Car();
        car3.setId(12);
        car3.setMake("Audi");
        car3.setModel("A8");
        car3.setDescription("Sophisticated design with advanced features.");
        car3.setDailyRate(5000);
        car3.setCategory("Sedan");
        car3.setImageUrl("Audi A8.jpeg");

        Car car4 = new Car();
        car4.setId(13);
        car4.setMake("Lexus");
        car4.setModel("LS");
        car4.setDescription("Japanese luxury with exceptional craftsmanship.");
        car4.setDailyRate(5000);
        car4.setCategory("Sedan");
        car4.setImageUrl("Lexus LS.jpeg");

        Car car5 = new Car();
        car5.setId(14);
        car5.setMake("Genesis");
        car5.setModel("G90");
        car5.setDescription("Korean luxury redefined.");
        car5.setDailyRate(5000);
        car5.setCategory("Sedan");
        car5.setImageUrl("Genesis g90.jpeg");

        Car car6 = new Car();
        car6.setId(15);
        car6.setMake("Jaguar");
        car6.setModel("XJ");
        car6.setDescription("British elegance with powerful performance.");
        car6.setDailyRate(5000);
        car6.setCategory("Sedan");
        car6.setImageUrl("Jaguar XJ.jpeg");

        carList.add(car1);
        carList.add(car2);
        carList.add(car3);
        carList.add(car4);
        carList.add(car5);
        carList.add(car6);

        // Set carList into request scope
        request.setAttribute("carList", carList);

        // Forward to sedan-cars.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("sedan-cars.jsp");
        dispatcher.forward(request, response);
    }
}
