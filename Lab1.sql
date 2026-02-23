Create database depatrtment;
use class;

Create table Dept( DeptNo INT Primary key,
DName varchar(255),
Loc varchar(255));

select * from Dept;
Rename table Dept to Department;
Alter table Department
Add Column PINCODE Int Not Null default 0 ;

Alter table Department
change Dname Dept_Name varchar (20);

Alter table Department
modify Loc Char(20);
drop table Department;










