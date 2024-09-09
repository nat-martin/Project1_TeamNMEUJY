library(ggplot2)

library(tidyverse)

5000/3

setwd("/Users/jasmine/Library/Mobile Documents/com~apple~CloudDocs/BIOL 3140 /Scales")
dat <- read.csv("scales.csv")

dim(dat)
head(dat)

#with "$"

class(dat$N)
class(dat$quadrant)
class(dat$species)
class(dat$specimen)

mean(dat$N)
mean(dat$quadrant)

sapply(dat,class)
?sapply()

# how many species do we have? 
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species
length(species)

#subset the data frame 
dat$species==species[1]

#nesting values to match A. repestris
dat$species[dat$species==species[1]]

#find length of subsetted vector 
A.rup<-length(dat$species[dat$species==species[1]])
L.gib<-length(dat$species[dat$species==species[2]])
L.mac<-length(dat$species[dat$species==species[3]])
M.sal<-length(dat$species[dat$species==species[4]])
M.sax<-length(dat$species[dat$species==species[5]])
P.fla<-length(dat$species[dat$species==species[6]])

#combine the results with species
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs

#finding number of punctures per species
dat %>%
  group_by(species) %>%
  summarise(n = n())

#save results of punctures per species
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

#how many specimens for each species? 
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#iterating through operations with for loop
for(i in 1:10) print(i)

for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}

#saving as PDF
pdf("species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")
