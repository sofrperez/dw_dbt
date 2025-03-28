{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['traffic_source']) }} as trafficsource_key,
traffic_source
FROM {{ source("web_analytics_landing", "web_traffic_events")}}
