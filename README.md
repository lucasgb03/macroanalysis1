# Inflation Prediction Using Money Supply and Oil Prices
## Overview
- Project determining the effects of WTI Crude Oil Prices and US Money Supply on US CPI Index from 2020-2025
- Tools Used: R, ggplot2, FRED Economic Data
- Data: Monthly 2020-2024, aggregated daily oil prices to monthly using a simple average of all oil prices in that month

## Methodology
- Transformed CPI and M2 into YoY growth rates
- Lagged oil prices by 1 month
- Ran a linear regression model using R
- Plotted actual CPI yoy change vs predicted model values
  
## Summary of Findings
- A $1 increase in lagged oil price is associated with a 0.026pp increase in YoY inflation (p < 0.001)
- Money supply growth had a negative but statistically insignificant association with inflation (p = 0.15)
- R² = 0.15 — modest explanatory power, typical for macro time series with other influencing factors

## Files
- PredictedvsActual.png
- Macroanalysis1.R
- macrodata.csv
