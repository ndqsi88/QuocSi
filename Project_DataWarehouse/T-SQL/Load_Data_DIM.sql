INSERT INTO dim_product (product_id, product_category_name, product_category_name_english, product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
SELECT 
    p.product_id, 
    p.product_category_name, 
    t.product_category_name_english, 
    p.product_name_lenght, 
    p.product_description_lenght, 
    p.product_photos_qty, 
    p.product_weight_g, 
    p.product_length_cm, 
    p.product_height_cm, 
    p.product_width_cm
FROM FinalOlist.dbo.olist_products_dataset p
JOIN FinalOlist.dbo.product_category_name_translation t
ON p.product_category_name = t.product_category_name;

INSERT INTO dim_customer (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
SELECT 
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix, 
    customer_city, 
    customer_state
FROM FinalOlist.dbo.olist_order_customer_dataset;

-- Insert data into dim_seller from olist_seller_dataset
INSERT INTO dim_seller (seller_id, seller_zip_code_prefix, seller_city, seller_state)
SELECT 
    seller_id, 
    seller_zip_code_prefix, 
    seller_city, 
    seller_state
FROM FinalOlist.dbo.olist_seller_dataset;

-- Insert data into dim_order_items from olist_order_items_dataset
INSERT INTO dim_order_items (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
SELECT 
    order_id, 
    order_item_id, 
    product_id, 
    seller_id, 
    shipping_limit_date, 
    price, 
    freight_value
FROM FinalOlist.dbo.olist_order_items_dataset;

-- Insert data into dim_order_payment from olist_order_payments_dataset
INSERT INTO dim_order_payment (order_id,  payment_sequential, payment_type, payment_installments, payment_value)
SELECT 
    order_id, 
    payment_sequential, 
    payment_type, 
    payment_installments, 
    payment_value
FROM FinalOlist.dbo.olist_order_payments_dataset;


-- Load bảng DimDate
insert into dim_date
	(DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear,
	WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsAWeekday)
select
	date_key, full_date, day_of_week, day_name, day_num_in_month,
	day_num_overall, week_num_in_year, month_name, month, quarter,
	case
		when quarter >= 1 and quarter <= 3 then 'First'
		when quarter >= 4 and quarter <= 6 then 'Second'
		when quarter >= 7 and quarter <= 9 then 'Third'
		when quarter >= 10 and quarter <= 12 then 'Fourth'
	end,
	year, case when weekday_flag = 'Weekday' then 'Y' else 'N' end
from FinalOlist.dbo.DateDimension;

-- Load Fact


INSERT INTO fact_sales (DateKey, customer_key, seller_key, product_key, price, freight_value, payment_value)
SELECT
    Day(oi.shipping_limit_date) + MONTH(oi.shipping_limit_date) * 100 + YEAR(oi.shipping_limit_date) * 10000 As DateKey,
    c.customer_key,
    s.seller_key,
    p.product_key,
    oi.price,
    oi.freight_value,
    op.payment_value
FROM
    dim_order_items oi
JOIN
    dim_product p ON oi.product_id = p.product_id
JOIN
    dim_seller s ON oi.seller_id = s.seller_id
JOIN
    dim_order_payment op ON oi.order_id = op.order_id
JOIN
    FinalOlist.dbo.olist_orders_dataset a ON a.order_id = oi.order_id 
JOIN
    dim_customer c ON c.customer_id = a.customer_id

