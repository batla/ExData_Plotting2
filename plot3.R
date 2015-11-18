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

### Of the four types of sources indicated by the type (point, nonpoint, onroad,
### nonroad) variable, which of these four sources have seen decreases in 
### emissions from 1999–2008 for Baltimore City? Which have seen increases in 
### emissions from 1999–2008? 
### Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

baltimoreCityNEI <- NEI[NEI$fips=="24510", ]

aggregatedTotalByYearType <- aggregate(Emissions ~ year + type, baltimoreCityNEI, sum)


png("plot3.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearType, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") + ylab(expression('Total PM'[2.5]*" emissions")) +
  ggtitle('Total Emissions in Baltimore City, MD 1999-2008')
print(g)
dev.off()

### All but "point" sources saw a decrease in emissions from 1999 to 2008.
### In 1999, "point"was the lowest PM25 emissions source, by 2008,
### "point" rose to second highest, with "non-road" moving into the lowest PM25
### emissions source
