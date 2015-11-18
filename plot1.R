## This first line will likely take a few seconds. Be patient!

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

### let's take a quick look at the data
head(NEI)
head(SCC)

### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
### Using the base plotting system, make a plot showing the total PM2.5 emission 
### from all sources for each of the years 1999, 2002, 2005, and 2008.

aggregatedPM25TotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')

### Taking a look at a couple of different graphs in one panel
### par(mfrow = c(1, 2))

barplot(height=aggregatedPM25TotalByYear$Emissions, 
        names.arg=aggregatedPM25TotalByYear$year, 
        xlab="Year", ylab=expression('PM'[2.5]*' emissions'), 
        main=expression('Total PM'[2.5]*' emissions 1999-2008'))

### strictly following instructions for one plot
### plot(aggregatedPM25TotalByYear, type="l", 
###        xlab="Year", 
###        ylab=expression('PM'[2.5]*' emissions'), 
###        main=expression('Total PM'[2.5]*' emissions 1999-2008'))
dev.off()

### Yes, emissions from PM2.5 have decreased in the U.S. from 1999 to 2008