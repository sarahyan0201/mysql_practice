-- 2-1.查找farmers_market table 裡product表格中的product欄位並顯示五行資料
SELECT *
FROM farmers_market.product
LIMIT 5;

-- 2-2.查找farmers_market table 裡product表格中的product_id、product_name欄位並顯示五行資料
SELECT product_id, product_name 
FROM farmers_market.product
LIMIT 10;

-- 2-3.查找farmers_market table 裡product表格中的product_id、product_name欄位、依照product_name欄位資料a-z排序、顯示五行資料
SELECT product_id, product_name
FROM farmers_market.product
ORDER BY product_name ASC
LIMIT 10;

/* 2-4.查找farmers_market table 的
customer_purchases表格裡面的
market_date
customer_id
vendor_id
quantity
cost_to_customer_purchases內容
並按照market_date排列
限制看十行 */
SELECT
market_date,
customer_id,
vendor_id,
quantity,
cost_to_customer_per_qty
FROM farmers_market.customer_purchases
ORDER BY market_date
LIMIT 10;

/* 2-5.查找farmers_market table 的
customer_purchases表格裡面的
market_date
customer_id
vendor_id
quantity
cost_to_customer_purchases的內容
並將quantity和cost_to_customer_per_qty相乘
並按照market_date排列
限制看十行 */
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity,
	cost_to_customer_per_qty,
	quantity * cost_to_customer_per_qty
FROM farmers_market.customer_purchases
ORDER BY market_date
LIMIT 30;

-- 2-6-1延續2-5如果有欄位相乘，就不需要再打欄位了
SELECT 
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases 
ORDER BY market_date
LIMIT 30;

/* 2-6-2查找farmers_market table 的
customer_purchases表格裡面的
market_date
customer_id
vendor_id
quantity
cost_to_customer_purchases的內容
並將quantity和cost_to_customer_per_qty相乘
用round函數將前面相乘的欄位四捨五入到兩位小數
並按照market_date排列
限制看30行 */

SELECT 
	market_date,
	customer_id,
	vendor_id,
	ROUND(quantity * cost_to_customer_per_qty, 2) AS Price
FROM farmers_market.customer_purchases
ORDER BY market_date
LIMIT 30;

/*2-7 從farmers_market這個table裡面的
customer表格裡
查找customer_id這個欄位
並將customer_first_name以及customer_last_name
運用CONCAT將字串串接
並取名為 customer_name
然後看30行*/
SELECT 
	customer_id,	
	CONCAT (customer_first_name, " ", customer_last_name) 
    AS customer_name
FROM farmers_market.customer
LIMIT 30;

-- 練習題1
SELECT *
FROM farmers_market.customer
LIMIT 10;

-- 練習2
SELECT *
FROM farmers_market.customer
ORDER BY customer_last_name, customer_first_name 
LIMIT 10;

-- 練習3
SELECT 
	customer_id,
    customer_first_name
FROM farmers_market.customer
ORDER BY customer_first_name 
LIMIT 10;