CREATE TABLE kafka_store_data  (
	 store_id  UInt32,
	 store_name String,
	 store_address Nullable(String),
	 store_location Nullable(String),
	 description Nullable(String)
) ENGINE = Kafka SETTINGS kafka_broker_list = '<kafka-broker-fqdn>:9091',
                            kafka_topic_list = 'inventory.dbo.store_data',
                            kafka_group_name = 'inventory-consumer-group', 
                            kafka_format = 'JSONEachRow'


CREATE TABLE ch_store_data  ON CLUSTER  '{cluster}'(
	 store_id  UInt32,
	 store_name String,
	 store_address Nullable(String),
	 store_location Nullable(String),
	 description Nullable(String)
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{shard}/ch_store_data', '{replica}') 
ORDER BY (store_id)

CREATE MATERIALIZED VIEW materialized_store_data TO store_data
		AS SELECT  store_id, store_name, store_address, store_location, description
FROM kafka_store_data


SELECT * from store_data;
DROP TABLE store_data  ON CLUSTER  '{cluster}'