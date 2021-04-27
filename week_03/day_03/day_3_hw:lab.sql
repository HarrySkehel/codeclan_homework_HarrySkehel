/* Question  1 */

SELECT *
FROM pay_details 
WHERE iban IS NULL AND local_account_no IS NULL

/* Question 2 */

SELECT
	first_name,
	last_name,
	country 
FROM employees 
ORDER BY country, last_name, first_name NULLS LAST

/* Question 3 */
SELECT *
	 FROM employees 
ORDER BY salary DESC NULLS LAST 
limit 10 

/* Question 4 */

SELECT 
	first_name,
	last_name,
	salary 
	FROM employees
WHERE country = 'Hungary'

/* Question 5 */

SELECT *
FROM employees 
WHERE email LIKE '%@yahoo%'

/* Question 6 */
SELECT 
COUNT(*) AS num_employees,
department 
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department 

/* Question 7 */

SELECT 
department,
fte_hours,
COUNT(fte_hours) AS number_of_employees
FROM employees
GROUP BY department, fte_hours
ORDER BY department, fte_hours

/* Question 8 */

SELECT 
	count(*) AS number_of_employess,
	pension_enrol 
FROM employees 
GROUP BY pension_enrol 

/* Question 9 */

SELECT 
	max(salary)
FROM employees
WHERE department = 'Engineering' AND fte_hours = 1

/* Question 10 */

SELECT
	count(*) AS num_employees,
	country,
	ROUND(AVG(salary)) AS average_salary
FROM employees
GROUP BY country
HAVING (count(*) > 30)
ORDER BY AVG(salary)

/* Question 11 */

SELECT 
	first_name,
	last_name,
	salary,
	fte_hours,
	salary * fte_hours AS effective_yearly_salary
FROM employees 

/* Question 12 */
SELECT 
e.last_name,
e.first_name,
p_d.local_tax_code 
FROM employees AS e 
INNER JOIN pay_details AS p_d
ON e.pay_detail_id = p_d.id 
WHERE local_tax_code IS NULL

/* Question 13 */
SELECT 
(48 * 35 *(CAST (t.charge_cost AS int)) - e.salary)*e.fte_hours 
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id 

/* Question 14 */
SELECT
department,
COUNT(id) AS number_of_employees
FROM employees
WHERE first_name IS NULL 
GROUP BY department
HAVING COUNT(id) >= 2
ORDER BY COUNT(*), department


/* Question 15 */
SELECT
COUNT(id),
first_name
FROM employees 
WHERE first_name IS NOT NULL
GROUP BY first_name 
HAVING COUNT(id) >= 2
ORDER BY COUNT(id), first_name

/* Question 16 */

WITH grade_1_count AS (
	SELECT 
		COUNT(id) AS num_employees,
		department 
	FROM employees
	GROUP BY department 
)
	SELECT e.department, 
		count(e.id) AS num_grade_1,
		100*count(id)/
		g.num_employees AS percenatage_grade_1
		FROM employees AS e
		INNER JOIN grade_1_count AS g
		ON e.department = g.department
		WHERE grade = 1
		GROUP BY e.department, g.num_employees
		
		
--- Other way of answering 16
		

		
-- number of employees grade 1 grouped by department 
-- number of all employees grouped by department 
-- to get prop divide first number by second 
		
		
		
		WITH grade_1_count AS (               --- first find all the folk who are grade 1
		SELECT 
			department,
			CAST(COUNT(id) AS REAL) AS count_grade_1  --- CAST() stops all the integers being rounded down
		FROM employees
		WHERE grade = 1
		GROUP BY department 
		),
		department_count AS ( 					--- find the count of all the folk in each department 
		SELECT 
			department,
			COUNT(id) AS count_all
		FROM employees
		GROUP BY department
		)
		SELECT
			department_count.department,
			grade_1_count.count_grade_1,
			department_count.count_all,
			grade_1_count.count_grade_1/department_count.count_all AS grade_1_prop  --- Without cast, grade_1_prop would have loads of zeros
		FROM department_count
		INNER JOIN grade_1_count 
		ON department_count.department = grade_1_count.department 
		
		
--- very quick way of doing 16
		
SELECT 
  department, 
  SUM(CAST(grade = '1' AS INT)) / CAST(COUNT(id) AS REAL) AS prop_grade_1 
FROM employees 
GROUP BY department
		
		
--- SUM(CAST(grade = '1' AS INT)) turns grade into a boolean so its a 1 is grade1 is true and 0 if not 	
--- so then that sum total is divided by CAST(COUNT(id) AS REAL), 
--- which is the total count of employees across all grades	to get the amount of grade 1s as a proportion.	
		
		/* Averager salary per country compared to overall average salary */

WITH country_average AS(
	SELECT 
	country,
	ROUND(AVG(salary)) AS average_salary
	FROM employees
	GROUP BY country 
)
SELECT
	e.country,
	country_average.average_salary,
	e.first_name,
	ROUND(country_average.average_salary - AVG(e.salary) OVER ()) AS diff_in_salary
	FROM employees AS e 
	LEFT JOIN country_average 
	ON e.country = country_average.country
	ORDER BY country 
	

SELECT
  id,
    first_name,
    last_name,
    start_date,
  RANK() OVER (ORDER BY start_date ASC NULLS LAST) AS start_rank,
  DENSE_RANK() OVER (ORDER BY start_date ASC NULLS LAST) AS start_rank_dense,
  ROW_NUMBER () OVER (ORDER BY start_date ASC NULLS LAST) AS row_number_rank
FROM employees;


SELECT 
first_name,
last_name,
salary,
NTILE(5) OVER ( ORDER BY salary) 
FROM employees 


WITH grouped_salaries(salary_group) AS (
  SELECT
    NTILE(4) OVER (ORDER BY salary ASC NULLS FIRST)
  FROM employees 
)
SELECT
  salary_group,
  COUNT(*) AS num_in_group
FROM grouped_salaries
GROUP BY salary_group
