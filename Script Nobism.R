#INSTALL AND LOAD PACKAGES-----

#If pacman is missing we install it, then we load libraries
if (!require("pacman")) {
  install.packages("pacman")
  } else{
  library(pacman)
  pacman::p_load(lubridate, ggplot2, caret, readr, dplyr, tidyr, ggfortify)
  }

#GET DATA -----

df <- read_csv("Data/train_student.csv")
View(df)
plot(df$week, df$cases)
str(df)
summary(df)


#NEW DF WITHOUT 2010 AND 2011 -----

df_v2 <- df[83:476,]

# TRAIN & TEST -------
df_train <- df[1:399,]
df_test  <- df[400:476,]

df2_train <- df_v2[1:317,]
df2_test <- df_v2[318:394,]


#CREATE TS ------

ts_train <- ts(df_train$cases, frequency=365.25/7, start=decimal_date(ymd("2010-05-09")))
ts_test <- ts(df_test$cases, frequency=365.25/7, start=decimal_date(ymd("2017-12-31")))

ts2_train <- ts(df2_train$cases, frequency=365.25/7, start=decimal_date(ymd("2011-12-04")))
ts2_test <- ts(df2_test$cases, frequency=365.25/7, start=decimal_date(ymd("2017-12-31")))

#Plot partition
autoplot(ts_train, xlab="Week",series="Week") + 
  autolayer(ts_test, series = "Cases") +
  ggtitle("Cases per week")

autoplot(ts2_train, xlab="Week",series="Week") + 
  autolayer(ts2_test, series = "Cases") +
  ggtitle("Cases per week")

