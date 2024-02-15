-- tests/test_positive_user_logins.sql

SELECT *
FROM {{ ref('fct_active_users') }}
WHERE login_count < 0
