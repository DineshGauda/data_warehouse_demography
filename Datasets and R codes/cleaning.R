setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")
library(xlsx)
library(stringr)
source("util.R")

#Infant mortality
filename = 'raw_infant_mortality.csv'
infant_mortality = read.csv(filename, header = T, stringsAsFactors = F)

infant_mortality = infant_mortality[, c(1,8)]
column_names <- c('Country', 'Infant Mortality')
colnames(infant_mortality) <- column_names
infant_mortality$`Infant Mortality` <- gsub("[/,]",".",infant_mortality$`Infant Mortality`)
infant_mortality$Country <- gsub("[/&]","and",infant_mortality$Country)
infant_mortality$Country = trim(infant_mortality$Country)
infant_mortality$Country = tolower(infant_mortality$Country)

write.csv(infant_mortality,'infant_mortality_intermediate.csv', row.names=FALSE)

#Population

filename = 'raw_population.csv'
df = read.csv(filename, header=T,stringsAsFactors = F)
colLength= ncol(df);
df = df[, c(1,colLength, colLength-1, colLength-2, colLength-3, colLength-4, colLength-5, colLength-6, colLength-7)]
colnames(df) = c('Country', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006')
df$Country= tolower(df$Country)

write.csv(df,'population_intermediate.csv', row.names=FALSE)


#Fertility Rate
filename = 'raw_fertility_rate.csv'
df = read.csv(filename, header=T,stringsAsFactors = F)
colLength= ncol(df);
df = df[, c(1,colLength, colLength-1, colLength-2, colLength-3, colLength-4, colLength-5, colLength-6, colLength-7)]
colnames(df) = c('Country', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006')
df$Country= tolower(df$Country)

write.csv(df,'fertility_rate_intermediate.csv', row.names=FALSE)


#GDP
filename = 'raw_gdp_kaggle.xls'
df <- read.xlsx(filename, sheetIndex = 1, startRow=4)
colLength= ncol(df);
df = df[, c(1,colLength-4, colLength-5, colLength-6, colLength-7, colLength-8, colLength-9, colLength-10, colLength-11)]
colnames(df) = c('Country', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006')
df$Country= tolower(df$Country)

write.csv(df,'gdp_intermediate.csv', row.names=FALSE)


#Life Expectancy

filename = 'raw_life-epectancy-rate_data_world.csv'
life_expectancy_rate = read.csv(filename, header=T,stringsAsFactors = F)

colLength= ncol(life_expectancy_rate);
life_expectancy_rate = life_expectancy_rate[, c(1,colLength, colLength-1, colLength-2, colLength-3, colLength-4, colLength-5, colLength-6, colLength-7)]
colnames(life_expectancy_rate) = c('Country', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006')
life_expectancy_rate$Country= tolower(life_expectancy_rate$Country)

countries = life_expectancy_rate$Country

lifeExpectancy <- data.frame(matrix(ncol = 3, nrow= 0))
column_names <- c("Country", "Year", "Life.expectancy")
colnames(lifeExpectancy) <- column_names

for (i in 2: ncol(life_expectancy_rate)) {
  lengthOfDataFrame = nrow(lifeExpectancy) 
  for (j in 1 : length(countries)) {
    Year = as.numeric(gsub("[^0-9.]", "",  colnames( life_expectancy_rate )[i]))
    lifeExpectancy[ lengthOfDataFrame + j, ] = c(life_expectancy_rate$Country[j], Year, life_expectancy_rate[j, i])
  }
}


filename = 'raw_life_expectancy_rate_statista.xlsx'
df <- read.xlsx(filename, sheetIndex = 2, startRow=5)
df = df[(c(1:8)), ]
colnames(df) =  c('Year', 'Life.expectancy')
write.csv(df,'life_expectancy_rate_statista.csv', row.names=FALSE)

lifeExpectancy_Statista = read.csv("life_expectancy_rate_statista.csv", header=T,stringsAsFactors = F)

life_expectancy_rate<- data.frame(matrix(ncol = 8, nrow= 0))
column_names <- c("2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013")
colnames(life_expectancy_rate) <- column_names

for (i in 1 : ncol(life_expectancy_rate)) {
  life_expectancy_rate[1,i] = lifeExpectancy_Statista$Life.expectancy[i]
}

life_expectancy_rate_data_frame <- data.frame(matrix(ncol = 4, nrow= 0))
column_names <- c("Country", "Year", "Life Expectancy Rate", "Worldwide Life Expectancy Rate")
colnames(life_expectancy_rate_data_frame) <- column_names

for (j in 1 : length(lifeExpectancy$Country)) {
  year = lifeExpectancy$Year[j]
  location = which( colnames(life_expectancy_rate)== as.character(year) )
  life_expectancy_rate_data_frame[j, ] = c(lifeExpectancy$Country[j], lifeExpectancy$Year[j], lifeExpectancy$Life.expectancy[j], life_expectancy_rate[1, location])
}

life_expectancy_rate_data_frame$Country= tolower(life_expectancy_rate_data_frame$Country)

fileName <- "life_expectancy_rate_statista.csv"
if (file.exists(fileName)) file.remove(fileName)

write.csv(life_expectancy_rate_data_frame, "life_expectancy_rate_intermediate.csv", row.names = F)


#Literacy Rate

datawiki = read.csv("raw_literacy_rate_wiki.csv", header=T,stringsAsFactors = F)
datawiki$X <- NULL
datawiki$Gender.difference <- NULL
datawiki$non.unesco <- NULL

datawiki = datawiki[datawiki$Male.literacy.rate != 'not reported by UNESCO 2015', ]

datawiki$Literacy.rate.all. = numextract(datawiki$Literacy.rate.all.)
datawiki$Male.literacy.rate = numextract(datawiki$Male.literacy.rate)
datawiki$Female.literacy.rate = numextract(datawiki$Female.literacy.rate)
datawiki$Country = str_to_lower(datawiki$Country)

colnames(datawiki) = c('Country', 'Literacy rate all','Male literacy rate', 'Female literacy rate')
write.csv(datawiki, 'literacy_rate_wiki.csv', row.names=FALSE)

dataMissing = read.csv("raw_literacy_rate_missing.csv", header=T,stringsAsFactors = F)
dataMissing$X <- NULL
dataMissing$Country = str_to_lower(dataMissing$Country)
dataMissing$Country <- gsub('_', ' ', dataMissing$Country)

colnames(dataMissing) = c('Country', 'Literacy rate all','Male literacy rate', 'Female literacy rate')

write.csv(dataMissing, 'literacy_rate_missing.csv', row.names=FALSE)

dataMissing = read.csv("literacy_rate_missing.csv", header=T,stringsAsFactors = F)
datawiki = read.csv("literacy_rate_wiki.csv", header=T,stringsAsFactors = F)

dataMissing$X <- NULL
datawiki$X <- NULL

literacyData <- merge(dataMissing, datawiki,all.x = TRUE, all.y = TRUE)
literacyData$X <- NULL


fileName <- "literacy_rate_missing.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "literacy_rate_wiki.csv"
if (file.exists(fileName)) file.remove(fileName)

write.csv(literacyData, 'literacy_rate_intermediate.csv', row.names = F)


#Location

filename = 'raw_location.csv'
df = read.csv(filename, header=T,stringsAsFactors = F)

df$Country.Code = NULL
df$SpecialNotes = NULL
df$IncomeGroup = NULL
colnames(df)[colnames(df)=="Country.Name"] <- "Country"
df$Country= tolower(df$Country)

write.csv(df, 'location_intermediate.csv' ,row.names = F)
