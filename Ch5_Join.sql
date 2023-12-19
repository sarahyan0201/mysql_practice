-- 第五章join
/*5-1 left join 重點:
  ．必須是主從關係
  ．主鍵數值亂的表格(可當「從」表格)可以LEFT JOIN在主鍵數值有「唯一值」的表格上（可當「主」表格）
  
-- 5-2-1 兩個表格透過關聯的欄位連結
/*在product產品清單表格中，補上product_category裡面對應的產品類別*/
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.product;
DESCRIBE farmers_market.product_category;
SELECT product_category_id FROM farmers_market.product_category LIMIT 5;
SELECT product_category_id FROM farmers_market.product LIMIT 5;

SELECT * FROM product
LEFT JOIN product_category
	ON product.product_category_id =
    product_category.product_category_id;
    
-- 5-2-2 承上，join後表格出現重複欄位名稱，重新命名兩個來自不同表格的相同欄位
SELECT 
	product_id,
    product_name,
    product_size,
    product.product_category_id AS pro_cateid,
	product_category.product_category_id AS pro_cate_procateid,
    product_category.product_category_name
FROM product
LEFT JOIN product_category 
	ON product.product_category_id = 
    product_category.product_category_id;
    
-- 5-2-3 修正上題長長的表格名稱，為表格取別名方便閱讀
SELECT 
	p.product_id,
    p.product_name,
    p.product_category_id AS pro_cateid,
	pc.product_category_id AS pro_cate_procateid,
    pc.product_category_name
FROM product AS p
LEFT JOIN product_category AS pc
	ON p.product_category_id = pc.product_category_id;

-- 5-2-4 在單一table內部裡面進行單一表格的left join(特別情況)
-- 5-3 right join
-- 5-4 inner join
-- 5-5 比較三個join的差異

-- 5-5-1 join customer和 customer_purchases的資料
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer;
DESCRIBE farmers_market.customer_purchases;
SELECT * FROM farmers_market.customer LIMIT 5;
SELECT * FROM farmers_market.customer_purchases LIMIT 5;

SELECT 
	c.customer_id,
    cp.customer_id,
    c.customer_first_name,
    c.customer_last_name,
    cp.market_date,
    cp.quantity,
    cp.cost_to_customer_per_qty
    
    
FROM customer_purchases AS cp
LEFT JOIN customer AS c
ON cp.customer_id = c.customer_id 
ORDER BY c.customer_id, cp.customer_id;

-- 5-6-1找出每位顧客的多筆購買紀錄
SELECT *
FROM customer AS c
LEFT JOIN customer_purchases AS cp
ON c.customer_id = cp.customer_id ; 

-- 5-6-2承上題，找出顧客購買紀錄，以及顧客ID為NULL的資料
SELECT c.*
FROM customer AS c
LEFT JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id 
WHERE cp.customer_id IS NULL;

-- 5-6-3用left join回傳所有除了2019/04/03以外日期以及購買日期為NULL的顧客購買清單
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer_purchases;
DESCRIBE farmers_market.customer;

SELECT c.*,  cp.market_date
FROM customer AS c
LEFT JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE (cp.market_date <> '2019-04-03' OR cp.market_date IS NULL);

-- 5-6-4承上題，用DISTINCT去除顧客清單中的重複值(並刪掉 SELECT cp.market_date)
SELECT DISTINCT c.*
FROM customer AS c
LEFT JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE (cp.market_date <> '2019-04-03' OR cp.market_date IS NULL);