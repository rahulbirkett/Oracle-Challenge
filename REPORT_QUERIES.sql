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