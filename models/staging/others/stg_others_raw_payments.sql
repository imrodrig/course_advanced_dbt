WITH source AS (

    SELECT * FROM {{ ref('raw_payments') }}

),

renamed AS (

    SELECT
        id,
        order_id,
        payment_method,
        amount

    FROM source

)

SELECT * FROM renamed
