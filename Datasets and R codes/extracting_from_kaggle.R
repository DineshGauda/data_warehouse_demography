setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")

#delete file if already exist
fileName <- "raw_gdp_kaggle.xls"
if (file.exists(fileName)) file.remove(fileName)

fileName <- "raw_infant_mortality.csv"
if (file.exists(fileName)) file.remove(fileName)

system("kaggle datasets download -f w_gdp.xls resulcaliskan/countries-gdp")
file.rename("w_gdp.xls", "raw_gdp_kaggle.xls")


system("kaggle datasets download -d fernandol/countries-of-the-world")
zipF<- "countries-of-the-world.zip"
outDir<-"C:\\Users\\Dell\\Desktop\\Countries\\R"
unzip(zipF,exdir=outDir) 
file.rename("countries of the world.csv", "raw_infant_mortality.csv")

#delete zip
fileName <- "countries-of-the-world.zip"
if (file.exists(fileName)) file.remove(fileName)
