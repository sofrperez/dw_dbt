{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['page_url']) }} as webpage_key,
page_url
FROM {{ source("web_analytics_landing","web_traffic_events")}}
