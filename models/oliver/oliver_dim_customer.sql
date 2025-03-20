{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

select
customer_id AS cust_key,
customer_id,
first_name,
last_name,
email,
phone_number,
state
FROM {{ source('oliver_landing', 'customer')}}