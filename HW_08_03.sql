-- В базе данных “MyFunkDB” создать 3 таблицы: 
-- В 1-й содержатся имена и номера телефонов сотрудников некоторой компании. 
-- Во 2-й содержатся ведомости об их зарплате, и должностях: главный директор, менеджер, рабочий. 
-- В 3-й данные семейном положении, дате рождения, где они проживают.

drop database MyFunkDB;

create database MyFunkDB;

use  MyFunkDB;

create table employees
(
	id_number smallint auto_increment PRIMARY KEY,
	full_name varchar(20) Not Null,
    telephone varchar(15) Not Null
);

insert into employees(id_number, full_name, telephone)
values (1, 'Сергеев В.С.', '067-608-45-93'),
	   (2, 'Федоров А.Н.', '095-345-12-70'),
	   (3, 'Носов Б.А.', '073-777-45-88');

select * from employees;
------------------------
create table owns_data
(
	id_number smallint auto_increment PRIMARY KEY,
	salary mediumint Not Null,
	position varchar(20) Not Null
);

alter table owns_data
add constraint FK_OwnEmployee
foreign key(id_number) references employees(id_number);

insert into owns_data(id_number, salary, position)
values (1, 35000, 'директор'),
	   (2, 22000, 'менеджер'),
	   (3, 20500, 'рабочий');	

select * from owns_data;
---------------------------

create table personals_data
(
	id_number smallint auto_increment PRIMARY KEY,
	family_status varchar(10) Not Null,
    birthday date Not Null,
    address varchar(50) Not Null
);

alter table personals_data
add constraint FK_PersonEmployee
foreign key(id_number) references employees(id_number);

insert into personals_data(id_number, family_status, birthday, address)
values  (1, 'женат', '1975-03-27', 'Сумы, пр.Шевченко,78'),
		(2, 'женат', '1991-11-14', 'Сумы, ул.Киевская,33'),
		(3, 'холост', '1998-06-28', 'Сумы, ул.Одесская,12');

select * from personals_data;