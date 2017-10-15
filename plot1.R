plot1 <- function() {
  ##Initiating required libraries
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ##Reading source file
  data<-read.table("household_power_consumption.txt", sep=";", dec=".", header=TRUE)
  data<-tbl_df(data)
  data<-data %>% 
    mutate(Date=dmy(Date), Time=hms(Time), Global_active_power=as.numeric(as.character(Global_active_power))) %>%
    filter(Date==ymd("2007-02-01") | Date==ymd("2007-02-02")) %>%
    mutate(WKD=lubridate::wday(Date, label=TRUE, abbr=TRUE))
  png(file="plot1.png")
  hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
       main="Global Active Power")
  dev.off()
  
}