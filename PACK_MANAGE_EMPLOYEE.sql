/*
* Script Name:      PACK_MANAGE_EMPLOYEE.sql
* Project:          Oracle Test Challenge
* Description:      Oracle Type and Package Creation
* Author:           Rahul Birkett
* Date Created:     25/03/22  
* Purpose:          Package to manage all employee functions
* 
* Audit History:
* Vers      Date      Project       Changed By      Description
* 1.0       25/03/22  Oracle Test   Rahul Birkett   Create Type and Package
* 
*/

SET serveroutput ON SIZE unlimited

--Create Type to manage package calls
CREATE OR REPLACE TYPE employee_rec AS OBJECT 
(
emp_id         NUMBER(10),
emp_name       VARCHAR2(50),
job_title      VARCHAR2(50),
manager_id     NUMBER(10),
date_hired     DATE,
salary         NUMBER(10),
dept_id        NUMBER(5)
);
/

--Create Package to manage employees
CREATE OR REPLACE PACKAGE pack_manage_employee IS
PROCEDURE proc_create_emp    (p_emp_rec              employee_rec);

PROCEDURE proc_update_salary (p_emp_id               employees.emp_id%type, 
                              p_salary_change_percnt NUMBER);

PROCEDURE proc_transfer_dept (p_emp_id               employees.emp_id%type, 
                              p_dept_id              employees.dept_id%type);

FUNCTION  get_salary         (p_emp_id               employees.emp_id%type)
  RETURN  employees.salary%type;
END;
/


--Create Package Body to manage employees
CREATE OR REPLACE PACKAGE BODY pack_manage_employee IS

--Procedure to validate that employee exists
PROCEDURE proc_validate_emp (p_emp_id     IN   employees.emp_id%type,
                             o_emp_exists OUT  VARCHAR2
							 ) IS

 CURSOR cur_emp_exists IS
 SELECT 'Y'
   FROM employees
  WHERE emp_id = p_emp_id;
  
  lv_emp_exists   VARCHAR2(1):='N';
  
BEGIN

	 OPEN cur_emp_exists;
	FETCH cur_emp_exists 
	 INTO lv_emp_exists;
	   IF cur_emp_exists%found then
		  o_emp_exists := 'Y';
	 ELSE
          o_emp_exists := 'N';		
	  END IF;
	  
	CLOSE cur_emp_exists;
	
	

EXCEPTION
  WHEN NO_DATA_FOUND THEN 
     o_emp_exists := 'N';
	 DBMS_OUTPUT.PUT_LINE('Employee not found !!!');
  WHEN OTHERS THEN 
     o_emp_exists := 'N';
     DBMS_OUTPUT.PUT_LINE('Error occured in package proc_validate_emp -'||SQLERRM);
END proc_validate_emp;


--Procedure to create new employee
PROCEDURE proc_create_emp (p_emp_rec  employee_rec) IS

  lv_emp_exists   VARCHAR2(1):='N';

BEGIN

  proc_validate_emp(p_emp_rec.emp_id, lv_emp_exists);

  IF lv_emp_exists = 'N' THEN
  
  INSERT INTO employees 
  VALUES (p_emp_rec.emp_id,
          p_emp_rec.emp_name,
		  p_emp_rec.job_title,
		  p_emp_rec.manager_id,
		  p_emp_rec.date_hired,
		  p_emp_rec.salary,
		  p_emp_rec.dept_id);
		  
   END IF;		  

EXCEPTION
  WHEN OTHERS THEN 
     DBMS_OUTPUT.PUT_LINE('Error occured in creating employee -'||SQLERRM);
END proc_create_emp;


--Procedure to update salary of employee
PROCEDURE proc_update_salary (p_emp_id                 employees.emp_id%type, 
                              p_salary_change_percnt   NUMBER) IS
 
 lv_emp_exists   VARCHAR2(1):='N';
 
BEGIN

  proc_validate_emp(p_emp_id, lv_emp_exists);

  IF lv_emp_exists = 'Y' THEN
  
	  UPDATE employees
		 SET salary = salary * (1 + p_salary_change_percnt)
	   WHERE emp_id = p_emp_id;
  
  END IF;		  

EXCEPTION
  WHEN OTHERS THEN 
     DBMS_OUTPUT.PUT_LINE('Error occured in updating employee salary-'||SQLERRM);
END proc_update_salary;


--Procedure to trasfer department of employee
PROCEDURE proc_transfer_dept (p_emp_id   employees.emp_id%type, 
                              p_dept_id  employees.dept_id%type) IS
							  
 lv_emp_exists   VARCHAR2(1):='N';
BEGIN

  proc_validate_emp(p_emp_id, lv_emp_exists);

  IF lv_emp_exists = 'Y' THEN

	  UPDATE employees
		 SET dept_id = p_dept_id
	   WHERE emp_id = p_emp_id;
	   
  END IF;
EXCEPTION
  WHEN OTHERS THEN 
     DBMS_OUTPUT.PUT_LINE('Error occured in transfer of department -'||SQLERRM);
END proc_transfer_dept;


--Function to get salary of employee
FUNCTION  get_salary         (p_emp_id               employees.emp_id%type)
  RETURN  employees.salary%type IS
 
 CURSOR cur_salary IS
 SELECT salary
   FROM employees
  WHERE emp_id = p_emp_id;
	
  ls_salary employees.salary%type;	

BEGIN

 OPEN cur_salary;
FETCH cur_salary 
 INTO ls_salary;
   IF cur_salary%notfound THEN
      RETURN 0;
   END IF;
CLOSE cur_salary;

RETURN ls_salary;

EXCEPTION
  WHEN OTHERS THEN 
     DBMS_OUTPUT.PUT_LINE('Error occured in fetching employee salary -'||SQLERRM);
END get_salary;

END pack_manage_employee;
/