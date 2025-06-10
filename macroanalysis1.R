library(readr)
library(lubridate)

# Load data
df <- read_csv("macrodata.csv")
# Make sure the date column is recognized as a Date object
df$date <- as.Date(paste0(df$date, "-01"))
df$date <- ymd(df$date)
#check the structure
head(df)

#transform variables
df$cpi_yoy <- (df$cpi / dplyr::lag(df$cpi,12)-1)*100
df$msbillions_yoy <- (df$msbillions / dplyr::lag(df$msbillions,12)-1)*100
df$oil_lag1  <- dplyr::lag(df$oilprice, 1)
df <- na.omit(df)

#run model
fit1 <- lm(cpi_yoy ~ msbillions_yoy + oil_lag1, data = df)
summary(fit1)

discuss1 <- c('An increase of 1% in the YoY growth rate of the money supply is 
associated with an average decrease in YoY inflation of 0.03 percentage points, 
though this effect is not statistically significant (p = 0.15). In contrast, a 
$1 increase in WTI crude oil prices (lagged one month) is associated with a 
0.026 percentage point increase in YoY inflation, and this relationship is 
statistically significant (p < 0.001). The R-squared of 0.15 indicates that 
approximately 15% of the variation in YoY inflation is explained by changes in 
money supply and lagged oil prices. While this is a modest fit, it is typical 
in macroeconomic models given the large number of other influencing factors.')
discuss1

# Predict values using your model
df$predicted <- predict(fit1)
# Plot using base ggplot
library(ggplot2)
ggplot(df, aes(x = date)) +
  geom_line(aes(y = cpi_yoy, color = "Actual")) +
  geom_line(aes(y = predicted, color = "Predicted")) +
  labs(title = "Inflation: Actual vs Predicted",
       y = "YoY Inflation (%)",
       x = "Date",
       color = "Line")

ggsave("inflation_plot.png")