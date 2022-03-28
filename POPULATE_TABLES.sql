/*
* Script Name:      POPULATE_TABLES.sql
* Project:          Oracle Test Challenge
* Description:      Oracle Table Creation
* Author:           Rahul Birkett
* Date Created:     25/03/22  
* Purpose:          Populate tables DEPARTMENT and EMPLOYEES
* 
* Audit History:
* Vers      Date      Project       Changed By      Description
* 1.0       25/03/22  Oracle Test   Rahul Birkett   Populate tables
* 
*/

SET serveroutput ON SIZE unlimited
  
BEGIN
    
	DBMS_OUTPUT.PUT_LINE('Populating Tables');

    --Populate table DEPARTMENT
	INSERT INTO DEPARTMENT VALUES (1,'Management','London');
	INSERT INTO DEPARTMENT VALUES (2,'Engineering','Cardiff');
	INSERT INTO DEPARTMENT VALUES (3,'Research '||'&'||' Development','Edinburgh');
	INSERT INTO DEPARTMENT VALUES (4,'Sales','Belfast');

    --Populate table EMPLOYEES
	INSERT INTO EMPLOYEES VALUES ('90001', 'John Smith', 'CEO',null, to_date('01/01/95','dd/mm/yy'), 100000, 1);
	INSERT INTO EMPLOYEES VALUES ('90002', 'Jimmy Willis', 'Manager', 90001, to_date('23/09/03','dd/mm/yy'), 52500, 4);
	INSERT INTO EMPLOYEES VALUES ('90003', 'Roxy Jones', 'Salesperson', 90002, to_date('11/02/17','dd/mm/yy'), 35000, 4);
	INSERT INTO EMPLOYEES VALUES ('90004', 'Selwyn Field', 'Salesperson', 90003, to_date('20/05/15','dd/mm/yy'),32000, 4);
	INSERT INTO EMPLOYEES VALUES ('90005', 'David Hallett', 'Engineer', 90006, to_date('17/04/18','dd/mm/yy'), 40000, 2);
	INSERT INTO EMPLOYEES VALUES ('90006', 'Sarah Phelps', 'Manager', 90001, to_date('21/03/15','dd/mm/yy'), 45000, 2);
	INSERT INTO EMPLOYEES VALUES ('90007', 'Louise Harper', 'Engineer', 90006, to_date('01/01/13','dd/mm/yy'), 47000, 2);
	INSERT INTO EMPLOYEES VALUES ('90008', 'Tina Hart', 'Engineer', 90009, to_date('28/07/14','dd/mm/yy'), 45000, 3);
	INSERT INTO EMPLOYEES VALUES ('90009', 'Gus Jones', 'Manager', 90001, to_date('15/05/18','dd/mm/yy'), 50000, 3);
	INSERT INTO EMPLOYEES VALUES ('90010', 'Mildred Hall', 'Secretary', 90001, to_date('12/10/96','dd/mm/yy'), 35000, 1);
    
	DBMS_OUTPUT.PUT_LINE('Tables Populated !!!');
	
    COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error while insertion - '||SQLERRM);
END;  
/