{{ config(materialized='table') }}

select *
from {{ source('raw', 'allergies_raw') }}