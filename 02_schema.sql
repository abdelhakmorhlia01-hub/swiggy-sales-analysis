-- ============================
-- Modelling  (Schema)
# Dimension Tables
# Date Table
CREATE TABLE dim_date (
    Date_id INT AUTO_INCREMENT PRIMARY KEY,
    Full_date DATE,
    Year INT,
    Month INT,
    Month_name varchar(20),
    Quarter INT,
    Week INT,
    Day INT,
    Day_name varchar(20)  
);

-- Location Table
CREATE TABLE dim_location(
    Location_id INT AUTO_INCREMENT PRIMARY KEY,
    State VARCHAR(100),
    City VARCHAR(100),
    Location VARCHAR(250) 
);

-- Restaurant Table 
CREATE TABLE dim_restaurant(
    Restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    Restaurant_name VARCHAR(200)
);

-- Category Table
CREATE TABLE dim_category(
    Category_id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(200)
);

-- Dish Table
CREATE TABLE dim_dish(
    Dish_id INT AUTO_INCREMENT PRIMARY KEY,
    Dish_name VARCHAR(200)
);
-- Fact Table
CREATE TABLE fact_swiggy_orders(
    Order_id INT AUTO_INCREMENT PRIMARY KEY,
    Date_id INT ,
    Location_id INT ,
    Restaurant_id INT ,
    Category_id INT ,
    Dish_id INT ,
    Price_INR DECIMAL(10,2),
    Rating DECIMAL(3,1),
    Rating_count INT,
    FOREIGN KEY(Date_id) REFERENCES dim_date(Date_id),
    FOREIGN KEY(Location_id) REFERENCES dim_location(Location_id),
    FOREIGN KEY(Restaurant_id) REFERENCES dim_restaurant(Restaurant_id),
    FOREIGN KEY(Category_id) REFERENCES dim_category(Category_id),
    FOREIGN KEY(Dish_id) REFERENCES dim_dish(Dish_id)
);
