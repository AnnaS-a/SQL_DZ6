-- 1. Создать процедуру, которая решает следующую задачу
-- Выбрать для одного пользователя 5 пользователей в случайной комбинации, которые удовлетворяют хотя бы одному критерию:
-- а) из одного города
-- б) состоят в одной группе
-- в) друзья друзей	
USE dz_dop4;
SELECT * FROM users;
SELECT * FROM profiles;
SELECT * FROM users_communities;
SELECT * FROM friend_requests;


DROP PROCEDURE IF EXISTS get_users;
DELIMITER $$
CREATE PROCEDURE get_users
(
IN num INT 
)
BEGIN 
    SELECT find.id
    FROM
    (
        SELECT id FROM users u
        JOIN profiles p
        ON u.id = p.user_id 
        AND (
            SELECT p.hometown FROM users u 
            JOIN profiles p
            ON u.id = p.user_id AND u.id = num
            ) = p.hometown
		UNION
        SELECT DISTINCT u.id FROM users u
        JOIN  users_communities uc
        ON u.id = uc.user_id
        WHERE uc.community_id
        IN (
          SELECT community_id FROM users_communities uc
          WHERE uc.user_id = num
        ) 
        UNION
        SELECT id FROM users u 
        WHERE u.id
        IN (
          SELECT initiator_user_id AS id
          FROM friend_requests fr 
          WHERE fr.status = "approved"
          AND target_user_id IN(
            SELECT initiator_user_id FROM friend_requests fr 
            WHERE target_user_id = num AND status = "approved"
            UNION ALL
            SELECT target_user_id FROM friend_requests fr 
            WHERE initiator_user_id = num AND status = "approved"
          )
          UNION
          SELECT target_user_id FROM friend_requests fr 
          WHERE status = "approved" AND initiator_user_id IN(
            SELECT initiator_user_id FROM friend_requests fr
            WHERE target_user_id = num AND status = "approved"
            UNION ALL
            SELECT target_user_id FROM friend_requests fr 
            WHERE initiator_user_id = num AND status = "approved"
          )
       )
) find
ORDER BY RAND() LIMIT 5;
END $$

CALL get_users(7); 
