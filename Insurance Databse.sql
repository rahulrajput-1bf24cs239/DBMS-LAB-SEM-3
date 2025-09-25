show databases;
create database IF NOT exists Insurance;
show databases;
use insurance;

create table Person (
driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
desc Person;

create table Car(
reg_num varchar(10),
model varchar(10),
year int ,
primary key(reg_num));
desc Car;

create table Accident (
report_num int, 
accident_date date,
location varchar(20),
primary key(report_num));
desc Accident;

create table Owns (
driver_id varchar(10),
reg_num varchar(10),
primary key (driver_id,reg_num),
foreign key(driver_id) references Person(driver_id),
foreign key(reg_num) references Car(reg_num));
desc Owns;

create table Participated(driver_id varchar(10),
reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc Participated;

insert into Person(driver_id,name,address)
values("A01","Richard","Srinivas nagar");
insert into Person(driver_id,name,address)
values("A02","Pradeep","Rajaji nagar");
insert into Person(driver_id,name,address)
values("A03","Smith","Ashok nagar");
insert into Person(driver_id,name,address)
values("A04","Veno","NR COLONY");
insert into Person(driver_id,name,address)
values("A05","Jhon","Hanumanthanagar");
commit;
select * from Person;


insert into Car(reg_num,model,year)
values("KA052250","Indica",1990);
insert into Car(reg_num,model,year)
values("KA031181","Lancer",1957);
insert into Car(reg_num,model,year)
values("KA095477","Toyota",1998);
insert into Car(reg_num,model,year)
values("KA053408","Honda",2008);
insert into Car(reg_num,model,year)
values("KA041702","Audi",2005);
commit;
select * from Car;

insert into Owns(driver_id,reg_num)
values("A01","KA052250");
insert into Owns(driver_id,reg_num)
values("A02","KA053408");
insert into Owns(driver_id,reg_num)
values("A03","KA031181");
insert into Owns(driver_id,reg_num)
values("A04","KA095477");
insert into Owns(driver_id,reg_num)
values("A05","KA041702");
commit;
select * from Owns;

insert into Accident(report_num,accident_date,location)
values(11,"01-01-03","Mysore Road");
insert into Accident(report_num,accident_date,location)
values(12,"02-02-04","South end Circle");
insert into Accident(report_num,accident_date,location)
values(13,"21-01-03","Bull temple Road");
insert into Accident(report_num,accident_date,location)
values(14,"01-01-03","Mysore Road");
insert into Accident(report_num,accident_date,location)
values(15,"01-01-03","Kanakpura Road");
commit;
select * from Accident;

insert into Participated(driver_id,reg_num,report_num,damage_amount)
values("A01","KA052250",11,10000);
insert into Participated(driver_id,reg_num,report_num,damage_amount)
values("A02","KA053408",12,50000);
insert into Participated(driver_id,reg_num,report_num,damage_amount)
values("A03","KA095477",13,25000);
insert into Participated(driver_id,reg_num,report_num,damage_amount)
values("A04","KA031181",14,3000);
insert into Participated(driver_id,reg_num,report_num,damage_amount)
values("A05","KA041702",11,5000);
commit;
select * from Participated;

update Participated set damage_amount=25000 where reg_num="KA053408" and report_num=12;
commit;
select * from Participated;

insert into accident values(16,"15-03-08","Domlur");
select * from Accident;

select Accident_date,location
from Accident;

select driver_id
from Participated
where damage_amount >=25000;




















