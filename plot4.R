plot4 <- function() {
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
           Sub_metering_3=as.numeric(as.character(Sub_metering_3)),
           Global_reactive_power=as.numeric(as.character(Global_reactive_power)),
           Voltage=as.numeric(as.character(Voltage))) %>%
    filter(Date==ymd("2007-02-01") | Date==ymd("2007-02-02")) %>%
    mutate(WKD=lubridate::wday(Date, label=TRUE, abbr=TRUE))
  png(file="plot4.png")
  par(mfrow=c(2,2))
  with(data, plot(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
                  Global_active_power, type="l", xlab="", 
                  ylab="Global Active Power (killowatts)")) 
  with(data, plot(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
                  Voltage, type="l", xlab="datatime", 
                  ylab="Voltage")) 
  with(data, plot(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
                  Sub_metering_1, type="l", xlab="", 
                  ylab="Energy sub metering", col="black"))
  lines(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
        data$Sub_metering_2, type="l", col="red")
  lines(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
        data$Sub_metering_3, type="l", col="blue")
  legend("topright", pch = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  with(data, plot(strptime(paste(data$Date, data$Time), "%Y-%m-%d %T"), 
                  Global_reactive_power, type="l", xlab="datatime", 
                  ylab="Global_reactive_power")) 
  dev.off()
}