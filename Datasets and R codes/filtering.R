setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")
library(stringr)
library(countrycode)

#read csv files
literacy_rate = read.csv("literacy_rate_intermediate.csv", header = T, stringsAsFactors = F)
gdp = read.csv("gdp_intermediate.csv", header = T, stringsAsFactors = F)
fertility_rate = read.csv("fertility_rate_intermediate.csv", header = T, stringsAsFactors = F)
life_expectancy_rate = read.csv("life_expectancy_rate_intermediate.csv", header=T,stringsAsFactors = F)
meta_data = read.csv('location_intermediate.csv', header=T,stringsAsFactors = F)
infant_mortality = read.csv('infant_mortality_intermediate.csv', header = T, stringsAsFactors = F)
population = read.csv("population_intermediate.csv", header = T, stringsAsFactors = F)


#Delete Intermediate files
fileName <- "literacy_rate_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "gdp_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

# fileName <- "population_intermediate.csv"
# if (file.exists(fileName)) file.remove(fileName)

fileName <- "fertility_rate_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "life_expectancy_rate_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "location_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "infant_mortality_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "population_intermediate.csv"
if (file.exists(fileName)) file.remove(fileName)


#merge by country
all_data_by_country = Reduce(function(...) merge(..., by='Country'), mget(c('literacy_rate', 'gdp', 'infant_mortality', 'fertility_rate', 'life_expectancy_rate', 'meta_data', 'population')))
#remove rows with NA 
all_data_by_country =  na.omit(all_data_by_country)


#filter on the basis of common countries
literacy_rate = literacy_rate[literacy_rate$Country %in% all_data_by_country$Country,]
gdp = gdp[gdp$Country %in% all_data_by_country$Country,]
fertility_rate = fertility_rate[fertility_rate$Country %in% all_data_by_country$Country,]
life_expectancy_rate = life_expectancy_rate[life_expectancy_rate$Country %in% all_data_by_country$Country, ]
meta_data = meta_data[meta_data$Country %in% all_data_by_country$Country, ]
infant_mortality = infant_mortality[infant_mortality$Country %in% all_data_by_country$Country, ]

#infant mortality
write.csv(infant_mortality, 'infant_mortality.csv', row.names = F)


#population
countries = population$Country

population_data_frame <- data.frame(matrix(ncol = 4, nrow= 0))
column_names <- c("Country", "Decade", "Year", "Population")
colnames(population_data_frame) <- column_names

for (i in 2: ncol(population)) {
  lengthOfDataFrame = nrow(population_data_frame) 
  for (j in 1 : length(countries)) {
    Year = as.numeric(gsub("[^0-9.]", "",  colnames( population )[i]))
    Decade = Year - (Year %% 10)
    population_data_frame[ lengthOfDataFrame + j, ] = c(population$Country[j], Decade, Year, population[j, i])
  }
}
write.csv(population_data_frame, 'population.csv', row.names=FALSE)




#location
column_names <- c("Country", "Region")
colnames(meta_data) <- column_names
meta_data$Continent <- factor(countrycode(sourcevar = meta_data[, "Country"],
                                          origin = "country.name",
                                          destination = "continent"))
meta_data$Region = gsub("&", "and", meta_data$Region)
write.csv(meta_data, 'location.csv', row.names=FALSE)


#life_expectancy_rate
column_names <- c("Country", "Year", "Life Expectancy Rate", "Worldwide Life Expectancy Rate")
colnames(life_expectancy_rate) <- column_names
life_expectancy_rate$Decade = 2010
for (j in 1 : length(life_expectancy_rate$Country)) {
  Decade = life_expectancy_rate$Year[j] - (life_expectancy_rate$Year[j] %% 10)
  life_expectancy_rate$Decade[j]= Decade
}
write.csv(life_expectancy_rate, 'life_expectancy_rate.csv', row.names=FALSE)

#literacy_rate
countries = literacy_rate$Country

literacy_rate_data_frame <- data.frame(matrix(ncol = 3, nrow= 0))
column_names <- c("Country", "Gender", "Literacy Rate")
colnames(literacy_rate_data_frame) <- column_names
Gender = c('', 'Overall', 'Male', 'Female')
for (i in 2: ncol(literacy_rate)) {
  lengthOfDataFrame = nrow(literacy_rate_data_frame)
  for (j in 1 : length(countries)) {
    literacy_rate_data_frame[ lengthOfDataFrame + j, ] = c(literacy_rate$Country[j], Gender[i], literacy_rate[j, i])
  }
}
write.csv(literacy_rate_data_frame, 'literacy_rate.csv', row.names=FALSE)


#GDP
countries = gdp$Country

gdp_data_frame <- data.frame(matrix(ncol = 4, nrow= 0))
column_names <- c("Country","Decade", "Year", "GDP")
colnames(gdp_data_frame) <- column_names

for (i in 2: ncol(gdp)) {
  lengthOfDataFrame = nrow(gdp_data_frame) 
  for (j in 1 : length(countries)) {
    Year = as.numeric(gsub("[^0-9.]", "",  colnames( gdp )[i]))
    Decade = Year - (Year %% 10)
    gdp_data_frame[ lengthOfDataFrame + j, ] = c(gdp$Country[j], Decade, Year , gdp[j, i])
  }
}
gdp_data_frame$GDP = as.numeric(gdp_data_frame$GDP)
gdp_data_frame$GDP = round(gdp_data_frame$GDP / 1e6, 1)  #Converting it to millions
write.csv(gdp_data_frame, 'gdp.csv', row.names=FALSE)


#fertility rate
countries = fertility_rate$Country

fertility_rate_data_frame <- data.frame(matrix(ncol = 4, nrow= 0))
column_names <- c("Country", "Decade", "Year", "Fertility Rate")
colnames(fertility_rate_data_frame) <- column_names

for (i in 2: ncol(fertility_rate)) {
  lengthOfDataFrame = nrow(fertility_rate_data_frame)   
  for (j in 1 : length(countries)) {
    Year = as.numeric(gsub("[^0-9.]", "",  colnames( fertility_rate )[i]))
    Decade = Year - (Year %% 10)
    fertility_rate_data_frame[ lengthOfDataFrame + j, ] = c(fertility_rate$Country[j], Decade, Year, fertility_rate[j, i])
  }
}
write.csv(fertility_rate_data_frame, 'fertility_rate.csv', row.names=FALSE)
