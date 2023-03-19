-- В базе данных “MyFunkDB”
-- Выполните ряд записей вставки в виде транзакции в хранимой процедуре. 
-- Если такой сотрудник имеется откатите базу данных обратно.

use  MyFunkDB;

select * from employees;

select * from owns_data;

select * from personals_data;
------------------------------

-- Выполните ряд записей вставки в виде транзакции в хранимой процедуре.
DELIMITER /
drop procedure transactMyFunkDB;/
 
create procedure transactMyFunkDB 
(IN name varchar(20), IN phone varchar(15), 
 IN salary mediumint, IN position varchar(20), 
 IN status varchar(10), IN Date date, IN address varchar(50))
 
begin
declare id smallint;
start transaction;
        insert employees(full_name, telephone)
        value( name, phone);
        
        insert owns_data(salary, position)
        value(salary, position);
        
        insert personals_data(family_status, birthday, address)
        value(status, Date, address);
commit;        
end /

call transactMyFunkDB('Скорик С.Ф.', '066-108-44-33', '21500', 'менеджер', 'холост', '2002-05-02', 'Сумы, ул.Победы,36'); /

call transactMyFunkDB('Запорожец Г.Я.', '099-878-61-16', '21200', 'рабочий', 'женат', '1989-09-03', 'Сумы, ул.Б.Панасовская,245'); /


select * from employees;/

select * from owns_data;/

select * from personals_data;/
------------------------------------------------------------

-- Если такой сотрудник имеется откатите базу данных обратно.
drop procedure transactEmployees;/

create procedure transactEmployees 
(IN name varchar(20), IN phone varchar(15), 
 IN salary mediumint, IN position varchar(20), 
 IN status varchar(10), IN Date date, IN address varchar(50))
 
begin
declare id smallint;
start transaction;
        insert employees(full_name, telephone)
        value(name, phone);
        SET id = @@IDENTITY;
        
        insert owns_data(salary, position)
        value(salary, position);
        
        insert personals_data(family_status, birthday, address)
        value(status, Date, address);
        
if exists(select * from employees WHERE full_name = name and id_number != id)
			then
				rollback; 
			end if;	
        
commit;        
end /

-- т.к. такой сотрудник уже имеется в базе данных, то мы его не сможем повторно добавить
call transactEmployees('Сергеев В.С.', '067-608-45-93', '35000', 'директор', 'женат', '1975-03-27', 'Сумы, пр.Шевченко,78'); /
call transactEmployees('Федоров А.Н.', '095-345-12-70', '22000', 'менеджер', 'женат', '1991-11-14', 'Сумы, ул.Киевская,33'); /

select * from employees;/

-- но мы можем добавлять нового сотрудника
call transactEmployees('Бодник М.Р.', '050-112-38-39', '22000', 'рабочий', 'женат', '1980-01-16', 'Сумы, пер.Заводской,43'); /


select * from employees;/

select * from owns_data;/

select * from personals_data;/
