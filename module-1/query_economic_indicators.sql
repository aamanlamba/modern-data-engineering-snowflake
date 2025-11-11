USE ROLE accountadmin;

CREATE WAREHOUSE IF NOT EXISTS compute_wh;
USE WAREHOUSE compute_wh;

-- Create a database and schema to store our data
CREATE OR REPLACE DATABASE economic_indicators;
CREATE OR REPLACE SCHEMA data;
USE DATABASE economic_indicators;
USE SCHEMA data;

-- Creates a table tracking average annual wages and CPI for the USA, between 2012 and 2022
CREATE OR REPLACE TABLE indicators as
select
    m.indicatorid,
    m.name,
    m.classification,
    m.description,
    t.date,
    t.value
from
    industry_leading_indicators_metadata as m
    JOIN industry_leading_indicators_timeseries as t ON m.INDICATORID = t.INDICATORID
where
    t.DATE = (
        select
            max(t2.date)
        from
            industry_leading_indicators_timeseries t2
        where
            t2.indicatorid = m.indicatorid
    )

select *  from indicators
order by classification, name;