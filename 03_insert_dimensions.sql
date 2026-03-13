-- ============================
-- Insert Data Into Dimention Table
-- Date Table
INSERT INTO dim_date(Full_date, Year, Month, Month_name, Quarter, Week, Day,Day_name)
SELECT DISTINCT
    `Order_date`,        
    YEAR(`Order_date`),
    MONTH(`Order_date`),
    MONTHNAME(`Order_date`),
    QUARTER(`Order_date`),
    WEEK(`Order_date`),
    DAY(`Order_date`),
    DAYNAME(`Order_date`)
FROM swiggy_data
WHERE Order_date IS NOT NULL;

-- Location Table
INSERT INTO dim_location(State,City,Location)
SELECT DISTINCT
	State, 
    City,
    Location
FROM swiggy_data;

-- Restaurant Table 
INSERT INTO dim_restaurant(Restaurant_name)
SELECT DISTINCT
	Restaurant_name
FROM swiggy_data;

-- Category Table 
INSERT INTO dim_category(Category)
SELECT DISTINCT
	Category
FROM swiggy_data;

-- Dish Table 
INSERT INTO dim_dish(Dish_name)
SELECT DISTINCT
	Dish_name
FROM swiggy_data;
