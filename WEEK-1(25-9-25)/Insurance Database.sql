create database insurance_database;
use insurance_database;
create table person(
driver_id int primary key,
dname varchar(20),
address varchar(20)
);
desc person;

create table car(
reg_num int primary key,
model varchar(20),
year int);
 desc car;
 
 create table owns(
 driver_id int,
 reg_num int,
 primary key(driver_id,reg_num),
 foreign key(driver_id)references person(driver_id),
 foreign key(reg_num)references car(reg_num)
 );
 
 desc owns;
 
 
 create table accident(
 report_num int primary key,
 accident_date date,
 location varchar(20)
 );
 desc accident;
 
 
 create table participated(
 driver_id int,
 reg_num int,
 report_num int,
 damage_ammount int,
 primary key(driver_id,reg_num,report_num),
 foreign key(driver_id)references person(driver_id),
 foreign key(reg_num)references car(reg_num),
 foreign key(report_num)references accident(report_num)
 );
 
desc participated;




insert into person values(01,"Richard","Srinivas nagar");
insert into person values(02,"Pradeep","Rajaji nagar");
insert into person values(03,"smith","Ashok nagar");
insert into person values(04,"venu","N R Colony");
insert into person values(05,"jhon","Hanumanth nagar");



insert into car values(052250,"Indica",1990);
insert into car values(031181,"Lancer",1957);
insert into car values(095477,"Toyato",1998);
insert into car values(053408,"Honda",2008);
insert into car values(041702,"Audi",2005);


insert into owns values(01,052250);
insert into owns values(02,031181);
insert into owns values(03,095477);
insert into owns values(04,053408);
insert into owns values(05,041702);


insert into accident values(11,'2003-01-01',"Mysore Road");
insert into accident values(12,'2004-02-02',"south end circle");
insert into accident values(13,'2003-01-21',"Bull Temple Road");
insert into accident values(14,'2008-02-17',"Mysore Road");
insert into accident values(15,'2005-03-04',"Kanakpura Road");


insert into participated values(01,052250,11,10000);
insert into participated values(02,031181,12,50000);
insert into participated values(03,095477,13,25000);
insert into participated values(04,053408,14,3000);
insert into participated values(05,041702,15,5000);

update participated set damage_ammount=25000 
where  reg_num=53408 and report_num=14;

select *from participated;


insert into accident values(16,'2006-05-11',"Bellary");

select * from accident;
                                       
/*display accident date and location from accident relation*/
select accident_date,location from accident;


/*display driver id who did the accident damage greater than or equal to 25000*/
select driver_id from participated 
where damage_ammount>=25000;



/*Display the entire car relation in the ascending order of manufacturing year*/
select * from car 
order by year asc;



/*find the number of accidents in which car belonging to a specific model (examplke 'lancer') were involved*/
select count(report_num) as total_number_of_accidents from participated 
where reg_num in(select reg_num from car
where model="Lancer");  


/*find toatl number of people who owned cars that involved in accidents in 2008*/
select count(driver_id) as toatl_number_of_people from owns
where reg_num in(select reg_num from participated where report_num in
(select report_num from accident where year(accident_date)='2008'));



/*list the entire participated relation in the descending order of damage ammount*/
select * from participated order by damage_ammount desc;


/*find the average damage ammount*/
select avg(damage_ammount)
from participated;


/*fimd the maximum dammage ammount */
select max(damage_ammount) from participated;


/*delete the tuple whose damage ammount is below the average damage ammount */
delete from participated where damage_ammount<(select avg(damage_ammount)from participated);





