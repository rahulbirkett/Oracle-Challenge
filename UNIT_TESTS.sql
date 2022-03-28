--Test 1 : Test that data structures are created, Ensure below SQL returns count 2
SELECT COUNT(1) 
  FROM user_tables 
 WHERE table_name in ('DEPARTMENT','EMPLOYEES') 
   AND status='VALID';

/*------------------------------------------------------------------------------------*/ 
 
--Test 2 : Test that data structures are populated, 

--Ensure below SQL returns count 4  
SELECT COUNT(1) 
  FROM DEPARTMENT;

--Ensure below SQL returns count 10  
SELECT COUNT(1) 
  FROM EMPLOYEES;  
 

/*------------------------------------------------------------------------------------*/  

--Test 3 : Test that database executable is created, Ensure below SQL returns count 2 
SELECT COUNT(1) 
  FROM user_objects 
 WHERE object_name in ('PACK_MANAGE_EMPLOYEE') 
   AND status='VALID';
   
/*------------------------------------------------------------------------------------*/ 
   
--Test 4 : Test to create new employee 90013, execute below PLSQL block  
DECLARE
	l_emp_rec employee_rec;
BEGIN
    dbms_output.put_line('Test 4 : Test to create new employee 90013 and ensure below SQL returns count 1');
	l_emp_rec := employee_rec('90013', 'John Denver', 'Developer', 90002, to_date('01/03/22','dd/mm/yy'), 55000, 1);
	pack_manage_employee.proc_create_emp(l_emp_rec);
	COMMIT;

EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line(sqlerrm);
END;
/
 
--Ensure below SQL returns count 1 
SELECT COUNT(1) 
  FROM EMPLOYEES
 WHERE emp_id = 90013;   
   
/*------------------------------------------------------------------------------------*/    

--Test 5 : Test to increment salary of an employee by 25%, execute below PLSQL block  
BEGIN
    dbms_output.put_line('Test 5 : Test to increment salary of an employee by 25% and ensure below SQL returns salary of 68750');
	pack_manage_employee.proc_update_salary(90013,0.25);
	COMMIT;

EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line(sqlerrm);
END;  
/

--Ensure below SQL returns salary of 68750
SELECT salary 
  FROM EMPLOYEES
 WHERE emp_id = 90013; 

/*------------------------------------------------------------------------------------*/ 

--Test 6 : Test to transfer empployee 90013 from department 1 to 2, execute below PLSQL block 
BEGIN
    dbms_output.put_line('Test 6 : Test to transfer empployee 90013 from department 1 to 2 and ensure below SQL returns department id 2');
	pack_manage_employee.proc_transfer_dept(90013,2);
	COMMIT;

EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line(sqlerrm);
END;
/

--Ensure below SQL returns department id 2
SELECT dept_id 
  FROM EMPLOYEES
 WHERE emp_id = 90013; 

/*------------------------------------------------------------------------------------*/ 

--Test 7 : Test to get salary of empployee 90001, execute below PLSQL block
DECLARE 
    ls_salary employees.salary%type;

BEGIN
    dbms_output.put_line('Test 7 : Test to get salary of empployee 90001 and ensure below SQL returns salary of 100000');
	ls_salary := pack_manage_employee.get_salary(90001);
	dbms_output.put_line(ls_salary);

EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line(sqlerrm);
END;
/

--Ensure below SQL returns salary of 100000
SELECT salary 
  FROM EMPLOYEES
 WHERE emp_id = 90001; 

/*------------------------------------------------------------------------------------*/ 

--Test 8 : Test reports and ensure all data is fetched correctly 
--SQL to show all Employees for a Department
SELECT b.dept_name department_name, 
       a.emp_id employee_id, 
       a.emp_name employee_name,
       a.job_title,
       emp_manager.emp_name manager_name, 
       a.date_hired,
       a.salary
  FROM employees a, department b, employees emp_manager
 WHERE a.dept_id = b.dept_id
   AND a.manager_id = emp_manager.emp_id(+)
 ORDER BY b.dept_id;


--SQL to show the total of Employee Salary for a Department 
SELECT b.dept_id,
       b.dept_name department_name, 
       SUM(a.salary) total_dept_salary
  FROM employees a, department b
 WHERE a.dept_id = b.dept_id
 GROUP BY b.dept_id,b.dept_name
 ORDER BY b.dept_id; 