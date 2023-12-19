-- 4-1用case練習將五種類別分成兩個類別:供應商列
/*
1.從farmers_market的表中指定vendor欄位
2.選取欄位中的vendor_id、vendor_name、vendor_type
3.從資料庫區分哪些供應商有賣農產品，哪些沒有
 */
 
 SHOW TABLES FROM farmers_market;
 DESCRIBE farmers_market.vendor;
 SELECT DISTINCT vendor_type
 FROM farmers_market.vendor;
 
 SELECT
 vendor_id,
 vendor_name,
 vendor_type,
 
 CASE
	WHEN LOWER(vendor_type) LIKE '%fresh%'
		THEN 'Fresh Produce'
	ELSE 'other'
END AS vendor_type_condensed

FROM farmers_market.vendor;
 
 
 -- 4-2 用CASE產生二元布林值欄位(目的是給機器學習辨識)
 /* 將市集日期區分平日和假日，用case when達成*/
 SHOW TABLES FROM farmers_market;
 DESCRIBE farmers_market.market_date_info;
 SELECT
	market_date,
    market_day
FROM farmers_market.market_date_info;

SELECT 
	market_date,
    market_day,
	CASE
		WHEN market_day = 'Saturday' or market_day = 'Sunday'
    THEN 1 ELSE  0
	END AS weekend_flag
FROM farmers_market.market_date_info
LIMIT 5;

-- 4-3-1 將連續數值用CASE分出區間
/* 查出顧客所有交易，將交易超過50的設成1 */
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer_purchases;
SELECT 
	customer_id,
	market_date,
    vendor_id,
	ROUND(quantity * cost_to_customer_per_qty ,2) AS Price,
CASE
	WHEN quantity * cost_to_customer_per_qty > 50
    THEN 1 ELSE 0
END AS Price_over_50
FROM farmers_market.customer_purchases
ORDER BY customer_id, market_date ASC;

-- 4-3-2 將連續數值用CASE分出區間
/* 先算出客人購買商品數量，指定金額算到小數點兩位。
   再將每筆金額分成$5以下、$5-%9.99、$10.00-19.99、$20*/
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer_purchases;
SELECT
	market_date,
    customer_id,
    vendor_id,
ROUND (quantity * cost_to_customer_per_qty,2)AS Total_price,
CASE
	WHEN quantity * cost_to_customer_per_qty < 5
    THEN 'Under $5'
    WHEN quantity * cost_to_customer_per_qty < 10
    THEN 'Under $10'
    WHEN quantity * cost_to_customer_per_qty < 20
    THEN 'Under $20'
    WHEN quantity * cost_to_customer_per_qty >= 20
    THEN '$20 and up'
END AS price_bin
FROM farmers_market.customer_purchases
LIMIT 10;
    
-- 4-4-1透過case將攤位大小分級(進行分類編碼用於機器學習)
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.booth;
DESCRIBE farmers_market.vendor_booth_assignments;
SELECT
	booth_number,
	booth_price_level,
CASE
	WHEN booth_price_level = 'A' THEN '1'
    WHEN booth_price_level = 'B' THEN '2'
    WHEN booth_price_level = 'C' THEN '3'
END AS booth_price_level_numeric
FROM farmers_market.booth
LIMIT 5;

-- 4-4-2透過case將平等地位的供應商們標示成0或1(用於機器學習)
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.vendor;
SELECT
	vendor_type
FROM farmers_market.vendor;
SELECT
	vendor_id,
    vendor_type,
CASE WHEN vendor_type = 'Eggs & Meats' THEN 1 else 0
END AS 'Eggs & Meats',
CASE WHEN vendor_type = 'Fresh Focused' THEN 1 else 0
END AS 'Fresh Focused',
CASE WHEN vendor_type = 'Arts & Jewelry' THEN 1 else 0
END AS 'Arts & Jewelry',
CASE WHEN vendor_type = 'Fresh Focused' THEN 1 else 0
END AS 'Fresh Focused',
CASE WHEN vendor_type = 'Prepared Foods' THEN 1 else 0
END AS 'Prepared'
FROM farmers_market.vendor;


-- 練習題1
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.product;
SELECT 	
	product_qty_type
FROM farmers_market.product;

SELECT 
	product_id,
    product_name,
CASE 
	WHEN product_qty_type = 'unit' THEN 'unit' ELSE 'bulk'
	END AS prod_qty_type_condensed
FROM farmers_market.product;

-- 練習題2
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.product;
SELECT
	product_id,
    product_name,
CASE 
	WHEN LOWER(product_name) = '%pepper%' THEN 1 ELSE 0
END AS paper_flag
FROM farmers_market.product;



    

-- 補充
-- 去看看全部table
SHOW TABLES FROM farmers_market;

-- 看某一個table裡面的欄位alter
DESCRIBE farmers_market.vendor;

-- 用舊方法去看看vendor_type有哪些欄位(但效能低會出現重複資料)
SELECT  vendor_type
FROM farmers_market.vendor;

-- 用DISTINCT看看vendor_type有哪些欄位(欄位就不會重複出現了)
SELECT DISTINCT vendor_type
FROM farmers_market.vendor;