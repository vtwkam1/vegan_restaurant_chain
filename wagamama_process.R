library(tidyverse)
library(stringi)

source_table <- read.csv("wagamama.csv")

dim(source_table) # check dimensions (141 rows)

# Simple cleaning
table <- source_table %>% 
    mutate(price = as.numeric(str_replace(price, "[:symbol:]", ""))) %>% 
    mutate(across(where(is.character), 
                  ~ str_replace_all(.x, "\\<[:graph:]*\\>", "") %>% 
                      stringi::stri_trans_general("latin-ascii") %>%
                      str_to_lower %>% 
                      str_trim)) %>% 
    mutate(name = str_replace(name, "new(?=\\s{1})", "") %>% 
               str_trim) %>% 
    filter(between(row_number(), 1, (which(name=="still water")-1))) # drop drinks

nrow(table) # 115 rows

# Identify sold out items to manually add description
table %>% 
    filter(description == "currently sold out")

# Assign menu sections
menu_section <- read.delim("wagamama_menu_section.txt", header=F)
menu_section <- as.character(menu_section[,1]) %>% str_to_lower()

## Tidy menu sections
menu_section <- menu_section %>% 
    str_replace_all("\\<[:graph:]*\\>", "") %>% 
    str_trim()

## Assign sections (needs updating)
table <- table %>% 
    mutate(section = case_when(
        between(row_number(), which(name=="wagamama rookie bundle"), which(name=="bowls for souls bundle")) ~ menu_section[1],
        between(row_number(), which(name=="new! spicy teriyaki vegan ‘chicken’ buns (vg)"), which(name=="no duck donburi (vg)")) ~ menu_section[2],
        between(row_number(), which(name=="vegan sticky 'ribs' (vg)"), which(name=="chicken yakitori")) ~ menu_section[3],
        between(row_number(), which(name=="new! hoisin pulled duck buns"), which(name=="mixed mushroom hirata steamed buns (vg)")) ~ menu_section[4],
        between(row_number(), which(name=="steamed chicken (gyoza)"), which(name=="fried prawn (gyoza)")) ~ menu_section[5],
        between(row_number(), which(name=="salmon harusame salad"), which(name=="tofu harusame salad (vg)")[2]) ~ menu_section[6],
        between(row_number(), which(name=="katsu curry (chicken)"), which(name=="firecracker curry (tofu) (vg)")[2]) ~ menu_section[7],
        between(row_number(), which(name=="yaki soba (chicken + prawn) (thin noodles)"), which(name=="ginger chicken udon (thick noodles)")) ~ menu_section[8],
        between(row_number(), which(name=="grilled chicken ramen"), which(name=="shirodashi ramen (pork belly)")) ~ menu_section[9],
        between(row_number(), which(name=="teriyaki donburi (chicken)"), which(name=="shu's 'shiok' chicken (under 600 calories)")) ~ menu_section[10],
        between(row_number(), which(name=="chilli sambal paste (vg)"), which(name=="noodles")) ~ menu_section[11],
        between(row_number(), which(name=="katsu curry sauce"), which(name=="shichimi")) ~ menu_section[12],
        between(row_number(), which(name=="mini chicken katsu (katsu curry sauce)"), which(name=="crispy fish bites (amai sauce)")) ~ menu_section[13],
        between(row_number(), which(name=="white chocolate + ginger cheesecake"), which(name=="white chocolate + ginger cheesecake")) ~ menu_section[14]))

## Identify duplicates
duplicated <- table %>% 
    count(name) %>% 
    filter(n>1)

### check if all duplicates in "the vegan edit"
table %>% 
    filter(section=="the vegan edit") %>% 
    mutate(duplicated = name %in% duplicated$name) # Two items shown as not duplicated due to different naming

section_drop <- c("soulful bundles", "the vegan edit", "extras", "sauces", "kids")

# number of rows dropped when unwanted sections dropped
table %>% 
    count(section) %>% 
    filter(section %in% section_drop) %>% 
    summarise(sum = sum(n))

table <- table %>% 
    filter(!section %in% section_drop) %>% # drop sections
    mutate(name = str_replace(name, "new\\!", "") %>% str_trim()) # tidy

nrow(table)

# Assign categories
table <- table %>% 
    mutate(category = case_when(
        section %in% c("gyoza", "hirata steamed buns", "sides") ~ "sides",
        section %in% c("donburi", "ramen", "teppanyaki", "harusame salad", "curry") ~ "mains",
        section %in% c("desserts") ~ "desserts"
    ))

# Assign item ID
table <- table %>% 
    mutate(id = row_number(),
           .before = 1)

# Identify vegan options
table <- table %>% 
    mutate(vegan = case_when(
        str_detect(name, "\\(vg\\)") ~ "vegan",
        str_detect(name, "\\(v\\)") ~ "vegetarian",
        TRUE ~ "non-veg"))

protein_table <- table

# Vegan protein list
veg_protein <- c("seitan", "tofu", "soya")

# Identify vegan proteins
for (i in veg_protein) {
    protein_table <- protein_table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & (vegan %in% c("vegan", "vegetarian"))), 1, 0
        ))
}

# Meat list
meat <- c("chicken", "pork", "squid", "prawn", "beef", "salmon", "steak", "cod", "duck")

# Identify meat
for (i in meat) {
    protein_table <- protein_table %>% 
        mutate("protein.{i}" := if_else(
            ((str_detect(name, i) | str_detect(description, i)) & vegan=="non-veg"), 1, 0
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

## Identify vegan mock meats with unspecified protein source
meat_string <- paste(meat, collapse="|")

protein_table <- protein_table %>% 
    mutate(protein = if_else(
        ((str_detect(name, meat_string) | str_detect(description, meat_string)) & (vegan %in% c("vegan", "vegetarian")) & is.na(protein)), "unknown mock meat", protein))

# Protein SQL table
protein_sql <- protein_table %>% 
    select(id, protein) %>%
    drop_na(protein) %>% 
    rename(item_id = id)

write.csv(protein_sql, "wagamama_protein.csv", row.names = F)

# Menu section SQL table
section_sql <- table %>% 
    distinct(section) %>% 
    mutate(section_id = row_number(),
           .before = 1)

write.csv(section_sql, "wagamama_section.csv", row.names = F)

# Item SQL table
item_sql <- table %>% 
    left_join(section_sql, 
              by="section") %>% 
    select(!section) %>% 
    rename(item_id = id, item_name = name)

write.csv(item_sql, "wagamama_item.csv", row.names = F)

