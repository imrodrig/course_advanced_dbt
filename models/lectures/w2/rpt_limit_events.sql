SELECT
    session_id,
    created_at,
    user_id,
    event_name,
    event_id

FROM {{ ref('stg_bingeflix__events') }}

WHERE
    {{ limit_data_in_nonprd(ref_date = 'created_at') }}
