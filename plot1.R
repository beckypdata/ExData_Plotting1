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


#Plot 1
png("plot1.png")  # by default,480x480
with(pwr, hist(Global_active_power, col="red", breaks=12, main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()
