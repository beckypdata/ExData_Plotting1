# Read the file previously downloaded and unzipped in current working directory

# Early evaluation of data was completed by reading portions of file at a time.
# This revealed ordering in data which enabled ability to identify
# specific rows of interest for the date range 2/1/2007-2/2/2007.
# In the interest of memory consumption for initial read as well as subsequent
# subsetting, read has been narrowed in this script to these specific file rows

# Read first row of file and save for column headings to be applied after specific rows of interest obtained
# Read data from file with ";" seperator,"?" na indicator, avoid factors for string columns Date/Time


cnames <- read.table("household_power_consumption.txt",nrows=1,sep=";",stringsAsFactors=FALSE)
pwr <- read.table("household_power_consumption.txt",skip=66636,nrows=2880,na.strings="?",sep=";",stringsAsFactors=FALSE)
colnames(pwr) <- cnames[1,]


# Date and Time columns are strings; combine to one and convert to Date using strptime
# Set Time column to NULL to remove column from dataframe


pwr$Date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")
pwr$Time <- NULL


#Plot 4
png("plot4.png")  # by default,480x480
par(mfcol=c(2,2),mar=c(3,4,1,1))
with(pwr, {
  plot(Date,Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(Date,Sub_metering_1,ylab="Energy sub metering",xlab="",type="l")
  lines(Date,Sub_metering_2,col="red")
  lines(Date,Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),
         lty=c(1,1,1),bty="n")
  plot(Date,Voltage,ylab="Voltage",xlab="",type="l")
  mtext("datetime",side=1,line=2,cex=.7)
  plot(Date,Global_reactive_power,ylab="Global_reactive_power",xlab="",type="l")
  mtext("datetime",side=1,line=2,cex=.7)
})
dev.off()
