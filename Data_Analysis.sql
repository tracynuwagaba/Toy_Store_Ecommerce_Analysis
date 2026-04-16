-- Ecommerce analysis

-- 1. Revenue analysis

-- Total Revenue
SELECT ROUND(SUM(price_usd), 0) AS total_revenue
FROM order_items;
-- 1.9M

-- Revenue over time(daily)
SELECT 
    DATE(o.created_at) AS order_date,
    ROUND(SUM(oi.price_usd), 2) AS daily_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_date
ORDER BY order_date;

-- Revenue by product
SELECT 
    oi.product_id,
    p.product_name,
    ROUND(SUM(oi.price_usd), 2) AS revenue
FROM order_items oi 
JOIN products p USING (product_id)
GROUP BY product_id, product_name
ORDER BY revenue DESC;
-- The Original Mr.Fuzzy with the highest revenue

-- 2. Profitability analysis

-- Total Profit (Gross)
SELECT ROUND(SUM(price_usd - cogs_usd), 0) AS total_profit
FROM order_items;
-- 1.2M

-- Profit Margin (%)
SELECT 
    ROUND(SUM(price_usd - cogs_usd) / SUM(price_usd) * 100, 2) AS profit_margin_pct
FROM order_items;
-- 62.74%

-- Profit by Product
SELECT 
    oi.product_id,
    p.product_name,
    ROUND(SUM(oi.price_usd - oi.cogs_usd), 0) AS profit,
    ROUND(SUM(oi.price_usd), 0) AS revenue,
    ROUND(SUM(oi.price_usd - oi.cogs_usd) / SUM(oi.price_usd) * 100, 2) AS margin_pct
FROM order_items oi
JOIN products p USING (product_id)
GROUP BY oi.product_id, p.product_name
ORDER BY profit DESC;
-- The Original Mr.Fuzzy again with the highest profit

-- 3. Refund analysis

-- Total Refund Amount
SELECT ROUND(SUM(refund_amount_usd), 0) AS total_refunds
FROM order_item_refunds;
-- 85K

-- Refund Rate (% of Revenue)
SELECT 
    ROUND(SUM(r.refund_amount_usd) / SUM(oi.price_usd) * 100, 2) AS refund_rate_pct
FROM order_items oi
LEFT JOIN order_item_refunds r 
    ON oi.order_item_id = r.order_item_id;
-- 4.4%

-- Refunds by Product
SELECT 
    oi.product_id,
    p.product_name,
    ROUND(SUM(r.refund_amount_usd), 0) AS total_refunded
FROM order_item_refunds r
JOIN order_items oi 
    ON r.order_item_id = oi.order_item_id
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_name
ORDER BY total_refunded DESC;
-- The Original Mr.Fuzzy again with the highest refund amount

-- Refund Trend Over Time
SELECT 
    DATE(o.created_at) AS date,
    ROUND(SUM(r.refund_amount_usd), 0) AS refund_total
FROM order_item_refunds r
JOIN order_items oi ON r.order_item_id = oi.order_item_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY date
ORDER BY date;

-- Net Revenue (After Refunds)
SELECT 
    ROUND(SUM(oi.price_usd - IFNULL(r.refund_amount_usd, 0)), 0) AS net_revenue
FROM order_items oi
LEFT JOIN order_item_refunds r 
    ON oi.order_item_id = r.order_item_id;
-- 1.8M
    
-- Refund Rate per Product
SELECT 
    oi.product_id,
    p.product_name,
    ROUND(SUM(IFNULL(r.refund_amount_usd, 0)) / SUM(oi.price_usd) * 100, 2) AS refund_rate_pct
FROM order_items oi
LEFT JOIN order_item_refunds r 
    ON oi.order_item_id = r.order_item_id
JOIN products p 
	ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_name
ORDER BY refund_rate_pct DESC;
-- The Birthday Sugar Panda with the highest refund rate percentage
