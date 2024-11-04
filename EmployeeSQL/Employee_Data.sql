--Create Departments Table
CREATE TABLE "departments" (
    "dept_no" varchar(20)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

--Create Dept_Emp Table
CREATE TABLE "dept_emp" (
    "emp_no" varchar(20)   NOT NULL,
    "dept_no" varchar(20)   NOT NULL
);

--Create Dept_Manager Table
CREATE TABLE "dept_manager" (
    "dept_no" varchar(20)   NOT NULL,
    "emp_no" varchar(20)   NOT NULL
);

--Create Employees Table
CREATE TABLE "employees" (
    "emp_no" varchar(20)   NOT NULL,
    "emp_title_id" varchar(20)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" varchar(10)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

--Create Salaries Table
CREATE TABLE "salaries" (
    "emp_no" varchar(20)   NOT NULL,
    "salary" int   NOT NULL
);

--Create Titles Table
CREATE TABLE "titles" (
    "title_id" varchar(20)   NOT NULL,
    "title" varchar(20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_manager" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


--1. List the following details for each employee: 
-- employee number, last name, first name, sex and salary
SELECT emp.emp_no as employee_number, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees as emp
LEFT JOIN salaries as sal
ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;

--2. List the following details for employees hired in 1986: 
-- last name, first name and hire date
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986/01/01' AND '1986/12/31';

--3. List the following details for each manager of each department: 
-- manager, department number, department name, employee number, last name and first name
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments AS d
JOIN dept_manager AS dm 
	ON (d.dept_no = dm.dept_no)
JOIN employees AS e
	ON (dm.emp_no = e.emp_no);

--4. List the following details for each employee of each department: 
-- department number, department name, employee number, last name and first name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_no
FROM employees AS e
JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
JOIN departments AS d
	ON (de.dept_no = d.dept_no);

--5. List the following details for any employee with the name "Hercules" and last name beginning with the letter "B": 
-- first anme, last name and sex
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List the following details for any employee in the Sales Department: 
-- employee number, last name, first name and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

--7. List the following details for any employee in the Sales and Development Departments: 
-- employee number, last name, first name and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

--8. In descending order - List frequency counts of all employee last names. (i.e. how many employees share each last name):
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;
