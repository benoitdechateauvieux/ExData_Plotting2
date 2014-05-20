library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting
NEI.Baltimore <- NEI[NEI$fips=="24510", ]

#Calculating sum
totPM25perYear <- aggregate(NEI.Baltimore$Emissions, list(Year=NEI.Baltimore$year, 
                                                          Source=as.factor(NEI.Baltimore$type)), sum)
totPM25perYear$x <- totPM25perYear$x/1000

#Plotting
p <- ggplot(totPM25perYear) + 
        geom_line(aes(y = x, x = Year, group = Source, col=Source)) + 
        labs(y="Amount of PM2.5 emitted, in kilotons") + 
        ggtitle(expression(atop("Total PM2.5 emission", 
                                atop(italic("Baltimore City, Maryland"), ""))))
ggsave("plot3.png", p)
