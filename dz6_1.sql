-- 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP FUNCTION IF EXISTS count_sec;
DELIMITER $$
CREATE FUNCTION count_sec
(
num_sec INT   
)
RETURNS VARCHAR(45)   -- возвращать будем 
DETERMINISTIC 
BEGIN
	DECLARE days, hours, minutes INT DEFAULT 0;
    SET minutes = num_sec DIV 60;
    SET num_sec = num_sec % 60;
    SET hours = minutes DIV 60;
    SET minutes = minutes % 60;
    SET days = hours DIV 24;
    SET hours = hours % 24;
RETURN concat(days, ' дней ', hours, ' часов ', minutes, ' минут ', num_sec, ' секунд ');    
END $$
SELECT count_sec(8451488);

