/*=============================================
Title: 			query_tags

Usage:			N/A

Author:			Sirius Computer Solutions, Inc.
		
--
Create date: 	2020-JUN-18
--
Description:	Sirius About Snowflake - Query Tag - Demo
				Query Tag Demo script
				
Goal:			Demonstrate query tags in Snowflake

				Snowflake Functionality Covered:
					query history
					query tags

Requires:		Snowflake account and a user ID
			
--
--
Optional:		None
--
WARNING: 		This is a destructive script - review before using - USE AT YOUR OWN RISK!
--
Copyright (C) 2020 - Sirius Computer Solutions, Inc.
All Rights Reserved
--
Version: 0.0.1.000
Revision History:


0.0.1.000 Original
=============================================*/
-- set our query tag value
ALTER SESSION SET query_tag = 
 '{
  "PGMID":296282,
  "PGMNM":"item_class",
  "PGMVER": "1.2.123",
  "MODNM":"generate_class",
  "FNCNM":"join_to_item_mstr",
  "STMNM":"item_class_filter_on_active_items",
  "EXECID":"92c6da4e-68de-4ad0-9861-7e72819a02af"
  }';

-- execute our query with the tag associated to it
-- for query history
SELECT * FROM item_master im
INNER JOIN
class_master cm ON 
im.upc = cm.upc;

-- unset the query tag - otherwise this query tag
-- will be used subsequent queries
ALTER SESSION UNSET query_tag;

--check query history for our tagged query
SELECT query_id, query_tag, * 
FROM snowflake.account_usage.query_history
WHERE query_id = '{your query ID here}'

-- query log table
CREATE OR REPLACE TABLE QUERY_LOG 
(
 QUID VARCHAR,
 TAG VARIANT
);

--insert the query ID and query tag into our query_log table
INSERT INTO query_log 
(
  SELECT query_id, parse_json(query_tag) 
  FROM snowflake.account_usage.query_history 
  WHERE query_id = '{your query ID here}'
);

-- review data from query log
SELECT 
 quid
,tag:PGMID
,tag:PGMNM
,tag:PGMVER
,tag:MODNM
,tag:FNCNM
,tag:STMNM
,tag:EXECID
FROM query_log;

-- review data from query log
SELECT 
qh.*
,quid
,tag:PGMID
,tag:PGMNM
,tag:PGMVER
,tag:MODNM
,tag:FNCNM
,tag:STMNM
,tag:EXECID
FROM query_log ql
INNER JOIN 
snowflake.account_usage.query_history qh ON
ql.quid = qh.query_id;

