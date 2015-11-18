## This first line will likely take a few seconds. Be patient!

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

### merge the two data sets key off of Source Code Classification (SCC)
### this step takes a while if the two are not merged already

if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

### let's take a quick look at the data
head(NEISCC)

### How have emissions from motor vehicle sources changed from 1999–2008 in 
### Baltimore City?

library(ggplot2)

baltimoreCityNEIOnRoad <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, baltimoreCityNEIOnRoad, sum)

png("plot5.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + 
  ylab(expression('Total PM'[2.5]*" emissions")) +
  ggtitle('Total emissions from motor vehicles in Baltimore City, MD 1999-2008')
print(g)
dev.off()

### emissions from motor vehicle sources decreased dramatically from 1999-2008
