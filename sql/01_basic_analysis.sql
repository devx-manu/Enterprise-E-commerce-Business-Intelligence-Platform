-- 1. Total Revenue
SELECT ROUND(SUM(sales), 2) AS total_revenue
FROM order_items;

-- 2. Total Profit
SELECT ROUND(SUM(profit), 2) AS total_profit
FROM order_items;

-- 3. Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 4. Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 5. Average Order Value (AOV)
SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- 6. Total Units Sold
SELECT SUM(quantity) AS total_units_sold
FROM order_items;

-- 7. Average Discount
SELECT ROUND(AVG(discount), 2) AS average_discount
FROM order_items;

-- 8. Profit Margin (%)
SELECT
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM order_items;

-- 9. Average Profit per Order
SELECT
    ROUND(SUM(profit) / COUNT(DISTINCT order_id), 2) AS average_profit_per_order
FROM order_items;

-- 10. Average Items per Order
SELECT
    ROUND(SUM(quantity)::numeric / COUNT(DISTINCT order_id), 2) AS average_items_per_order
FROM order_items;

-- ============================
-- DASHBOARD CHART QUERIES
-- ============================

-- 11. Top 10 Products by Revenue
SELECT
    p.product_name,
    ROUND(SUM(oi.sales), 2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- 12. Top 10 Customers
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(oi.sales), 2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- 13. Revenue by Category
SELECT
    cat.category_name,
    ROUND(SUM(oi.sales), 2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN categories cat
ON p.category_id = cat.category_id
GROUP BY cat.category_name
ORDER BY revenue DESC;

-- 14. Revenue by State
SELECT
    c.state,
    ROUND(SUM(oi.sales), 2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.state
ORDER BY revenue DESC;

-- 15. Monthly Revenue
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.sales), 2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 16. Monthly Profit
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.profit), 2) AS profit
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 17. Orders by Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM payments
GROUP BY payment_method
ORDER BY total_orders DESC;

-- 18. Orders by Shipping Mode
SELECT
    shipping_mode,
    COUNT(*) AS total_orders
FROM shipping
GROUP BY shipping_mode
ORDER BY total_orders DESC;

-- 19. Monthly Orders
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 20. Revenue by Category by Month
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    cat.category_name,
    ROUND(SUM(oi.sales), 2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
JOIN categories cat
ON p.category_id = cat.category_id
GROUP BY month, cat.category_name
ORDER BY month, revenue DESC;