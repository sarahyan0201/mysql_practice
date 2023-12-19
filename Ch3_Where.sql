/* 3-1用where選出符合條件的資料
從farmers_market資料集中的product表格
選擇product_id、product_name、product_category_id
找出產品分類欄位值為1的資料輸出
限看10行 */
SELECT 
	product_id,
    product_name,
    product_category_id
FROM farmers_market.product
WHERE product_category_id = 1
LIMIT 10;

/*3-2-1 運用多重條件篩選 */
SELECT
	market_date,
    customer_id,
    vendor_id,
    product_id
FROM farmers_market.customer_purchases
WHERE customer_id = 1 OR customer_id = 5
ORDER BY market_date, customer_id, vendor_id, product_id;

/* 3-2-2 條件式中有多個運算符
從farmers_market資料集中的product表格
選擇product_id、product_name
並找出product_id= 8，或者product_id > 3
以及product_id < 10 的資料，後兩者請用小括號，讓系統優先處理 */

SELECT
	product_id,
    product_name
FROM farmers_market.product
WHERE 
	product_id = 8
	OR (product_id > 3 AND product_id < 10);
    
/*3-3 多欄位條件式篩選
從farmers_market資料集中的customer表格
選擇customer_firstname、customer_lastname
並找出customer_firstname = Carlos或者customer_lastname = Diaz的資料，
*/
SELECT
	customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE
	customer_first_name = 'Carlos'
OR  customer_last_name = 'Diaz';
    
/*3-4-1 數種用於篩選的關鍵字:BETWEEN AND
從farmers_market資料集中的vendor_booth_assignments表格
找出vender_id = 7 然後
market_date 介於 2019-04-13 和 2019-05-26的資料，
*/
SELECT *
FROM farmers_market.vendor_booth_assignments
WHERE vendor_id = 7
AND market_date BETWEEN '2019-04-13' AND '2019-05-26';

/*3-4-2 數種用於篩選的關鍵字:IN
從farmers_market資料集中的customer表格裡
選擇customer_id、customer_first_name、customer_last_name
找出當 customer_last_name是Diaz、Edwards、Wilson
並按照customer_last_name、customer_first_name排序
*/

SELECT 
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE customer_last_name in ('Diaz', 'Edwards', 'Wilson')
ORDER BY customer_last_name, customer_first_name;

/*3-4-3 用like篩選部分相符的資料，並搭配%找出不確定的名字*/
SELECT 
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE customer_first_name LIKE 'jer%';

/*3-4-4 用is null篩選缺漏值*/
SELECT *
FROM farmers_market.product
WHERE 
	product_size IS NULL
OR 
	TRIM(product_size) = '';

-- 補充: 看所有table、看部分table裡面的欄位 
SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.market_date_info;

-- 練習1
/*用where選出符合條件的資料
從farmers_market資料集中的customer表格
選擇customer_i為5和9的購買紀錄輸出
限看10行 */

SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer_purchases;

SELECT
	customer_id,
	product_id,
    customer_last_name
FROM farmers_market.customer_purchases
WHERE product_id = 4 
OR product_id = 9
ORDER BY customer_last_name, customer_id ASC;

-- 練習二
/* 
1.用WHERE AND 寫出vendor_id在8到10(包括8&10)本身的指令
2.用WHERE BETWEEN 寫出vendoe_id在8到10(包括8&10)本身的指令
*/

SHOW TABLES FROM farmers_market;
DESCRIBE farmers_market.customer_purchases;

-- 第一種
SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id >= 8
AND   vendor_id <= 10
ORDER BY vendor_id;

-- 第二種
SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id BETWEEN 8 AND 10
ORDER BY vendor_id;
