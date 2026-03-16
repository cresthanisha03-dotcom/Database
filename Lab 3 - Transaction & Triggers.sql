#1 create a db named BankDB
# and create a table accounts with the fields: account_id,
#account_holder, balance.

Create database BankDB;
Use BankDB;

Create table accounts(
account_id int primary Key,
account_holder varchar (100),
balance decimal(10,2));

insert into accounts values
(1, 'Hareshiva', 500000),
(2, 'Sabetidevi', 200000),
(3, 'Kanchana', 100000);

# Write a transaction that transfers Rs 5000 from
# Hareshiva's accounts to Kanchana's account.
start transaction;
update accounts 
set balance = balance - 5000
where account_id = 1;
update accounts
set balance = balance + 5000
where account_id = 3;
commit;


# Write a transaction that transfers Rs 10000 from
# Sabetidevi's accounts to Kanchana's account.
#demonstrate the use of rollback.
start transaction;
update accounts 
set balance = balance - 10000
where account_id = 2;
update accounts
set balance = balance + 10000
where account_id = 3;
rollback;


# write a transaction that demonstrates the use of 
# SAVEPOINT while updating acccount balances.
start transaction;
update accounts
set balance = balance - 2000
where account_id = 1;
savepoint sp1;
update accounts set balance = balance + 2000
where account_id = 2;
rollback to sp1;
commit;

# Triggers 
# 1 create a table emplyoees
# with the fields: emp_id, name, salary.
create table emplyoees(
emp_id int primary key,
name varchar (25),
salary decimal (10,2));

# 2. create another table salary_log to record emplyoee
# salary changes with fields: log_id, emp_id,
# old_salary, new_salary, updated_at.
create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10,2),
new_salary decimal(10,2),
updated_at timestamp default current_timestamp);

# create a BEFORE INSERT TRIGGER on emplyoees
# that prevents inserting emplyoee whose 
# salary is less tahn 10000.
Delimiter $$
 create trigger check_salary
 before insert on employees
 for each row
 begin
 if new.salary < 10000 then
 signal sqlstate '45000'
 set message_text = 'salary must be atleast 10000';
 end if ;
 end $$
Delimiter ;

Delimiter $$
create trigger log_salary_update
after update on emplyoees
for each row
begin
insert into salary_log(emp_id, old_salary, new_salary)
values (old.emp_id, old.salary, new.salary);
end $$
Delimiter ;

#stored procedure
# create a stored procedure that retrieves
# all records drom the emplyoees table.
Delimiter $$
create procedure getEmplyoees()
begin
select * from emplyoees;
end $$
Delimiter ;
call getEmplyoeees();

# create a stored procedure that inserts
# a new emplyoee into the emplyoees table
# using parameters
Delimiter $$
create procedure addEmplyoee(
IN p_id int,
In p_name varchar(100),
In p_salary decimal (10,2))
begin
insert into emplyoees values
(p_id, p_name, p_salary);
end $$
Delimiter ;
call addEmplyoee (5, 'Kanchana', 100000);

#3 create a stored procedure that updates the
# salary of an emplyoee based on emplyoee ID.
Delimiter $$
create procedure update_salary(
in p_id int, in new_salary decimal(10,2))
begin
update emplyoees
set salary = new_salary
where emp_id = p_id;
end $$
Delimiter ;
call updateSalary(3 ,300000);

#4 create a stored procedure that transfers
# money between two accounts using a transaction.
Delimiter $$
create procedure tansfersMoney(
in form_account int, in to_account int,
in amount decimal)
begin
start transaction;
Update accounts
set balance = balance - amount
where account_id = form_account;
update accounts
set balance = balance + amount
where account_id = form_account;
commit;
end $$
Delimiter ;
call trabsferMoney(1,2,5000);






