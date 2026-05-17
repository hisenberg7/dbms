CREATE TABLE job_grades (
    grade_level VARCHAR2(5),
    lowest_sal NUMBER,
    highest_sal NUMBER
);
insert into job_grades(grade_level,lowest_sal,highest_sal)
values('&grade_level',&lowest_sal,&highest_sal);


CREATE VIEW emp_vu AS
SELECT employee_id,
       first_name || ' ' || last_name AS employee,
       department_id
FROM employee;

SELECT * FROM emp_vu;

CREATE VIEW dept50 (empno, employee, deptno) AS
SELECT employee_id,
       last_name,
       department_id
FROM employee
WHERE department_id = 1;
drop view dept50;

DESC dept50;

SELECT * FROM dept50;

UPDATE employee
SET department_id = 80
WHERE last_name = 'bhai';
commit;

CREATE view salary_vu AS
SELECT e.last_name,
       d.department_name,
       e.salary,
       j.grade_level
FROM employee e
JOIN departmentmm d
ON e.department_id = d.department_id
JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;


CREATE USER user2 IDENTIFIED BY user2;

GRANT CONNECT, RESOURCE TO user2;

GRANT SELECT ON departments TO user2;

CREATE SYNONYM dept_syn
FOR user2.departments;

SELECT * FROM dept_syn;

GRANT SELECT ON departmentmm TO user2;

