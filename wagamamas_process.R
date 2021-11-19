library(tidyverse)

source_table <- read.csv("wagamamas.csv")

dim(source_table) # check dimensions

# Simple cleaning
table <- source_table %>% 
    mutate(across(everything(), str_to_lower)) %>% # convert to lowercase
    mutate(name = str_replace(name, "new\\!\\s", ""), # remove "new!"
           price = as.numeric(str_replace(price, "[:symbol:]", ""))) %>%  # price to numeric
    distinct(name, .keep_all=T) # remove duplicates based on item name

# Remove irrelevant items
table <- table %>% 
    filter(!str_detect(name, "bundle")) %>% # remove bundles
    filter(between(row_number(), 1, (which(name=="still water")-1))) %>% # remove drinks
    filter(!between(row_number(), which(name=="chilli sambal paste (vg)"), which(name=="crispy fish bites (amai sauce)"))) # remove extras, sauces and kids

# Assign item ID
table <- table %>% 
    mutate(id = row_number(),
           .before = 1)

# Assign categories (manual)

# Assign menu sections
menu_section <- read.delim("wagamamas_menu_sections.txt")
menu_section <- as.character(menu_section[,1]) %>% str_to_lower()

## Tidy menu sections
menu_section <- menu_section %>% 
    str_replace_all("\\<[:graph:]*\\>", "") %>% 
    str_trim()

# Identify vegan options
table <- table %>% 
    mutate(vegan = case_when(
        str_detect(name, "(vg)") ~ "vegan",
        str_detect(name, "(v)") ~ "vegetarian",
        TRUE ~ "non-veg"))

# Vegan protein list
veg_protein <- c("seitan", "tofu", "soya")

# Identify vegan proteins
for (i in vegan_protein) {
    table <- table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & (vegan %in% c("vegan", "vegetarian"))), 1, 0
        ))
}

# Meat list
meat <- c("chicken", "pork", "squid", "prawn", "beef", "salmon", "steak", "cod", "duck")

# Identify meat
for (i in meat) {
    table <- table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & vegan=="non-veg"), 1, 0
        ))
}

# Temporary table to generate column for identified protein sources
temp_table <- table %>% 
    pivot_longer(cols = matches("protein\\."), 
                 names_to = "protein", 
                 names_prefix = "protein\\.",
                 values_to = "binary") %>% 
    filter(binary==1) %>%
    select(id, protein)

# Join protein source 
table <- table %>% 
    select(!matches("protein\\.")) %>% # Dump binary protein columns
    left_join(temp_table, by="id") # rejoin for pivoted

## Identify vegan mock meats with unspecified protein source
meat_string <- paste(meat, collapse="|")

table <- table %>% 
    mutate(protein = if_else(
        ((str_detect(name, meat_string) | str_detect(description, meat_string)) & (vegan %in% c("vegan", "vegetarian")) & is.na(protein)), "unknown mock meat", protein))

# 