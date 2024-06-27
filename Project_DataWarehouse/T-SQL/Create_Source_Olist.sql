use master
GO
CREATE database FinalOlist;
GO
use FinalOlist
GO

-- Tạo bảng olist_seller_dataset
CREATE TABLE olist_seller_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(255),
    seller_state VARCHAR(2)
);

-- Tạo bảng olist_order_customer_dataset
CREATE TABLE olist_order_customer_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(255),
    customer_state VARCHAR(2)
);

-- Tạo bảng olist_geolocation_dataset
CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(2)
);

-- Tạo bảng olist_order_items_dataset
CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price REAL,
    freight_value REAL,
    PRIMARY KEY (order_id, order_item_id)
);

-- Tạo bảng olist_order_payments_dataset
CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value REAL,
    PRIMARY KEY (order_id, payment_sequential)
);

-- Tạo bảng olist_order_reviews_dataset
CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

-- Tạo bảng olist_orders_dataset
CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- Tạo bảng olist_products_dataset
CREATE TABLE olist_products_dataset (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g REAL,
    product_length_cm REAL,
    product_height_cm REAL,
    product_width_cm REAL
);

-- Tạo bảng product_category_name_translation
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(50) PRIMARY KEY,
    product_category_name_english VARCHAR(50)
);



create table DateDimension (
	date_key int not null,
	full_date smalldatetime,
	day_of_week tinyint,
	day_num_in_month tinyint,
	day_num_overall smallint,
	day_name varchar(9),
	day_abbrev char(3),
	weekday_flag char(7),
	week_num_in_year tinyint,
	week_num_overall smallint,
	week_begin_date smalldatetime,
	week_begin_date_key int,
	month tinyint,
	month_num_overall smallint,
	month_name varchar(9),
	month_abbrev char(3),
	quarter tinyint,
	year smallint,
	yearmo int,
	fiscal_month tinyint,
	fiscal_quarter tinyint,
	fiscal_year smallint,
	last_day_in_month_flag char(13),
	same_day_year_ago_date smalldatetime,
	primary key (date_key)
);