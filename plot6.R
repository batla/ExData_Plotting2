## This first line will likely take a few seconds. Be patient!

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

### merge the two data sets key off of Source Code Classification (SCC)

### let's take a quick look at the data
head(NEI)
head(SCC)

### Compare emissions from motor vehicle sources in Baltimore City with 
### emissions from motor vehicle sources in Los Angeles County, California 
### (fips == "06037"). Which city has seen greater changes over time in motor 
### vehicle emissions?

library(ggplot2)

### "motor" only, e.g. "on-road"
subsetNEIBCLA <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearFips <- aggregate(Emissions ~ year + fips, subsetNEIBCLA, sum)
aggregatedTotalByYearFips$fips[aggregatedTotalByYearFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearFips$fips[aggregatedTotalByYearFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" emissions")) +
  ggtitle('Total emissions from motor vehicles in Baltimore City, MD vs 
          Los Angeles, CA 1999-2008')
print(g)
dev.off()

### Los Angeles & Baltimore City both have experienced emissions changes from 1999-2008
### However, Los Angeles emissions went up and Baltimore City emissions went down
### In addition, the total emissions by Motor Vehicle are dramatically higher in
### Los Angeles.
