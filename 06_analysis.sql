-- ==================
-- KPI Development
WITH Overview AS(
    SELECT 
    COUNT(*) as Total_orders,
    SUM(Price_INR) as `Total_revenue`,
    AVG(Price_INR) as `Average_dish_price`,
    AVG(Rating) as Avg_rating
    FROM fact_swiggy_orders

)
SELECT 
	Total_orders,
    CONCAT(ROUND(`Total_revenue`/1000000,2),' Million') AS Total_revenue ,
    ROUND(`Average_dish_price`,2) AS Average_dish_price ,
    Avg_rating
FROM Overview;

-- ==========================
-- Deep-Dive Business Analysis
-- ----------------------
-- 1 Date-Based Analysis
-- ----------------------
# Monthly order trends
# Total orders
SELECT 
	d.Month_name,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_date d on f.Date_id=d.Date_id
GROUP BY d.Month_name
ORDER BY Total_orders DESC;

# Monthly Revenue
SELECT 
	d.Month_name,
    CONCAT(ROUND(SUM(f.Price_INR)/1000000,2),' M') AS Revenue
FROM fact_swiggy_orders f
JOIN dim_date d on f.Date_id=d.Date_id
GROUP BY d.Month_name
ORDER BY Revenue DESC;

# Quarterly order trends
# Total Order By Quarter
SELECT 
	d.Quarter,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_date d on f.Date_id=d.Date_id
GROUP BY d.Quarter
ORDER BY d.Quarter ;

# Quarterly Revenue
SELECT 
	d.Quarter,
    CONCAT(ROUND(SUM(f.Price_INR)/1000000,2),' M') AS Revenue
FROM fact_swiggy_orders f
JOIN dim_date d on f.Date_id=d.Date_id
GROUP BY d.Quarter
ORDER BY d.Quarter DESC;


# Day-of-week patterns
# Orders By Days Of Week
SELECT 
	d.Day_name,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_date d on f.Date_id=d.Date_id
GROUP BY d.Day_name
ORDER BY d.Day_name;

-- ----------------------------
-- 2 Location-Based Analysis
-- ----------------------------
# Top 10 cities by order volume

SELECT 
	l.City,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_location l ON f.Location_id=l.Location_id
GROUP BY l.City
ORDER BY Total_orders DESC
LIMIT 10;

# Revenue contribution by states
SELECT 
	l.State,
    CONCAT(ROUND(SUM(f.Price_INR)/1000000,2),' M') AS Revenue
FROM fact_swiggy_orders f
JOIN dim_location l ON f.Location_id=l.Location_id
GROUP BY l.State
ORDER BY Revenue DESC
LIMIT 10;

-- ------------------
-- 3 Food Performance
-- ------------------
# Top 10 restaurants by orders
SELECT 
	r.Restaurant_name,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_restaurant r ON f.Restaurant_id=r.Restaurant_id
GROUP BY r.Restaurant_name
ORDER BY Total_orders DESC
LIMIT 10;

# Most ordered dishes
SELECT 
	ds.Dish_name,
    COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
JOIN dim_dish ds ON f.Dish_id=ds.Dish_id
GROUP BY ds.Dish_name
ORDER BY Total_orders DESC
LIMIT 10;

# Cuisine performance (Orders + Avg Rating)

SELECT 
	c.Category,
    COUNT(*) AS Total_orders,
    AVG(f.Rating) AS Avg_rating
FROM fact_swiggy_orders f
JOIN dim_category c ON f.Category_id=c.Category_id
GROUP BY c.Category
ORDER BY Total_orders DESC
LIMIT 10;

-- -----------------------------
-- 4 Customer Spending Insights
-- -----------------------------
SELECT 
 CASE
  WHEN f.Price_INR < 100 THEN 'Under 100'
  WHEN f.Price_INR < 200 THEN '100-199'
  WHEN f.Price_INR < 300 THEN '200-299'
  WHEN f.Price_INR < 500 THEN '300-499'
  ELSE '500+'
  END AS Customer_spending,
 COUNT(*) AS Total_orders
FROM fact_swiggy_orders f
GROUP BY Customer_spending
ORDER BY Total_orders DESC;

-- ------------------------------
-- 5 Distribution of dish ratings
-- ------------------------------
SELECT 
 CASE
  WHEN f.Price_INR < 100 THEN 'Under 100'
  WHEN f.Price_INR < 200 THEN '100-199'
  WHEN f.Price_INR < 300 THEN '200-299'
  WHEN f.Price_INR < 500 THEN '300-499'
  ELSE '500+'
  END AS Customer_spending,
  AvG(f.Rating) AS Avg_rating
FROM fact_swiggy_orders f
GROUP BY Customer_spending
ORDER BY Avg_rating DESC;
