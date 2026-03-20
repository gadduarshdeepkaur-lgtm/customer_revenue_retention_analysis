CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
quantity INT,
product_name VARCHAR(50),
category VARCHAR(50),
price INT,
revenue INT,
city VARCHAR(50),
signup_date date
);

-- revenue by product --
SELECT product_name, SUM(revenue) AS total_revenue
FROM ORDERS
GROUP BY product_name
ORDER BY total_revenue DESC;

-- revenue by city --
SELECT city, SUM(revenue) AS total_revenue
FROM orders
GROUP BY city
ORDER BY total_revenue DESC;

-- monthly revenue --
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(revenue) AS montly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- top customers clv --
SELECT customer_id, SUM(revenue) AS lifetime_value
FROM orders
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

-- customers whose revenue is ABOVE average --
SELECT *
FROM (
    SELECT customer_id, SUM(revenue) AS total_revenue
    FROM orders
    GROUP BY customer_id
) t
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM (
        SELECT SUM(revenue) AS total_revenue
        FROM orders
        GROUP BY customer_id
    ) x
);












