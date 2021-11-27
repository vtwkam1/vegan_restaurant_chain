USE vegan_restaurant_chain;

-- TASK: Create relational DB of your choice with minimum 5 tables
SHOW TABLES;

-- TASK: Set Primary and Foreign Key constraints to create relations
-- between the tables
DESCRIBE chain;
DESCRIBE menu;
DESCRIBE section;
DESCRIBE item;
DESCRIBE item_protein;

-- TASK: Using any type of the joins create a view that combines multiple
-- tables in a logical way

	-- Joining to show item name, vegan status, category, menu section name and chain name
    -- (c.chain_id kept for later query)
CREATE OR REPLACE VIEW item_section_chain
AS
	SELECT i.item_name, i.vegan, i.category, s.section_name, c.chain_name, c.chain_id
    FROM item i
    LEFT JOIN section s ON s.section_id = i.section_id
    LEFT JOIN menu m ON m.menu_id = s.menu_id
    LEFT JOIN chain c ON c.chain_id = m.chain_id;
    
SELECT * FROM item_section_chain;

-- TASK: In your database, create a stored function that can be applied to a
-- query in your DB

	-- Stored function 'incomplete_string' to detect '......' in TEXT datatype input
SHOW FUNCTION STATUS
WHERE db = "vegan_restaurant_chain";

	-- Using stored function incomplete_string to on item description column
		-- Initial look at descriptions
SELECT item_name, description
FROM item
LIMIT 20;

		-- Use function
SELECT item_name, description, incomplete_string(description) AS description_complete
FROM item;

		-- Use function and filter for incomplete descriptions
SELECT item_name, description, incomplete_string(description) AS description_complete
FROM item
WHERE incomplete_string(description) = "incomplete";

-- TASK: Prepare an example query with a subquery to demonstrate how to
-- extract data from your DB for analysis

	-- Select names of all sides which contain chicken, beef or pork
SELECT i.item_name
FROM item i
WHERE i.item_id IN (SELECT p.item_id
	FROM item_protein p
    WHERE p.protein IN ('chicken', 'beef', 'pork')) AND i.category = "sides";

-- TASK: Create DB diagram where all table relations are shown

-- ADVANCED
-- TASK: In your database, create a stored procedure and
-- demonstrate how it runs
	SHOW PROCEDURE STATUS 
    WHERE db = "vegan_restaurant_chain";

	-- Counts number of items for given chain name
CALL total_items("wagamama");
    
    -- Extracts item_id, item name and protein for given chain name
CALL chain_proteins("nandos"); 
    
-- TASK: In your database, create a trigger and demonstrate how it
-- runs
	-- chain_name_lower: (Before insert) Converts chain name to lowercase
	-- new_chain: (After insert) Extracts chain_id for newly inserted chain
SHOW TRIGGERS
FROM vegan_restaurant_chain
LIKE "chain";

SELECT * FROM chain;

START TRANSACTION;
	
    -- chain_id not specified, auto-generated
INSERT INTO chain (chain_name)
	VALUES ('McDonalds');
        
SELECT * FROM chain;
SELECT @current_chain_id;

SELECT * 
FROM chain
WHERE chain_id = @current_chain_id;
    
ROLLBACK;

-- TASK: In your database, create an event and demonstrate how it
-- runs

	-- NA

-- TASK: Create a view that uses at least 3-4 base tables; prepare
-- and demonstrate a query that uses the view to produce a
-- logically arranged result set for analysis.
	
    -- View 'item_section_chain' created before
SELECT * FROM item_section_chain;
    
    -- First subquery: Queries item_section_chain, counts number of items by category (sides, mains,
	-- desserts) for each restaurant chain
	-- Second subquery: Queries item_section_chain, counts number of vegan items by category (sides, mains,
	-- desserts) for each restaurant chain
    -- Joins first and second subquery using category and chain_id
    -- Calculates percentage of vegan items in each category for each chain_id
    CREATE OR REPLACE VIEW perc_vegan_by_section
    AS
		SELECT v.nvegan_items, i.nitems, ROUND((100*v.nvegan_items/i.nitems),2) AS percentage_vegan, i.category, i.chain_name
		FROM (
			SELECT COUNT(*) AS nitems, category, chain_name, chain_id
			FROM item_section_chain
			GROUP BY category, chain_id) i
		LEFT JOIN (
			SELECT SUM(IF(vegan="vegan", 1, 0)) AS nvegan_items, category, chain_name, chain_id
            FROM item_section_chain
            GROUP BY category, chain_id) v
		ON v.chain_id = i.chain_id AND v.category = i.category;
   
	SELECT * FROM perc_vegan_by_section;
    
-- TASK: Prepare an example query with group by and having to
-- demonstrate how to extract data from your DB for analysis

	-- Top three most common proteins in a mains at Pizza Express and average price
SELECT COUNT(*) AS n_entries, p.protein, ROUND(AVG(i.price),2) AS avg_price, i.category, c.chain_name
FROM item_protein p
LEFT JOIN item i ON i.item_id = p.item_id
LEFT JOIN section s ON s.section_id = i.section_id
LEFT JOIN menu m ON m.menu_id = s.menu_id
LEFT JOIN chain c ON c.chain_id = m.menu_id
GROUP BY c.chain_id, i.category, p.protein
HAVING i.category = "mains" AND c.chain_name = "pizza express"
ORDER BY n_entries DESC
LIMIT 3;    