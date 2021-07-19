CREATE DATABASE Inventory;

USE Inventory;
EXEC sys.sp_cdc_enable_db;

-- Create and populate our products using a single insert with many rows
CREATE TABLE products (
  id INTEGER IDENTITY(101,1) NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(512),
  weight FLOAT
);

INSERT INTO products(name,description,weight)
  VALUES ('bike 12','Small 2-wheel scooter',3.14);
INSERT INTO products(name,description,weight)
  VALUES ('car battery','12V car battery',8.1);
INSERT INTO products(name,description,weight)
  VALUES ('12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO products(name,description,weight)
  VALUES ('hammer','12oz carpenter''s hammer',0.75);
INSERT INTO products(name,description,weight)
  VALUES ('hammer','14oz carpenter''s hammer',0.875);
INSERT INTO products(name,description,weight)
  VALUES ('hammer','16oz carpenter''s hammer',1.0);
INSERT INTO products(name,description,weight)
  VALUES ('rocks','box of assorted rocks',5.3);
INSERT INTO products(name,description,weight)
  VALUES ('jacket','water resistent black wind breaker',0.1);
INSERT INTO products(name,description,weight)
  VALUES ('spare tire','24 inch spare tire',22.2);
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'products', @role_name = NULL, @supports_net_changes = 0;
-- Create and populate the products on hand using multiple inserts
CREATE TABLE products_on_hand (
  product_id INTEGER NOT NULL PRIMARY KEY,
  quantity INTEGER NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO products_on_hand VALUES (101,3);
INSERT INTO products_on_hand VALUES (102,8);
INSERT INTO products_on_hand VALUES (103,18);
INSERT INTO products_on_hand VALUES (104,4);
INSERT INTO products_on_hand VALUES (105,5);
INSERT INTO products_on_hand VALUES (106,0);
INSERT INTO products_on_hand VALUES (107,44);
INSERT INTO products_on_hand VALUES (108,2);
INSERT INTO products_on_hand VALUES (109,5);
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'products_on_hand', @role_name = NULL, @supports_net_changes = 0;
-- Create some customers ...
CREATE TABLE customers (
  id INTEGER IDENTITY(1001,1) NOT NULL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE
);
INSERT INTO customers(first_name,last_name,email)
  VALUES ('Sally','Thomas','sally.thomas@acme.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('George','Bailey','gbailey@foobar.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('Edward','Walker','ed@walker.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('Anne','Kretchmar','annek@noanswer.org');
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'customers', @role_name = NULL, @supports_net_changes = 0;
-- Create some very simple orders
CREATE TABLE orders (
  id INTEGER IDENTITY(10001,1) NOT NULL PRIMARY KEY,
  order_date DATE NOT NULL,
  purchaser INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  FOREIGN KEY (purchaser) REFERENCES customers(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO orders(order_date,purchaser,quantity,product_id)
  VALUES ('16-JAN-2016', 1001, 1, 102);
INSERT INTO orders(order_date,purchaser,quantity,product_id)
  VALUES ('17-JAN-2016', 1002, 2, 105);
INSERT INTO orders(order_date,purchaser,quantity,product_id)
  VALUES ('19-FEB-2016', 1002, 2, 106);
INSERT INTO orders(order_date,purchaser,quantity,product_id)
  VALUES ('21-FEB-2016', 1003, 1, 107);
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'orders', @role_name = NULL, @supports_net_changes = 0;


CREATE TABLE inventory_source (
  id INTEGER IDENTITY(10001,1) NOT NULL PRIMARY KEY,
  source_code varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  enabled smallint  NOT NULL DEFAULT 1,
  description text,
  latitude decimal(8,6) DEFAULT NULL,
  longitude decimal(9,6) DEFAULT NULL,
  country_id varchar(2) NOT NULL,
  region_id int DEFAULT NULL,
  region varchar(255) DEFAULT NULL,
  city varchar(255) DEFAULT NULL,
  street varchar(255) DEFAULT NULL,
  postcode varchar(255) NOT NULL,
  contact_name varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  fax varchar(255) DEFAULT NULL,
  use_default_carrier_config smallint NOT NULL DEFAULT 1,
  is_pickup_location_active tinyint NOT NULL DEFAULT 0,
  frontend_name varchar(255) DEFAULT '',
  frontend_description text
);

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'inventory_source', @role_name = NULL, @supports_net_changes = 0;

CREATE TABLE store_data (
	store_id bigint NULL,
	store_name nvarchar(11) NULL,
	store_address nvarchar(105) NULL,
	store_location varchar(27) NULL,
	description nvarchar(257) NULL
);

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'store_data', @role_name = NULL, @supports_net_changes = 0;

