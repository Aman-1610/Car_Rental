package com.carrental;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/suv-cars")
public class SUVCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> carList = new ArrayList<>();

        Car car1 = new Car();
        car1.setId(16);
        car1.setMake("BMW");
        car1.setModel("X5");
        car1.setDescription("Luxury and performance in a family-sized package.");
        car1.setDailyRate(5000);
        car1.setCategory("SUV");
        car1.setImageUrl("BMW X5.jpg");

        Car car2 = new Car();
        car2.setId(17);
        car2.setMake("Audi");
        car2.setModel("Q7");
        car2.setDescription("Spacious and sophisticated family SUV.");
        car2.setDailyRate(5000);
        car2.setCategory("SUV");
        car2.setImageUrl("Audi Q7.jpg");

        Car car3 = new Car();
        car3.setId(18);
        car3.setMake("Mercedes-Benz");
        car3.setModel("GLE");
        car3.setDescription("Comfort and style for the whole family.");
        car3.setDailyRate(5000);
        car3.setCategory("SUV");
        car3.setImageUrl("Mercedes Benz GLE.jpg");

        Car car4 = new Car();
        car4.setId(19);
        car4.setMake("Volvo");
        car4.setModel("XC90");
        car4.setDescription("Safety and luxury combined.");
        car4.setDailyRate(5000);
        car4.setCategory("SUV");
        car4.setImageUrl("Volvo XC90.jpg");

        Car car5 = new Car();
        car5.setId(20);
        car5.setMake("Range Rover");
        car5.setModel("Sport");
        car5.setDescription("Luxury on and off the road.");
        car5.setDailyRate(5000);
        car5.setCategory("SUV");
        car5.setImageUrl("Range Rover Sports.jpeg");

        Car car6 = new Car();
        car6.setId(21);
        car6.setMake("Porsche");
        car6.setModel("Cayenne");
        car6.setDescription("Sports car performance in an SUV.");
        car6.setDailyRate(5000);
        car6.setCategory("SUV");
        car6.setImageUrl("Porsche Cayenne GT.jpg");

        carList.add(car1);
        carList.add(car2);
        carList.add(car3);
        carList.add(car4);
        carList.add(car5);
        carList.add(car6);

        request.setAttribute("carList", carList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("suv-cars.jsp");
        dispatcher.forward(request, response);
    }
}
