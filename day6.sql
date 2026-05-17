
CREATE TABLE departmentmm (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50),
    location_id NUMBER
);
insert into departmentmm(department_id,department_name,location_id)
values(&department_id,'&department_name',&location_id);
select * from departmentmm;

CREATE TABLE employee (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER,
    job_id VARCHAR2(50),
    manager_id NUMBER,
    department_id NUMBER,
    FOREIGN KEY (department_id) REFERENCES departmentmm(department_id)
);
insert into employee(employee_id,first_name,last_name,salary,job_id,manager_id,department_id)
values(&employee_id,'&first_name','&last_name',&salary,'&job_id',&manager_id,&department_id); 
select * from employee;
---1
SELECT employee_id, last_name
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
)
ORDER BY salary ASC;
----2.a
SELECT employee_id, last_name
FROM employee
WHERE department_id IN (
    SELECT department_id
    FROM employee
    WHERE last_name LIKE '%u%'
);
---2.b
SELECT employee_id,
       first_name || ' ' || last_name AS name,
       salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
)
AND department_id IN (
    SELECT department_id
    FROM employee
    WHERE last_name LIKE '%u%'
);
-------3
SELECT e.first_name || ' ' || e.last_name AS name,
       e.department_id,
       e.job_id
FROM employee e
JOIN departmentmm d
ON e.department_id = d.department_id
WHERE d.location_id = 1700;
----4
SELECT first_name || ' ' || last_name AS name,
       salary
FROM employee
WHERE manager_id = (
    SELECT employee_id
    FROM employee
    WHERE last_name = 'King'
);
------5
SELECT e.department_id,
       e.first_name || ' ' || e.last_name AS name,
       e.job_id
FROM employee e
JOIN departmentmm d
ON e.department_id = d.department_id
WHERE d.department_name = 'executive';
------6
SELECT first_name || ' ' || last_name AS name
FROM (
    SELECT first_name,
           last_name,
           salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) rnk
    FROM employee
)
WHERE rnk = 4;