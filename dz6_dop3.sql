-- 3 Создать процедуру для добавления нового пользователя с профилем
USE dz_dop4;
SELECT * FROM users;
SELECT * FROM profiles;
DROP PROCEDURE IF EXISTS add_user;
DELIMITER $$
CREATE PROCEDURE add_user
( 
    IN firstname VARCHAR(50),
    IN lastname VARCHAR(50),
    IN email VARCHAR(120),
    IN gender CHAR(1),
    IN birthday DATE,
    IN hometown VARCHAR(100),
    IN photo_body text,
  	IN photo_filename VARCHAR(255),
    OUT user_id INT
)
BEGIN
    DECLARE media_id INT;
    DECLARE media_type_id INT;
	
    INSERT INTO users(firstname, lastname, email)
    VALUES
    (firstname, lastname, email);
	SET user_id = LAST_INSERT_ID();
        
    IF photo_body IS NOT NULL OR photo_filename IS NOT NULL THEN
		SELECT id INTO media_type_id
		FROM media_types
		WHERE name_type = "Photo"
		LIMIT 1;
        
		INSERT INTO media(user_id, media_type_id, body, filename)
		VALUES
		(user_id, media_type_id, photo_body, photo_filename);
		SET media_id = LAST_INSERT_ID();
	
    END IF;
    
    INSERT INTO profiles
    VALUES
    (user_id, gender, birthday, media_id, hometown);
    
END$$

CALL add_user("Лев", "Толстой", "tolstoy@gmail.com", "m", '1828-09-09', "test", "test", "test", @user_id);

SELECT *
FROM users
LEFT JOIN profiles
ON users.id = profiles.user_id
LEFT JOIN media
ON profiles.photo_id = media.id
AND users.id = media.user_id
WHERE users.id = @user_id;