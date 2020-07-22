/*=============================================
Title: 			item_desc.js

Usage:			N/A

Author:			Sirius Computer Solutions, Inc.
		
--
Create date: 	2020-JUL-18
--
Description:	Sirius About Snowflake - Stored Procedure Exception Handling - Demo
				Stored Procedure Exception Handling stored procedure create script
				
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
// create the procedure
CREATE OR REPLACE PROCEDURE SIRIUSABOUTSNOWFLAKE.SIRIUSABOUTSNOWFLAKE.ITEM_DESC(UPC STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$

  v_proc_step = 0;
  v_proc_name = 'ITEM_DESC';

  // initialize and assign variable
  var upc = UPC;

// main try catch block
try {

  // set stored procedure step
  v_proc_step = 1
  
  // construct sql statement using 'upc' substitution  variable
  var sql_exec = "select desc from siriusaboutsnowflake.siriusaboutsnowflake.item_master where upc = " + upc;
  
  v_proc_step = 2
  // use .createStatement() method to create a statement object
  var stmt1 =  snowflake.createStatement({sqlText: sql_exec});
  
  v_proc_step = 3
  // use .execute() method to submit query to Snowflake
  var res1 = stmt1.execute();
  
  v_proc_step = 4
  // use .next() method to make the ResultSet available for access
  res1.next();

  v_proc_step = 5
  // return description and exit
  return res1.getColumnValue(1);
	
} catch (err) {
    result = `Failed: Step: ` + v_proc_step + `
        Code: ` + err.code + `
        State: ` + err.state;
    result += `
        Message: ` + err.message;
    result += `
Stack Trace:
` + err.stackTraceTxt;
                err.message_detail=result;

    // begin nested try catch block
    try {
            // insert error info into table using binding variables
            var stmt_err = snowflake.createStatement({sqlText: `insert into siriusaboutsnowflake.siriusaboutsnowflake.SF_PROCEDURE_ERROR_LOG (PROCEDURE_NAME,ERROR_STEP,ERROR_MESSAGE) VALUES (?,?,?)`
                                                     ,binds: [v_proc_name, v_proc_step, err.message_detail]});
            var res_err = stmt_err.execute();
    } catch (err2) {
        return err2;
    }
    // exit sproc with error message
    throw err;
}

$$; 
