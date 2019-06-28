# Aggregate by functional group

rm(list=ls())

library(reshape)
library(ggplot2)

# Set parameters
#isn't working
#inputdir="~/Analyses_notGit/EwE-NBayTrawlData" # name of input directory
#outputdir="~/Analyses_notGit/_RESULTS/EwE-NBayTrawlData" # name of output directory

trawlName="Collie2008-25-species-CPUE-UPDATED-WhaleRock.csv" #name of data file (downloaded from URI trawl website)
outName="trawlDat-by-functionalGroup-WhaleRock.csv" # name of output file
graphName="WhaleRockTimeSeries.pdf"



setwd("~/Desktop/GSO Trawl")

trawlDat<-read.csv(trawlName)

functKey<-read.csv("ByronFunctionalGroups-KEY.csv")
functKey$Common.Name<-gsub(" ", ".", functKey$Common.Name)

trawlMelt<-melt(trawlDat, id.vars="Year")
names(trawlMelt)[2:3]<-c("Common.Name", "Biomass")
trawlMelt<-merge(trawlMelt, functKey, by="Common.Name")

trawlByFunct<-aggregate(trawlMelt$Biomass ~ trawlMelt$Year + trawlMelt$Functional.Code, FUN=sum)
names(trawlByFunct)<-c("Year", "Function", "Biomass")

ggplot(trawlByFunct, aes(x=Year, y=Biomass, colour=Function))+
  geom_line() +
  geom_point() +
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        plot.title = element_text(hjust = 0.5))+
  scale_color_manual(name="Functional Group",
                     values=c("red", "green", "blue", "purple"),
                     labels=c("Benthic Deposit Feeder", "Carnivorous Fish", "Invertebrate Carnivores", "Piscivorous Fish"))+
  ggtitle("Whale Rock")


##fox Island

trawlName2="Collie2008-25-species-CPUE-UPDATED-FoxIsland.csv" #name of data file (downloaded from URI trawl website)
outName2="trawlDat-by-functionalGroup-FoxIsland.csv" # name of output file
graphName2="FoxIslandTimeSeries.pdf"
trawlDat2<-read.csv(trawlName2)

functKey<-read.csv("ByronFunctionalGroups-KEY.csv")
functKey$Common.Name<-gsub(" ", ".", functKey$Common.Name)

trawlMelt2<-melt(trawlDat2, id.vars="Year")
names(trawlMelt2)[2:3]<-c("Common.Name", "Biomass")
trawlMelt2<-merge(trawlMelt2, functKey, by="Common.Name")

trawlByFunct2<-aggregate(trawlMelt2$Biomass ~ trawlMelt2$Year + trawlMelt2$Functional.Code, FUN=sum)
names(trawlByFunct2)<-c("Year", "Function", "Biomass")

ggplot(trawlByFunct2, aes(x=Year, y=Biomass, colour=Function))+
  geom_line() +
  geom_point() +
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        plot.title = element_text(hjust = 0.5))+
  scale_color_manual(name="Functional Group",
                     values=c("red", "green", "blue", "purple"),
                     labels=c("Benthic Deposit Feeder", "Carnivorous Fish", "Invertebrate Carnivores", "Piscivorous Fish"))+
  ggtitle("Fox Island")

#setwd(outputdir)
#pdf(file=graphName)
#print(p)
#dev.off()


#setwd(outputdir)
#write.csv(trawlByFunct, file=outName, quote=FALSE, row.names=FALSE)



