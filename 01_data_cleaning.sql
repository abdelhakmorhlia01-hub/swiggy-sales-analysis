-- First few rows of data
SELECT * FROM swiggy_data  LIMIT 5;

-- ============================
-- Data Cleaning & Validation
-- Null Check
SELECT 
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS state_null,
    SUM(CASE WHEN `City` IS NULL THEN 1 ELSE 0 END) AS city_null,
    SUM(CASE WHEN `Order_date` IS NULL THEN 1 ELSE 0 END) AS date_null,
    SUM(CASE WHEN `Restaurant_name` IS NULL THEN 1 ELSE 0 END)  as restaurant_name_null,
    SUM(CASE WHEN `Location` IS NULL THEN 1 ELSE 0 END) as location_null,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) as category_null,
    SUM(CASE WHEN `Dish_name` IS NULL THEN 1 ELSE 0 END) as dish_null,
    SUM(CASE WHEN `Price_INR` IS NULL THEN 1 ELSE 0 END) as price_null,
    SUM(CASE WHEN `Rating` IS NULL THEN 1 ELSE 0 END) as rating_null,
    SUM(CASE WHEN `Rating_count` IS NULL THEN 1 ELSE 0 END) as rated_null
FROM swiggy_data;

-- ============================
-- Empty/Blank Strings
SELECT *
FROM swiggy_data
WHERE 
	`State`='' OR
    `City`='' OR
    `Restaurant_name`='' OR
    `Location`='' OR
	`Category`='' OR
    `Dish_name`='';
    
-- ============================
-- Duplicates

with duplicates as(
    SELECT * ,ROW_NUMBER() OVER(
        PARTITION BY `State`,`City`,`Order_date`,`Restaurant_name`,`Location`,
                    `Category`,`Dish_name`,`Price_INR`,`Rating`,`Rating_count`
        ORDER BY (SELECT NULL)
    ) AS rn
    FROM swiggy_data
)
SELECT * FROM duplicates WHERE rn >1;

-- ============================
-- Remove Duplication
CREATE TEMPORARY TABLE temp_swiggy AS
SELECT DISTINCT * FROM swiggy_data;

TRUNCATE TABLE swiggy_data;

INSERT INTO swiggy_data
SELECT * FROM temp_swiggy;

DROP TABLE temp_swiggy;
