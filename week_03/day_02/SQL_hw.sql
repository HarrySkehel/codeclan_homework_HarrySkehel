/* Question 1(a)*/

SELECT  
	employees.first_name,
	employees.last_name,
	teams.name AS team_name
FROM employees 
LEFT JOIN teams 
ON teams.id = employees.team_id
WHERE employees.first_name IS NOT NULL 
AND employees.last_name IS NOT NULL 
ORDER BY team_name;


/* Question 1(b) */
SELECT  
	employees.first_name,
	employees.last_name,
	teams.name AS team_name,
	employees.pension_enrol 
FROM employees 
LEFT JOIN teams 
ON teams.id = employees.team_id
WHERE employees.first_name IS NOT NULL 
AND employees.last_name IS NOT NULL AND employees.pension_enrol = TRUE
ORDER BY team_name;

/* Question 1 (c) */

SELECT  
	employees.first_name,
	employees.last_name,
	teams.name AS team_name,
	teams.charge_cost
FROM employees 
LEFT JOIN teams 
ON teams.id = employees.team_id
WHERE employees.first_name IS NOT NULL 
AND employees.last_name IS NOT NULL AND CAST(teams.charge_cost AS int) >= 80

/* Question 2(a) */

SELECT *
FROM employees AS e
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id 
WHERE pd.local_account_no IS NOT NULL AND pd.local_sort_code IS NOT NULL
 

/* Question 2(b) */

SELECT
	t.name
FROM teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id 

SELECT
	e. * ,
	pd. * ,
	t.name AS team_name
FROM (teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id)
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id 
WHERE pd.local_account_no IS NOT NULL AND pd.local_sort_code IS NOT NULL



/* Question 2(c) */
SELECT
	e.*, 
	pd.*,
	t.name 
FROM (teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id)
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id 
WHERE pd.local_account_no IS NOT NULL AND pd.local_sort_code IS NOT NULL


/* Question 3(a) */
SELECT
	e.id AS employee_id,
	t.name AS team_name
FROM teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id 

/* Question 3(b) & (c) */
SELECT
	count(e) AS number_of_employees,
	t.name AS team_name
FROM teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id 
GROUP BY t.name
ORDER BY  COUNT(e) DESC


/* Question 4 (a) */
SELECT
	t.id AS team_id,
	t.name AS team_name,
	count(e),
	(CAST(t.charge_cost AS int) * count(e)) AS total_charge_cost	
FROM teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id 
GROUP BY t.name, t.id 
ORDER BY team_id 


/* Question 4 (b) */
SELECT
	t.id AS team_id,
	t.name AS team_name,
	count(e),
	(CAST(t.charge_cost AS int) * count(e)) AS total_charge_cost	
FROM teams AS t
INNER JOIN employees AS e
ON e.team_id = t.id 
WHERE (t.id * count(e)) > 5000
GROUP BY t.name, t.id 
ORDER BY team_id 


/* Extension */

SELECT 
	e.first_name,
	e.last_name,
	emp_coms.committee_id,
	emp_coms.employee_id
FROM employees AS e
LEFT JOIN employees_committees AS emp_coms
ON emp_coms.employee_id = e.id 
WHERE emp_coms.committee_id IS NOT NULL
