/* Question 1 -Find all the employees who work in the 'Human Resources' `department`. */

SELECT *
FROM employees 
WHERE department = 'Human Resources';


/* 2. Get the `first_name`, `last_name`, and `country` of the employees who work in the 'Legal' `department`. */

SELECT 
first_name, 
last_name, 
country
FROM employees 
WHERE department = 'Legal';

/* 3. Count the number of employees based in Portugal. */

SELECT 
COUNT(employees) AS portugues_employees
FROM employees 
WHERE country = 'Portugal';

/* 4. Count the number of employees based in either Portugal or Spain. */

SELECT 
COUNT(employees) AS from_Spain_or_Portugal
FROM employees 
WHERE country IN ('Portugal', 'Spain');


/* 5. Count the number of pay_details records lacking a `local_account_no`.*/

SELECT 
COUNT(pay_details) AS no_local_accouunt
FROM pay_details 
WHERE local_account_no IS NULL;


/* 6. Get a table with employees `first_name` and `last_name` ordered alphabetically by `last_name` (put any `NULL`s last).  */

SELECT 
first_name, 
last_name
FROM employees 
ORDER BY last_name;


/* 7. How many employees have a `first_name` beginning with 'F'? */

SELECT 
COUNT (employees) AS first_name_begins_with_F
FROM employees 
WHERE first_name LIKE 'F%'

/* 8. Count the number of pension enrolled employees not based in either France or Germany. */

SELECT *
FROM employees 
WHERE pension_enrol IS TRUE 
AND country NOT IN ('France', 'Germany');

/* 9. The corporation wants to make name badges for a forthcoming conference. Return a column `badge_label` 
 * showing employees' `first_name` and `last_name` joined together with their `department` in the following style: 
 * 'Bob Smith - Legal'. Restrict output to only those employees with stored `first_name`, `last_name` and `department`. */

SELECT 
first_name, 
last_name, 
department,
CONCAT(first_name, ' ', last_name, ' - ', department, ' - Joined in ', start_date ) AS new_badge
FROM employees 
WHERE first_name IS NOT NULL AND last_name IS NOT NULL AND department IS NOT NULL AND start_date IS NOT NULL



SELECT
  first_name,
  last_name,
  department,
  start_date,
  CONCAT(
    first_name, ' ', last_name, ' - ', department, 
    ' (joined ', EXTRACT(YEAR FROM start_date), ')'
  ) AS badge_label
FROM employees
WHERE 
  first_name IS NOT NULL AND 
  last_name IS NOT NULL AND 
  department IS NOT NULL AND
  start_date IS NOT NULL


SELECT
  first_name,
  last_name,
  department,
  start_date,
  CONCAT(
    first_name, ' ', last_name, ' - ', department, ' (joined ', 
    TO_CHAR(start_date, 'Month'),' ', TO_CHAR(start_date,'YYYY'), ')'
  ) AS badge_label
FROM employees
WHERE 
  first_name IS NOT NULL AND 
  last_name IS NOT NULL AND 
  department IS NOT NULL AND
  start_date IS NOT NULL







