create Database TechSolutionsDB;
use TechSolutionsDB;

create table DEPARTMENT(
DeptId int primary key,
DeptName varchar(20) Not Null,
Location varchar(255));

Create table EMPLYOEE(
EmpId int primary key,
FirstName varchar(20),
LastName varchar(20),
Gender char(1),
Salary int,
HireDate date,
DeptId int,
Foreign Key (DeptId) references DEPARTMENT(DeptId));

Create table PROJECT(
ProjectId int primary key,
ProjectName varchar(255),
StartDate date,
EndDate date,
Budget decimal(2));

Create table Works_ON(
EmpId int,
ProjectId int, HoursWorked int,
Primary key (EmpId, ProjectId),
foreign key(EmpId) references EMPLYOEE(EmpId),
Foreign key(ProjectId) references PROJECT(ProjectId));

INSERT INTO DEPARTMENT (DeptId, DeptName, Location)
VALUES
(1, 'IT', 'Kathmandu'),
(2, 'HR', 'Lalitpur'),
(3, 'Finance', 'Bhaktapur'),
(4, 'Marketing', 'Pokhara');

INSERT INTO EMPLYOEE (EmpId, FirstName, LastName, Gender, Salary, HireDate, DeptId)
VALUES
(101, 'Anisha', 'Shrestha', 'F', 50000, '2022-03-15', 1),
(102, 'Ramesh', 'Karki', 'M', 45000, '2021-07-10', 2),
(103, 'Sita', 'Gurung', 'F', 48000, '2023-01-20', 3),
(104, 'Amit', 'Thapa', 'M', 52000, '2020-11-05', 1),
(105, 'Nisha', 'Rai', 'F', 47000, '2022-09-12', 4);

INSERT INTO PROJECT (ProjectId, ProjectName, StartDate, EndDate, Budget)
VALUES
(1, 'Website Development', '2024-01-10', '2024-04-15', 50),
(2, 'Mobile App System', '2024-02-01', '2024-06-30', 75),
(3, 'Database Upgrade', '2024-03-05', '2024-05-20', 60),
(4, 'Cloud Migration', '2024-04-01', '2024-08-10', 80),
(5, 'Security Enhancement', '2024-05-12', '2024-09-25', 90);

INSERT INTO Works_ON (EmpId, ProjectId, HoursWorked)
VALUES
(101, 1, 40),
(102, 2, 35),
(103, 3, 30),
(104, 4, 45),
(105, 5, 38);

UPDATE EMPLYOEE
SET Salary = Salary * 1.10
WHERE EmpId = 102;

Select * from Project where ProjectId = 5;
Delete from PROJECT where ProjectId= 5;
DELETE FROM Works_ON
WHERE ProjectId = 5;

Select * from EMPLYOEE where Salary > 50000;
Select FirstName, LastName, Salary from EMPLYOEE 
order by Salary desc;

SELECT * FROM EMPLYOEE
WHERE DeptId = (
SELECT DeptId FROM DEPARTMENT
WHERE DeptName = 'IT'
);

SELECT DeptID, COUNT(*) AS TotalEmployee
FROM EMPLYOEE GROUP BY DeptID;

SELECT * FROM EMPLYOEE WHERE HireDate > '2022-01-01';

SELECT e.FirstName, e.LastName, d.DeptName
FROM EMPLYOEE e Join DEPARTMENT d
ON e.DeptId = d.DeptId;

SELECT e.FirstName, e.LastName, p.ProjectName
FROM EMPLYOEE e
JOIN Works_ON w
ON e.EmpId = w.EmpId
JOIN PROJECT p
ON w.ProjectId = p.ProjectId;

SELECT DeptId, AVG(Salary) AS AverageSalary
FROM EMPLYOEE
GROUP BY DeptId;

SELECT d.DeptName, AVG(e.Salary) AS AverageSalary
FROM EMPLYOEE e
JOIN DEPARTMENT d
ON e.DeptId = d.DeptId
GROUP BY d.DeptName;

SELECT DeptId, COUNT(*) AS TotalEmployee
FROM EMPLYOEE
GROUP BY DeptId
ORDER BY TotalEmployee DESC
LIMIT 1;

SELECT d.DeptName, COUNT(e.EmpId) AS TotalEmployee
FROM EMPLYOEE e
JOIN DEPARTMENT d
ON e.DeptId = d.DeptId
GROUP BY d.DeptName
ORDER BY TotalEmployee DESC
LIMIT 1;

SELECT * From EMPLYOEE WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLYOEE);
    
CREATE VIEW HighSalaryEmployee AS
SELECT * FROM EMPLYOEE
WHERE Salary > 60000;

SELECT * FROM HighSalaryEmployee;

CREATE Index idx_lastname
ON EMPLYOEE (LastName);










