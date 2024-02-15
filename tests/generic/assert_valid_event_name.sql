-- We have an issue with some test events appearing in our data source that we want to be notified about
-- This returns records where the event name contains 'test'
-- SELECT * FROM {{ ref ('stg_bingeflix__events') }}
-- WHERE lower(event_name) LIKE '%test%'

{%- test assert_valid_event_name(model, column_name, value) %}

SELECT *
FROM {{ model }}
WHERE lower({{ column_name }}) LIKE '{{ value }}'

{%- endtest %}
