package com.carrental;

public class Car {
    private int id;
    private String make;
    private String model;
    private int year;
    private String color;
    private String license_plate;
    private double daily_rate;
    private boolean is_available;
    private String image_url;
    private String description;
    private String category;
    private int capacity;
    private String transmission;
    private String fuelType;
    
    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getMake() { return make; }
    public void setMake(String make) { this.make = make; }
    
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public String getLicensePlate() { return license_plate; }
    public void setLicensePlate(String licensePlate) { this.license_plate = license_plate; }
    
    public double getDailyRate() { return daily_rate; }
    public void setDailyRate(double dailyRate) { this.daily_rate = daily_rate; }
    
    public boolean isAvailable() { return is_available; }
    public void setAvailable(boolean isAvailable) { this.is_available = is_available; }
    
    public String getImageUrl() { return image_url; }
    public void setImageUrl(String imageUrl) { this.image_url = image_url; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    
    public String getTransmission() { return transmission; }
    public void setTransmission(String transmission) { this.transmission = transmission; }
    
    public String getFuelType() { return fuelType; }
    public void setFuelType(String fuelType) { this.fuelType = fuelType; }
}