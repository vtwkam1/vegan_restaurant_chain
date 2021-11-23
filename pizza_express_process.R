library(tidyverse)
library(stringi)

chain <- "pizza_express"

source_table <- read.csv(sprintf("%s.csv", chain))

dim(source_table) # check dimensions (112 rows)

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
    filter(between(row_number(), 1, (which(name=="coca-cola classic (330ml)")-1))) # drop drinks

nrow(table) # 85 rows

# Assign menu sections
menu_section <- read.delim(sprintf("%s_menu_section.txt", chain), header=F)
menu_section <- as.character(menu_section[,1]) %>% str_to_lower()

table %>% 
    count(name) %>% 
    filter(n>1)

## Assign sections (needs updating)
table <- table %>% 
    mutate(section = case_when(
        between(row_number(), which(name=="festive sharer"), which(name=="festive banquet")) ~ "Restaurant picks",
        between(row_number(), which(name=="margherita (v)")[1], which(name=="garlic bread with mozzarella (v)")[1]) ~ menu_section[1],
        between(row_number(), which(name=="piccolo to go"), which(name=="pizza & drink bundle for 4")) ~ menu_section[2],
        between(row_number(), which(name=="dough balls 'pizzaexpress' (v)"), which(name=="roasted tomatoes (v) (ve) (gf)")) ~ menu_section[3],
        between(row_number(), which(name=="margherita (v)")[2], which(name=="vegan mushroom & pine nut (v) (ve)")[1]) ~ menu_section[4],
        between(row_number(), which(name=="pollo pesto (gf)"), which(name=="cannelloni (v)")) ~ menu_section[5],
        between(row_number(), which(name=="calzone 'nduja"), which(name=="calzone verdure (v) (ve)")[1]) ~ menu_section[6],
        between(row_number(), which(name=="sweet & smoky bbq dip (v) (gf)"), which(name=="italian tomato dip (v) (ve) (gf)")) ~ menu_section[7],
        between(row_number(), which(name=="vegan nourish bowl (v) (ve)"), which(name=="grand chicken caesar")) ~ menu_section[8],
        between(row_number(), which(name=="calzone verdure (v) (ve)")[2], which(name=="vegan mushroom & pine nut (v) (ve)")[2]) ~ menu_section[9],
        between(row_number(), which(name=="chocolate brownie (v) (gf)"), which(name=="vegan snowball dough balls (v) (ve)")[2]) ~ menu_section[10]))

## Identify duplicates
duplicated <- table %>% 
    count(name) %>% 
    filter(n>1)

table %>% 
    select(name, section) %>% 
    filter(name %in% duplicated$name)

table %>% 
    select(name, section) %>% 
    filter(section %in% c("Restaurant picks", "pizzeria bundles", "most popular", "vegan menu")) %>% 
    mutate(duplicated = name %in% duplicated$name) 

section_drop <- c("Restaurant picks", "pizzeria bundles", "most popular", "dips")

# number of rows dropped when unwanted sections dropped
table %>% 
    count(section) %>% 
    filter(section %in% section_drop) %>% 
    summarise(sum = sum(n)) # 17

table %>% 
    filter(section == "vegan menu" & name %in% duplicated$name) %>% 
    count() # 7
    
table <- table %>% 
    filter(!section %in% section_drop) %>% # drop sections
    filter(!(section == "vegan menu" & name %in% duplicated$name)) # drop duplicated vegan items

nrow(table) # 61

# Assign categories
table %>% 
    distinct(section)

table <- table %>% 
    mutate(category = case_when(
        section %in% c("starters") ~ "sides",
        section %in% c("pizzas", "al forno", "calzone", "salads", "vegan menu") ~ "mains",
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
table <- table %>% 
    mutate(vegan = case_when(
        str_detect(name, "\\(ve\\)") ~ "vegan",
        str_detect(name, "\\(v\\)") & !str_detect(name, "\\(ve\\)") ~ "vegetarian",
        TRUE ~ "non-veg"))

protein_table <- table

# Vegan protein list
veg_protein <- c("quorn")

# Identify vegan proteins
for (i in veg_protein) {
    protein_table <- protein_table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & (vegan %in% c("vegan", "vegetarian"))), 1, 0
        ))
}

# Meat list
meat <- c("calamari", "chicken", "pepperoni", "beef", "porchetta", "sausage", "ham", "pork", "anchovies", "tuna", "pancetta")

pork_meat <- c("porchetta", "sausage", "ham", "pancetta")

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
    filter(binary==1) %>% 
    mutate(protein = if_else(protein %in% pork_meat, "pork", protein)) %>% 
    distinct(name, protein, .keep_all = T)
    

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