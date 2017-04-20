# Ensure the following linked .txt file has been downloaded and unzipped into 
# the current working directory under the name "household_power_consumption.txt"
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Turn off warnings whilst running
options(warn=-1)
library(sqldf)
#load the relevant data into DF3
con <- "household_power_consumption.txt"
DF3 <- read.csv.sql(con, sql = 'select Date, Time, Sub_metering_1, Sub_metering_2, 
                    Sub_metering_3 from file where Date = "1/2/2007" or Date = 
                    "2/2/2007"', sep = ";")
#check that there are no NAs
NAmessage=list("There are no NAs?: ",as.character(sum(is.na(DF3))==0))
print(paste0(NAmessage[[1]],NAmessage[[2]]))
library(lubridate)
# Create a datetime column from the Date and Time columns using lubridate
DF3$datetime<- dmy_hms(paste(DF3$Date,DF3$Time, sep=" "))
# Create png file device and line-graph then close the device & restore warnings
png(filename= "plot3.png", width = 480, height = 480)
with(DF3, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", 
               type = "n", xlab = ""))
with(DF3, points(datetime,Sub_metering_1, col="black", type = "l"))
with(DF3, points(datetime,Sub_metering_2, col="red", type = "l"))
with(DF3, points(datetime,Sub_metering_3, col="blue", type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
options(warn=0)