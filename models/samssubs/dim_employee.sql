{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employee_key,
employeeid,
employeefname as empfname,
employeelname as emplname,
employeebday as empbirthdate
FROM {{ source("samssubs_landing","employee")}}