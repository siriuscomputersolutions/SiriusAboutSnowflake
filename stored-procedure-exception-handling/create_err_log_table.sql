/*=============================================
Title: 			create_err_log_table

Usage:			N/A

Author:			Sirius Computer Solutions, Inc.
		
--
Create date: 	2020-JUL-18
--
Description:	Sirius About Snowflake - Stored Procedure Exception Handling - Demo
				Stored Procedure Exception Handling error log table create script
				
Goal:			Demonstrate Stored Procedure Exception Handling in Snowflake

				Snowflake Functionality Covered:
					stored procedures


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
-- create a table for logging errors
CREATE OR REPLACE TABLE siriusaboutsnowflake.siriusaboutsnowflake.SF_PROCEDURE_ERROR_LOG
(
     procedure_error_id	        bigint   identity(1,1)	NOT NULL
    ,procedure_name	            varchar(255)            NOT NULL
    ,error_step	                varchar                 NULL
    ,error_message		        varchar                 NULL
    ,error_event_dt		        timestamp_ntz 	        NOT NULL    DEFAULT convert_timezone('UTC', current_timestamp)::timestampntz
);

