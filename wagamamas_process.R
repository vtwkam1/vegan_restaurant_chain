library(tidyverse)

table <- read.csv("wagamamas.csv")

dim(table) # check dimensions

table2 <- table %>% 
    mutate(across(everything(), str_to_lower)) %>% # convert to lowercase
    mutate(name = str_replace(name, "new\\!\\s", ""), # remove "new!"
           price = as.numeric(str_replace(price, "[:symbol:]", ""))) # price to numeric

# Remove irrelevant items
table2 <- table2 %>% 
    filter(!str_detect(name, "bundle")) %>% # remove bundles
    filter(between(row_number(), 1, (which(name=="still water")-1))) %>% # remove drinks
    filter(!between(row_number(), which(name=="chilli sambal paste (vg)"), which(name=="crispy fish bites (amai sauce)"))) # remove extras, sauces and kids