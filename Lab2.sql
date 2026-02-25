create database COMPANYDB;
use COMPANYDB;
create table DEPARTMENT(
DNAME varchar(20),
DNUMBER int primary Key,
MGRSSN varchar(15), 
MGRSTARTDATE date);
create table EMPLYOEE (
FNAME varchar(20),
MINIT char(1),
LNAME varchar(15),
SSN varchar(15) primary key,
BDATE date,
ADDRESS varchar(100),
SEX char(1),
SALARY int,
SUPERSSN varchar(15),
DNO int,
foreign key(DNO)
references DEPARTMENT(DNUMBER) 
);
Insert into DEPARTMENT
(DNAME, DNUMBER, MGRSSN, MGRSTARTDATE)values
('Human Resources', 1, '123456789', '2022-01-15'),
('Finance', 2, '234567890', '2021-03-10'),
('IT', 3, '345678901', '2020-07-01'),
('Marketing', 4, '456789012', '2023-05-20'),
('Operations', 5, '567890123', '2019-11-30');

INSERT INTO EMPLYOEE
(FNAME, MINIT, LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, SUPERSSN, DNO)
VALUES
('John', 'A', 'Smith', '111111111', '1990-02-15', 'New York, USA', 'M', 60000, NULL, 1),
('Sarah', 'B', 'Johnson', '222222222', '1988-07-22', 'California, USA', 'F', 65000, '111111111', 2),
('Michael', 'C', 'Brown', '333333333', '1992-11-05', 'Texas, USA', 'M', 55000, '111111111', 3),
('Emily', 'D', 'Davis', '444444444', '1995-03-18', 'Florida, USA', 'F', 50000, '222222222', 4),
('David', 'E', 'Wilson', '555555555', '1985-09-30', 'Nevada, USA', 'M', 70000, '222222222', 5),
('Sophia', 'F', 'Taylor', '666666666', '1993-12-12', 'Washington, USA', 'F', 62000, '333333333', 1);

select * from DEPARTMENT;
select * from EMPLYOEE;

#q1: 10% Salary Raise for research Department
SELECT E.FNAME, E.LNAME, 
E.SALARY * 1.1 AS increased_salary
FROM EMPLYOEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
WHERE D.DNAME = 'Research';
#2. Salary statistics of Accounts Department
# sum. max, min, avg for department adaministration
Select Sum(E.SALARY) AS TOTAL,
max(E.SALARY), min(E.SALARY),
avg(E.SALARY)
FROM EMPLYOEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
WHERE D.DNAME = 'Administration';
#q3: Emplyoees controlled by department no 5
Select FNAME,LNAME 
From EMPLYOEE E
where E.DNO =5;
#q4: Departments having At Least 2 Emplyoee
select D.DNAME, count(*) as Emp_count
from EMPLYOEE E
join DEPARTMENT D on E.DNO = D.DNUMBER
group by D.DNUMBER,D.DNAME
having count(*) >=2;
#q5: Emplyoees Born in 1990's (1985-1999)
select * from EMPLYOEE
where year(BDATE) between 1985 and 1999;

