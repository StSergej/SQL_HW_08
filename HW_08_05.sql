-- Создайте триггер в базе данных “MyFunkDB”, 
-- который будет удалять записи со 2-й и 3-й таблиц перед удалением записей из таблиц сотрудников (1-й таблицы), 
-- чтобы не нарушить целостность данных.

use  MyFunkDB;

select * from employees;

select * from owns_data;

select * from personals_data;


drop trigger if exists delete_employees;

DELIMITER /
create trigger delete_employees
before delete on employees
for each row 
  begin
	delete from owns_data where id_number = OLD.id_number; 
	delete from personals_data where id_number = OLD.id_number;
  end; /
  
  select * from employees;/
  
  delete from employees where id_number = 8;/
  delete from employees where id_number = 4;/
  delete from employees where id_number = 5;/
  
select * from employees;/
select * from owns_data;/
select * from personals_data;/  
  
  