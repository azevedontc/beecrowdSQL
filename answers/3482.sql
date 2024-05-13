SELECT
    LEAST(u1.user_name, u2.user_name) AS u1_name,
    GREATEST(u1.user_name, u2.user_name) AS u2_name
FROM
    followers f1
    JOIN followers f2 ON f1.user_id_fk = f2.following_user_id_fk
    JOIN users u1 ON f1.user_id_fk = u1.user_id
    JOIN users u2 ON f2.following_user_id_fk = u2.user_id
WHERE
    f1.following_user_id_fk = f2.user_id_fk
    AND u1.posts < u2.posts
ORDER BY
    u1.user_id;
