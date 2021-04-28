DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments
(
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL
);

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager
(
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

CREATE EXTENSION btree_gist;
ALTER TABLE "titles" ADD CONSTRAINT "overlap_date_range"
EXCLUDE  USING gist
   ( emp_no WITH =,
     daterange(from_date, to_date, '[]') WITH &&
   );

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM salaries 
INNER JOIN employees ON
employees.emp_no = salaries.emp_no;

-- DATA ANALYSIS -- 

-- List the following details of each employee: --
-- employee number, last name, first name, gender, and salary --
SELECT EMPLOYEES.employee_number,
	EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname,
	EMPLOYEES.employee_gender,
	SALARIES.employee_salary
FROM EMPLOYEES
INNER JOIN SALARIES
ON SALARIES.employee_number = EMPLOYEES.employee_number;

-- List employees who were hired in 1986 --
SELECT EMPLOYEES.employee_number,
	EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname,
	EMPLOYEES.employee_gender,
	EMPLOYEES.employee_hiredate
FROM EMPLOYEES
INNER JOIN SALARIES
ON SALARIES.employee_number = EMPLOYEES.employee_number
WHERE EMPLOYEES.employee_hiredate LIKE '1986%';

-- List the manager of each department with the following information: --
-- department number, department name, the manager's employee number, --
-- last name, first name, and start and end employment dates --
SELECT DISTINCT DEPARTMENT_MANAGERS.department_number,
	DEPARTMENTS.department_name,
	DEPARTMENT_MANAGERS.employee_number,
	EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname,
	DEPARTMENT_MANAGERS.from_date,
	DEPARTMENT_MANAGERS.to_date
FROM EMPLOYEES
INNER JOIN DEPARTMENT_MANAGERS
ON EMPLOYEES.employee_number = DEPARTMENT_MANAGERS.employee_number
INNER JOIN DEPARTMENTS
ON DEPARTMENT_MANAGERS.department_number = DEPARTMENTS.department_number
ORDER BY employee_number;

-- List the department of each employee with the following information: --
-- employee number, last name, first name, and department name --
SELECT DISTINCT DEPARTMENT_EMPLOYEES.employee_number,
	EMPLOYEES.employee_firstname,
	EMPLOYEES.employee_lastname,
	DEPARTMENTS.department_name  
FROM DEPARTMENT_EMPLOYEES
JOIN EMPLOYEES
ON DEPARTMENT_EMPLOYEES.employee_number = EMPLOYEES.employee_number
JOIN DEPARTMENTS
ON  DEPARTMENT_EMPLOYEES.department_number = DEPARTMENTS.department_number
ORDER BY employee_number;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname
FROM EMPLOYEES
WHERE EMPLOYEES.employee_firstname LIKE 'Hercules' 
AND EMPLOYEES.employee_lastname LIKE 'B%';

-- List all employees in the Sales department, including their: --
-- employee number, last name, first name, and department name --
SELECT DISTINCT EMPLOYEES.employee_number,
	EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname,
	DEPARTMENTS.department_name
FROM EMPLOYEES
JOIN DEPARTMENT_EMPLOYEES
ON EMPLOYEES.employee_number = DEPARTMENT_EMPLOYEES.employee_number
JOIN DEPARTMENTS
ON DEPARTMENTS.department_number = DEPARTMENT_EMPLOYEES.department_number
WHERE DEPARTMENTS.department_name = 'Sales'
ORDER BY employee_number;

-- List all employees in the Sales and Development departments, including -- 
-- their employee number, last name, first name, and department name --
SELECT DISTINCT EMPLOYEES.employee_number,
	EMPLOYEES.employee_lastname,
	EMPLOYEES.employee_firstname,
	DEPARTMENTS.department_name
FROM EMPLOYEES
JOIN DEPARTMENT_EMPLOYEES
ON EMPLOYEES.employee_number = DEPARTMENT_EMPLOYEES.employee_number
JOIN DEPARTMENTS
ON DEPARTMENTS.department_number = DEPARTMENT_EMPLOYEES.department_number
WHERE DEPARTMENTS.department_name = 'Sales'
OR DEPARTMENTS.department_name = 'Development'
ORDER BY employee_number;

-- In descending order, list the frequency count of employee last names --
SELECT EMPLOYEES.employee_lastname,
	COUNT(EMPLOYEES.employee_number)