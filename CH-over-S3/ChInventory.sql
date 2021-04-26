-- DROP TABLE mysql_sales_order_grid;
-- MySql external tabke
CREATE TABLE mysql_sales_order_grid  (
  `entity_id` UInt32,
  `status` Nullable(String),
  `store_id` Nullable(UInt16),
  `store_name` Nullable(String), 
  `customer_id` Nullable(UInt32),
  `grand_total` Nullable(Float32),
  `order_currency_code` String,
  `created_at` DateTime,
  `updated_at` DateTime,
  `billing_address` Nullable(String),
  `shipping_address` Nullable(String),
  `shipping_information` Nullable(String),
  `customer_email` Nullable(String),
  `customer_group` Nullable(String)
 
)  ENGINE = MySQL('<mysql-host-fqdn>:3306', 'magento-cloud', 'sales_order_grid', 'makhlu', 'P@ssw0rd.1')

--select * from mysql_sales_order_grid;

/* CH Table with S3 Virtual storage TTL Rule*/
CREATE TABLE sales_order ON CLUSTER  `{cluster}`(
  `entity_id` UInt32,
  `status` Nullable(String),
  `store_id` Nullable(UInt16),
  `store_name` Nullable(String), 
  `customer_id` Nullable(UInt32),
  `grand_total` Nullable(Float32),
  `order_currency_code` String,
  `created_at` DateTime,
  `updated_at` DateTime,
  `billing_address` Nullable(String),
  `shipping_address` Nullable(String),
  `shipping_information` Nullable(String),
  `customer_email` Nullable(String),
  `customer_group` Nullable(String)
) ENGINE = ReplacingMergeTree('/clickhouse/tables/{shard}/data_cluster', '{replica}') -- 
  PARTITION BY toYYYYMM(`created_at`)
  ORDER BY (`entity_id`)
  TTL `created_at` + INTERVAL 1 MONTH TO DISK 'object_storage';

 select * from sales_order so;
 
INSERT INTO inventory.sales_order (entity_id, status, store_id, store_name, customer_id, grand_total, order_currency_code, created_at, updated_at, 
billing_address, shipping_address, shipping_information, customer_email, customer_group) 
SELECT  entity_id, status, store_id, store_name, customer_id, grand_total, order_currency_code, created_at, updated_at, 
billing_address, shipping_address, shipping_information, customer_email, customer_group
FROM mysql_sales_order_grid
WHERE entity_id > (SELECT MAX(entity_id) from sales_order);

 select * from sales_order so;

SELECT * FROM system.disks;



 
