/*
2.	Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
*/
DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER //
CREATE PROCEDURE even_numbers
(
IN num INT -- входящий параметр, число N
)
BEGIN
    DECLARE n INT; 
    DECLARE result VARCHAR(45) DEFAULT " "; 
    SET n = 2;
    REPEAT                     
        SET result = CONCAT(result, n, ",");   
        SET n = n + 2;
        UNTIL n = num   -- Условие выхода из цикла UNTIL 
    END REPEAT;
    SELECT result;
END //
CALL even_numbers(10);



-- 2.	Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER //
CREATE PROCEDURE even_numbers
(
IN num INT -- входящий параметр, число N
)
BEGIN
    DECLARE n INT DEFAULT 1;
    DECLARE result VARCHAR(45) DEFAULT " "; 
    IF (num > 0 AND num <= 10) THEN
        WHILE (n <= num) DO
		    IF (n % 2 = 0) THEN
			    SET result = CONCAT(result, n, ","); 
		    END IF;
		    SET n = n + 1;
	    END WHILE;
    END IF;
	SELECT result;
END //

CALL even_numbers(10);
