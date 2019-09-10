setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")
library("httr")
library("readxl")

GET("https://query.data.world/s/enywjzjweteawkuzd3llgwsnmkrwmq", write_disk(tf <- tempfile(fileext = ".xls")))
df <- read_excel(tf)
write.csv(df,"raw_population.csv", row.names = F)

GET("https://query.data.world/s/ad4vnhjplgn6tmogwlusdcwzpjzdvu", write_disk(tf <- tempfile(fileext = ".xls")))
df <- read_excel(tf)
write.csv(df,"raw_location.csv", row.names = F)

GET("https://query.data.world/s/d54pheg25sygfg5ntsfx226zcon7ji", write_disk(tf <- tempfile(fileext = ".xls")))
df <- read_excel(tf)
write.csv(df,"raw_fertility_rate.csv", row.names = F)

GET("https://query.data.world/s/sg4z5wzztp4d5hjqgzcwxj44gvyh7u", write_disk(tf <- tempfile(fileext = ".csv")))
df <- read.csv(tf)
write.csv(df,"raw_life-epectancy-rate_data_world.csv", row.names = F)