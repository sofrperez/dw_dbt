{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['ordermethod']) }} as ordermethod_key,
ordermethod
FROM {{ source("samssubs_landing","order") }}
