#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculating sum
totPM25perYear <- aggregate(NEI$Emissions, list(Year=NEI$year), sum)
totPM25perYear$x <- totPM25perYear$x/1000

#Plotting
png(file="plot1.png")
plot(totPM25perYear, type="l",
     ylab="Amount of PM2.5 emitted, in kilotons", 
     main="Total PM2.5 emission from all sources")
dev.off()