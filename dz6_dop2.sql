-- 2 Создать функцию, вычисляющей коэффициент популярности пользователя
-- (сколько раз какой-либо пользователь упоминается со статусом "approved")
USE dz_dop4;
SELECT * FROM friend_requests;

DROP FUNCTION IF EXISTS get_k;
DELIMITER //
CREATE FUNCTION get_k
(
num INT
)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE result INT DEFAULT 0;
	SELECT 
		(   
			SELECT count(f.id)
			FROM (
				SELECT fr.initiator_user_id AS id
				FROM friend_requests fr
				WHERE fr.target_user_id = u.id AND fr.status='approved'
				UNION
				SELECT fr.target_user_id 
				FROM friend_requests fr
				WHERE fr.initiator_user_id = u.id AND fr.status='approved'
			) f
		) AS `count_friends` INTO result
	FROM users u
    WHERE u.id = num;
    
    RETURN result;
END//
SELECT get_k(10);

