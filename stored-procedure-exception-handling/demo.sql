/*=============================================
Title: 			demo

Usage:			N/A

Author:			Sirius Computer Solutions, Inc.
		
--
Create date: 	2020-JUL-18
--
Description:	Sirius About Snowflake - Stored Procedure Exception Handling - Demo
				Stored Procedure Exception Handling Demo script
				
Goal:			Demonstrate Stored Procedure Exception Handling in Snowflake

				Snowflake Functionality Covered:
					stored procedures


Requires:		Snowflake account and a user ID
				SF_PROCEDURE_ERROR_LOG table
--
--
Optional:		None
--
WARNING: 		This is a constructive script - review before using - USE AT YOUR OWN RISK!
--
Copyright (C) 2020 - Sirius Computer Solutions, Inc.
All Rights Reserved
--
Version: 0.0.1.000
Revision History:


0.0.1.000 Original
=============================================*/
-- validate log table
desc table "SIRIUSABOUTSNOWFLAKE"."SIRIUSABOUTSNOWFLAKE"."SF_PROCEDURE_ERROR_LOG";

-- validate stored procedure
select procedure_catalog, 
    procedure_name, 
    procedure_owner, 
    argument_signature, 
    procedure_definition, 
    created, 
    last_altered  
from "SIRIUSABOUTSNOWFLAKE"."INFORMATION_SCHEMA"."PROCEDURES" where procedure_name = 'ITEM_DESC';

-- execute sproc - PASS
call "SIRIUSABOUTSNOWFLAKE"."SIRIUSABOUTSNOWFLAKE".ITEM_DESC(51131971332); 

-- execute sproc - FAIL
call "SIRIUSABOUTSNOWFLAKE"."SIRIUSABOUTSNOWFLAKE".ITEM_DESC(01010101010); 

-- read error from log table
select * from "SIRIUSABOUTSNOWFLAKE"."SIRIUSABOUTSNOWFLAKE"."SF_PROCEDURE_ERROR_LOG";
