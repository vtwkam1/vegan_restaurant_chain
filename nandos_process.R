library(tidyverse)
library(stringi)

chain <- "nandos"

source_table <- read.csv(sprintf("%s.csv", chain))

dim(source_table) # check dimensions (71 rows)

# Simple cleaning
table <- source_table %>% 
    mutate(price = as.numeric(str_replace(price, "[:symbol:]", ""))) %>% 
    mutate(across(where(is.character), 
                  ~ str_replace_all(.x, "\\<[:graph:]*\\>", "") %>% 
                      stringi::stri_trans_general("latin-ascii") %>%
                      str_to_lower %>% 
                      str_trim)) %>% 
    mutate(name = str_replace(name, "new(?=\\s{1})", "") %>% 
               str_trim)

# Identify sold out items to manually add description
table %>% 
    filter(description == "currently sold out")

table <- table %>% 
    filter(between(row_number(), 1, (which(name=="coca-cola classic")-1))) # drop drinks

nrow(table) # 53 rows

# Assign menu sections
menu_section <- read.delim(sprintf("%s_menu_section.txt", chain), header=F)
menu_section <- as.character(menu_section[,1]) %>% str_to_lower()

## Assign sections (needs updating)
table <- table %>% 
    mutate(section = case_when(
        between(row_number(), which(name=="spicy mixed olives"), which(name=="dare to share!")) ~ menu_section[1],
        between(row_number(), which(name=="chicken butterfly"), which(name=="10 wing roulette")) ~ menu_section[2],
        between(row_number(), which(name=="boneless platter"), which(name=="family platter")) ~ menu_section[3],
        between(row_number(), which(name=="sunset burger"), which(name=="the great imitator wrap")) ~ menu_section[4],
        between(row_number(), which(name=="grilled chicken burger"), which(name=="chicken breast fillet")) ~ menu_section[5],
        between(row_number(), which(name=="chilli jam"), which(name=="peri-peri salt")) ~ menu_section[6],
        between(row_number(), which(name=="peri-salted chips"), which(name=="rainbow slaw")) ~ menu_section[7],
        between(row_number(), which(name=="gooey caramel cheesecake"), which(name=="salted caramel brownie")) ~ menu_section[8]))

## Identify duplicates
duplicated <- table %>% 
    count(name) %>% 
    filter(n>1)

section_drop <- c("sharing platters", "nandinos (kids)", "extras")

# number of rows dropped when unwanted sections dropped
table %>% 
    count(section) %>% 
    filter(section %in% section_drop) %>% 
    summarise(sum = sum(n)) # 22

table <- table %>% 
    filter(!section %in% section_drop) %>% # drop sections
    filter(!name == "dare to share!")

nrow(table) # 30

# Assign categories
table %>% 
    distinct(section)

table <- table %>% 
    mutate(category = case_when(
        section %in% c("starters", "sides") ~ "sides",
        section %in% c("peri-peri chicken", "burgers, pittas, wraps") ~ "mains",
        section %in% c("desserts") ~ "desserts"
    ))

# Assign item ID
table %>% 
    count(name) %>% 
    filter(n>1) # Check if any duplicates remaining

table <- table %>% 
    mutate(id = row_number(),
           .before = 1)

# Identify vegan options
table <- table %>% ## Manual identification
    mutate(vegan = case_when(
        id %in% c(1,2,19,20,21,22,23,25,27,28) ~ "vegan",
        id %in% c(3,24,26,29,30) ~ "vegetarian",
        TRUE ~ "non-veg"))

protein_table <- table

# Vegan protein list
veg_protein <- c("pea-protein")

# Identify vegan proteins
for (i in veg_protein) {
    protein_table <- protein_table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & (vegan %in% c("vegan", "vegetarian"))), 1, 0
        ))
}

# Meat list
meat <- c("chicken")

# Identify meat
for (i in meat) {
    protein_table <- protein_table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i) | str_detect(section, i)) & vegan=="non-veg"), 1, 0
        ))
}

# Temporary table to generate column for identified protein sources
temp_table <- protein_table %>% 
    pivot_longer(cols = matches("protein\\."), 
                 names_to = "protein", 
                 names_prefix = "protein\\.",
                 values_to = "binary") %>% 
    filter(binary==1)

# Join protein source 
protein_table <- protein_table %>% 
    select(!matches("protein\\.")) %>% # Dump binary protein columns
    left_join(
        temp_table %>% select(id, protein), 
        by="id") # rejoin for pivoted

# Menu section SQL table
section_sql <- table %>% 
    distinct(section) %>% 
    mutate(section_id = row_number(),
           .before = 1)

write.csv(section_sql, sprintf("%s_section.csv", chain), row.names = F)

## Import new Section IDs from SQL database
section_id_sql_assigned <- read.csv(sprintf("%s_section_sql.csv", chain))

## Replace Section IDs
section_sql <- section_sql %>% 
    inner_join(section_id_sql_assigned %>% select(!section_name),
               by = c("section_id"="temp_id"),
               suffix = c("_r", "_sql"))

# Item SQL table
item_sql <- table %>% 
    left_join(section_sql %>% select(!section_id), 
              by=c("section"="section")) %>% 
    select(!section) %>% 
    rename(item_id_r = id, item_name = name) 

write.csv(item_sql, sprintf("%s_item.csv", chain), row.names = F)

## Import new item IDs from SQL database
item_id_sql_assigned <- read.csv(sprintf("%s_item_sql.csv", chain))

# Protein SQL table
protein_sql <- protein_table %>%
    left_join(item_id_sql_assigned, 
              by=c("id"="temp_id")) %>%
    select(!id) %>% 
    select(item_id, protein) %>%
    drop_na(protein) 

write.csv(protein_sql, sprintf("%s_protein.csv", chain), row.names = F)