# Ensure the following linked .txt file has been downloaded and unzipped into 
# the current working directory under the name "household_power_consumption.txt"
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Turn off warnings whilst running
options(warn=-1)
library(sqldf)
#load the relevant data into DF4
con <- "household_power_consumption.txt"
DF4 <- read.csv.sql(con, sql = 'select * from file where Date = "1/2/2007" or Date = 
                    "2/2/2007"', sep = ";")
#check that there are no NAs
NAmessage=list("There are no NAs?: ",as.character(sum(is.na(DF4))==0))
print(paste0(NAmessage[[1]],NAmessage[[2]]))
library(lubridate)
# Create a datetime column from the Date and Time columns using lubridate
DF4$datetime<- dmy_hms(paste(DF4$Date,DF4$Time, sep=" "))
# Create png file device 
png(filename= "plot4.png", width = 480, height = 480)
# set the framework for 2x2 plots created row-wise and create the 4 line-graphs
# then close the device & restore warnings
par(mfrow = c(2,2))

# plot1 (line plot; datetime vs Global_active_power)
with(DF4, plot(datetime, Global_active_power, 
               ylab = "Global Active Power", 
               type = "l", xlab = ""))

# plot2 (line plot; datetime vs Voltage)
with(DF4, plot(datetime, Voltage, 
               ylab = "Voltage", 
               type = "l", xlab = "datetime"))

# plot3 (line plots; datetime vs Energy sub metering)
with(DF4, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", 
               type = "n", xlab = ""))
with(DF4, points(datetime,Sub_metering_1, col="black", type = "l"))
with(DF4, points(datetime,Sub_metering_2, col="red", type = "l"))
with(DF4, points(datetime,Sub_metering_3, col="blue", type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot4 (line plot datetime vs Global_reactive_power)
with(DF4, plot(datetime, Global_reactive_power, 
               ylab = "Global_reactive_power", 
               type = "l", xlab = "datetime"))
dev.off()
options(warn=0)