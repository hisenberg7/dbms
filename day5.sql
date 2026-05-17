ALTER TABLE employee
ADD hire_date DATE;

ALTER TABLE employee
ADD commission_pct NUMBER(10);

CREATE TABLE locations (
    location_id NUMBER PRIMARY KEY,
    city VARCHAR2(50)
);

INSERT INTO locations(location_id,city)
VALUES(&location_id,'&city');


UPDATE employee
SET hire_date = TO_DATE('&hire_date','DD-MM-YYYY'),
    commission_pct = &commission_pct
WHERE employee_id = &employee_id;
select * from employee;

---------------------------------------------------
-- 1(a)

SELECT e.first_name || ' ' || e.last_name AS employee_name,
       d.department_name
FROM employee e
JOIN departmentmm d
ON e.department_id = d.department_id
WHERE LOWER(e.last_name) LIKE '%a%';

---------------------------------------------------
-- 1(b)

SELECT e.first_name || ' ' || e.last_name AS employee_name,
       d.department_name,
       l.location_id,
       l.city
FROM employee e
JOIN departmentmm d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;

---------------------------------------------------
-- 2(a)

SELECT e.first_name || ' ' || e.last_name AS employee,
       e.employee_id AS "emp#",
       m.first_name || ' ' || m.last_name AS manager,
       m.employee_id AS "mgr#"
FROM employee e
JOIN employee m
ON e.manager_id = m.employee_id;

---------------------------------------------------
-- 2(b)

SELECT e.first_name || ' ' || e.last_name AS employee,
       e.employee_id AS "emp#",
       m.first_name || ' ' || m.last_name AS manager,
       m.employee_id AS "mgr#"
FROM employee e
LEFT JOIN employee m
ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

---------------------------------------------------
-- 3(a)

SELECT e.first_name || ' ' || e.last_name AS employee_name,
       e.department_id,
       s.first_name || ' ' || s.last_name AS same_department_employee
FROM employee e
JOIN employee s
ON e.department_id = s.department_id
WHERE e.last_name = '&last_name';

---------------------------------------------------
-- 3(b)

SELECT first_name || ' ' || last_name AS employee_name,
       hire_date
FROM employee
WHERE hire_date > (
    SELECT hire_date
    FROM employee
    WHERE last_name = '&employee_name'
);

---------------------------------------------------
-- 4

SELECT e.first_name || ' ' || e.last_name AS employee_name,
       e.hire_date,
       m.first_name || ' ' || m.last_name AS manager_name,
       m.hire_date AS manager_hire_date
FROM employee e
JOIN employee m
ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

COMMIT;