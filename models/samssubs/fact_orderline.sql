{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}


WITH employee_store AS(
    SELECT DISTINCT employeeid, storeid
    FROM {{ source("samssubs_landing","employee")}})

SELECT
d.date_key,
c.customer_key,
e.employee_key,
p.product_key,
om.ordermethod_key,
s.store_key,
pointsearned,
orderlineqty,
oi.ordernumber,
(od.orderlineprice/od.orderlineqty) as productcost
FROM {{ source("samssubs_landing","orderinfo")}} oi
JOIN {{ source("samssubs_landing","orderdetails")}} od ON oi.ordernumber = od.ordernumber
JOIN {{ ref("dim_date")}} d ON CAST(oi.orderdate AS DATE) = d.date_day
JOIN {{ ref("dim_customer")}} c ON c.customerid = oi.customerid
JOIN {{ ref("dim_employee")}} e ON e.employeeid = oi.employeeid
JOIN {{ ref("dim_product")}} p ON p.productid = od.productid
JOIN {{ ref("dim_ordermethod")}} om ON om.ordermethod = oi.ordermethod
JOIN employee_store es ON es.employeeid = oi.employeeid
JOIN {{ ref("dim_store")}} s ON s.storeid = es.storeid