library(tidyverse)
library(xml2)
library(selectr)
library(rvest)

options(stringsAsFactors = FALSE)
require(rvest)

    
## change Phantom.js scrape file
url <- "https://deliveroo.co.uk/menu/sheffield/sheffield-city-centre/wagamama-sheffield-city-centre"
lines <- readLines("scrape_final.js")
lines[1] <- paste0("var url ='", url ,"';")
writeLines(lines, "scrape_final.js")

## Download website
system("phantomjs scrape_final.js")

### use Rvest to scrape the downloaded website.
html <- read_html("1.html")

class(html)

# extract item name and cost
item <- html %>% 
    html_elements(".orderweb__e1b03759 .ccl-1daa0367dee37c3b") %>% 
    html_text2()

item_name <- item[seq(1, length(item), 2)]

item_price <- item[seq(2, length(item), 2)]


# extract item description
item_description <- html %>% 
    html_elements(".ccl-91a59d84c8a54641 .ccl-9d0a5327c911d0f3") %>% 
    html_text2()

# extract menu sections
menu_section <- html %>% 
    html_elements(".ccl-08a2df08ac68413d .ccl-9ff886da4b0592ae") %>% 
    html_text2()

# check lengths
length(item_name)
length(item_name) == length(item_price)
length(item_name) == length(item_description)

# create table
item_table <- tibble(name=item_name, 
                     description=item_description, 
                     price=item_price)

# export item table
write.csv(item_table, "wagamamas.csv", row.names = F)

# export menu section
write(menu_section, "wagamamas_menu_sections.txt")
