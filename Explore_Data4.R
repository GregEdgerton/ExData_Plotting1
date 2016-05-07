Explore_Data4 <- function() {
        
        # STEP 1 is to read in data.  
        # Assumes you've already unzipped to the working directory.  (No reason to wait for that every time.)        
        # Read in the source file.
        # Use na.strings = "?" to convert fields to NA        
        
        house_power <- read.table("household_power_consumption.txt", 
                                  header = TRUE, sep = ";", na.strings = "?")
        
        
        # could not get filter to work on initial read.
        #hp1 <- read.table("household_power_consumption.txt", 
        #                header = FALSE, sep = ";", na.strings = "?")
        #                skip=grep("2/1/2007", readLines("household_power_consumption.txt")),
        #                nrows = 1440)
        
        hp <- subset(house_power, Date == "2/1/2007" | Date == "2/2/2007") 
        
        # remove the big file from memory after subsetting.
        rm(house_power)
        
        #write for debugging purposes
        write.csv(hp, "power.csv")
        
        # Plotting starts here.
        
        #plot4
        
        datetime <- strptime(paste(hp$Date, hp$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
        plot4 <- as.numeric(hp$Global_active_power)
        globalReactivePower <- as.numeric(hp$Global_reactive_power)
        voltage <- as.numeric(hp$Voltage)
        subMetering1 <- as.numeric(hp$Sub_metering_1)
        subMetering2 <- as.numeric(hp$Sub_metering_2)
        subMetering3 <- as.numeric(hp$Sub_metering_3)
        png("plot4.png", width=480, height=480)
        par(mfrow = c(2, 2)) 
        plot(datetime, hp, type="l", xlab="", ylab="Global Active Power", cex=0.2)
        plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
        lines(datetime, subMetering2, type="l", col="red")
        lines(datetime, subMetering3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
        plot(datetime, hp, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        
        dev.off()
        
}