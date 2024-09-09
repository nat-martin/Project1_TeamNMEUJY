dat <- read.csv("scales.csv")
sapply(dat, class)
dim(dat)
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species
length(species)
A.rup <- length(dat$species[dat$species==species[1]])
L.gib <- length(dat$species[dat$species==species[2]])
L.mac <- length(dat$species[dat$species==species[3]])
M.sal <- length(dat$species[dat$species==species[4]])
M.sax <- length(dat$species[dat$species==species[5]])
P.fla <- length(dat$species[dat$species==species[6]])
species.obs <- data.frame(sp=species, n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs
dat %>%
  group_by(species) %>%
  summarise(n=n())
dat %>%
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")
pdf("species_quadrant.pdf")
for(i in species) {
  p <- dat %>%
    filter(species==i) %>%
    ggplot()+geom_boxplot(aes(x=quadrant, y=N)) + ggtitle(i)
  print(p)
}
dev.off()
list.files(pattern=".pdf")
