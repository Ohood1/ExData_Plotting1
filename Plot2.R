#Download and unzip data

if(!file.exists('household_power_consumption.zip')){
  url<-"https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"
  
  download.file(url,destfile = "household_power_consumption.zip")
}


unzip("household_power_consumption.zip") 


# Read the data into R
data <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                 na.strings = "?", check.names = F, quote = '\"')


## Subsetting the data to work with the data for dates 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))


## Converting dates to yyyy-mm-dd hh:mm:ss format
data$DateTime<-paste(as.Date(data$Date), data$Time)
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")  ## OR  data$Datetime <- as.POSIXct(DateTime)


## Generating Plot 2
win.graph(200,200)
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
