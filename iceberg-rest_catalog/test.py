#!/usr/bin/env python
# coding: utf-8

# In[1]:


from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType

# In[19]:


spark.sql("CREATE NAMESPACE IF NOT EXISTS nyc")



# In[4]:


schema = StructType([
  StructField("vendor_id", LongType(), True),
  StructField("trip_id", LongType(), True),
  StructField("trip_distance", FloatType(), True),
  StructField("fare_amount", DoubleType(), True),
  StructField("store_and_fwd_flag", StringType(), True)
])

df = spark.createDataFrame([], schema)
df.writeTo("nyc.taxis").create()


# In[7]:


schema = spark.table("nyc.taxis").schema
data = [
    (1, 1000371, 1.8, 15.32, "N"),
    (2, 1000372, 2.5, 22.15, "N"),
    (2, 1000373, 0.9, 9.01, "N"),
    (1, 1000374, 8.4, 42.13, "Y")
  ]
df = spark.createDataFrame(data, schema)
df.writeTo("nyc.taxis").append()


# In[8]:


df = spark.table("nyc.taxis").show()




####
