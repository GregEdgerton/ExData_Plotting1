Explore_Data3 <- function() {
        
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
        
        #plot3
        
        datetime <- strptime(paste(hp$Date, hp$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
        plot3 <- as.numeric(hp$Global_active_power)
        subMetering1 <- as.numeric(hp$Sub_metering_1)
        subMetering2 <- as.numeric(hp$Sub_metering_2)
        subMetering3 <- as.numeric(hp$Sub_metering_3)
        png("plot3.png", width=480, height=480)
        plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
        lines(datetime, subMetering2, type="l", col="red")
        lines(datetime, subMetering3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
        

        dev.off()
        
}