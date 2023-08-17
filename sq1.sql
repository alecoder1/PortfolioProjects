USE project;
SELECT * FROM employee_details;

CREATE TABLE department (
	dept_id INT NOT NULL PRIMARY KEY,
	dept_name VARCHAR(50)
);

INSERT INTO department
VALUES 	(11, 'IT'),
		(12, 'HR'),
        (13, 'Finance'),
        (14, 'Sales $ marketing'),
        (15, 'Operations');
SELECT * FROM department;

ALTER TABLE projects
ADD COLUMN project_manager VARCHAR(45); 

ALTER TABLE employee_details
ADD FOREIGN KEY (dept_id) REFERENCES department(dept_id);
SELECT * FROM employee_details;

UPDATE employee_details
SET dept_id = 17
WHERE ID = 106;

ALTER TABLE employee_details
DROP FOREIGN KEY fk_dept_id;

CREATE TABLE projects (
	project_id INT NOT NULL PRIMARY KEY,
	id INT NOT NULL,
    project_name VARCHAR(50)
);

INSERT INTO projects
VALUES 	(110, 103, 'ERP systems', 'vinay'),
		(210, 104, 'HR', 'priyanka'),
        (310, 105,'cyber security', 'karthik'),
        (410, 101,'network solutions', 'aman'),
        (510, 102,'android deelopment', 'raghav'),
        (610, 106, 'data warehousing', 'sneha'),
        (710, 107, 'image encription', 'braya'),
        (810, 110, 'business intelligence', 'kavrat');
SELECT * FROM projects

->joins
-> retrieve the employee details and the department they are working in
SELECT employee_details.id, employee_details.name, employee_details.designation, department.dept_id, department.dept_name
FROM employee_details
INNER JOIN department ON department.dept_id = employee_details.dept_id;

->retrieve the employee details, project they are working on and the project manager assisting them;
SELECT e.id, e.name, p.project_name, p.project_manager
FROM employee_details as e
INNER JOIN projects as p ON p.id = e.id;

-->left join
SELECT e.id, e.name, p.project_name, p.project_manager
FROM employee_details as e
LEFT JOIN projects as p ON e.id = p.id;
-->right join
SELECT e.id, e.name, p.project_name, p.project_manager
FROM employee_details as e
RIGHT JOIN projects as p ON e.id = p.id;

CREATE TABLE customer (
	custid INT NOT NULL PRIMARY KEY,
	custname VARCHAR(45),
    age INT,
    address VARCHAR(50),
    phone VARCHAR(50)
);

INSERT INTO customer
VALUES 	(10110, 'rahul', 25, 'hyderabad','798345678'),
		(10120, 'kavya', 28, 'bangalore','8793459081'),
        (10130, 'ajay', 24, 'mumbai', '9887648926'),
        (10140, 'divya', 25, 'bangalore', '7885678209'),
        (10150, 'adarsh', 25,'chennai', '9883467290'),
        (10170, 'pranay', 28,'pune', '7898834678');
SELECT * FROM customer;
CREATE TABLE orders (
	product_id INT NOT NULL PRIMARY KEY,
	custid INT NOT NULL,
    product_name VARCHAR(50),
    quantity INT,
    price BIGINT(50),
    purchase_date DATE
);

INSERT INTO orders
VALUES 	(1, 10120, 'AC', 1, 40000, '2021-07-11'),
		(2, 10130, 'TV', 1, 75000, '2022-03-25'),
        (3, 10110, 'phone', 2, 45000, '2019-10-22'),
        (4, 10140, 'cooker', 1, 20000, '2020-07-19'),
        (5, 10160, 'car', 1, 6000000, '2020-04-24'),
        (6, 10130, 'sofa set', 2, 45000, '2021-05-19'),
        (7, 10190, 'phone', 3, '27000', '2022-04-23');
SELECT * FROM orders;

SELECT c.custid, c.custname, c.address, o.product_name, o.quantity, o.price, o.purchase_date
FROM customer AS c 
LEFT JOIN orders AS o 
ON c.custid = o.custid;

SELECT c.custname, c.address, o.product_name, o.quantity, o.price, o.purchase_date
FROM customer as c
RIGHT JOIN orders as o 
ON c.custid = o.custid;