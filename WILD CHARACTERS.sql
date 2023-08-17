SET AUTOCOMMIT = 0;

SELECT * FROM employee_details;

UPDATE employee_details
SET designation = 'Business Analyst'
WHERE id = 103;

COMMIT;

UPDATE employee_details
SET Total_salary = 60000
WHERE id = 103;

DELETE FROM employee_details
WHERE designation = 'Business Analyst';

ROLLBACK;


--percent
SELECT * FROM employee_details
WHERE name LIKE 'K%N';

SELECT * FROM employee_details 
WHERE name LIKE 'N%'
AND Total_salary BETWEEN 30000 AND 50000;

