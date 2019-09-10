setwd("C:\\Users\\Dell\\Desktop\\Countries\\R")
library(rvest)

#scraping html table using rvest from wikipedia
literacy_rate <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_literacy_rate")
literacy_rate_table = html_table(html_nodes(literacy_rate, "table")[[4]], fill=TRUE)

literacy_rate_table = tail(literacy_rate_table, -1)

names(literacy_rate_table) <- c('Country', 'Literacy rate(all)', 'Male literacy rate', 'Female literacy rate', 'Gender difference', 'non-unesco')

write.csv(literacy_rate_table, 'raw_literacy_rate_wiki.csv')
