-- ============================
-- LOAD FACT TABLE
INSERT INTO fact_swiggy_orders(
    Date_id ,
    Location_id ,
    Restaurant_id ,
    Category_id ,
    Dish_id ,
    Price_INR ,
    Rating ,
    Rating_count
)
SELECT 
	d.Date_id,
    l.Location_id,
    r.Restaurant_id,
    c.Category_id,
    ds.Dish_id,
    s.Price_INR,
    s.Rating,
    s.Rating_count
FROM swiggy_data s
JOIN dim_date d
ON d.Full_date=s.Order_date

JOIN dim_location l
ON l.State=s.State
AND l.City=s.City
AND l.Location=s.Location

JOIN dim_restaurant r
ON r.Restaurant_name=s.Restaurant_name

JOIN dim_category c
ON c.Category=s.Category

JOIN dim_dish ds
ON ds.Dish_name=s.Dish_name ;

-- Select The Full Schema
SELECT * FROM fact_swiggy_orders f
JOIN dim_date d ON f.Date_id=d.Date_id
JOIN dim_location l ON f.Location_id=l.Location_id
JOIN dim_restaurant r ON f.Restaurant_id=r.Restaurant_id
JOIN dim_category c ON f.Category_id=c.Category_id
JOIN dim_dish ds ON f.Dish_id=ds.Dish_id
LIMIT 5;
