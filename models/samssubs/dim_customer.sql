{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_key,
customerid,
customerfname as custfname,
customerlname as custlname,
customerbday as custbirthdate,
customerphone as custphone
FROM {{ source("samssubs_landing", "customer") }}