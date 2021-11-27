# vegan_restaurant_chain
A project inspired by [Wagamama's claim](https://www.wagamama.com/50-percent-plant-based) that they've made 50% of their menu plant-based.  
(Produced for the completion of the '[Data & SQL](https://codefirstgirls.org.uk/courses/classes/career-switcher/)' course run by Code First Girls.)  

The aim of the project was to see what percentage of the menus of major chain restaurants in the UK is suitable for vegans. As concern over not getting enough protein is a common justification raised against consuming more plant-based diets, the project also aims to identify the main protein source of menu items where possible.

## [scrape_menu.R](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/scrape_menu.R)
Specifies function scrape_menu() to get webpage html
- Uses [phantomjs](https://phantomjs.org/) headless browser to bypass delayed JavaScript content and scrape Deliveroo webpages, following [tutorial from R-bloggers](https://www.r-bloggers.com/2016/03/web-scraping-javascript-rendered-sites/)

Specifies function extract_menu() to extract relevant information from html
- Uses [rvest package](https://rvest.tidyverse.org/) 
- [SelectorGadget](https://rvest.tidyverse.org/articles/selectorgadget.html) used to find CSS selectors for item name & price, item description and menu sections
- Saves files for pre-processing

## Scripts for pre-processing
Cleans extracted information, assigns vegan status, category and menu section to items, identifies protein sources, generates csv files to insert data into SQL database. As IDs assigned in R not in sync with IDs in SQL, additional code in Nando's and Pizza Express file to update to IDs in SQL.
- [wagamama_process.R](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/wagamama_process.R)
- [nandos_process.R](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/nandos_process.R)
- [pizza_express_process.R](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/pizza_express_process.R)

## Database in mySQL
![Entity relationship diagram](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/vrc_er_diagram.png)
- [vegan_restaurant_chain_submission.sql](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/vegan_restaurant_chain_submission.sql) - Backup of MySQL database, use to reproduce database on another server
- [vrc_demo.sql](https://github.com/vtwkam1/vegan_restaurant_chain/blob/main/vrc_demo.sql) - Demos joins, views, stored procedures, stored functions, triggers and more complex queries


## [Tableau dashboard](https://public.tableau.com/app/profile/vanessa.kam/viz/vegan_restaurant_chain/1_Category) to explore database
