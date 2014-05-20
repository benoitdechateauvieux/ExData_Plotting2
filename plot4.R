library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#finding Coal Combustion SCC
coalCombSCC <- SCC[grep(".*Comb.*Coal", SCC$Short.Name, ignore.case=T), "SCC"]
NEI.coalComb <- NEI[NEI$SCC %in% coalCombSCC, ]

#Calculating sum
totPM25perYear <- aggregate(NEI.coalComb$Emissions, list(Year=NEI.coalComb$year), sum)
totPM25perYear$x <- totPM25perYear$x/1000

#Plotting
p <- ggplot(totPM25perYear) + 
        geom_line(aes(y = x, x = Year)) + 
        labs(y="Amount of PM2.5 emitted, in kilotons") + 
        ggtitle(expression(atop("Total PM2.5 emission from coal combustion-related sources", 
                                atop("across the United States"), "")))
ggsave("plot4.png", p)