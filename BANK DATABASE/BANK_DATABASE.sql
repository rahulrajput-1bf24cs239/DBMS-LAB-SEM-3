create database bank_database;
use bank_database;

create table branch(
branch_name varchar(50),
branch_city varchar(50),
assests real,
primary key(branch_name)
);

create table bankAccount(
accno int,
branch_name varchar(50),
balance real,
primary key (accno),
foreign key(branch_name) references branch(branch_name)
);

create table bankCustomer(
customer_name varchar(50),
customer_street varchar(50),
customer_city varchar(50) ,
primary key (customer_name)
);

create table depositor(
 customer_name varchar(50),
 accno int,
primary key (customer_name,accno),
foreign key(customer_name) references bankCustomer(customer_name),
foreign key(accno) references bankAccount(accno)
);
desc depositor;

create table loan(
loan_number int,
branch_name varchar(50),
amount real,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name)
);

insert into branch values('SBI_chamrajpet','bangalore',50000);
insert into branch values('SBI_residencyroad','bangalore',10000);
insert into branch values('SBI_shivajiroad','bombay',20000);
insert into branch values('SBI_parliamentroad','delhi',10000);
insert into branch values('SBI_jantarmantar','delhi',20000);
select*from branch;

insert into bankAccount values(1,'SBI_chamrajpet',2000);
insert into bankAccount values(2,'SBI_residencyroad',5000);
insert into bankAccount values(3,'SBI_shivajiroad',6000);
insert into bankAccount values(4,'SBI_parliamentroad',9000);
insert into bankAccount values(5,'SBI_jantarmantar',8000);
insert into bankAccount values(6,'SBI_shivajiroad',4000);
insert into bankAccount values(7,'SBI_residencyroad',4000);
insert into bankAccount values(8,'SBI_parliamentroad',3000);
insert into bankAccount values(9,'SBI_residencyroad',5000);
insert into bankAccount values(10,'SBI_jantarmantar',2000);
insert into bankAccount values(11,'SBI_jantarmantar',2000);
select*from bankAccount;

insert into bankCustomer values('Avinash','Bull Temple Road','Bengaluru');
insert into bankCustomer values('Dinesh','Bannerghata Road','Bengaluru');
insert into bankCustomer values('Mohan','National College Road','Bengaluru');
insert into bankCustomer values('Nikhil','Akbar Road','Delhi');
insert into bankCustomer values('Ravi','Prithviraj Road','Delhi');
select*from bankCustomer;

insert into loan values (1,'SBI_chamrajpet',1000);
insert into loan values (2,'SBI_ResidencyRoad',2000);
insert into loan values (3,'SBI_ShivajiRoad',3000);
insert into loan values (4,'SBI_ParliamentRoad',4000);
insert into loan values (5,'SBI_Jantarmantar',5000);
select*from loan;

insert into depositor values ('Avinash',1);
insert into depositor values ('Dinesh',2);
insert into depositor values ('Nikhil',4);
insert into depositor values ('Ravi',5);
insert into depositor values ('Avinash',8);
insert into depositor values ('Nikhil',9);
insert into depositor values ('Dinesh',10);
insert into depositor values ('Nikhil',11);
select*from depositor;

select branch_name , round(assests/100000,2) as
"assests in lakhs" from branch;

select customer_name,branch_name from depositor,
bankAccount where depositor.accno = bankAccount.accno
group by customer_name,branch_name
having count(depositor.accno)>=2;

create view BranchLoanSummary as
select branch_name,sum(amount) as total_loan_amount
from loan group by branch_name;
select * from BranchLoanSummary;

select d.customer_name from depositor d,bankAccount b,branch br
where d.accno=b.accno
and b.branch_name=br.branch_name
and br.branch_city = 'Delhi'
group by d.customer_name
having count(distinct br.branch_name)=(select count(*) from 
branch where branch_city='Delhi');

select customer_name from bankCustomer where
customer_name not in (select customer_name from depositor);

select distinct d.customer_name from depositor d,bankAccount b,
loan l where d.accno=b.accno and 
b.branch_name = l.branch_name and 
branch_name in (select branch_name from branch where
branch_city='bangalore');

select branch_name from branch where assests > all(select assests
from branch where branch_city='bangalore');

delete from bankAccount where branch_name in (
select branch_name from branch where branch_city='bengaluru');

update bankAccount 
set balance=balance*1.05;