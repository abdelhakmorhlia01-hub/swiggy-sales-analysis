-- ============================
--  CREATE INDEXES (PERFORMANCE)


CREATE INDEX idx_date_full_date 
ON dim_date(Full_date);

CREATE INDEX idx_location_all 
ON dim_location(State, City, Location);

CREATE INDEX idx_restaurant_name 
ON dim_restaurant(Restaurant_name);

CREATE INDEX idx_category_name 
ON dim_category(Category);

CREATE INDEX idx_dish_name 
ON dim_dish(Dish_name);

CREATE INDEX idx_order_date 
ON swiggy_data(Order_date);

CREATE INDEX idx_restaurant 
ON swiggy_data(Restaurant_name);

CREATE INDEX idx_category 
ON swiggy_data(Category);

CREATE INDEX idx_dish 
ON swiggy_data(Dish_name);

CREATE INDEX idx_location 
ON swiggy_data(State, City, Location);
