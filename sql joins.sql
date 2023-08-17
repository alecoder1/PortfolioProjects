SELECT emp_id, emp_name, salary, dept_id, manager_id
FROM `sql_joins - pf`.employees;


-- Creating employees table
CREATE TABLE employees(
    emp_id varchar (20),
    emp_name varchar (50),
    salary int,
    dept_id varchar (20),
    manager_id varchar (20)
);

INSERT INTO employees 
values  ('E1','Rahul',15000,'D1','M1'),
        ('E2','Manoj',15000,'D1','M1'),
        ('E3','James',55000,'D2','M2'),
        ('E4','Michael',25000,'D2','M2'),
        ('E5','Ali',20000,'D10','M3'),
        ('E6','Robin',35000,'D10','M3');

DROP TABLE employees;        

update employees 
set emp_id = 'E6'
where emp_name = 'Robin'

    
-- Creating department table
CREATE TABLE department (
    dept_id varchar (20),
    dept_name varchar (50)
);

INSERT INTO department 
values  ('D1','IT'),
        ('D2','HR'),
        ('D3','Finance'),
        ('D4','Admin');


DROP TABLE department; 
        

SELECT *
FROM `sql_joins - pf`.department;
    
-- Creating managers table
CREATE TABLE managers(
   manager_id varchar (20),
    manager_name varchar (50),
    dept_id varchar (20)
);

INSERT INTO managers 
values  ('M1','Prem','D3'),
        ('M2','Shripadh','D4'),
        ('M3','Nick','D1'),
        ('M4','Cory','D1');

SELECT *
FROM `sql_joins - pf`.managers;
    
-- Creating projects table
CREATE TABLE projects(
   project_id varchar (20),
   project_name varchar (100),
   team_member_id varchar (20)
);

INSERT INTO projects 
values  ('P1','Data Migration','E1'),
        ('P1','Data Migration','E2'),
        ('P1','Data Migration','M3'),
        ('P2','ETL Tool','E1'),
        ('P2','ETL Tool','M4');

SELECT *
FROM `sql_joins - pf`.projects;
        


-- Fetch the employee name and the department name theybelong to.
-- inner join / JOIN
SELECT e.emp_name ,d.dept_name 
FROM  employees e inner join  department d on e.dept_id = d.dept_id ;

-- Fetch ALL the employee name and their department name theybelong to.
-- left join 
SELECT e.emp_name ,d.dept_name 
FROM  employees e left join  department d on e.dept_id = d.dept_id ;

-- left join = inner join + any additional records in the left table.

-- right join 
SELECT e.emp_name ,d.dept_name 
FROM  employees e right join  department d on e.dept_id = d.dept_id ;

-- right join = inner join + any additional details in the right table.

-- Fetch ALL the employees, their manager, their departmentand the projects they work on.

SELECT e.emp_name, d.dept_name, m.manager_name, p.project_name 
from employees e 
left join department d on e.dept_id = d.dept_id 
inner join managers m on m.manager_id = e.manager_id
left join projects p on p.team_member_id = e.emp_id ;




    
    