# Ensure the following linked .txt file has been downloaded and unzipped into 
# the current working directory under the name "household_power_consumption.txt"
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Turn off warnings whilst running
options(warn=-1)
library(sqldf)
#load the relevant data into DF1
DF1 <- read.csv.sql("household_power_consumption.txt", sql = 'select 
                   Global_active_power from file where Date = "1/2/2007" or 
                   Date = "2/2/2007"', sep = ";")

# Check that there are no NAs
NAmessage=list("There are no NAs?: ",as.character(sum(is.na(DF1))==0))
paste0(NAmessage[[1]],NAmessage[[2]])
# Create png file device, create histogram then close the device
png(filename= "plot1.png", width = 480, height = 480)
hist(DF1$Global_active_power, xlab="Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red", breaks = 12)
dev.off()
options(warn=0)