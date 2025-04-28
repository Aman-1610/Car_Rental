package com.carrental;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/sports-cars")
public class SportsCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> carList = new ArrayList<>();

        // Create sports cars
        Car car1 = new Car();
        car1.setId(1);
        car1.setMake("Porsche");
        car1.setModel("911");
        car1.setDescription("Experience the thrill of German engineering");
        car1.setDailyRate(5000);
        car1.setCategory("Sports");
        car1.setImageUrl("porche911.jpg");

        Car car2 = new Car();
        car2.setId(2);
        car2.setMake("Ferrari");
        car2.setModel("488 Spider");
        car2.setDescription("Feel the power of Italian passion");
        car2.setDailyRate(5000);
        car2.setCategory("Sports");
        car2.setImageUrl("Ferrari 488.jpg");

        Car car3 = new Car();
        car3.setId(3);
        car3.setMake("Lamborghini");
        car3.setModel("Huracán");
        car3.setDescription("Unleash the bull on the road");
        car3.setDailyRate(6000);
        car3.setCategory("Sports");
        car3.setImageUrl("Lamborghini Huracán.jpg");

        Car car4 = new Car();
        car4.setId(4);
        car4.setMake("Chevrolet");
        car4.setModel("Corvette");
        car4.setDescription("American muscle meets precision");
        car4.setDailyRate(8000);
        car4.setCategory("Sports");
        car4.setImageUrl("chevrolet-corvette.jpg");

        Car car5 = new Car();
        car5.setId(5);
        car5.setMake("Audi");
        car5.setModel("R8");
        car5.setDescription("Cutting-edge performance and style");
        car5.setDailyRate(4000);
        car5.setCategory("Sports");
        car5.setImageUrl("Audi R8.jpg");

        Car car6 = new Car();
        car6.setId(6);
        car6.setMake("McLaren");
        car6.setModel("720S");
        car6.setDescription("Formula 1 technology for the road");
        car6.setDailyRate(7000);
        car6.setCategory("Sports");
        car6.setImageUrl("McLaren 720S.jpg");

        // Add all cars into the list
        carList.add(car1);
        carList.add(car2);
        carList.add(car3);
        carList.add(car4);
        carList.add(car5);
        carList.add(car6);

        // Set carList attribute in request
        request.setAttribute("carList", carList);

        // Forward to sports-cars.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("sports-cars.jsp");
        dispatcher.forward(request, response);
    }
}
