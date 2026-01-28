

# FOR SPARK 4.0.1 and SCALA 2.13
## --packages org.apache.iceberg:iceberg-spark-runtime-4.0_2.13:1.10.1
## --packages org.apache.hadoop:hadoop-aws:3.4.0
## bundle-2.23.19.jar
## iceberg-aws-bundle-1.10.1.jar

export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID=admin
export AWS_SECRET_ACCESS_KEY=password


bin/spark-sql


```{sql}

USE prod; -- "prod" refers to the name a the catalog

CREATE NAMESPACE IF NOT EXISTS nyc;


CREATE TABLE nyc.taxis
(
  vendor_id bigint,
  trip_id bigint,
  trip_distance float,
  fare_amount double,
  store_and_fwd_flag string
)
PARTITIONED BY (vendor_id);


INSERT INTO nyc.taxis
VALUES (1, 1000371, 1.8, 15.32, 'N'), (2, 1000372, 2.5, 22.15, 'N'), (2, 1000373, 0.9, 9.01, 'N'), (1, 1000374, 8.4, 42.13, 'Y');

SELECT * FROM nyc.taxis;


CREATE NAMESPACE IF NOT EXISTS db;

CREATE TABLE db.external_table (
    id bigint,
    data string
) 
USING iceberg;
LOCATION 's3a://other/';

INSERT INTO db.external_table
VALUES (1, 'External data 1'), (2, 'External data 2');


USE dev; -- "dev" refers to the name of a catalog

-- Create a namespace
CREATE NAMESPACE IF NOT EXISTS db;

-- Create a table
CREATE TABLE db.logs (
    id bigint, 
    message string, 
    level string
) 
PARTITIONED BY (level);

-- Insert data
INSERT INTO db.logs VALUES (1, 'System started', 'INFO'), (2, 'System stop', 'WARN'), (3, 'Null pointer exception', 'ERROR');

-- Query data
SELECT * FROM db.logs;



```



bin/spark-sql \
  --packages org.apache.hadoop:hadoop-aws:3.4.0 \
  --packages org.apache.iceberg:iceberg-spark-runtime-4.0_2.13:1.10.1 \
    --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
    --conf spark.sql.catalog.spark_catalog=org.apache.iceberg.spark.SparkSessionCatalog \
    --conf spark.sql.catalog.spark_catalog.type=hive \
    --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
    --conf spark.sql.catalog.local.type=hadoop \
    --conf spark.sql.catalog.local.warehouse=$PWD/warehouse \
    --conf spark.sql.defaultCatalog=local