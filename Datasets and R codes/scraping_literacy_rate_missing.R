setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")
library(rvest)
library(stringr)
source("util.R")


literacyRateDf = data.frame(matrix(ncol = 4))
colnames(literacyRateDf) = c('Country', 'Total literacy rate', 'Male literacy rate', 'Female literacy rate')
countries = c('andorra', 'australia', 'belgium', 'barbados', 'canada', 'czech_republic', 'denmark', 'djibouti', 'dominica', 'fiji', 'finland', 'france', 'germany', 'iceland', 'ireland', 'israel', 'japan', 'liechtenstein', 'luxembourg','marshall_islands', 'monaco', 'netherlands', 'new_zealand', 'norway', 'saint_lucia', 'saint_vincent_and_the_grenadines', 'san_marino', 'solomon_islands', 'somalia', 'sweden', 'switzerland', 'united_kingdom', 'united_states')


for(i in 1:length(countries)){
urlContent = read_html(paste("https://www.indexmundi.com/",countries[i],"/literacy.html", sep=""))

allData = urlContent %>% html_nodes("div.c") %>% html_text()

location_total = instr(allData, 'total population:') + 18
literacyRate_total = substr(allData, location_total, location_total+5)
literacyRate_total = numextract(literacyRate_total)

location_male = instr(allData, 'male:') + 5
literacyRate_male = substr(allData, location_total, location_total+5)
literacyRate_male = numextract(literacyRate_male)

location_female = instr(allData, 'female:') + 7
literacyRate_female = substr(allData, location_total, location_total+5)
literacyRate_female = numextract(literacyRate_female)

rowContent = c(countries[i], literacyRate_total, literacyRate_male, literacyRate_female)
literacyRateDf =rbind(literacyRateDf, rowContent)
}
literacyRateDf = literacyRateDf[-1, ]
write.csv(literacyRateDf, 'raw_literacy_rate_missing.csv')