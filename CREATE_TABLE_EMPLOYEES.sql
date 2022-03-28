/*
* Script Name:      CREATE_TABLE_EMPLOYEES.sql
* Project:          Oracle Test Challenge
* Description:      Oracle Table Creation
* Author:           Rahul Birkett
* Date Created:     25/03/22  
* Purpose:          Create EMPLOYEES table
* 
* Audit History:
* Vers      Date      Project       Changed By      Description
* 1.0       25/03/22  Oracle Test   Rahul Birkett   Create Table 
* 
*/

SET serveroutput ON SIZE unlimited

DECLARE

  lv_table_name        VARCHAR2(30):= 'EMPLOYEES';
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
						  ' (EMP_ID         NUMBER(10)    NOT NULL,  '||
						  '  EMP_NAME       VARCHAR2(50)  NOT NULL,  '||
						  '  JOB_TITLE      VARCHAR2(50)  NOT NULL,  '||
						  '  MANAGER_ID     NUMBER(10),              '||
						  '  DATE_HIRED     DATE          NOT NULL,  '||
						  '  SALARY         NUMBER(10)    NOT NULL,  '||
						  '  DEPT_ID        NUMBER(5)     NOT NULL,  '||
						  '  CONSTRAINT EMP_PK PRIMARY KEY (EMP_ID), '||
						  '  CONSTRAINT EMP_DEPT_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID))';
						  
		EXECUTE IMMEDIATE lv_execute_text;	

        -- Adding table and column comments
        lv_execute_text := 'COMMENT ON TABLE EMPLOYEES IS ''Table to store EMPLOYEES details''';
		EXECUTE IMMEDIATE lv_execute_text;
        lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.EMP_ID IS ''The unique identifier for the employee''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.EMP_NAME IS ''The name of the employee''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.JOB_TITLE IS ''The job role undertaken by the employee. Some employees may undertaken the same job role''';
		EXECUTE IMMEDIATE lv_execute_text;
        lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.MANAGER_ID IS ''Line manager of the employee''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.DATE_HIRED IS ''The date the employee was hired''';
		EXECUTE IMMEDIATE lv_execute_text;
		lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.SALARY IS ''Current salary of the employee''';
		EXECUTE IMMEDIATE lv_execute_text;	
		lv_execute_text := 'COMMENT ON COLUMN EMPLOYEES.DEPT_ID IS ''Each employee must belong to a department''';
		EXECUTE IMMEDIATE lv_execute_text;	

        DBMS_OUTPUT.PUT_LINE('Table Created - '||lv_table_name);		
	 
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Table Already Exists - '||lv_table_name);	
	END IF;

END;
/