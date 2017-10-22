CREATE DATABASE  IF NOT EXISTS `db_churn` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_churn`;
-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: db_churn
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `view_region`
--

DROP TABLE IF EXISTS `view_region`;
/*!50001 DROP VIEW IF EXISTS `view_region`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_region` AS SELECT 
 1 AS `region`,
 1 AS `churn_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_state_true_cnt`
--

DROP TABLE IF EXISTS `v_state_true_cnt`;
/*!50001 DROP VIEW IF EXISTS `v_state_true_cnt`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_state_true_cnt` AS SELECT 
 1 AS `state`,
 1 AS `counts`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_state_false_cnt`
--

DROP TABLE IF EXISTS `v_state_false_cnt`;
/*!50001 DROP VIEW IF EXISTS `v_state_false_cnt`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_state_false_cnt` AS SELECT 
 1 AS `state`,
 1 AS `counts`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_region`
--

/*!50001 DROP VIEW IF EXISTS `view_region`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_region` AS select `tab_state_abbv`.`region` AS `region`,`tab_churn`.`churn_value` AS `churn_value` from (`tab_churn` join `tab_state_abbv`) where (`tab_state_abbv`.`abbrev` = `tab_churn`.`state`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_state_true_cnt`
--

/*!50001 DROP VIEW IF EXISTS `v_state_true_cnt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_state_true_cnt` AS select `t2`.`state` AS `state`,`t1`.`counts` AS `counts` from ((select `db_churn`.`tab_churn`.`state` AS `state`,count(0) AS `counts` from `db_churn`.`tab_churn` where (`db_churn`.`tab_churn`.`churn_value` = 'True') group by `db_churn`.`tab_churn`.`state`) `t1` join `db_churn`.`tab_state_abbv` `t2`) where (`t1`.`state` = `t2`.`abbrev`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_state_false_cnt`
--

/*!50001 DROP VIEW IF EXISTS `v_state_false_cnt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_state_false_cnt` AS select `t2`.`state` AS `state`,`t1`.`counts` AS `counts` from ((select `db_churn`.`tab_churn`.`state` AS `state`,count(0) AS `counts` from `db_churn`.`tab_churn` where (`db_churn`.`tab_churn`.`churn_value` = 'False') group by `db_churn`.`tab_churn`.`state`) `t1` join `db_churn`.`tab_state_abbv` `t2`) where (`t1`.`state` = `t2`.`abbrev`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'db_churn'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-20 14:50:56
