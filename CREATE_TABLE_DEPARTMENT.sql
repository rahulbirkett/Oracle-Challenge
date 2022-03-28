/*
* Script Name:      CREATE_TABLE_DEPARTMENT.sql
* Project:          Oracle Test Challenge
* Description:      Oracle Table Creation
* Author:           Rahul Birkett
* Date Created:     25/03/22  
* Purpose:          Create DEPARTMENT table
* 
* Audit History:
* Vers      Date      Project       Changed By      Description
* 1.0       25/03/22  Oracle Test   Rahul Birkett   Create Table 
* 
*/

SET serveroutput ON SIZE unlimited

DECLARE

  lv_table_name        VARCHAR2(30):= 'DEPARTMENT';
  lv_table_exists      VARCHAR2(1):= 'N';
  lv_execute_text      VARCHAR2(3000):= NULL;
  
  CURSOR check_table_exists IS
  SELECT 'Y'
    FROM user_tables
   WHERE table_name = lv_table_name;  	
  
BEGIN

  -- Checking if table already exists
  OPEN check_table_exists;
 FETCH check_table_exists
  INTO lv_table_exists;
  
  IF check_table_exists%NOTFOUND THEN
    lv_table_exists := 'N';
  END IF;
  
 CLOSE check_table_exists; 
  
    --Creating table if not already exists
    IF lv_table_exists = 'N' THEN
	   
	    DBMS_OUTPUT.PUT_LINE('Creating Table -'||lv_table_name);
	
	    lv_execute_text := 'CREATE TABLE '||lv_table_name||
	                      ' (DEPT_ID         NUMBER(5)     NOT NULL,   '||
						  '  DEPT_NAME       VARCHAR2(50)  NOT NULL,   '||
						  '  DEPT_LOCATION   VARCHAR2(50)  NOT NULL,   '||
						  '  CONSTRAINT DEPT_PK1 PRIMARY KEY (DEPT_ID) '||
						  '  )';
						  
		EXECUTE IMMEDIATE lv_execute_text;	

        -- Adding table and column comments
        lv_execute_text := 'COMMENT ON TABLE DEPARTMENT IS ''Table to store department details''';
		EXECUTE IMMEDIATE lv_execute_text;
        lv_execute_text := 'COMMENT ON COLUMN DEPARTMENT.DEPT_ID IS ''The unique identifier for the department''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN DEPARTMENT.DEPT_NAME IS ''The name of the department''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN DEPARTMENT.DEPT_LOCATION IS ''The physical location of the department''';
		EXECUTE IMMEDIATE lv_execute_text;
	 
	    DBMS_OUTPUT.PUT_LINE('Table Created - '||lv_table_name);
		
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Table Already Exists - '||lv_table_name);	
	END IF;

END;
/