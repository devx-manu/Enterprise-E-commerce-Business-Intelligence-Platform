-- 1. Top 5 Customers by Profit
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(oi.profit),2) AS total_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_profit DESC
LIMIT 5;

-- 2. Monthly Revenue & Profit
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.sales),2) AS revenue,
    ROUND(SUM(oi.profit),2) AS profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 3. Category-wise Orders, Revenue & Profit
SELECT
    cat.category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.sales),2) AS revenue,
    ROUND(SUM(oi.profit),2) AS profit
FROM categories cat
JOIN products p
    ON cat.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY cat.category_name
ORDER BY revenue DESC;

-- 4. Average Profit by Category
SELECT
    cat.category_name,
    ROUND(AVG(oi.profit),2) AS avg_profit
FROM categories cat
JOIN products p
    ON cat.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY cat.category_name
ORDER BY avg_profit DESC;

-- 5. Customers with More Than 5 Orders
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;

-- 6. Top 10 Products by Quantity Sold
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- 7. Average Shipping Cost by Partner
SELECT
    shipping_partner,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM shipping
GROUP BY shipping_partner
ORDER BY avg_shipping_cost DESC;

-- 8. Top 10 Most Returned Products
SELECT
    p.product_name,
    COUNT(r.return_id) AS total_returns
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN returns r
    ON oi.order_item_id = r.order_item_id
GROUP BY p.product_name
ORDER BY total_returns DESC
LIMIT 10;

-- 9. Warehouse Stock Levels
SELECT
    w.warehouse_name,
    SUM(i.stock_quantity) AS total_stock
FROM warehouses w
JOIN inventory i
    ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_stock DESC;

-- 10. Orders with Total Discount Greater Than 100
SELECT
    order_id,
    SUM(discount) AS total_discount
FROM order_items
GROUP BY order_id
HAVING SUM(discount) > 100
ORDER BY total_discount DESC;