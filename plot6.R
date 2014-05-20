library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting
#Looking at the data source document found here: http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf
#The type="on-road" gives us the subset
NEI.BaltAndLAOnRoad <- NEI[(NEI$fips %in% c("24510","06037")) & (NEI$type=="ON-ROAD"), ]
NEI.BaltAndLAOnRoad$fips <- factor(NEI.BaltAndLAOnRoad$fips, levels=c("24510", "06037"), labels=c("Baltimore City", "Los Angeles County"))
NEI.BaltAndLAOnRoad$year <- factor(NEI.BaltAndLAOnRoad$year)

#Calculating sum
totPM25perYear <- aggregate(NEI.BaltAndLAOnRoad$Emissions, list(Year=NEI.BaltAndLAOnRoad$year, 
                                                                Location=as.factor(NEI.BaltAndLAOnRoad$fips)
                                                                ), sum)

totPM25perYear <- ddply(totPM25perYear,"Location",transform, Growth=c(0,(exp(diff(log(x)))-1)*100))

#Plotting
p <- ggplot(totPM25perYear, aes(Year, Growth, fill = Location)) + 
        geom_bar(position = "dodge", stat="identity") + 
        labs(y="Variation (in %)") + 
        ggtitle(expression(atop("Annual variation of emission of PM2.5", 
                                atop(italic("from motor vehicle sources"), ""))))
ggsave("plot6.png", p)
