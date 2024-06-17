SELECT
    CASE 
        WHEN u1.posts < u2.posts THEN u1.user_name
        ELSE u2.user_name
    END AS u1_name,
    CASE 
        WHEN u1.posts < u2.posts THEN u2.user_name
        ELSE u1.user_name
    END AS u2_name
FROM
    followers f1
    JOIN followers f2 ON f1.user_id_fk = f2.following_user_id_fk AND f1.following_user_id_fk = f2.user_id_fk
    JOIN users u1 ON f1.user_id_fk = u1.user_id
    JOIN users u2 ON f1.following_user_id_fk = u2.user_id
WHERE
    u1.user_id < u2.user_id
ORDER BY
    CASE 
        WHEN u1.posts < u2.posts THEN u1.user_id
        ELSE u2.user_id
    END;
