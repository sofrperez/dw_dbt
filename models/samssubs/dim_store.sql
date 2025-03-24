{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['storeid']) }} as store_key,
storeid,
address as storeaddress,
city as storecity,
state as storestate,
zip as storezip
FROM {{ source("samssubs_landing","store") }}