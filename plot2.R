# Ensure the following linked .txt file has been downloaded and unzipped into 
# the current working directory under the name "household_power_consumption.txt"
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Turn off warnings whilst running
options(warn=-1)
library(sqldf)
#load the relevant data into DF2
con <- "household_power_consumption.txt"
DF2 <- read.csv.sql(con, sql = 'select 
                   Date, Time, Global_active_power from file where Date = 
                    "1/2/2007" or Date = "2/2/2007"', sep = ";")
#check that there are no NAs
NAmessage=list("There are no NAs?: ",as.character(sum(is.na(DF2))==0))
print(paste0(NAmessage[[1]],NAmessage[[2]]))
library(lubridate)
# Create a datetime column from the Date and Time columns using lubridate
DF2$datetime<- dmy_hms(paste(DF2$Date,DF2$Time, sep=" "))
# Create png file device and line-graph then close the device & restore warnings
png(filename= "plot2.png", width = 480, height = 480)
with(DF2, plot(datetime, Global_active_power, 
               ylab = "Global Active Power (kilowatts)", 
               type = "l", xlab = ""))
dev.off()
options(warn=0)