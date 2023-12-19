-- Ch6 Aggregate Functions

-- 6-1-1 調整重複紀錄出現的困擾，讓資訊只顯示代表一行：此處用GROUP BY不加入聚合函數（如SUM(), AVG(), COUNT()等）達成
/*
output紀錄僅會顯示統合
market_date
customer_id後，
代表的資訊（只會有一行）
*/
SELECT 
	market_date,
    customer_id
FROM farmers_market.customer_purchases
GROUP BY market_date, customer_id
ORDER BY market_date, customer_id;

-- 6-1-2 使用DISTINCT同樣能達成
SELECT DISTINCT
	market_date,
    customer_id
FROM farmers_market.customer_purchases
ORDER BY market_date, customer_id