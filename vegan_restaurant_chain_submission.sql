-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: vegan_restaurant_chain
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `#tableau_10_sid_00000056_1_group`
--

DROP TABLE IF EXISTS `#tableau_10_sid_00000056_1_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `#tableau_10_sid_00000056_1_group` (
  `Protein (exists)` varchar(50) NOT NULL DEFAULT '',
  `protein` varchar(50) NOT NULL,
  KEY `_tidx_#Tableau_10_sid_00000056_1_Group_2a` (`protein`(17))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `#tableau_10_sid_00000056_1_group`
--

LOCK TABLES `#tableau_10_sid_00000056_1_group` WRITE;
/*!40000 ALTER TABLE `#tableau_10_sid_00000056_1_group` DISABLE KEYS */;
INSERT INTO `#tableau_10_sid_00000056_1_group` VALUES ('Identified','anchovies'),('Identified','beef'),('Identified','calamari'),('Identified','chicken'),('Identified','cod'),('Identified','duck'),('Identified','pea-protein'),('Identified','pepperoni'),('Identified','pork'),('Identified','prawn'),('Identified','quorn'),('Identified','salmon'),('Identified','seitan'),('Identified','soya'),('Identified','squid'),('Identified','steak'),('Identified','tofu'),('Identified','tuna'),('Identified','unknown mock meat');
/*!40000 ALTER TABLE `#tableau_10_sid_00000056_1_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `#tableau_9_sid_00000054_1_group`
--

DROP TABLE IF EXISTS `#tableau_9_sid_00000054_1_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `#tableau_9_sid_00000054_1_group` (
  `Protein (exists)` varchar(50) NOT NULL DEFAULT '',
  `protein` varchar(50) NOT NULL,
  KEY `_tidx_#Tableau_9_sid_00000054_1_Group_2a` (`protein`(17))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `#tableau_9_sid_00000054_1_group`
--

LOCK TABLES `#tableau_9_sid_00000054_1_group` WRITE;
/*!40000 ALTER TABLE `#tableau_9_sid_00000054_1_group` DISABLE KEYS */;
INSERT INTO `#tableau_9_sid_00000054_1_group` VALUES ('Identified','anchovies'),('Identified','beef'),('Identified','calamari'),('Identified','chicken'),('Identified','cod'),('Identified','duck'),('Identified','pea-protein'),('Identified','pepperoni'),('Identified','pork'),('Identified','prawn'),('Identified','quorn'),('Identified','salmon'),('Identified','seitan'),('Identified','soya'),('Identified','squid'),('Identified','steak'),('Identified','tofu'),('Identified','tuna'),('Identified','unknown mock meat');
/*!40000 ALTER TABLE `#tableau_9_sid_00000054_1_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('desserts'),('mains'),('sides');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chain`
--

DROP TABLE IF EXISTS `chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chain` (
  `chain_id` int NOT NULL AUTO_INCREMENT,
  `chain_name` varchar(50) NOT NULL,
  PRIMARY KEY (`chain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chain`
--

LOCK TABLES `chain` WRITE;
/*!40000 ALTER TABLE `chain` DISABLE KEYS */;
INSERT INTO `chain` VALUES (1,'wagamama'),(2,'nandos'),(3,'pizza express');
/*!40000 ALTER TABLE `chain` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `chain_name_lower` BEFORE INSERT ON `chain` FOR EACH ROW BEGIN
	SET NEW.chain_name = LOWER(NEW.chain_name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_chain` AFTER INSERT ON `chain` FOR EACH ROW BEGIN
	SET @current_chain_id = NEW.chain_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(500) NOT NULL,
  `description` text,
  `price` decimal(6,2) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `vegan` varchar(50) DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `section_id` (`section_id`),
  KEY `category` (`category`),
  KEY `vegan` (`vegan`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE,
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON DELETE SET NULL,
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`vegan`) REFERENCES `vegan` (`vegan`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'vegan sticky \'ribs\' (vg)','mushroom + soya protein \'ribs\'. sweet + spicy stickysauce. sesame seeds. spring onion...',6.75,'sides','vegan',1),(2,'chilli squid','crispy fried squid dusted with shichimi. served with a chilli coriander dipping sauce',7.25,'sides','non-veg',1),(3,'ebi katsu (prawn)','prawns in crispy panko breadcrumbs. coriander. freshlime. chilli + garlic dipping sauce...',7.25,'sides','non-veg',1),(4,'edamame with salt (vg)','beans with salt...',4.50,'sides','vegan',1),(5,'edamame with chilli garlic salt (vg)','beans with chilli-garlic salt...',4.50,'sides','vegan',1),(6,'bang bang cauliflower (vg)','crispy cauliflower. firecracker sauce. red + spring onion.fresh ginger. coriander...',5.50,'sides','vegan',1),(7,'wok-fried greens (vg)','tenderstem broccoli. bok choi. garlic + soy sauce...',4.75,'sides','vegan',1),(8,'tama squid','crispy fried squid balls. okonomiyaki sauce. veganmayonnaise. seaweed. bonito flakes...',7.50,'sides','non-veg',1),(9,'chicken yakitori','marinated chicken skewers. spicy teriyaki sauce. shichimi.spring onions...',6.95,'sides','non-veg',1),(10,'hoisin pulled duck buns','two fluffy asian buns filled with hoisin pulled duck.cucumber. hoisin sauce. vegan mayonnaise...',6.50,'sides','non-veg',2),(11,'spicy teriyaki vegan \'chicken\' buns (vg)','two fluffy asian buns filled with karikari vegan \'chicken\'.asian slaw. fried shallots. spicy teriyaki sauce...',6.50,'sides','vegan',2),(12,'korean barbecue beef hirata steamed buns','two fluffy asian buns filled with korean barbecue beef. redonion. asian slaw. sriracha vegan mayonnaise....',6.50,'sides','non-veg',2),(13,'mixed mushroom hirata steamed buns (vg)','two fluffy asian buns filled with panko aubergine. mixedmushrooms. vegan mayonnaise. coriander...',6.50,'sides','vegan',2),(14,'steamed chicken (gyoza)','served grilled and with a dipping sauce...',6.50,'sides','non-veg',3),(15,'fried duck (gyoza)','served with a dipping sauce...',6.50,'sides','non-veg',3),(16,'fried yasai gyoza (vegetable) (vg)','served with a dipping sauce...',6.50,'sides','vegan',3),(17,'steamed pulled pork (gyoza)','served grilled and with a dipping sauce...',6.50,'sides','non-veg',3),(18,'fried prawn (gyoza)','served with a dipping sauce...',6.50,'sides','non-veg',3),(19,'salmon harusame salad','glass noodles. peashoots. edamame. adzuki beans. redradish. pickled asian slaw. tamari soy dressing. mint. slic......',11.25,'mains','non-veg',4),(20,'tofu harusame salad (vg)','glass noodles. peashoots. edamame. adzuki beans. redradish. pickled asian slaw. tamari soy dressing. mint. slic......',9.75,'mains','vegan',4),(21,'katsu curry (chicken)','chicken coated in crispy panko breadcrumbs. aromaticcurry sauce. sticky white rice. side salad...',11.25,'mains','non-veg',5),(22,'katsu curry (yasai) - sweet potato, aubergine + butternut squash (vg)','vegetables coated in crispy panko breadcrumbs. aromatickatsu curry sauce. sticky white rice. side salad...',10.25,'mains','vegan',5),(23,'vegatsu (katsu curry) (vg)','*refreshed recipe* tofu + soya protein in crispy pankobreadcrumbs. aromatic katsu curry sauce. sticky white ri......',11.25,'mains','vegan',5),(24,'hot katsu curry (chicken)','spicy! chicken coated in panko breadcrumbs. spicy currysauce. sticky white rice. side salad...',11.50,'mains','non-veg',5),(25,'hot katsu curry (yasai) - sweet potato, aubergine + butternut squash (vg)','spicy! panko coated vegetables. spicy curry sauce. stickywhite rice. side salad...',10.50,'mains','vegan',5),(26,'hot vegatsu (katsu curry) (vg)','*refreshed recipe* spicy! vegan katsu curry. tofu + soyaprotein in crispy panko breadcrumbs. spicy curry sauce.......',11.50,'mains','vegan',5),(27,'naked katsu','grilled curried chicken. brown rice. edamame. shreddedcarrots. dressed mixed leaves. japanese pickles. side of......',11.25,'mains','non-veg',5),(28,'raisukaree curry (chicken)','a mild, coconut and citrus curry, with chicken, mangetout, peppers, red and spring onions. served with white rice, a sprinkle of mixed sesame seeds, red chillies, coriander and fresh lime',12.95,'mains','non-veg',5),(29,'raisukaree curry (prawn)','a mild, coconut and citrus curry, with prawns, mangetout, peppers, red and spring onions. served with white rice, a sprinkle of mixed sesame seeds, red chillies, coriander and fresh lime',13.95,'mains','non-veg',5),(30,'raisukaree curry (tofu) (vg)','mild + citrusy. tofu. coconut. mangetout. peppers. red + spring onion. sesame seeds. chilli. coriander. fresh lime. white sticky rice',11.95,'mains','vegan',5),(31,'firecracker curry (chicken)','bold + fiery. mangetout. red + green peppers. onion. hotred chillies. sesame seeds. shichimi. fresh lime. white rice...',12.50,'mains','non-veg',5),(32,'firecracker curry (prawn)','bold + fiery. mangetout. red + green peppers. onion. hotred chillies. sesame seeds. shichimi. fresh lime. white rice...',13.50,'mains','non-veg',5),(33,'firecracker curry (tofu) (vg)','bold + fiery. tofu. hot red chillies. mangetout. red + greenpeppers. onion. sesame seeds. shichimi. fresh lime. whit......',11.50,'mains','vegan',5),(34,'yaki soba (chicken + prawn) (thin noodles)','thin noodles. egg. chicken. prawns. peppers.beansprouts. white + spring onion. fried shallots. pickled......',10.50,'mains','non-veg',6),(35,'yaki soba (yasai) - mushroom + vegetable (thin noodles) (v)','thin noodles. egg. peppers. beansprouts. white + springonion. fried shallots. pickled ginger. sesame seeds...',9.50,'mains','vegetarian',6),(36,'yaki soba (yasai) - mushroom + vegetable (rice noodles) (vg)','rice noodles. mushrooms. peppers. beansprout. white +spring onion. fried shallots. pickled ginger. sesame seeds...',9.50,'mains','vegan',6),(37,'yaki soba (yasai) - mushroom + vegetable (thick noodles) (vg)','thick noodles. mushrooms. peppers. beansprout. white +spring onion. fried shallots. pickled ginger. sesame seeds...',9.50,'mains','vegan',6),(38,'pad thai (chicken + prawn) (rice noodles)','rice noodles. amai sauce. egg. beansprouts. leeks. chilli.red + spring onion. fried shallots. mint. coriander. fresh l......',11.50,'mains','non-veg',6),(39,'yasai pad thai - tofu + vegetables (rice noodles) (vg)','rice noodles. amai sauce. tofu. beansprouts. leek. chilli.red + spring onions. fried shallots. mint. coriander...',10.50,'mains','vegan',6),(40,'yasai pad thai - tofu + vegetables (rice noodles) (v)','rice noodles. amai sauce. egg. tofu. beansprouts. leek.chilli. red + spring onions. fried shallots. mint. coriander...',10.50,'mains','vegetarian',6),(41,'yaki udon (chicken + prawn) (thick noodles)','thick noodles. curry oil. chicken. prawns. chikuwa. egg.beansprouts. leeks. mushrooms. peppers. fried shallots.......',11.25,'mains','non-veg',6),(42,'teriyaki soba (sirloin steak) (thin noodles)','thin noodles. curry oil. mangetout. bok choi. red + springonion. chilli. beansprouts. teriyaki sauce. coriander. ses......',15.25,'mains','non-veg',6),(43,'teriyaki soba (salmon) (may contain small bones) (thin noodles)','thin noodles. curry oil. mangetout. bok choi. red + springonion. chilli. beansprouts. teriyaki sauce. sesame seeds...',14.25,'mains','non-veg',6),(44,'ginger chicken udon (thick noodles)','thick noodles. mangetout. chicken. egg. chilli.beansprouts. red + spring onion. pickled ginger. coriander...',11.25,'mains','non-veg',6),(45,'grilled chicken ramen','with seasonal greens. menma. spring onion. rich chicken broth with dashi + miso. marinated chicken.',10.50,'mains','non-veg',7),(46,'chilli ramen (chicken)','noodles in a spicy chicken broth topped with grilled chicken, red onion, spring onions, beansprouts, chilli, coriander and fresh lime',12.25,'mains','non-veg',7),(47,'tantanmen beef brisket ramen','korean barbecue beef. half a tea-stained egg. menma.kimchi. spring onion. coriander. chilli oil. extra rich chick......',13.95,'mains','non-veg',7),(48,'kare burosu ramen (tofu) (vg)','shichimi coated silken tofu. grilled mushrooms. seasonalgreens. carrot. chilli. coriander. udon noodles. curried v......',11.95,'mains','vegan',7),(49,'miso-glazed cod ramen','bok choy. menma. spring onion. chilli oil. light vegetablebroth...',14.50,'mains','non-veg',7),(50,'chilli ramen (sirlion steak)','red + spring onion. beansprouts. coriander. fresh lime.spicy chicken broth...',13.95,'mains','non-veg',7),(51,'shirodashi ramen (pork belly)','slow-cooked with seasonal greens. menma. spring onion.wakame. half a tea-stained egg. rich chicken broth with ......',12.25,'mains','non-veg',7),(52,'teriyaki donburi (chicken)','teriyaki sauce. shredded carrots. seasonal greens. springonion. sesame seeds. side of kimchee...',10.95,'mains','non-veg',8),(53,'teriyaki donburi (beef brisket)','teriyaki sauce. shredded carrots. seasonal greens. springonion. sesame seeds. side of kimchee...',12.75,'mains','non-veg',8),(54,'grilled duck donburi (may contain small bones)','shredded in spicy teriyaki sauce. carrot. mangetout. sweetpotato. red + spring onion. fried egg. cucumber. side of ......',14.75,'mains','non-veg',8),(55,'no duck donburi (vg)','shredded seitan + shiitake mushrooms in a cherry hoisinsauce. edamame beans. kimchee. coconut + sriracha v......',12.25,'mains','vegan',8),(56,'shu\'s shiok jackfruit (vg)','turmeric + ginger jackfruit, roasted and served on a bed of coconut + lemongrass dressed rice. pickled slaw + radish. chilli. coriander. caramelised lime.',10.95,'mains','vegan',8),(57,'shu\'s \'shiok\' chicken (under 600 calories)','currently sold out',11.25,'mains','non-veg',8),(58,'white chocolate + ginger cheesecake','with toffee + ginger sauce...',6.50,'desserts','vegetarian',9),(59,'spicy mixed olives','spicy mixed olives co-starring mushrooms, garlic and redpepper....',3.75,'sides','vegan',10),(60,'peri-peri nuts','crunchy almonds, cashews and macadamia nuts in a fieryperi-peri seasoning. ...',3.75,'sides','vegan',10),(61,'halloumi sticks & dip','five chunky sticks of grilled halloumi with chilli jam fordipping....',4.25,'sides','vegetarian',10),(62,'chicken butterfly','two chicken breasts, flame-grilled with crispy skin. infusedwith peri-peri and served in your choice of spice. ...',8.25,'mains','non-veg',11),(63,'1/2 chicken','one breast and one leg, flame-grilled and infused withperi-peri. served on the bone with crispy skin, in your ......',7.95,'mains','non-veg',11),(64,'4 boneless chicken thighs','flame-grilled with crispy skin. infused with peri-peri andserved in your choice of spice. ...',8.25,'mains','non-veg',11),(65,'whole chicken','flame-grilled, infused with peri-peri and served in yourchoice of spice. cut into quarters and perfect with sides,......',14.50,'mains','non-veg',11),(66,'1/4 chicken','flame-grilled, infused with peri-peri and perfect forpairing with sides. served on the bone with crispy skin, i......',4.25,'mains','non-veg',11),(67,'3 chicken wings','flame-grilled, infused with peri-peri and perfect forpairing with sides. served in your choice of spice....',3.95,'mains','non-veg',11),(68,'5 chicken wings','flame-grilled, infused with peri-peri and perfect forpairing with sides. served in your choice of spice....',5.95,'mains','non-veg',11),(69,'10 chicken wings','flame-grilled with crispy skin and great for sharing! ...',10.95,'mains','non-veg',11),(70,'15 chicken wings','bigger is always better. a feast that\'s great for sharing! ...',13.95,'mains','non-veg',11),(71,'10 wing roulette','think you can handle the heat? take on our challenge -10 wings in various heats. (it\'s not for the faint-hearted!)....',10.95,'mains','non-veg',11),(72,'sunset burger','two chicken thighs, melting cheddar cheese, smoky redpepper chutney, lettuce and lemon & herb mayo in a b......',8.25,'mains','non-veg',12),(73,'grilled chicken burger','chicken breast infused with peri-peri and grilled in yourfavourite spice. served in a portuguese roll with lemon ......',6.95,'mains','non-veg',12),(74,'grilled chicken wrap','chicken breast infused with peri-peri and grilled to yourfavourite spice. served in a wrap with lettuce, lightly spic......',6.95,'mains','non-veg',12),(75,'double chicken burger','two chicken breasts infused with peri-peri and grilled inyour favourite spice. served in a portuguese roll with le......',10.25,'mains','non-veg',12),(76,'double chicken wrap','two chicken breasts infused with peri-peri and grilled toyour favourite spice. served in a wrap with lettuce, lightl......',10.25,'mains','non-veg',12),(77,'the great imitator burger','our peri-plant strips are made from pea-protein but tastejust like our famous peri-peri chicken. served in a por......',6.95,'mains','vegan',12),(78,'the great imitator wrap','our peri-plant strips are made from pea-protein but tastejust like our famous peri-peri chicken. served with pla......',6.95,'mains','vegan',12),(79,'peri-salted chips','crispy and sprinkled with peri-peri salt. ...',2.95,'sides','vegan',13),(80,'chips','crispy and delicious!...',2.95,'sides','vegan',13),(81,'garlic bread','grilled for the perfect crunch! ...',2.95,'sides','vegan',13),(82,'coleslaw','packed full of crunchy chopped vegetables in a lightlyspiced mayo. ...',2.95,'sides','vegetarian',13),(83,'spicy rice','lightly spiced rice. one of our signature sides!...',2.95,'sides','vegan',13),(84,'corn on the cob','crunchy, crisp and sweet. flame-grilled and served withbutter. ...',2.95,'sides','vegetarian',13),(85,'mixed leaf salad','served with balsamic dressing...',2.95,'sides','vegan',13),(86,'rainbow slaw','a fresh mix of crunchy veg in a tangy mustard dressing.topped with seeds....',2.95,'sides','vegan',13),(87,'gooey caramel cheesecake','rich and creamy caramel cheesecake on a crumblybiscuit base. served with cream to pour on....',4.75,'desserts','vegetarian',14),(88,'salted caramel brownie','rich chocolate brownie with a delicious hint of saltedcaramel. ...',2.75,'desserts','vegetarian',14),(89,'dough balls \'pizzaexpress\' (v)','no one does garlic butter like we do. freshly made dailywith creamy butter and whole crushed garlic...',3.95,'sides','vegetarian',15),(90,'halloumi bites (v) (gf)','crispy coated halloumi with italian tomato dip and parsley...',4.65,'sides','vegetarian',15),(91,'dough balls doppio (v)','double helpings with garlic butter, basil & pine kernelpesto and smoky tomato harissa...',8.35,'sides','vegetarian',15),(92,'calamari','lightly crumbed calamari with caesar dressing, lemon andparsley...',6.45,'sides','non-veg',15),(93,'lemon & herb chicken wings (gf)','new recipe house dressing dip and parsley...',6.30,'sides','non-veg',15),(94,'bruschetta originale \'pizzaexpress\' (v)','freshly-baked dough topped with our signature garlicbutter, fresh tomatoes, red onion and basil & pine kerne......',5.50,'sides','vegetarian',15),(95,'buffalo mozzarella & tomato salad (v) (gf)','beautifully soft luxurious buffalo milk mozzarella with freshtomatoes and basil & pine kernel pesto...',4.95,'sides','vegetarian',15),(96,'garlic bread with mozzarella (v)','for dough lovers, a perfect prelude to the main course;smothered with garlic butter and melted mozzarella...',4.95,'sides','vegetarian',15),(97,'polenta chips (v)','rosemary polenta chips with gran milano cheese, andhoney & mustard dip...',4.15,'sides','vegetarian',15),(98,'vegan dough balls \'pizzaexpress\' (v) (ve)','a pizzaexpress classic, served with smoky tomato harissa...',3.95,'sides','vegan',15),(99,'mixed salad (v) (ve) (gf)','mixed leaves, rocket, tomatoes and cucumber with newrecipe house dressing...',3.90,'sides','vegan',15),(100,'marinated olives (v) (ve) (gf)','with pink peppercorns and whole sweet garlic cloves...',2.50,'sides','vegan',15),(101,'roasted tomatoes (v) (ve) (gf)','marinated in garlic and oregano and packed with flavour...',2.50,'sides','vegan',15),(102,'margherita (v)','the hero here is our passata, lovingly made by the grecifamily, with 100% italian tomatoes from parma since \'87,......',8.95,'mains','vegetarian',16),(103,'american','on the menu since day one with only the best pepperoni,with mozzarella and tomato...',9.45,'mains','non-veg',16),(104,'bbq burnt ends','slow-cooked beef brisket with a hint of chipotle, sweet &smoky bbq sauce, mozzarella and red onions, topped wi......',12.00,'mains','non-veg',16),(105,'etna','exclusive to deliveroo - soft and spicy \'nduja sausage withpancetta, spicy roquito pepper, tomato, mozzarella and ......',12.00,'mains','non-veg',16),(106,'pollo forza','forza is italian for strong. big on flavour and full of colourwith smoked chilli chicken, roasted peppers, hot & sweet......',12.00,'mains','non-veg',16),(107,'diavolo','the name means \'devil\' and, sure enough, this is a pizzawith attitude! topped with spicy beef, pepperoni, mozzar......',12.00,'mains','non-veg',16),(108,'sloppy giuseppe','famous for hot spiced beef, green pepper, red onion,mozzarella and tomato...',11.95,'mains','non-veg',16),(109,'vegan giardiniera (v) (ve)','a veggie lover\'s delight. artichoke, mushrooms, red onionand black olives, with tomato, vegan mozzarella alternati......',11.45,'mains','vegan',16),(110,'american hot','in our humble opinion, the best pepperoni, packed withpaprika for a smoky depth of flavour, mozzarella and to......',11.00,'mains','non-veg',16),(111,'pollo ad astra','cajun spiced chicken, red onions, mozzarella, tomato,garlic oil and sweet red peppers really deliver on southe......',11.00,'mains','non-veg',16),(112,'la reine','the queen. ham, black olives, mushrooms, mozzarellaand tomato ...',10.95,'mains','non-veg',16),(113,'quattro formaggi piccante (v)','a hot take on a four cheese favourite: pecorino, italianblue cheese, mozzarella and gran milano cheese with to......',10.00,'mains','vegetarian',16),(114,'fiorentina (v)','the one with the \'egg and spinach\', plus mozzarella,tomato, gran milano cheese, black olives and garlic oil...',9.95,'mains','vegetarian',16),(115,'veneziana (v)','our love letter to venice. flavoursome capers, red onion,black olives, sultanas and pine kernels, with mozzarella ......',9.70,'mains','vegetarian',16),(116,'porchetta','porchetta; slow-cooked pulled pork is a traditional part of many italian feasts. we\'ve put it on a white bechamel base with crispy pancetta, mozzarella, garlic oil, fennel seeds and gran milano cheese on a romana base.',12.00,'mains','non-veg',16),(117,'padana natale (v)','goat\'s cheese, spinach, mozzarella, tomato, garlic oil andred onions - it\'s a feast of flavours and textures, topped......',11.25,'mains','vegetarian',16),(118,'mushroom & truffle (v)','mushroom lovers, this one\'s for you. mixed mushrooms, bechamel, mozzarella, gran milano cheese, garlic, rosemary, a generous splash of truffle oil, parsley and a double pinch of black pepper come together in an indulgent vegetarian delight on a romana base.',12.00,'mains','vegetarian',16),(119,'vegan mushroom & pine nut (v) (ve)','a white \'bianca\' pizza. the base is seasoned with oregano,pepper and garlic oil, then topped with chestnut mushro......',12.00,'mains','vegan',16),(120,'pollo pesto (gf)','chicken, mushroom, red onion, mozzarella, gran milano cheese and penne pasta baked in a bechamel and basil & pine kernel pesto sauce.',11.75,'mains','non-veg',17),(121,'bolognese (gf)','beef bolognese ragu with penne pasta, garlic and fennelseeds, parsley and gran milano cheese...',11.75,'mains','non-veg',17),(122,'melanzane (v) (gf)','grilled aubergine, italian tomato sauce, garlic, mozzarellaan gran milano cheese...',11.45,'mains','vegetarian',17),(123,'lasagna classica','the ultimate al forno dish. slow-cooked beef, mushroomand tomato ragu, layered with silky pasta, creamy becha......',11.45,'mains','non-veg',17),(124,'cannelloni (v)','spinach and ricotta filled pasta with passata, bechamel, mozzarella, garlic oil and gran milano cheese.',11.45,'mains','vegetarian',17),(125,'calzone \'nduja','rich & spicy \'nduja pork sausage and pepperoni meltinginto mozzarella and tomato, with the heat of fiery chillies,......',13.95,'mains','non-veg',18),(126,'calzone verdure (v) (ve)','roasted sweet peppers and silky aubergine with spinach,smoky tomato harissa, hot chilli, tomato with garlic and s......',13.45,'mains','vegan',18),(127,'vegan nourish bowl (v) (ve)','mixed grains with lemon and herbs, chilli & maple sweetpotato, roasted peppers, mixed leaves, cucumber and o......',8.95,'mains','vegan',19),(128,'nicoise (gf)','on the menu since \'85 and easy to see why. the bigflavours of white anchovies, capers, olives and tuna, wit......',8.95,'mains','non-veg',19),(129,'pollo & grain','chicken, mixed grains with lemon and herbs, slow-roastedtomatoes, black olives, mixed leaves, cucumber and our......',8.75,'mains','non-veg',19),(130,'caprese & prosciutto (gf)','prosciutto ham, buffalo mozzarella, marinated tomatoes,olives, roasted peppers, mixed leaves, basil & pine kern......',8.75,'mains','non-veg',19),(131,'grand chicken caesar','chicken, white anchovies, cos lettuce, croutons, granmilano cheese, free-range egg and caesar dressing...',8.75,'mains','non-veg',19),(132,'vegan diavolo (v) (ve)','a hot devil. smoky jackfruit \'pepperoni\', quorn™ pieces,tabasco, smoky chilli, garlic oil, fennel seeds, tomato, gr......',12.00,'mains','vegan',20),(133,'vegan forza (v) (ve)','forza is italian for strong. big on flavour and full of colour,smoky chilli quorn™ with mixed peppers, tomato, hot & ......',12.00,'mains','vegan',20),(134,'vegan melanzane (v) (ve) (gf)','the ultimate comfort food. grilled aubergine, italiantomato sauce, garlic, vegan mozzarella alternative and f......',11.45,'mains','vegan',20),(135,'sloppy vegan (v) (ve)','quorn™ pieces with green pepper, red onion, tomato,smoky chilli, garlic oil, vegan mozzarella alternative and ......',11.45,'mains','vegan',20),(136,'vegan american hot (v) (ve)','turn up the heat with smoky jackfruit \'pepperoni\', tomatoand vegan mozzarella alternative, with your choice of ho......',11.00,'mains','vegan',20),(137,'vegan ad astra (v) (ve)','what a star. quorn™ with sweet red peppers, cajunspice, red onion, tomato, garlic oil and vegan mozzarella......',11.00,'mains','vegan',20),(138,'vegan veneziana (v) (ve)','our love letter to venice. flavoursome capers, red onion,black olives, sultanas and pine kernels, with vegan mozz......',9.70,'mains','vegan',20),(139,'vegan american jack (v) (ve)','smoky vegan jackfruit \'pepperoni\' and tomato withsignature vegan mozzarella alternative...',9.45,'mains','vegan',20),(140,'vegan margherita (v) (ve)','the hero here is our passata. lovingly made by the grecifamily, with 100% italian tomatoes from parma since \'87,......',8.95,'mains','vegan',20),(141,'vegan padana natale (v) (ve)','our signature vegan mozzarella alternative, combined withspinach, tomato, garlic oil and red onions, all topped wit......',11.25,'mains','vegan',20),(142,'chocolate brownie (v) (gf)','we\'ve taken chocolate brownie to a new level, luxuriousdouble belgian chocolate and silky chocolate sauce...',3.75,'desserts','vegetarian',21),(143,'red berry & vanilla cheesecake (v)','what a combination. tart, sweet red berries and coulismeets rich vanilla...',3.75,'desserts','vegetarian',21),(144,'orange & carrot cake (v) (ve) (gf)','full of flavour. vegan and gluten-free to suit everyone...',3.75,'desserts','vegan',21),(145,'tiramisu (v)','ladyfingers, mascarpone, marsala wine, coffee and cocoa.',4.20,'desserts','vegetarian',21),(146,'chocolate fudge cake (v)','freshly baked in our pizza ovens, a chocolate loversdream!...',3.75,'desserts','vegetarian',21),(147,'snowball dough balls (v)','what could be better than dough balls? snowball doughballs! dusted with cinnamon and icing sugar, and serve......',3.95,'desserts','vegetarian',21),(148,'snowball dough balls doppio (v)','double the fun! a double portion of snowball dough balls.served with all three dips; salted caramel, fruit coulis an......',8.35,'desserts','vegetarian',21),(149,'vegan snowball dough balls (v) (ve)','what could be better than dough balls? snowball doughballs! dusted with cinnamon and icing sugar, served wit......',3.95,'desserts','vegan',21);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_protein`
--

DROP TABLE IF EXISTS `item_protein`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_protein` (
  `item_id` int NOT NULL,
  `protein` varchar(50) NOT NULL,
  PRIMARY KEY (`item_id`,`protein`),
  CONSTRAINT `item_protein_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_protein`
--

LOCK TABLES `item_protein` WRITE;
/*!40000 ALTER TABLE `item_protein` DISABLE KEYS */;
INSERT INTO `item_protein` VALUES (1,'soya'),(2,'squid'),(3,'prawn'),(8,'squid'),(9,'chicken'),(10,'duck'),(11,'unknown mock meat'),(12,'beef'),(14,'chicken'),(15,'duck'),(17,'pork'),(18,'prawn'),(19,'salmon'),(20,'tofu'),(21,'chicken'),(23,'soya'),(23,'tofu'),(24,'chicken'),(26,'soya'),(26,'tofu'),(27,'chicken'),(28,'chicken'),(29,'prawn'),(30,'tofu'),(31,'chicken'),(32,'prawn'),(33,'tofu'),(34,'chicken'),(34,'prawn'),(38,'chicken'),(38,'prawn'),(39,'tofu'),(40,'tofu'),(41,'chicken'),(41,'prawn'),(42,'steak'),(43,'salmon'),(44,'chicken'),(45,'chicken'),(46,'chicken'),(47,'beef'),(48,'tofu'),(49,'cod'),(50,'chicken'),(50,'steak'),(51,'chicken'),(51,'pork'),(52,'chicken'),(53,'beef'),(54,'duck'),(55,'seitan'),(57,'chicken'),(62,'chicken'),(63,'chicken'),(64,'chicken'),(65,'chicken'),(66,'chicken'),(67,'chicken'),(68,'chicken'),(69,'chicken'),(70,'chicken'),(71,'chicken'),(72,'chicken'),(73,'chicken'),(74,'chicken'),(75,'chicken'),(76,'chicken'),(77,'pea-protein'),(78,'pea-protein'),(92,'calamari'),(93,'chicken'),(103,'pepperoni'),(104,'beef'),(105,'pork'),(106,'chicken'),(107,'beef'),(107,'pepperoni'),(108,'beef'),(110,'pepperoni'),(111,'chicken'),(112,'pork'),(116,'pork'),(120,'chicken'),(120,'pork'),(121,'beef'),(123,'beef'),(125,'pepperoni'),(125,'pork'),(128,'anchovies'),(128,'tuna'),(129,'chicken'),(130,'pork'),(131,'anchovies'),(131,'chicken'),(132,'quorn'),(133,'quorn'),(135,'quorn'),(137,'quorn');
/*!40000 ALTER TABLE `item_protein` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `item_section_chain`
--

DROP TABLE IF EXISTS `item_section_chain`;
/*!50001 DROP VIEW IF EXISTS `item_section_chain`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `item_section_chain` AS SELECT 
 1 AS `item_name`,
 1 AS `vegan`,
 1 AS `category`,
 1 AS `section_name`,
 1 AS `chain_name`,
 1 AS `chain_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) DEFAULT NULL,
  `chain_id` int DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_id`),
  KEY `chain_id` (`chain_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`chain_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,NULL,1,'2021-11-23 20:46:15'),(2,NULL,2,'2021-11-23 20:50:28'),(3,NULL,3,'2021-11-23 20:59:42');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_menu_id` AFTER INSERT ON `menu` FOR EACH ROW BEGIN
	SET @current_menu_id = NEW.menu_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `perc_vegan_by_section`
--

DROP TABLE IF EXISTS `perc_vegan_by_section`;
/*!50001 DROP VIEW IF EXISTS `perc_vegan_by_section`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `perc_vegan_by_section` AS SELECT 
 1 AS `nvegan_items`,
 1 AS `nitems`,
 1 AS `percentage_vegan`,
 1 AS `category`,
 1 AS `chain_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `section_name` varchar(50) NOT NULL,
  `menu_id` int DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (1,'sides',1),(2,'hirata steamed buns',1),(3,'gyoza',1),(4,'harusame salad',1),(5,'curry',1),(6,'teppanyaki',1),(7,'ramen',1),(8,'donburi',1),(9,'desserts',1),(10,'starters',2),(11,'peri-peri chicken',2),(12,'burgers, pittas, wraps',2),(13,'sides',2),(14,'desserts',2),(15,'starters',3),(16,'pizzas',3),(17,'al forno',3),(18,'calzone',3),(19,'salads',3),(20,'vegan menu',3),(21,'desserts',3);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vegan`
--

DROP TABLE IF EXISTS `vegan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vegan` (
  `vegan` varchar(50) NOT NULL,
  PRIMARY KEY (`vegan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vegan`
--

LOCK TABLES `vegan` WRITE;
/*!40000 ALTER TABLE `vegan` DISABLE KEYS */;
INSERT INTO `vegan` VALUES ('non-veg'),('vegan'),('vegetarian');
/*!40000 ALTER TABLE `vegan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `item_section_chain`
--

/*!50001 DROP VIEW IF EXISTS `item_section_chain`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `item_section_chain` AS select `i`.`item_name` AS `item_name`,`i`.`vegan` AS `vegan`,`i`.`category` AS `category`,`s`.`section_name` AS `section_name`,`c`.`chain_name` AS `chain_name`,`c`.`chain_id` AS `chain_id` from (((`item` `i` left join `section` `s` on((`s`.`section_id` = `i`.`section_id`))) left join `menu` `m` on((`m`.`menu_id` = `s`.`menu_id`))) left join `chain` `c` on((`c`.`chain_id` = `m`.`chain_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `perc_vegan_by_section`
--

/*!50001 DROP VIEW IF EXISTS `perc_vegan_by_section`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `perc_vegan_by_section` AS select `v`.`nvegan_items` AS `nvegan_items`,`i`.`nitems` AS `nitems`,round(((100 * `v`.`nvegan_items`) / `i`.`nitems`),2) AS `percentage_vegan`,`i`.`category` AS `category`,`i`.`chain_name` AS `chain_name` from ((select count(0) AS `nitems`,`item_section_chain`.`category` AS `category`,`item_section_chain`.`chain_name` AS `chain_name`,`item_section_chain`.`chain_id` AS `chain_id` from `item_section_chain` group by `item_section_chain`.`category`,`item_section_chain`.`chain_id`) `i` left join (select sum(if((`item_section_chain`.`vegan` = 'vegan'),1,0)) AS `nvegan_items`,`item_section_chain`.`category` AS `category`,`item_section_chain`.`chain_name` AS `chain_name`,`item_section_chain`.`chain_id` AS `chain_id` from `item_section_chain` group by `item_section_chain`.`category`,`item_section_chain`.`chain_id`) `v` on(((`v`.`chain_id` = `i`.`chain_id`) and (`v`.`category` = `i`.`category`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-25 13:37:16
