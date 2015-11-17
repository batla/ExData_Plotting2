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

### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
### (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
### plot answering this question.


baltimoreCityNEI <- NEI[NEI$fips=="24510", ]

aggregatedPM25TotalByYear <- aggregate(Emissions ~ year, baltimoreCityNEI, sum)

png('plot2.png')


barplot(height=aggregatedPM25TotalByYear$Emissions, 
        names.arg=aggregatedPM25TotalByYear$year, 
        xlab="years", ylab=expression('PM'[2.5]*' emissions'), 
        main=expression('Total PM'[2.5]*' emissions in Baltimore City, MD 1999-2008'))
dev.off()
### Yes, overall emissions from PM2.5 in Baltimore City, MD have decreased
### from 1999 to 2008; however, there was an uptick between 2002 & 2005