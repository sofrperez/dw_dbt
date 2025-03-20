{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
c.cust_key,
d.date_key,
s.store_key,
p.product_key,
employee_key,
ol.quantity,
(ol.quantity * ol.unit_price) as dollars_sold,
ol.unit_price
FROM {{ source('oliver_landing','orders')}} o
INNER JOIN {{ source('oliver_landing','orderline')}} ol ON ol.order_id = o.order_id
INNER JOIN {{ ref('oliver_dim_customer')}} c ON o.customer_id = c.customer_id
INNER JOIN {{ ref('oliver_dim_date')}} d ON o.order_date = d.date_day
INNER JOIN {{ ref('oliver_dim_store')}} s ON o.store_id = s.store_id
INNER JOIN {{ ref('oliver_dim_product')}} p ON ol.product_id = p.product_id
INNER JOIN {{ ref('oliver_dim_employee')}} e ON o.employee_id = e.employee_id