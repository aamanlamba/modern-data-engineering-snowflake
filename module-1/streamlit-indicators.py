# Import Python packages
import streamlit as st
import altair as alt
from snowflake.snowpark.context import get_active_session

# Get the current credentials
session = get_active_session()

# Create references to the tables
indicators_table = session.table("economic_indicators.data.indicators")

# Fetch data from Snowflake tables
indicators_data = indicators_table.to_pandas()
# Streamlit app
st.title("Latest Indicator values from Prevedere's Economic Indicators")

# Table of Indicators
st.subheader("Prevedere's Economic Indicators")
st.dataframe(indicators_data)
st.write(f"Total Indicators: {len(indicators_data)}")

