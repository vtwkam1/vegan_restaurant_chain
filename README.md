# vegan_restaurant_chain
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


## [Tableau dashboard](https://public.tableau.com/app/profile/vanessa.kam/viz/vegan_restaurant_chain/1_Category) to explore database
