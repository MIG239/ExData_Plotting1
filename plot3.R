plot3 <- function() {
  ##Initiating required libraries
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ##Reading source file
  data<-read.table("household_power_consumption.txt", sep=";", dec=".", header=TRUE)
  data<-tbl_df(data)
  data<-data %>% 
    mutate(Date=dmy(Date), Time, Global_active_power=as.numeric(as.character(Global_active_power)),
           Sub_metering_1=as.numeric(as.character(Sub_metering_1)),
           Sub_metering_2=as.numeric(as.character(Sub_metering_2)),
           Sub_metering_3=as.numeric(as.character(Sub_metering_3))) %>%
    filter(Date==ymd("2007-02-01") | Date==ymd("2007-02-02")) %>%
    mutate(WKD=lubridate::wday(Date, label=TRUE, abbr=TRUE))
  png(file="plot3.png")
  with(data, plot(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
                  Sub_metering_1, type="l", xlab="", 
                  ylab="Energy sub metering", col="black"))
  lines(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
        data$Sub_metering_2, type="l", col="red")
  lines(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
        data$Sub_metering_3, type="l", col="blue")
  legend("topright", pch = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}