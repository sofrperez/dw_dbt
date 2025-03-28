{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
wp.webpage_key,
t.trafficsource_key,
e.event_key,
d.date_key,
COUNT(w.*) as numinteractions
FROM {{ source("web_analytics_landing","web_traffic_events")}} w
INNER JOIN {{ ref("dim_webpage")}} wp ON w.page_url = wp.page_url
INNER JOIN {{ ref("dim_trafficsource")}} t ON w.traffic_source = t.traffic_source
INNER JOIN {{ ref("dim_event")}} e ON w.event_name = e.event_name
INNER JOIN {{ ref("dim_date")}} d ON CAST(w.event_timestamp AS DATE) = d.date_day
GROUP BY wp.webpage_key, t.trafficsource_key, e.event_key, d.date_key
ORDER BY d.date_key