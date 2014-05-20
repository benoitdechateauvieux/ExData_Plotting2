#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting
NEI.Baltimore <- NEI[NEI$fips=="24510", ]

#Calculating sum
totPM25perYear <- aggregate(NEI.Baltimore$Emissions, list(Year=NEI.Baltimore$year), sum)
totPM25perYear$x <- totPM25perYear$x/1000

#Plotting
png(file="plot2.png")
plot(totPM25perYear, type="l", 
     ylab="Amount of PM2.5 emitted, in kilotons", 
     main="Total PM2.5 emission from all sources
     Baltimore City, Maryland")
dev.off()