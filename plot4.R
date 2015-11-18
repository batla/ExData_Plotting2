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

### Across the United States, how have emissions from coal combustion-related
### sources changed from 1999–2008?

library(ggplot2)

# fetch all NEISCC records with Short.Name (SCC) coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
coalMatchesNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, coalMatchesNEISCC, sum)


png("plot4.png", width=640, height=480)

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" emissions")) +
  ggtitle('Total Emissions from coal: 1999-2008')
print(g)
dev.off()

### emissions from coal sources reduced overall from 1999-2008; however, aside
### from a slight increase in 2005 from 2002, the next three years showed a 
### dramatic decrease.
