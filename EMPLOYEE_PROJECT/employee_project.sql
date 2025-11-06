show databases;
create database Employee_project;
show databases;
use employee_project;

CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(30) NOT NULL,
    DLOC VARCHAR(30) NOT NULL
);
desc dept;

CREATE TABLE EMPLOYEE (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(30) NOT NULL,
    MGR_NO INT,
    HIREDATE DATE,
    SAL DECIMAL(10,2),
    DEPTNO INT,
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);
desc employee;

CREATE TABLE PROJECT (
    PNO INT PRIMARY KEY,
    PLOC VARCHAR(30) NOT NULL,
    PNAME VARCHAR(30) NOT NULL
);
desc project;

CREATE TABLE ASSIGNED_TO (
    EMPNO INT,
    PNO INT,
    JOB_ROLE VARCHAR(30),
    PRIMARY KEY (EMPNO, PNO),
    FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO),
    FOREIGN KEY (PNO) REFERENCES PROJECT(PNO)
);
desc assigned_to;

CREATE TABLE INCENTIVES (
    EMPNO INT,
    INCENTIVE_DATE DATE,
    INCENTIVE_AMOUNT DECIMAL(10,2),
    PRIMARY KEY (EMPNO, INCENTIVE_DATE),
    FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO)
);

INSERT INTO DEPT VALUES
(10, 'Sales', 'Bengaluru'),
(20, 'Accounting', 'Hyderabad'),
(30, 'Research', 'Mysuru'),
(40, 'Operations', 'Chennai'),
(50, 'HR', 'Mumbai'),
(60, 'IT', 'Delhi');
select * from dept;

INSERT INTO EMPLOYEE VALUES
(1001, 'Alice', NULL, '2019-02-10', 75000, 10),
(1002, 'Bob', 1001, '2020-06-01', 65000, 20),
(1003, 'Charlie', 1001, '2018-09-15', 80000, 30),
(1004, 'Diana', 1002, '2021-01-20', 55000, 40),
(1005, 'Ethan', 1003, '2022-07-12', 60000, 50),
(1006, 'Fay', 1001, '2023-03-05', 52000, 10);
select * from employee;

INSERT INTO PROJECT VALUES
(200, 'Bengaluru', 'Alpha'),
(201, 'Hyderabad', 'Beta'),
(202, 'Mysuru', 'Gamma'),
(203, 'Chennai', 'Delta'),
(204, 'Mumbai', 'Epsilon'),
(205, 'Pune', 'Zeta');
select * from project;

INSERT INTO ASSIGNED_TO VALUES
(1001, 200, 'Lead'),
(1002, 201, 'Analyst'),
(1003, 202, 'Senior'),
(1004, 203, 'Support'),
(1005, 204, 'Recruiter'),
(1006, 200, 'Developer'),
(1002, 203, 'Tester'),
(1003, 200, 'Consultant');
select * from assigned_to;

INSERT INTO INCENTIVES VALUES
(1001, '2024-01-15', 1500.00),
(1002, '2024-02-10', 1200.00),
(1003, '2024-03-05', 1800.00),
(1005, '2024-05-20', 1000.00),
(1006, '2024-06-18', 900.00),
(1001, '2024-07-01', 500.00);
select * from incentives;

SELECT DISTINCT a.EMPNO
FROM ASSIGNED_TO a
JOIN PROJECT p ON a.PNO = p.PNO
WHERE p.PLOC IN ('Bengaluru','Hyderabad','Mysuru');

SELECT e.EMPNO
FROM EMPLOYEE e
LEFT JOIN INCENTIVES i ON e.EMPNO = i.EMPNO
WHERE i.EMPNO IS NULL;

SELECT e.ENAME, e.EMPNO, e.DEPTNO, a.JOB_ROLE,
       d.DLOC AS DEPT_LOCATION, p.PLOC AS PROJECT_LOCATION
FROM EMPLOYEE e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
JOIN ASSIGNED_TO a ON e.EMPNO = a.EMPNO
JOIN PROJECT p ON a.PNO = p.PNO
WHERE d.DLOC = p.PLOC;

      -- MORE QUERIES --

select e.Ename as manager_name, count(m.EmpNo) as Num_Employees 
from Employee e 
Join Employee m on e.EmpNo = m.Mgr_no
Group by e.EName 
having count(m.EmpNo)=(
select max(cnt)
from (
select count(Mgr_No) as cnt 
from Employee 
where Mgr_No is not null 
Group by Mgr_No
) as temp
);

select e.EName as Manager_Name 
from Employee e 
where e.EmpNo in (select distinct Mgr_No from Employee where Mgr_No is not null)
and e.sal > (
select avg(s.sal)
from employee s 
where s.Mgr_no = e.empNo
);  

select e.ename as second_level_manager,d.dname as department 
from employee e 
join dept d on e.deptno = d.deptno
where e.mgr_no in (
select empno from employee where mgr_no is null
);

select empno,incentive_date,incentive_amount
from incentives
where year(incentive_date)= 2019 and month(incentive_date)=1
order by incentive_amount desc 
limit 1 offset 1;

select e.ename as employee_name,m.ename as manager_name ,
d.dname as department 
from employee e 
join employee m on e.mgr_no = m.empno
join dept d on e.deptno = d.deptno 
where e.deptno = m.deptno;
