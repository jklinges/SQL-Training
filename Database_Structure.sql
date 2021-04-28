- DROP TABLE DEPARTMENT_EMPLOYEES;
-- DROP TABLE DEPARTMENT_MANAGERS;
-- DROP TABLE DEPARTMENTS;
-- DROP TABLE EMPLOYEES;
-- DROP TABLE SALARIES;
-- DROP TABLE TITLES;

CREATE TABLE EMPLOYEES (
    employee_number INTEGER NOT NULL,
    employee_birthdate VARCHAR(10) NOT NULL,
    employee_firstname VARCHAR(30) NOT NULL,
    employee_lastname VARCHAR(30) NOT NULL,
    employee_gender VARCHAR(10) NOT NULL,
    employee_hiredate VARCHAR(10) NOT NULL
);

CREATE TABLE DEPARTMENTS (
    department_number VARCHAR(10) NOT NULL,
    department_name VARCHAR(30) NOT NULL
);

CREATE TABLE DEPARTMENT_MANAGERS (
    department_number VARCHAR(10) NOT NULL,
    employee_number INTEGER NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL
);

CREATE TABLE DEPARTMENT_EMPLOYEES (
    employee_number INTEGER NOT NULL,
	department_number VARCHAR(10) NOT NULL,
    from_date VARCHAR(10) NOT NULL,
    to_date VARCHAR(10) NOT NULL
);

CREATE TABLE TITLES (
    employee_number INTEGER NOT NULL,
    title VARCHAR(30) NOT NULL,
    from_date VARCHAR(10) NOT NULL,
    to_date VARCHAR(10) NOT NULL
);

CREATE TABLE SALARIES (
    employee_number INTEGER NOT NULL,
    employee_salary INTEGER NOT NULL,
    from_date VARCHAR(10) NOT NULL,
    to_date VARCHAR(10) NOT NULL
);

