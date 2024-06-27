use master
GO
CREATE database FinalDimFact;
GO
use FinalDimFact
GO

CREATE TABLE dim_date(
	DateKey int NOT NULL,
	Date datetime NULL,
	DayOfWeek tinyint NOT NULL,
	DayName nchar(10) NOT NULL,
	DayOfMonth tinyint NOT NULL,
	DayOfYear int NOT NULL,
	WeekOfYear tinyint NOT NULL,
	MonthName nchar(10) NOT NULL,
	MonthOfYear tinyint NOT NULL,
	Quarter tinyint NOT NULL,
	QuarterName nchar(10) NOT NULL,
	Year int NOT NULL,
	IsAWeekday varchar(1) NOT NULL DEFAULT (('N')),
	constraint PK_DimDate PRIMARY KEY (DateKey)
)

CREATE SEQUENCE D_PRODUCTS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
CACHE 20;

-- Create a dimension table for products (dim_product)
CREATE TABLE dim_product (
	product_key BIGINT NOT NULL DEFAULT next value for D_PRODUCTS_SEQ,
    product_id VARCHAR(50) NOT NULL,
    product_category_name VARCHAR(50) NOT NULL,
    product_category_name_english VARCHAR(50) NOT NULL,
    product_name_lenght INT NOT NULL,
    product_description_lenght INT NOT NULL,
    product_photos_qty INT NOT NULL,
    product_weight_g REAL NOT NULL,
    product_length_cm REAL NOT NULL,
    product_height_cm REAL NOT NULL,
    product_width_cm REAL NOT NULL,
	CONSTRAINT D_PRODUCTS_PK PRIMARY KEY (product_key) 
);

CREATE SEQUENCE D_CUSTOMERS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
CACHE 20;

-- Create a dimension table for customers (dim_customer)
CREATE TABLE dim_customer (
	customer_key BIGINT NOT NULL DEFAULT next value for D_CUSTOMERS_SEQ,
    customer_id VARCHAR(50) NOT NULL,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix VARCHAR(10) NOT NULL,
    customer_city VARCHAR(255) NOT NULL,
    customer_state VARCHAR(2) NOT NULL,
	CONSTRAINT D_CUSTOMERS_PK PRIMARY KEY (customer_key)
);

CREATE SEQUENCE D_SELLERS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
CACHE 20;
-- Create a dimension table for sellers (dim_seller)
CREATE TABLE dim_seller (
	seller_key BIGINT NOT NULL DEFAULT next value for D_SELLERS_SEQ,
    seller_id VARCHAR(50) NOT NULL,
    seller_zip_code_prefix VARCHAR(10) NOT NULL,
    seller_city VARCHAR(255) NOT NULL,
    seller_state VARCHAR(2) NOT NULL,
	CONSTRAINT D_SELLERS_PK PRIMARY KEY (seller_key)
);

CREATE SEQUENCE D_PAYMENT_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
CACHE 20;

CREATE TABLE dim_order_payment (
	payment_key BIGINT NOT NULL DEFAULT next value for D_PAYMENT_SEQ,
	order_id VARCHAR(50) NOT NULL, 
	payment_sequential INT NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_installments INT NOT NULL, 
    payment_value REAL NOT NULL,
	CONSTRAINT D_PAYMENT_PK PRIMARY KEY (payment_key)
);

CREATE SEQUENCE D_ITEMS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
CACHE 20;
CREATE TABLE dim_order_items (
	order_item_key BIGINT NOT NULL DEFAULT next value for D_ITEMS_SEQ,
	order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
	shipping_limit_date DATETIME NOT NULL,
    price REAL NOT NULL,
    freight_value REAL NOT NULL,
	CONSTRAINT D_ITEMS_PK PRIMARY KEY (order_item_key)
);

CREATE TABLE fact_sales (
	DateKey INT NOT NULL,
	customer_key BIGINT NOT NULL,
	seller_key BIGINT NOT NULL,
	product_key BIGINT NOT NULL,
	price REAL NOT NULL,
    freight_value REAL NOT NULL,
	payment_value REAL NOT NULL,
	--PRIMARY KEY (DateKey, customer_key, seller_key, product_key),
    FOREIGN KEY (DateKey) REFERENCES dim_date(DateKey),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (seller_key) REFERENCES dim_seller(seller_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
)

