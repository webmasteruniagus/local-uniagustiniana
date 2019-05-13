-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: mibew
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

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
-- Table structure for table `availableupdate`
--

DROP TABLE IF EXISTS `availableupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `availableupdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `url` text,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `target` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availableupdate`
--

LOCK TABLES `availableupdate` WRITE;
/*!40000 ALTER TABLE `availableupdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `availableupdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `banid` int(11) NOT NULL AUTO_INCREMENT,
  `dtmcreated` int(11) NOT NULL DEFAULT '0',
  `dtmtill` int(11) NOT NULL DEFAULT '0',
  `address` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`banid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban`
--

LOCK TABLES `ban` WRITE;
/*!40000 ALTER TABLE `ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cannedmessage`
--

DROP TABLE IF EXISTS `cannedmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cannedmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(8) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `vctitle` varchar(100) NOT NULL DEFAULT '',
  `vcvalue` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cannedmessage`
--

LOCK TABLES `cannedmessage` WRITE;
/*!40000 ALTER TABLE `cannedmessage` DISABLE KEYS */;
INSERT INTO `cannedmessage` VALUES (1,'en',NULL,'Hello. How may I help you?','Hello. How may I help you?'),(2,'en',NULL,'Hello! Welcome to our support. How may I help you?','Hello! Welcome to our support. How may I help you?');
/*!40000 ALTER TABLE `cannedmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vckey` varchar(255) DEFAULT NULL,
  `vcvalue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'dbversion','3.2.3'),(2,'_instance_id','8567a7c07672f3efed8d97c2a094631763395e02561d261df92cd516fefaba65');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locale`
--

DROP TABLE IF EXISTS `locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locale` (
  `localeid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `enabled` tinyint(4) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `time_locale` varchar(128) NOT NULL DEFAULT 'en_US',
  `date_format` text,
  PRIMARY KEY (`localeid`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locale`
--

LOCK TABLES `locale` WRITE;
/*!40000 ALTER TABLE `locale` DISABLE KEYS */;
INSERT INTO `locale` VALUES (1,'en','English',1,0,'en_US','a:3:{s:4:\"full\";s:18:\"%B %d, %Y %I:%M %p\";s:4:\"date\";s:9:\"%B %d, %Y\";s:4:\"time\";s:8:\"%I:%M %p\";}');
/*!40000 ALTER TABLE `locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailtemplate`
--

DROP TABLE IF EXISTS `mailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailtemplate` (
  `templateid` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(5) NOT NULL,
  `name` varchar(256) NOT NULL,
  `subject` varchar(1024) NOT NULL,
  `body` text,
  PRIMARY KEY (`templateid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailtemplate`
--

LOCK TABLES `mailtemplate` WRITE;
/*!40000 ALTER TABLE `mailtemplate` DISABLE KEYS */;
INSERT INTO `mailtemplate` VALUES (1,'en','user_history','Mibew Messenger: dialog history','Hello {0}!\n\nYour chat history: \n\n{1}\n--- \nRegards,\n{2} and Mibew Messenger\n{3}'),(2,'en','password_recovery','Reset your Mibew Messenger password','Hi, {0}\n\nPlease click on the link below or copy and paste the URL into your browser:\n{1}\n\nThis will let you choose another password.\n\nRegards,\nMibew Messenger'),(3,'en','leave_message','Question from {0}','Your have a message from {0}:\n\n{2}\n\nHis email: {1}\n{3}\n--- \nRegards,\nMibew Messenger');
/*!40000 ALTER TABLE `mailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `messageid` int(11) NOT NULL AUTO_INCREMENT,
  `threadid` int(11) NOT NULL,
  `ikind` int(11) NOT NULL,
  `agentid` int(11) NOT NULL DEFAULT '0',
  `tmessage` text NOT NULL,
  `plugin` varchar(256) NOT NULL DEFAULT '',
  `data` text,
  `dtmcreated` int(11) NOT NULL DEFAULT '0',
  `tname` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`messageid`),
  KEY `idx_agentid` (`agentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operator` (
  `operatorid` int(11) NOT NULL AUTO_INCREMENT,
  `vclogin` varchar(64) NOT NULL,
  `vcpassword` varchar(64) NOT NULL,
  `vclocalename` varchar(64) NOT NULL,
  `vccommonname` varchar(64) NOT NULL,
  `vcemail` varchar(64) DEFAULT NULL,
  `dtmlastvisited` int(11) NOT NULL DEFAULT '0',
  `istatus` int(11) DEFAULT '0',
  `idisabled` int(11) DEFAULT '0',
  `vcavatar` varchar(255) DEFAULT NULL,
  `iperm` int(11) DEFAULT '0',
  `dtmrestore` int(11) NOT NULL DEFAULT '0',
  `vcrestoretoken` varchar(64) DEFAULT NULL,
  `code` varchar(64) DEFAULT '',
  PRIMARY KEY (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES (1,'admin','$2y$08$6GAj8LdLdOR1WIcCGc.TkuKLzoscIiPnpDUiYJxesZUFxdCn3xhOm','Administrator','Administrator','',0,0,0,'',65535,0,NULL,'');
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatorstatistics`
--

DROP TABLE IF EXISTS `operatorstatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operatorstatistics` (
  `statid` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL DEFAULT '0',
  `operatorid` int(11) NOT NULL,
  `threads` int(11) NOT NULL DEFAULT '0',
  `messages` int(11) NOT NULL DEFAULT '0',
  `averagelength` float(10,1) NOT NULL DEFAULT '0.0',
  `sentinvitations` int(11) NOT NULL DEFAULT '0',
  `acceptedinvitations` int(11) NOT NULL DEFAULT '0',
  `rejectedinvitations` int(11) NOT NULL DEFAULT '0',
  `ignoredinvitations` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statid`),
  KEY `operatorid` (`operatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatorstatistics`
--

LOCK TABLES `operatorstatistics` WRITE;
/*!40000 ALTER TABLE `operatorstatistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `operatorstatistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatortoopgroup`
--

DROP TABLE IF EXISTS `operatortoopgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operatortoopgroup` (
  `groupid` int(11) NOT NULL,
  `operatorid` int(11) NOT NULL,
  KEY `groupid` (`groupid`),
  KEY `operatorid` (`operatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatortoopgroup`
--

LOCK TABLES `operatortoopgroup` WRITE;
/*!40000 ALTER TABLE `operatortoopgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `operatortoopgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `vcemail` varchar(64) DEFAULT NULL,
  `vclocalname` varchar(64) NOT NULL,
  `vccommonname` varchar(64) NOT NULL,
  `vclocaldescription` varchar(1024) NOT NULL,
  `vccommondescription` varchar(1024) NOT NULL,
  `iweight` int(11) NOT NULL DEFAULT '0',
  `vctitle` varchar(255) DEFAULT '',
  `vcchattitle` varchar(255) DEFAULT '',
  `vclogo` varchar(255) DEFAULT '',
  `vchosturl` varchar(255) DEFAULT '',
  PRIMARY KEY (`groupid`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `installed` tinyint(4) NOT NULL DEFAULT '0',
  `enabled` tinyint(4) NOT NULL DEFAULT '0',
  `initialized` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requestbuffer`
--

DROP TABLE IF EXISTS `requestbuffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requestbuffer` (
  `requestid` int(11) NOT NULL AUTO_INCREMENT,
  `requestkey` char(32) NOT NULL,
  `request` text NOT NULL,
  PRIMARY KEY (`requestid`),
  KEY `requestkey` (`requestkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requestbuffer`
--

LOCK TABLES `requestbuffer` WRITE;
/*!40000 ALTER TABLE `requestbuffer` DISABLE KEYS */;
/*!40000 ALTER TABLE `requestbuffer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requestcallback`
--

DROP TABLE IF EXISTS `requestcallback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requestcallback` (
  `callbackid` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(64) NOT NULL DEFAULT '',
  `func` varchar(64) NOT NULL,
  `arguments` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`callbackid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requestcallback`
--

LOCK TABLES `requestcallback` WRITE;
/*!40000 ALTER TABLE `requestcallback` DISABLE KEYS */;
/*!40000 ALTER TABLE `requestcallback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision`
--

DROP TABLE IF EXISTS `revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision`
--

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
INSERT INTO `revision` VALUES (1);
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitevisitor`
--

DROP TABLE IF EXISTS `sitevisitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitevisitor` (
  `visitorid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `username` varchar(64) DEFAULT NULL,
  `firsttime` int(11) NOT NULL DEFAULT '0',
  `lasttime` int(11) NOT NULL DEFAULT '0',
  `entry` text NOT NULL,
  `details` text NOT NULL,
  `invitations` int(11) NOT NULL DEFAULT '0',
  `chats` int(11) NOT NULL DEFAULT '0',
  `threadid` int(11) DEFAULT NULL,
  PRIMARY KEY (`visitorid`),
  KEY `threadid` (`threadid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitevisitor`
--

LOCK TABLES `sitevisitor` WRITE;
/*!40000 ALTER TABLE `sitevisitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sitevisitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread`
--

DROP TABLE IF EXISTS `thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread` (
  `threadid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `agentname` varchar(64) DEFAULT NULL,
  `agentid` int(11) NOT NULL DEFAULT '0',
  `dtmcreated` int(11) NOT NULL DEFAULT '0',
  `dtmchatstarted` int(11) NOT NULL DEFAULT '0',
  `dtmmodified` int(11) NOT NULL DEFAULT '0',
  `dtmclosed` int(11) NOT NULL DEFAULT '0',
  `lrevision` int(11) NOT NULL DEFAULT '0',
  `istate` int(11) NOT NULL DEFAULT '0',
  `invitationstate` int(11) NOT NULL DEFAULT '0',
  `ltoken` int(11) NOT NULL,
  `remote` varchar(255) DEFAULT NULL,
  `referer` text,
  `nextagent` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(8) DEFAULT NULL,
  `lastpinguser` int(11) NOT NULL DEFAULT '0',
  `lastpingagent` int(11) NOT NULL DEFAULT '0',
  `usertyping` int(11) DEFAULT '0',
  `agenttyping` int(11) DEFAULT '0',
  `shownmessageid` int(11) NOT NULL DEFAULT '0',
  `useragent` varchar(255) DEFAULT NULL,
  `messagecount` varchar(16) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  PRIMARY KEY (`threadid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread`
--

LOCK TABLES `thread` WRITE;
/*!40000 ALTER TABLE `thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threadstatistics`
--

DROP TABLE IF EXISTS `threadstatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threadstatistics` (
  `statid` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL DEFAULT '0',
  `threads` int(11) NOT NULL DEFAULT '0',
  `missedthreads` int(11) NOT NULL DEFAULT '0',
  `sentinvitations` int(11) NOT NULL DEFAULT '0',
  `acceptedinvitations` int(11) NOT NULL DEFAULT '0',
  `rejectedinvitations` int(11) NOT NULL DEFAULT '0',
  `ignoredinvitations` int(11) NOT NULL DEFAULT '0',
  `operatormessages` int(11) NOT NULL DEFAULT '0',
  `usermessages` int(11) NOT NULL DEFAULT '0',
  `averagewaitingtime` float(10,1) NOT NULL DEFAULT '0.0',
  `averagechattime` float(10,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`statid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threadstatistics`
--

LOCK TABLES `threadstatistics` WRITE;
/*!40000 ALTER TABLE `threadstatistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `threadstatistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translation`
--

DROP TABLE IF EXISTS `translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translation` (
  `translationid` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(5) NOT NULL,
  `context` varchar(256) NOT NULL DEFAULT '',
  `source` text CHARACTER SET utf8 COLLATE utf8_bin,
  `translation` text,
  `hash` char(40) NOT NULL,
  PRIMARY KEY (`translationid`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=623 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translation`
--

LOCK TABLES `translation` WRITE;
/*!40000 ALTER TABLE `translation` DISABLE KEYS */;
INSERT INTO `translation` VALUES (1,'en','','Are you sure that you want to delete address {0} from the blocked list?','Are you sure that you want to delete address {0} from the blocked list?','521eadd0f4760097f23f41697dcba830ca822fac'),(2,'en','','Mibew Messenger','Mibew Messenger','64937a11a6473ddf3959d47a94780e1fca004b13'),(3,'en','','Are you sure that you want to delete the group \"{0}\"?','Are you sure that you want to delete the group \"{0}\"?','0f8e69296d693d2c50f4174b993c2db99a1a93de'),(4,'en','','Visitor <span class=\"visitor\">{0}</span> is already being assisted by <span class=\"operator\">{1}</span>.<br/> Are you really sure you want to start chatting the visitor?','Visitor <span class=\"visitor\">{0}</span> is already being assisted by <span class=\"operator\">{1}</span>.<br/> Are you really sure you want to start chatting the visitor?','9a476b3454eceada2194f79a29ac4af5cc4be3b8'),(5,'en','','Yes. I\'m sure','Yes. I\'m sure','d6dc5cd64327bfa13677303c6a062a14e4b18d8d'),(6,'en','','No. Close the window','No. Close the window','38b86939350862dd36ac0e4ba045d63dcd8a80ad'),(7,'en','','This action is irreversible, proceed anyway?','This action is irreversible, proceed anyway?','1bd55b46565695f5457f18049e5c7bbc97277a7a'),(8,'en','','Error','Error','9f2cc7883ed8e4a12fcdc1c1b2e8b31ea7d5a5de'),(9,'en','','Close...','Close...','fd61ad56b8f26698f7c5198fd3c5e940c5b7fd80'),(10,'en','','Cannot execute:','Cannot execute:','fbd901f3c971dcc145db99b9a209377a5420d9dd'),(11,'en','','Leave your message','Leave your message','de7331b08e3941018afa4069908c74fedc29679b'),(12,'en','','Live support','Live support','09c8e96ce3ff58d1923cca15f131ef81e9bc5e46'),(13,'en','','Guest','Guest','8bfdd92ba68bebc9ae27071decf0443422c953f0'),(14,'en','','Visitor accepted invitation from operator {0}','Visitor accepted invitation from operator {0}','d1934dfd5c1f9a3044878f7ddc936aec3cea65ac'),(15,'en','','Visitor came from page {0}','Visitor came from page {0}','282c69b7b257376dbbbe3ad491fe8e7174f45dc3'),(16,'en','','Thank you for contacting us. We are sorry, but requested operator <strong>{0}</strong> is offline. Another operator will be with you shortly.','Thank you for contacting us. We are sorry, but requested operator <strong>{0}</strong> is offline. Another operator will be with you shortly.','6d654b771d1fcf1bdf5e47ba7c19c12cc7e1f6be'),(17,'en','','Thank you for contacting us. An operator will be with you shortly.','Thank you for contacting us. An operator will be with you shortly.','30cded13859727f8601d6fa54281b5a002275629'),(18,'en','','Info: {0}','Info: {0}','c1ed8a64f74478728824382c7f3acab55db88ffa'),(19,'en','','Are you sure that you want to delete operator \"{0}\"?','Are you sure that you want to delete operator \"{0}\"?','a9e61990f586ee3ed217bba4cc958d4b830d4ecd'),(20,'en','','Send chat history<br/>by mail','Send chat history<br/>by mail','683846ead721f1f0ad2af4c9409ad8a000069c72'),(21,'en','','Enter your email:','Enter your email:','b1e5f807b15de66bacf8a8e15e0f09dd26ea7a8d'),(22,'en','','Send','Send','3a4e6ea7f23ffb6f8069155da7d3ec92aa0816d1'),(23,'en','','Correct the mistakes:','Correct the mistakes:','10366fc291c19d7c483684e3782bd117e36afe36'),(24,'en','','-none-','-none-','05a7bc19bbb69d72fbab6d6356b8647a77de76c8'),(25,'en','','Are you sure that you want to uninstall plugin \"{0}\"?','Are you sure that you want to uninstall plugin \"{0}\"?','a15ca7188c5fbecf31b463b9d0fd25075516a1bd'),(26,'en','','Sent','Sent','96b9bbed8afa89f122bcdf9df57f357b7c303a68'),(27,'en','','A history of your chat was sent to address {0}','A history of your chat was sent to address {0}','afbc51402e68b9bd4b97f5cb9e641047aff4da26'),(28,'en','','Redirect to<br/>another operator','Redirect to<br/>another operator','48cfb5ce5ac9267935c808ed6da22954ce8dc5c3'),(29,'en','','Back...','Back...','a51b7def9742cb2f8bbd528893575af28e9c3cc4'),(30,'en','','Choose:','Choose:','57bb69c56d8c63d1c92ef1b66f8dfd7f30cd0cbf'),(31,'en','','Operator:','Operator:','2e346bcad53d1aa79c03f11d3f170096483d2c3b'),(32,'en','','Group:','Group:','b88e7a9fd8c321bc6d11195567d743862a21d325'),(33,'en','','Operator {0} invites visitor at {1} page','Operator {0} invites visitor at {1} page','fc53d975499a1f652765de35f32f821cc2760d99'),(34,'en','','Hello, how can I help you?','Hello, how can I help you?','2debc7a1c3cc20b9b1ab77ee152f9dd0d6970f3e'),(35,'en','','Visitor rejected invitation','Visitor rejected invitation','7a37e6b2c61cf5c69063f50a2e24047c70640c46'),(36,'en','','Visitor ignored invitation and it was closed automatically','Visitor ignored invitation and it was closed automatically','08aa9e2d8bfc4afd810f1aeff15a3e1b969b07d7'),(37,'en','','The visitor has been redirected to another operator','The visitor has been redirected to another operator','51faffe2b2207a4d60f6e00582e10522abbf035b'),(38,'en','','System administration: settings, operators management, button generation','System administration: settings, operators management, button generation','b333fdfd4bada9720f925bea6c941edde2febc5b'),(39,'en','','Ability to view system statistics','Ability to view system statistics','38a7ff16f29b5044ec6647f264d3045a9fef3c16'),(40,'en','','Take over chat thread','Take over chat thread','02bab93b1295d2fc6d18555bc80b81f5fac8fdf0'),(41,'en','','View another operator\'s chat thread','View another operator\'s chat thread','28928d3a00d26b83165136346486bba310395ea2'),(42,'en','','Ability to modify profile','Ability to modify profile','b6e94b2ba04fb38a47f298b83d8cc4049e07486b'),(43,'en','','(online)','(online)','1c9e45fcf27919222fa4ffbe1ff2dcde101107ed'),(44,'en','','(away)','(away)','79dd25ff7b3292552aede81c43ed05cfd4ff4c9f'),(45,'en','','Page {0} of {1}, {2}-{3} from {4}','Page {0} of {1}, {2}-{3} from {4}','a481eee4fa50638e241976d82338a8d3972d1c31'),(46,'en','','previous','previous','ce9f34009c75ef11f9f1d91a66b3d4c1188d769c'),(47,'en','','next','next','da606a642d0e5e896da5e9dab6a0292414f996f6'),(48,'en','','Powered by:','Powered by:','f545d1c3f7bd13be1b33a64215fc9c9328b4ab38'),(49,'en','','Select answer...','Select answer...','097967f504c14b88df0fe30e6815daefbee18a71'),(50,'en','','Send message','Send message','a879c60639b045cf6198d6b69233179a93eaec10'),(51,'en','','Send ({0})','Send ({0})','b99159757ad1034c1d3abd81b24cf9cf943ffa1f'),(52,'en','','Close','Close','b93bc4905502ade774ced0f647fe723f5fa3a964'),(53,'en','','Sorry. None of the support team is available at the moment. <br/>Please leave a message and someone will get back to you shortly.','Sorry. None of the support team is available at the moment. <br/>Please leave a message and someone will get back to you shortly.','d40d058b59172192b10b560c979204790477af25'),(54,'en','','Your email','Your email','d88b4054f0444a6844c987d0f443ad604361b55f'),(55,'en','','Your name','Your name','f0fc15e1d4906a37b74eb6692e32b008829fc1db'),(56,'en','','Choose Department:','Choose Department:','dd70b7afd4aa4eefaaadf79261e82152c76523d0'),(57,'en','','Department description:','Department description:','0607df267f420e09c6ab87047737669c6362d1f0'),(58,'en','','Message','Message','a978fa5477568d1f215ad8828444bcc552d059c1'),(59,'en','','Please note that by leaving the message you\'re explicitly agree with the <a href=\"{0}\" target=\"_blank\">Privacy Policy</a>','Please note that by leaving the message you\'re explicitly agree with the <a href=\"{0}\" target=\"_blank\">Privacy Policy</a>','a12cf76048fa557ad45705f885bad3665533830b'),(60,'en','','Never','Never','79c7c2b18b38e37fecce2d710e21bdfc3320c6f7'),(61,'en','','Today at {0}','Today at {0}','23010c35fbe6f5a94902eea626771f5e2b5aa2d1'),(62,'en','','Yesterday at {0}','Yesterday at {0}','e3b1f72341fd5b43c01ce1021e25cf29e244dcbc'),(63,'en','','Thank you for your message. We\'ll answer your query by email as soon as possible.','Thank you for your message. We\'ll answer your query by email as soon as possible.','cd152aa3c25224ddf15f6fae28d222fc0bd77fff'),(64,'en','','OK','OK','d008a3f17783681671afbc52b8dba9e7ecf4e1d5'),(65,'en','','Cancel','Cancel','10a646af84be7665919e40c7adf6aee418c6066f'),(66,'en','','Name:','Name:','a818fc85baaa3a003f75de673377709d1ba247e7'),(67,'en','','Email:','Email:','3d37d6fc687ec19382ce593f4ebc9cd07899f61f'),(68,'en','','Initial Question:','Initial Question:','de0b6991c92cde354d106e5660f0a3125dc1a569'),(69,'en','','Please note that by starting the chat you\'re explicitly agree with the <a href=\"{0}\" target=\"_blank\">Privacy Policy</a>','Please note that by starting the chat you\'re explicitly agree with the <a href=\"{0}\" target=\"_blank\">Privacy Policy</a>','cef9aadfd85203d2fde54ce2cf80b7bb06f6ce4c'),(70,'en','','Start Chat','Start Chat','fca64b77e7db629bc7ef0b4d028f29369b260283'),(71,'en','','Thank you for contacting us. Please fill out the form below and click the Start Chat button.','Thank you for contacting us. Please fill out the form below and click the Start Chat button.','950306eaa4c29ea6f0400819f6a2406b5db0b95c'),(72,'en','','Network problems detected. Please refresh the page.','Network problems detected. Please refresh the page.','df12aee0c96c3c1ba0c4af20b57b6d497b22bc0e'),(73,'en','','Please fill \"{0}\".','Please fill \"{0}\".','21ee56696cac51a3ca8fdbc270c37e2ef7e61c48'),(74,'en','','Error uploading file \"{0}\": {1}.','Error uploading file \"{0}\": {1}.','8aa71c8ef2465d6d203106d0c7352f3a15e976f4'),(75,'en','','Please fill \"{0}\" correctly.','Please fill \"{0}\" correctly.','4c873ac078e2656e8185d62823992b82a90292be'),(76,'en','','Close chat','Close chat','0abcba1287cef04d7e9eea0e4ddeae9e15308f59'),(77,'en','','Visit history','Visit history','fa224c74eea74d0201d14b07a4ce98baa31be7b7'),(78,'en','','Redirect visitor to another operator','Redirect visitor to another operator','ec969efde421fe9a3b72cb973863ec1da139256a'),(79,'en','','Refresh','Refresh','18a31e02cb8cc402cf397a42200ec17143d2e632'),(80,'en','','Send chat history by e-mail','Send chat history by e-mail','c001fc7970dcfd346f6a90edde5450fb3d586a02'),(81,'en','','Turn off sound','Turn off sound','9ecf836e274b58b8581f357e72bd5a4072436d68'),(82,'en','','Turn on sound','Turn on sound','6f5db518cbcf3cebd1532a402d2845b7b8757dfe'),(83,'en','','You are','You are','228364d13903bddd31cc96f601cdce6fb5880307'),(84,'en','','Change name','Change name','b9d6f8a1e4b552a58d1e30ef0eb6cb3ddb527b19'),(85,'en','','Visitor joined chat again','Visitor joined chat again','2fb63e52795604f5b1432447b150627dd61bdd45'),(86,'en','','Your operator has connection issues. We have moved you to a priorty position in the queue. Sorry for keeping you waiting.','Your operator has connection issues. We have moved you to a priorty position in the queue. Sorry for keeping you waiting.','8ffc5431c2f4c2792db8a1f9aa3bce94a3c1e265'),(87,'en','','Visitor closed chat window','Visitor closed chat window','8bca898bd36e364ae93eb60a4931ad6a0d311a1b'),(88,'en','','Operator <strong>{0}</strong> changed operator <strong>{1}</strong>','Operator <strong>{0}</strong> changed operator <strong>{1}</strong>','157a4731996e88ecb82991703b67c1a154587c39'),(89,'en','','Operator {0} is back','Operator {0} is back','dc819ec44d8354333144edc9694d24c7ebdc0689'),(90,'en','','Visitor {0} left the chat','Visitor {0} left the chat','5ed216f321334a44d2281aae3cdb679d37d13418'),(91,'en','','Operator canceled invitation','Operator canceled invitation','2094e08a49459604d646b1de71482e3c60fee10b'),(92,'en','','Operator {0} left the chat','Operator {0} left the chat','500af1707236cd12fb6a224aeef8b0723e835d7f'),(93,'en','','Operator {0} joined the chat','Operator {0} joined the chat','886fabcfc981edbb64303aa5ccb2d646257cb32b'),(94,'en','','The visitor changed their name <strong>{0}</strong> to <strong>{1}</strong>','The visitor changed their name <strong>{0}</strong> to <strong>{1}</strong>','8f2936f14ce638e85370405ad9cc5312ad89628e'),(95,'en','','Remote user is typing...','Remote user is typing...','4d5775d1cdf266afcefcab4568f6739f1054958e'),(96,'en','','You are <a href=\"{0}\">{1}</a>','You are <a href=\"{0}\">{1}</a>','6a4e3359334b052accfe7c50efb25a73b988205b'),(97,'en','','Login:','Login:','9ad96d5767ee09d9d289a53f8288046ca0bff675'),(98,'en','','Choose your language','Choose your language','8d9a72a1a0f279588de6bc2d199cf64134acde7e'),(99,'en','','You are Offline.<br/><a href=\"{0}\">Connect...</a>','You are Offline.<br/><a href=\"{0}\">Connect...</a>','899a2ef8cab6281ea3fa1038bff2549027895783'),(100,'en','','Main','Main','d2d280598ea751741ee53cb19c7d0d32bd77db2e'),(101,'en','','Home','Home','6ea90287aa1b99cdd26dc2e40bd770d83fc41474'),(102,'en','','Visitors','Visitors','222329d0c99234199c3804a864fce8eeb0c0a0e6'),(103,'en','','without menu','without menu','814d5b31164020fa863f3a05d87ed4bf33febdba'),(104,'en','','Chat history','Chat history','1e5c94d90f5e085a84301c60aca3c195d19bfdcd'),(105,'en','','Statistics','Statistics','0e6949e282daea98284ab2c0a832ed306c25af45'),(106,'en','','Blocked visitors','Blocked visitors','ff3e8e28fd7a600ad269d696696cb4ff24f9d5d3'),(107,'en','','Administration','Administration','2fc1e3ebed7fc8cb53f2b95a268e415b3fc3dc90'),(108,'en','','Canned Messages','Canned Messages','6f221ca5a612bae1440e82a78454f5e71237ff0f'),(109,'en','','Button code','Button code','10f3be16c5f8d4deb831d0c2ac9c62cc61b82eed'),(110,'en','','Operators','Operators','eb392969311f52ed5576471798054d9b9b3b1aac'),(111,'en','','Groups','Groups','df509d26179cad04c267493253b267a3a4603464'),(112,'en','','Settings','Settings','5c2c3e4c018079e8ec36a9a608e8902bee903a3e'),(113,'en','','Plugins','Plugins','808910ff4e1fc12001727a9e7d9cbd09c75846d9'),(114,'en','','Styles','Styles','5a72705443ac823880b67f399db27a9080c546ed'),(115,'en','','Localize','Localize','24067053494d4284dc0ea0a46a2086bcc95a2745'),(116,'en','','Mail templates','Mail templates','26b24d27311745235590b0b7fb804fe6eeb16ee9'),(117,'en','','Other','Other','fb9e50806ebbb7e65ab021f06150e4ed5f04143d'),(118,'en','','About','About','ea12bf665baffd9b90a3e2380d15027414a18822'),(119,'en','','Exit','Exit','07e3503243f267d7d143d565fb0ab96faabc614b'),(120,'en','','About Mibew Messenger','About Mibew Messenger','7bc01db766fa1b6767b42ae0bab8d35f0f946eb5'),(121,'en','','Mibew Messenger is an open-source live support application licensed under the terms of the Apache License 2.0.','Mibew Messenger is an open-source live support application licensed under the terms of the Apache License 2.0.','518b1284a8deda3bbf5de1a1eb95aebdbdc132ee'),(122,'en','','Copyright &copy; {0} Contributors of the Mibew Messenger project.','Copyright &copy; {0} Contributors of the Mibew Messenger project.','8d8038cebda9b4794e8d56dca20b1b5648904988'),(123,'en','','For more information visit the official site of the project: <a href=\"https://mibew.org/\">https://mibew.org/</a>','For more information visit the official site of the project: <a href=\"https://mibew.org/\">https://mibew.org/</a>','39dcb4af59aead9c5f9f0ffdc039a05737f25d7b'),(124,'en','','System information','System information','cea4e0b63d073fd8bc9c2d25990d2222a2a64e0d'),(125,'en','','You are using:','You are using:','e728c8f04220990a18c7be3f66d20a66a8678b23'),(126,'en','','Installed localizations:','Installed localizations:','5716382b1a4c752d6eb107099f462dd58a3af7dc'),(127,'en','','Environment:','Environment:','12d7f69f3fc5769a8d0e81219973d0ce0fe78cb9'),(128,'en','','Available updates','Available updates','cda1257f3c6d5b639e2f545c97eaa05bbcf14bc7'),(129,'en','','Download','Download','fecdb37c6b89274f9725df1261dbd2a796bfa856'),(130,'en','','There are no available updates.','There are no available updates.','6b3e78824638ee35644977a8fa00087611a18092'),(131,'en','','Check for available updates','Check for available updates','42d00bfe99a3ebcf350545bb9b4a9b1604af2cbf'),(132,'en','','Address {0} is blocked for a specified number of days.','Address {0} is blocked for a specified number of days.','66dfb078782bebe62fd6db9f72b1b055be5d0f0b'),(133,'en','','Here you can block malicious visitors that affect your work with spam messages.','Here you can block malicious visitors that affect your work with spam messages.','0a2035f37c84424eace251ad1edce660543a75e8'),(134,'en','','You opened this window for \"{0}\" thread. <i>Address</i> field is already filled. Select a number of days and click <i>Send</i>.','You opened this window for \"{0}\" thread. <i>Address</i> field is already filled. Select a number of days and click <i>Send</i>.','2061d6b07113c210c70b244c9d6f17c3f83246f1'),(135,'en','','Visitor\'s Address','Visitor\'s Address','c69fff03a4a065dfe0975ee52abb65355790a3ee'),(136,'en','','Ex: 127.0.0.1 or example.com','Ex: 127.0.0.1 or example.com','feb09d2cbf3e886a4940102819614ba5dba1c4f9'),(137,'en','','Days','Days','2833f985376e631db4f8fe1f3092fad0a1349173'),(138,'en','','Numbers of days this address is blocked','Numbers of days this address is blocked','fa8c5570b4cdf7bd56b9b10affe50b2fcd716a24'),(139,'en','','Comment','Comment','7f3dca3f514e97afa9a6704b77bc06cee75afe2a'),(140,'en','','Reason for block','Reason for block','aa41533f69b1742be224768a96cdc9f5d935a24e'),(141,'en','','Save','Save','cdfd4ce7480514a5b6b0cbbf96ac5b65ff17c6a9'),(142,'en','','mandatory fields','mandatory fields','0a45ca97a62fe325c3bd384003885662fe47ac97'),(143,'en','','Add address','Add address','7fbb47e365a39d636ee270fca9aad4762a836088'),(144,'en','','Till','Till','5ef7d3602494ed7664490a78367c0957cbe72ef3'),(145,'en','','Edit','Edit','302b44c87feb23224982f07117b474dc3aefb52d'),(146,'en','','remove','remove','e11fc143ce1e936e70f6687f201a1382988397df'),(147,'en','','edit','edit','35927abffce80dc9209150f0cd05535320d5a7ed'),(148,'en','','No elements','No elements','8c5754a5493a3c828398858cbb1316d54e37a7dd'),(149,'en','','You can generate HTML code to place at your site here.','You can generate HTML code to place at your site here.','dfc9ab18e89075755da7c0894b17030607793237'),(150,'en','','Code for language','Code for language','1928e0e79c084eeff4f355d5e188922510bc4822'),(151,'en','','Chat window style','Chat window style','ac093d427ac28c1b721754fca36db895013ebeed'),(152,'en','','Generating code type','Generating code type','699c58318cdbd0433c6a39d26b791b813f888305'),(153,'en','','Use windows (even for modern browsers)','Use windows (even for modern browsers)','27a13f38886bd21c7237e7635e39cb411ad6163c'),(154,'en','','Choose image','Choose image','d5aa1b8219f78b73254e513def116811b6d4dd46'),(155,'en','','Invitation style','Invitation style','56b71572f06b5d4eb860c714ce1ace93f5217efa'),(156,'en','','Code for group','Code for group','3aa6b9bb412074f7d402018e455d5ac2e374b3f2'),(157,'en','','Include host name into the code','Include host name into the code','63691caca48dd9fb4b9aa56fe2a18104a2e90e46'),(158,'en','','Use secure links (https)','Use secure links (https)','3fe3c43c04ceed432835688ba8863b0c0db081d0'),(159,'en','','Compatibility with mod_security (modsecurity.org), turn on only if you have problems with it','Compatibility with mod_security (modsecurity.org), turn on only if you have problems with it','e54c3f98ff6dcf777b57d6da0ddf0f40b5e9225d'),(160,'en','','HTML code','HTML code','cbbc385242d69e7e41a42d13a50c31ca005ee289'),(161,'en','','<strong>Caution!</strong> Please don\'t change<br/> the code manually because<br/> we don\'t guarantee that<br/> it will work!','<strong>Caution!</strong> Please don\'t change<br/> the code manually because<br/> we don\'t guarantee that<br/> it will work!','ca51f0c0d8ebb3fefd01fa57570c6b529ce61311'),(162,'en','','Example','Example','45c459a237106a49c653c2b0197ae1e127089c62'),(163,'en','','Saved','Saved','287bd802fd07d071353ee494bc61a02bb385764c'),(164,'en','','Edit an existing message.','Edit an existing message.','99a0685c4b2a98c46c93ddef01596ccbab370d98'),(165,'en','','Add new message.','Add new message.','dc3d1e52772c9a7cf56c122f39ca71af8b659e3d'),(166,'en','','Title','Title','2b213f51b1c284f3590616511c1fe0f8adde6e9b'),(167,'en','','{0} plugin','{0} plugin','41e9d96dff779ef2e4e3195ed961636c994628b3'),(168,'en','','Edit messages that you frequently type into the chat.','Edit messages that you frequently type into the chat.','38a9363b326bbd08b71724e9d566c1037afe83c7'),(169,'en','','For language:','For language:','6bb6ef3c9e198294f5a5bf50f006fd6315399bb3'),(170,'en','','For group:','For group:','03eaab6c33c71d1d92dee809af9dfe63c6ad3689'),(171,'en','','Add message...','Add message...','29cd58dd490eded34df2cea1038b58064a246e69'),(172,'en','','Modify','Modify','a7d41da68e65df309f8866a61e0425d507a50e9a'),(173,'en','','On this page you can edit group details.','On this page you can edit group details.','b1ca584a7b43c452efe48f005a8da54696393fe9'),(174,'en','','Create new group here.','Create new group here.','689dca78be886a0b5af1acc618156bd1f561b62d'),(175,'en','','Changes saved','Changes saved','b56d5d1c041df295b2dc420fd6b0636048e0946c'),(176,'en','','Name','Name','8c1fed8336cfce2e0cae79ee7ba8d1d2579edcb1'),(177,'en','','Name to identify the group.','Name to identify the group.','17b8479b3b151fc7870c9a0da23b27241b7474dc'),(178,'en','','Description','Description','f51e09d519a22644387a211f372f45eefbe94b88'),(179,'en','','Description of the group.','Description of the group.','7276282e6bbc253db5ba7fa71d213f69f9ec3641'),(180,'en','','International name','International name','da58089606de2750c8b96e7824a97c97261a8b92'),(181,'en','','Name in English.','Name in English.','e89c19c1551a1f8c6bc09779e35fc0e666d6f7dc'),(182,'en','','International description','International description','d6ccd2027335c2b11d6e208c78658f4c08473df4'),(183,'en','','Description in English.','Description in English.','995f2b0b34c10ee64146e50876232e71e492e14f'),(184,'en','','E-mail','E-mail','524958d058a745ba533218df21f636fd7dd69753'),(185,'en','','Group email for notifications. Leave empty to use the default address.','Group email for notifications. Leave empty to use the default address.','0df8dea7d5dd4e54631b12137916e02901d3d351'),(186,'en','','Weight','Weight','505862a7e0f3d5c84d6c3dc8f0927014e0f1c1f5'),(187,'en','','Groups with lower weight display higher in groups list. Group weight is a positive integer value.','Groups with lower weight display higher in groups list. Group weight is a positive integer value.','62ccb9c01a81eb2287be9e0a6a5b15ee404614c6'),(188,'en','','Parent group','Parent group','2b42f5f124598f7aa182a00eb003152022d719b6'),(189,'en','','Groups can be organized in a hierarchical structure','Groups can be organized in a hierarchical structure','b91bb666f591ca95af9de2e600cbfd96b7124af0'),(190,'en','','The fields that located below are extra fields. These fields are only available for the top level groups and override corresponding system settings if specified.','The fields that located below are extra fields. These fields are only available for the top level groups and override corresponding system settings if specified.','30f9290b767f6612de137619d9404284fbe941ec'),(191,'en','','Company title','Company title','4239e06ba09c228fde8af72a29f408e3c04ad4a3'),(192,'en','','Enter your company title','Enter your company title','c266a4fc1878e3f44b7630c272784a77628ceab6'),(193,'en','','Title in the chat window','Title in the chat window','8afbe12222758cd36f2d044efd51d0fcb58712b9'),(194,'en','','Your company logo','Your company logo','9fe43e24efea046a8a7f3ea7d51227f6b1879fce'),(195,'en','','Enter http address of your company logo','Enter http address of your company logo','f9a1e7f38de99d502bf060e8a47b91ec50e6c1db'),(196,'en','','URL of your website','URL of your website','f0d8314b0b8ebd321a6ad03c6ed736a022ec9f98'),(197,'en','','Destination for your company name or logo link','Destination for your company name or logo link','5175f6400084abb8d671bae5a9ce3a688f274a2f'),(198,'en','','Ban List','Ban List','df30654eb1afd564a69a78f02cdd947000b2288c'),(199,'en','','Block address','Block address','edb474779d58dd225728ce98eff95917d6160d2c'),(200,'en','','The specified address is already in use. Click <a href=\"{1}\">here</a> if you want to edit it.','The specified address is already in use. Click <a href=\"{1}\">here</a> if you want to edit it.','725ba950ec73873b1dbf9d355dfaebd1c8caf4b9'),(201,'en','','View and edit the member list.','View and edit the member list.','3c5322cb1e8c13704094e15bf933816c4436657c'),(202,'en','','-from general settings-','-from general settings-','160b8be96a2ef0c6ab2c9439b81d4fb1f4ab7453'),(203,'en','','No such group','No such group','7240fca6c4f02a695a6e712ac4a1023cdd565191'),(204,'en','','Click to chat','Click to chat','cf2e2fd4f5552da057db4302406bcb3a69af3823'),(205,'en','','button','button','56432704d27c247d540e7e7801b544731dca809c'),(206,'en','','operator code field','operator code field','d0d6f0424592ddf0143994ff3d13ce375e4bfc94'),(207,'en','','text link','text link','752c41de4eb7c55e7b7adc4ee360b7f5c0a98d09'),(208,'en','','Button HTML code generation','Button HTML code generation','2c7b1159574b9002b99eb805b536b47a0cb48c16'),(209,'en','','-all operators-','-all operators-','1ff7d30c6613864e12d62712b05bf7236b8a0bd5'),(210,'en','','This page displays a list of groups. Each group can have separate button and canned responses.','This page displays a list of groups. Each group can have separate button and canned responses.','c87a0bf3662ec20184bcf037d678ba5dd63ec073'),(211,'en','','Sort by:','Sort by:','a77d229951748761abca30628eb97f0a51162b56'),(212,'en','','Sort direction:','Sort direction:','3a0f147e82bf64b3ccf662a2c9b3cc0a97cfcaa5'),(213,'en','','Create new group','Create new group','ec026bb1c70f0fa949adaa9ae1a27e103baf17a8'),(214,'en','','Last active','Last active','c85f87ee9bc0583aff6579b49f89a76def1754dc'),(215,'en','','Online','Online','ac13f845f5c9bb51c029ba2b9ae384029ef67252'),(216,'en','','Away','Away','ba81b0148a247f544b96febb1614acb6d969974f'),(217,'en','','Visitor navigated to {0}','Visitor navigated to {0}','d262e1ab7ebe5994223b1595932f24898dd6092d'),(218,'en','','Search the chat history for a specified user, an operator or a specified phrase in messages.','Search the chat history for a specified user, an operator or a specified phrase in messages.','80225a0f182a382b3fb889e2231e702243066601'),(219,'en','','User name, operator name or message text search:','User name, operator name or message text search:','86b21c26373a82ef2354dd9faa72b875ea8d796b'),(220,'en','','Search:','Search:','1b62eb07af876d3598445f1359d347d532e96531'),(221,'en','','everywhere','everywhere','e4a3f7e0ae3b52bd8b0915c20adb4263f68d1b37'),(222,'en','','in messages','in messages','006cf9a10e7090d147f291302fc216c952aa3d20'),(223,'en','','by operator','by operator','ad5d36bef08fe437feddc12ab3b52d12c14f888e'),(224,'en','','by visitor','by visitor','9b39552cafdf253f1503a2b2afe8f48ee33d5f5e'),(225,'en','','Search','Search','fea0ff3cc46444ea61a92a408c2ee239e7d106e5'),(226,'en','','Search in system messages','Search in system messages','c8fa8c6bf1f4acd3a45c60635f6fcdad329065ce'),(227,'en','','Visitor\'s address','Visitor\'s address','98813028c7bbfd7929a39febd6e792eb01699a8b'),(228,'en','','Operator','Operator','b2b4b470f26b15bbbe6c1f8b89311b7b58d08734'),(229,'en','','Visitor\'s messages','Visitor\'s messages','6bae21ed391a665757c327cef905aa4dcfcd9dd2'),(230,'en','','Time in chat','Time in chat','6eb131752c22f63b1ea35e1dd92335b2e7a94ce6'),(231,'en','','Found 0 elements','Found 0 elements','3b958d17ad4f4d2c4ba7809c076fe9a8d3fde132'),(232,'en','','No such message','No such message','4debd88d597ef037ed379e474fa75c03c06d93a8'),(233,'en','','New Message','New Message','75b20853b1cab54bfc3d62e76c9f9cb59dc331aa'),(234,'en','','Edit Message','Edit Message','28dd1f4af18cd7d54f1094e40d0e8bd62df682d1'),(235,'en','','This page displays chat details and content.','This page displays chat details and content.','2a6b87a13496801681db66ced5f8f12a969e845a'),(236,'en','','Browser','Browser','2c3e3d26fdf891cab40709f17b001a0b5e8e5028'),(237,'en','','Group','Group','425c4c31907a24e3218fe37ead53fe7ac4a2e31c'),(238,'en','','You can find the chat history of your visitors here.','You can find the chat history of your visitors here.','841edd0130dbfe2caafd41ad4041af0f4540df88'),(239,'en','','Please run the <a href=\"{0}\">Update wizard</a> to adjust your database.','Please run the <a href=\"{0}\">Update wizard</a> to adjust your database.','9c1faa01d3ca041e68a40c22ac99dd5e0f230223'),(240,'en','','You are Offline. <a href=\"{0}\">Connect...</a>','You are Offline. <a href=\"{0}\">Connect...</a>','05c020a682181f6cef30bc2b149e11b2b95f80ed'),(241,'en','','You can find awaiting visitors.','You can find awaiting visitors.','b3dbd11be9a38125bba1237825ec1c6a99907e62'),(242,'en','','Search the dialogs history.','Search the dialogs history.','da5a772dc4f06052eff80e1b129ac0363f296674'),(243,'en','','From this page you can generate a variety of usage reports.','From this page you can generate a variety of usage reports.','ec28057e666d64e475fb01a90df27d725cf90233'),(244,'en','','Here you can block malicious visitors.','Here you can block malicious visitors.','67b77be60e1b954ccdce6b586827046ee7ba7d93'),(245,'en','','Button HTML code generation.','Button HTML code generation.','baf7de8b35399eb18308839abb50ed3686cfc2ac'),(246,'en','','Create or delete company operators. Manage their permissions.','Create or delete company operators. Manage their permissions.','559e5d353924ae8481807e4964cc26b79922970e'),(247,'en','','Department or skill based groups.','Department or skill based groups.','59bc1033661eb0d579e3a8aeb30795464d869544'),(248,'en','','Specify options affecting chat window and common system behavior.','Specify options affecting chat window and common system behavior.','32e1ac138e4c4fe391951a462b03aed38a286454'),(249,'en','','Manage plugins.','Manage plugins.','bf49027b485a1a22716614d4e514d207027586cf'),(250,'en','','Manage styles.','Manage styles.','f8a017082a43f9803830b54427d6b7e917ee664b'),(251,'en','','Translations','Translations','efa0400cf2dabf90d8cf1d5f05e001df0a1d1d7a'),(252,'en','','Manage translations.','Manage translations.','1fd900d31da48ea04a3eeea0235f5fc33b5f248d'),(253,'en','','Manage mail templates.','Manage mail templates.','70d18d3c1c723329bbd8a7cc94f7586727a3c9f6'),(254,'en','','Profile','Profile','3b3c56a4bf5ba7b66be6007f2e1d2c2829d2010b'),(255,'en','','You can change your personal information on this page.','You can change your personal information on this page.','d79dbe164bcee51e79f9c7e8c692606114a8fd1e'),(256,'en','','Language','Language','896ae45a15bb6ab793630caeaa203c33254a7aa2'),(257,'en','','Change locale.','Change locale.','d0f66b4532234cf6ad5c0e544313780930fd2db8'),(258,'en','','View about page.','View about page.','88b632c78b123828d5700e8e2fbc9d05de8e4ddd'),(259,'en','','Log out of the system.','Log out of the system.','ab16b23a9d913204b9cb9de087f435503ececb7b'),(260,'en','','Application installed successfully.','Application installed successfully.','1674cca5dd7ff489e4862f223b0ec3008523eebc'),(261,'en','','Click to check the sound','Click to check the sound','a3b144804585461eea9fc7450e7fe1945c6be29e'),(262,'en','','New Visitor','New Visitor','ae1677942c1faa5a3f89fe5483e491a67b6fdeaa'),(263,'en','','For security reasons you should remove install.php file from your server.','For security reasons you should remove install.php file from your server.','dcb16b92ca22bdf971b202fa7d75aa6dffb862df'),(264,'en','','Chat log','Chat log','b3ba0890ee7af1b7cd33a379c09e416d902eb4f0'),(265,'en','','Tracked path of visitor','Tracked path of visitor','d8b417336ee94233ef8f7ea6b84b6d064baad719'),(266,'en','','Resolve the problem and try again. Press <a>back</a> to return to the wizard.','Resolve the problem and try again. Press <a>back</a> to return to the wizard.','d175393698d9fdc7d561888f7d7f08ee8d8b6d7e'),(267,'en','','A new visitor is waiting for an answer.','A new visitor is waiting for an answer.','c5a5df29aba49c63928601fb25afd8369e22e545'),(268,'en','','Type a password for the first administrator','Type a password for the first administrator','aa0a735dd250e9874304ed91c0eb13a64b1e95ab'),(269,'en','','Password','Password','8364caba71dbd431cf1f06bf0f3526cc29965aaa'),(270,'en','','Confirmation','Confirmation','3ab15c70644d4b1d014d2a8b6d7d91ce8bb332aa'),(271,'en','','The system is already installed!','The system is already installed!','5010efb5b4a21524682bc7755214913efdf3c196'),(272,'en','','Check database connection','Check database connection','a30fcb5f2dce2719b474546f36888a562bdfb0e8'),(273,'en','','Create necessary tables','Create necessary tables','9e88ca1056b8d5f882d69d8a1ac8b86cacb25458'),(274,'en','','Set administrator password','Set administrator password','89f94d626c8850fc85c2c27dddee064c80a26d40'),(275,'en','','Passwords do not match.','Passwords do not match.','dba5bd1ef354262c77cef7741c9901d536084c53'),(276,'en','','Password is set.','Password is set.','b59948481a47b82797dbcdbe06a23f2962cb4f12'),(277,'en','','Import locales','Import locales','eddeb311146f1e90331c1b7f9b645f4a3e3d308f'),(278,'en','','Check sound and lock the installation','Check sound and lock the installation','f5e1070d7713a72684c746bf085e9c14f210d800'),(279,'en','','You can login to using <a href=\"{0}\">this</a> link.','You can login to using <a href=\"{0}\">this</a> link.','33d01e046d80d482baf97907f0a25b073d747790'),(280,'en','','Installation','Installation','4478e41ec75979d511c02a4df91eaa1d646143e8'),(281,'en','','Problem','Problem','9506b93ec0de07fb457712b0a389d9c2c10fd619'),(282,'en','','Follow the wizard to setup your database.','Follow the wizard to setup your database.','2e369a5216eb51ae931a668eb3f0dc095e9c90dc'),(283,'en','','Completed:','Completed:','af2ee7cae4ccfae887e4f73f4d6dab02175ee42c'),(284,'en','','Next step:','Next step:','110d40262523e5989c6881942578319bb813161c'),(285,'en','','Software license agreement','Software license agreement','1c2b620f8e9dd2b0dda66c72aefeacb7b73aeed0'),(286,'en','','Edit locale settings.','Edit locale settings.','c0fc70ac863e830b97e805cb0cf1aac2e503b0a1'),(287,'en','','Time locale','Time locale','42f4be8c4f05282a0f5c9f6e946d226b69e593ed'),(288,'en','','This value will be passed to PHP\'s setlocale function to localize words in date/time string.','This value will be passed to PHP\'s setlocale function to localize words in date/time string.','200393845b5eb6d11c6172a8f3543d38e39c27fd'),(289,'en','','Date format (full)','Date format (full)','0b1196b103b00f53a83505212ba9c7055cebeda2'),(290,'en','','This value will be used with PHP\'s strftime to format date with time.','This value will be used with PHP\'s strftime to format date with time.','83bac9c3e6ffe1c642222e062a927e82d6187041'),(291,'en','','Date format (date)','Date format (date)','58072be784b22e8f82c78ee72380b21bfb9b0c48'),(292,'en','','This value will be used with PHP\'s strftime to format date only.','This value will be used with PHP\'s strftime to format date only.','48035a6fe5ce3b22250822f336d99f2bc3b2e4cf'),(293,'en','','Date format (time)','Date format (time)','6d655bcdc571fe33d64685c86414561c0214bfa0'),(294,'en','','This value will be used with PHP\'s strftime to format time only.','This value will be used with PHP\'s strftime to format time only.','a19472ac859dabac829a2c3523d3145c00886542'),(295,'en','','Login','Login','4bbe80d6a352d3b14306395152e8554cc051fab4'),(296,'en','','Your account is temporarily blocked. Please contact system administrator.','Your account is temporarily blocked. Please contact system administrator.','b5be7ade3c80c06389f72da020800f61d1055a4c'),(297,'en','','Entered login/password is incorrect','Entered login/password is incorrect','ec6a773c088b47a2d23fbeb5d993d8bdaede05d1'),(298,'en','','On this page you can configure locales which are used in the system','On this page you can configure locales which are used in the system','aaa735f3ad92dbe45d925e2c8f58028e358c40d5'),(299,'en','','Code','Code','97c7d8beffb4d8d33cf755933b61488c1bacbc28'),(300,'en','','enable','enable','da73036a7782b0978b040ee3cce2d8c2141a0c5f'),(301,'en','','disable','disable','86435b15406050d52c6409bcb963d3ae7626f303'),(302,'en','','Mibew Messenger is an open-source live support application.','Mibew Messenger is an open-source live support application.','e696dcd4d7d23a25ecf637d0e783a256829a7549'),(303,'en','','Please enter your username and password to access administrative tools. See your visitors and browse the history.','Please enter your username and password to access administrative tools. See your visitors and browse the history.','01758847b98ce87945408301ce611baa3a4b5fd5'),(304,'en','','Password:','Password:','f8268e113267ffffa02d84fcd3784713760b4642'),(305,'en','','Remember','Remember','d03676fbe38b9915d32c08b15e11271caeb88b00'),(306,'en','','Enter','Enter','d34e71f02efc1421de501d108f30c4f92a9dc412'),(307,'en','','Forgot your password?','Forgot your password?','dee79161438828a2e756733d805788e2898479ff'),(308,'en','','Mail subject','Mail subject','d81cad9663df31356baf20d4224bce8b74a8a11b'),(309,'en','','Mail body','Mail body','f5cc4235981c58741c1467de49b115b98577abb7'),(310,'en','','On this page you can edit mail templates which are used in the system.','On this page you can edit mail templates which are used in the system.','1e5d9471824325181b07d1128d1dac011ee1c92a'),(311,'en','','Trouble Accessing Your Account?','Trouble Accessing Your Account?','07b14411e37aeb2b71a93db0cdfcb3b1661bf596'),(312,'en','','No such Operator','No such Operator','c98a157e412c3d4390947a90340a7ebdfa900388'),(313,'en','','Change your password','Change your password','9fa867289683b1ed73bc1b109b2f3a6fe2d5a028'),(314,'en','','Entered passwords do not match','Entered passwords do not match','4cb24ac4302115dd16b610aded5515aa786bebc8'),(315,'en','','Machine name','Machine name','4cd1d89e2dfe2d50d8cff1ad58c5f51cf80d8f14'),(316,'en','','Plugin \"{0}\" cannot be enabled.','Plugin \"{0}\" cannot be enabled.','acbdb8ca68d726ef6cc412bda71c86eb2e3a52b2'),(317,'en','','Plugin \"{0}\" cannot be disabled.','Plugin \"{0}\" cannot be disabled.','7aa7b6764c2706bf6e1f95c211843ef5ccbb7384'),(318,'en','','Plugin \"{0}\" cannot be uninstalled.','Plugin \"{0}\" cannot be uninstalled.','fddf95589221a555db543b037898de328fcfc867'),(319,'en','','Plugin \"{0}\" cannot be updated.','Plugin \"{0}\" cannot be updated.','0d1e054748cd6aa895f33dfce8739fab7bb9447a'),(320,'en','','disabled','disabled','156ae97096807c3f5b0efa113719e885c934447a'),(321,'en','','working','working','0bb30bc3fb386086ff84339dfee05a533abdad69'),(322,'en','','needs update','needs update','b6bb1c5c50d7484efcb1a466f1b2290569300197'),(323,'en','','not initialized','not initialized','4c7f7ae552bace51fee6ba033a26db14e313cde7'),(324,'en','','You can upload your photo only as JPG, GIF, PNG or TIF image files.','You can upload your photo only as JPG, GIF, PNG or TIF image files.','190538ef8b39b4a2d95e8a4e11ce369ddd897bc6'),(325,'en','','Current avatar image','Current avatar image','6334887a58150ddc76a69dff246f45cc132cc53f'),(326,'en','','cannot load avatar','cannot load avatar','8a40c1fcfe70b7ce744b14c91410a475c85685ca'),(327,'en','','Remove avatar','Remove avatar','edd19289131c8a1b6dc01fa836673a7631cc3622'),(328,'en','','Your avatar image.','Your avatar image.','f8e30512a7fbd72772e37887792e5e4b82d8f9c8'),(329,'en','','Upload avatar','Upload avatar','1131b2bd6df1190343f8849428fadd08fe79272b'),(330,'en','','Choose the avatar file to upload.<br/>The picture size should not exceed 100x100 px.','Choose the avatar file to upload.<br/>The picture size should not exceed 100x100 px.','6e71984ff5bc89fd35c314897e85c13953d827e9'),(331,'en','','In queue','In queue','a574d494a8fa37ee489394148d44bc13f19b8fcc'),(332,'en','','Waiting for operator','Waiting for operator','3f2d69501baed438910b74010dba7554431d0df4'),(333,'en','','In chat','In chat','874cba9c05caadf12b7ee16f972b8f3e0fa19cf2'),(334,'en','','Closed','Closed','5d57fbb9fae74e35f831b8d973c07375db4cae66'),(335,'en','','Loading','Loading','3b26783b5c73edb3df63eed42c5268e2a47211a0'),(336,'en','','No geolocation data available. We recommend you to install Mibew:GeoIp and Mibew:OpenStreetMap (or Mibew:GoogleMaps) plugins.','No geolocation data available. We recommend you to install Mibew:GeoIp and Mibew:OpenStreetMap (or Mibew:GoogleMaps) plugins.','aaedab73d16148c995f52b929cb605ee3528efb1'),(337,'en','','Edit general operator settings.','Edit general operator settings.','62536e031e8283ad3940510b5762e1fe4bbf11dd'),(338,'en','','You can create a new operator here.','You can create a new operator here.','8b62ee18b731c0e46f884d9ed63f3d2c11f0415e'),(339,'en','','Login can consist of small Latin letters and underscore.','Login can consist of small Latin letters and underscore.','5335ea73197733f59f2073630f3a9f131a8b64c0'),(340,'en','','For notifications and password retrieval.','For notifications and password retrieval.','1e64379e75fa21cb589f62c9814cf97eb768477a'),(341,'en','','Enter a new password or leave the field empty to keep the previous one.','Enter a new password or leave the field empty to keep the previous one.','0774cbbe424e427bd1c5bde361568362dbf0b153'),(342,'en','','Confirm new password.','Confirm new password.','b1da2b2b366b25b562211b39a12860250a7b8091'),(343,'en','','This name will be seen by your visitors.','This name will be seen by your visitors.','183470548f669d8edc258a8940082d3060ef37b0'),(344,'en','','International name (Latin)','International name (Latin)','d607a983cf682657b2ecde4d6c0df340826939de'),(345,'en','','Use to start chat with determined operator','Use to start chat with determined operator','82a3061b611f8764ee670e8a5b5f5047f1bef011'),(346,'en','','From this page you can generate a variety of usage reports. Last time statistics was calculated {0}. You can calculate it <a href=\"{1}\" target=\"_blank\">manually</a>.','From this page you can generate a variety of usage reports. Last time statistics was calculated {0}. You can calculate it <a href=\"{1}\" target=\"_blank\">manually</a>.','ee8b14ba3d11f612cf232f44d19d3881690f95ee'),(347,'en','','You have selected From date after Till date','You have selected From date after Till date','f852af3c7b9d3b8ae6b83bfb3d3cc8239e168a86'),(348,'en','','Usage statistics for each date','Usage statistics for each date','df02111d0b0add417b2973d9c9faaeaae3517fb1'),(349,'en','','Threads by operator','Threads by operator','c782f0a254677045f1da8f288843ece2949bf601'),(350,'en','','Chat threads by page','Chat threads by page','1c0be0629c177344a3a05cd576049a8eb89c9a86'),(351,'en','','Choose groups according to operator skills.','Choose groups according to operator skills.','5b06ac227e9c637d5fc7751120b0ff16ddff4042'),(352,'en','','&lt;no description&gt;','&lt;no description&gt;','23408e536ebe746eafee9ea8c2b1966823e291ef'),(353,'en','','Site style','Site style','ada27a9abc3059ea154e6d9d9e307602d8d8e168'),(354,'en','','Operator pages themes preview','Operator pages themes preview','fd4a9ab0c8d80c15ca9f05638661b19b2ae925e7'),(355,'en','','Chat themes preview','Chat themes preview','bfc401eeeae5d90fca5f013201beada80ea98c89'),(356,'en','','Invitation themes preview','Invitation themes preview','aadecdc7c68e5839e957fcdb13650490833be587'),(357,'en','','Change restrictions and available features for this operator.','Change restrictions and available features for this operator.','6c00da3cc73e24579a1ad9d2de5cc2d329fce362'),(358,'en','','Update','Update','c17d8e6ad33f87a2f9af64f6accf7c3077217992'),(359,'en','','This page displays a list of company operators.','This page displays a list of company operators.','aae6ab4daba04565d968b39c20b64da8503825de'),(360,'en','','Add operator...','Add operator...','636756244953c293f3fcd89327611f1ffccecef2'),(361,'en','','List of visitors waiting','List of visitors waiting','3e25be3121147dd0c178ce8c81aabec8ff778c68'),(362,'en','','Password retrieval','Password retrieval','1f94194349d3cd993664543b16347ce69b365b2d'),(363,'en','','We\'ve sent the instructions to your email. Please check it.','We\'ve sent the instructions to your email. Please check it.','fb9c2a3460a53c60fcd2d36df502f4efa424e1f9'),(364,'en','','Back to login','Back to login','a8aa35743fd9b29a9e64e8b41945306d88206726'),(365,'en','','You cannot retrieve your password, but you can set a new one by following a link sent to you by email.','You cannot retrieve your password, but you can set a new one by following a link sent to you by email.','d7883a5ae73898b5d1d8009c836e615208f88705'),(366,'en','','Login or E-mail:','Login or E-mail:','e92a4d34dd10d388da106872311a433bc7d50dfc'),(367,'en','','Reset password','Reset password','f3944a8934cd96990d28970cff4711a648a3f25c'),(368,'en','','Answer','Answer','8e55cc883f8961aceba5e7c90989f71195f60401'),(369,'en','','Your password has been changed.','Your password has been changed.','25b0e70671f763d4f4d154512b2226c8bd3fb9cb'),(370,'en','','Login using your new password.','Login using your new password.','f18f62a4929139853bb754f22969814103a8207a'),(371,'en','','Proceed to login','Proceed to login','2d043da109557a9e84b8841270ab2bf2d1c66f05'),(372,'en','','Please choose a password to use with your account.','Please choose a password to use with your account.','087918813af90e88f63105daef0e86456c57a82a'),(373,'en','','Change','Change','15b86706500a6396b82492cc8cc3f52cd830145d'),(374,'en','','Here you can manage plugins. Notice that plugins are configured via the main config file.','Here you can manage plugins. Notice that plugins are configured via the main config file.','4250d228c19f3abeeb444d58c7238ce9ec4d0983'),(375,'en','','Version','Version','1f0b0928d5bef14e972c77637312d08654e78269'),(376,'en','','Dependencies','Dependencies','470fa1fd5ddf2015dd273028c0e7e4dad8eeb89a'),(377,'en','','State','State','311e191e720e746d4f2ec94ecf30fd13f0883a8f'),(378,'en','','Disable all the dependencies first','Disable all the dependencies first','912c9e209b927027773b9e537d9430eccc216934'),(379,'en','','Enable all the dependencies first','Enable all the dependencies first','4fb56029cd8bf6457b17ec5b23d3ba36f7ddabe0'),(380,'en','','uninstall','uninstall','43c5f3608f00d3ee2e1918b8ccc96ec88714f708'),(381,'en','','Uninstall all the dependencies first','Uninstall all the dependencies first','d33074ecac6ef4a76c17120e01d6afacd5b21394'),(382,'en','','update','update','c660f0ebab56dd06d8560e90ed6709c2a880eaff'),(383,'en','','Update all the dependencies first','Update all the dependencies first','8d84985b8407bece5e734b2c3172f0290a112df0'),(384,'en','','Are you sure that you want to leave the chat?','Are you sure that you want to leave the chat?','253fc376e1154a8daf4859cf50b0668994c19b17'),(385,'en','','Email','Email','4f8443d2cca6d437ea2c17372fb535f467cd7a25'),(386,'en','','Enter an email to receive system messages','Enter an email to receive system messages','f28cb8456c6cbcfeddc4d7adb1d14863c56cf03c'),(387,'en','','Language of the messages left by visitors','Language of the messages left by visitors','13f205ddb7ce79256234d9f8b35db0387d183a02'),(388,'en','','Language of the messages that could be left by visitors when operators aren\'t available','Language of the messages that could be left by visitors when operators aren\'t available','2e8801f00d6b08ae6889ce439fe4e8f76a651cfc'),(389,'en','','Name of your company for example.','Name of your company for example.','42ef41bc19344c65bc6a510ef597bac126de1ba8'),(390,'en','','Visitor\'s identifier','Visitor\'s identifier','ec87e4a565db96c285113e84d2eed0e3335be525'),(391,'en','','How to build visitor\'s identifying string from {name}, {id} or {addr}. Default: {name}','How to build visitor\'s identifying string from {name}, {id} or {addr}. Default: {name}','b4cf6dc5fd0d3e8e1c821a5c570954b29c419f97'),(392,'en','','Cron security key','Cron security key','a223eb2dd705b0ebb8a2c63e602e2c74886afa49'),(393,'en','','To run cron use link <a href=\"{0}\">{0}</a>.','To run cron use link <a href=\"{0}\">{0}</a>.','660f5acf03036baf2c1d8a692534ee57b66512f7'),(394,'en','','Select a style for your operator pages','Select a style for your operator pages','8896343fe44e7077ebd870082ce55fa1089b3c9b'),(395,'en','','A preview for each style is available <a href=\"{0}\">here</a>','A preview for each style is available <a href=\"{0}\">here</a>','124d35dab0e1ee27871078c1e3abfeaf268e0256'),(396,'en','','Select a style for your chat windows','Select a style for your chat windows','5c65a14c721affbb9451a9ab006f0019661b4a87'),(397,'en','','A preview all pages for each style is available <a href=\"{0}\">here</a>','A preview all pages for each style is available <a href=\"{0}\">here</a>','8e788fbe51cd31c59ea86b1cec378ba3ee5207d3'),(398,'en','','Select a style for your invitation','Select a style for your invitation','87755cb9f3107bc6f1b8b226a79c7c53cea887f4'),(399,'en','','A preview for invitation style is available <a href=\"{0}\">here</a>','A preview for invitation style is available <a href=\"{0}\">here</a>','de13972bb1751cd074574186a39d6b857b051534'),(400,'en','','Send messages with:','Send messages with:','483e3d5ecc2f5c7c1ec2fea09a5e1f08afd1272b'),(401,'en','','Features activated','Features activated','f579c9c0008fc62107419d2deb116eb09e23bc06'),(402,'en','','<a href=\"{0}\">Regenerate the chat button</a> for options to take effect','<a href=\"{0}\">Regenerate the chat button</a> for options to take effect','9d7b60a5e4ab6f077ad86c6226fd8ca2c4cd8ae3'),(403,'en','','Allows users to change their names','Allows users to change their names','28084050022357b64862df4a1104a043f7b3a49d'),(404,'en','','Turn off to hide edit box from chat window','Turn off to hide edit box from chat window','9fe8d93a5c6da50359ee799476bcbd9ca811ea2f'),(405,'en','','Allow secure connections (SSL)','Allow secure connections (SSL)','39249ffae9ab65dad541ec38ece17021d1719671'),(406,'en','','Please note that your web server should be configured to support https requests.','Please note that your web server should be configured to support https requests.','5fc4ab5605d3a233159e1473c4a2a561f8d20357'),(407,'en','','Force all chats to be secure','Force all chats to be secure','178a4b03693fb28922b6455216e80736289c5cc7'),(408,'en','','Show chats only through https connection','Show chats only through https connection','82c28fb7a0c558bc234ec3cce8f2daca5439c7c2'),(409,'en','','Enable \"Groups\"','Enable \"Groups\"','cffb058446d58a6a08d98faa5d0ccddb93d42d92'),(410,'en','','Use it to have separate queues for different questions.','Use it to have separate queues for different questions.','6d540c785a9dcce56a47a065fccf565e05634664'),(411,'en','','Enable \"Groups Isolation\"','Enable \"Groups Isolation\"','c15ce9d2d469d7a2272e3426a389b5ab01d227c7'),(412,'en','','Use it to completely isolate groups from each other.','Use it to completely isolate groups from each other.','9703ea6b76ed0eecee1973c76a2a13539b38d691'),(413,'en','','Enable \"Statistics\"','Enable \"Statistics\"','5acf846d1b90633579d71d488af07f7d62fa9a16'),(414,'en','','Adds a page with messenger usage reports.','Adds a page with messenger usage reports.','39359b8a4a5ced1e15c046623d0b0fee5d8cb8ef'),(415,'en','','Enable \"Tracking and inviting\"','Enable \"Tracking and inviting\"','708ef231b0ff62cb20fe73ea20a9faa74ff5b968'),(416,'en','','Enable tracking of visitors\' activity on your site and ability to invite visitors to chat.','Enable tracking of visitors\' activity on your site and ability to invite visitors to chat.','bab2115ed39372ea6646052175d0b48d8fef19bb'),(417,'en','','Track operators','Track operators','b0aba3902954e17c3fe9f74f518e1de753a4be41'),(418,'en','','Allow tracking system to treat operators as normal visitors and add show in the visitors on site list.','Allow tracking system to treat operators as normal visitors and add show in the visitors on site list.','5ab9d15aa9015c6c8c70a7dcd52e939614be1274'),(419,'en','','Enable feature \"Malicious Visitors\"','Enable feature \"Malicious Visitors\"','fbaf231e12918f566df0cb8f55325818ee82932f'),(420,'en','','Using it you can block attacks from specific IPs','Using it you can block attacks from specific IPs','5006d43b71af2cefe4732631c6cba00982bd3629'),(421,'en','','Enable \"Pre-chat survey\"','Enable \"Pre-chat survey\"','9f072579470b49f53d816f9c15feac5fd64f049a'),(422,'en','','Forces the user to fill out a special form to start a chat.','Forces the user to fill out a special form to start a chat.','fa848829c66926486786f8fe2d4183dceabaf4fd'),(423,'en','','Ask for visitor\'s email','Ask for visitor\'s email','ecdac08166b6d6339180f790226936a4897950bd'),(424,'en','','Show/hide email field in the survey','Show/hide email field in the survey','47e710d5d21886452ad9092b769de7131417b828'),(425,'en','','Allows a visitor to choose department/group','Allows a visitor to choose department/group','35df586ae7e8c0db1a8cd3af5026b206f4bbbd91'),(426,'en','','Show/hide department selection field in the survey','Show/hide department selection field in the survey','241bfede211849f6484fe75293002eaf81a20af6'),(427,'en','','Show initial question field','Show initial question field','8c36f6c23fdc83d0e594d27aa2b321d3004653e3'),(428,'en','','Show/hide initial question field in the survey','Show/hide initial question field in the survey','852a8446b114292a741d04b3bb979f77a1a1d8a8'),(429,'en','','Enable \"Privacy policy\"','Enable \"Privacy policy\"','5396e996e182698382a421705d73b88d327d71e4'),(430,'en','','Display a notice with the link to privacy policy on the survey page','Display a notice with the link to privacy policy on the survey page','7e747d277557ef529c2a48a1262cb3f57628adfe'),(431,'en','','Privacy policy','Privacy policy','e1365dd40c02ef3204d3712e73ae60e453e67d1d'),(432,'en','','Enter a URL of your privacy policy','Enter a URL of your privacy policy','555707ec24ac0c6d82605ad7c23fc9e871c3f99e'),(433,'en','','Enable \"Popup dialog notification of the new visitor\".','Enable \"Popup dialog notification of the new visitor\".','e5a755f3c6cbc033f7f790c230d8ecc75f4dbe64'),(434,'en','','Small dialog appears to attract your attention.','Small dialog appears to attract your attention.','4f31f95d834a6000e8d20e9162d618405fe8373d'),(435,'en','','Show online operators on \"List of awaiting visitors\" page','Show online operators on \"List of awaiting visitors\" page','a27802b43405bc6f3243031ba97f1e5d81f5ca39'),(436,'en','','Can slow down the update rate of the list','Can slow down the update rate of the list','3ba91634912197059e902fa102c9bd6ce3c17652'),(437,'en','','Force visitor to enter a verification code when leaving message','Force visitor to enter a verification code when leaving message','b2277386bf5181b89d159fc010b23b189e0910e7'),(438,'en','','Protection against automated spam (captcha)','Protection against automated spam (captcha)','c784a304cbcec8a123f641c2f7714b88977c8094'),(439,'en','','Check updates automatically','Check updates automatically','6365e7755815265208799fbc8667ce7c95b80e06'),(440,'en','','System will check updates for the core and plugins automatically using cron','System will check updates for the core and plugins automatically using cron','c71212b04116775702da7d04dc402ed779096b59'),(441,'en','','Operator online time threshold','Operator online time threshold','06804ae75940cda3dfeb065a5831bd7b7f363c47'),(442,'en','','Set the number of seconds to show an operator as online. Default is 30 seconds.','Set the number of seconds to show an operator as online. Default is 30 seconds.','55c9ceb8b61cf2a3d32fa2c22881465a5df7cfe0'),(443,'en','','Connection timeout for messaging window','Connection timeout for messaging window','3e1532729d5bfa73a2bb5e51307c3e0f7d93f912'),(444,'en','','Set the number of seconds after the last ping to consider the chat window still connected. Default is 30 seconds.','Set the number of seconds after the last ping to consider the chat window still connected. Default is 30 seconds.','9e176511d727cb823316a4bef0808584fe5b4fc9'),(445,'en','','Operator\'s console refresh time','Operator\'s console refresh time','c5f060223f11e6a8523a758af772b232a993a2bc'),(446,'en','','Specify the poll interval in seconds. Default is 2 seconds.','Specify the poll interval in seconds. Default is 2 seconds.','a8d4c45ab29a89b2184d76b6803fbe37e663fdca'),(447,'en','','Chat refresh time','Chat refresh time','416c74599c68ff98b79f2eaa68da4204b00edf3a'),(448,'en','','Max number of threads from one address','Max number of threads from one address','54055be08911c998509a6904c7da2c3d63663401'),(449,'en','','0 allows any number of connections','0 allows any number of connections','7d2198531369d2316a3d6e5c9b48c84dd71fd3e6'),(450,'en','','Thread lifetime','Thread lifetime','116fbfbcb8d23c833ac760d43b4fe16bf187e39c'),(451,'en','','Specify the lifetime of the thread after closing the dialog box in seconds. Default is 600 seconds. Set 0 for unlimited thread lifetime.','Specify the lifetime of the thread after closing the dialog box in seconds. Default is 600 seconds. Set 0 for unlimited thread lifetime.','4c09361b05243cdec6c28389d96490ad415ef62d'),(452,'en','','Tracking refresh time','Tracking refresh time','8b70d501de65a65d2b51dc6515f25d3877eb6d3c'),(453,'en','','Specify the poll interval in seconds. Default is 10 seconds.','Specify the poll interval in seconds. Default is 10 seconds.','b66e655433d73e6e9868c8e27794dc6f092e6de1'),(454,'en','','Limit for tracked visitors list','Limit for tracked visitors list','c4ea4b637d8db2738f73ec8ebc0f0d58b7d0dd96'),(455,'en','','Specify the number of items to display in tracked visitors list. Default is 20. Set 0 for all visitors (not recommended).','Specify the number of items to display in tracked visitors list. Default is 20. Set 0 for all visitors (not recommended).','bd888440d836b38d2484a72ffb004c49e0c0d85d'),(456,'en','','Invitation lifetime','Invitation lifetime','c84cfbbbd3b5e77666cf95b013f44d6d6e763633'),(457,'en','','Specify the lifetime of invitation in seconds. Default is 60 seconds.','Specify the lifetime of invitation in seconds. Default is 60 seconds.','a979438a3dfbdf178b82b69d148e972336f71343'),(458,'en','','Track lifetime','Track lifetime','601e027dfc9bac200fd91bacd615a463310e8681'),(459,'en','','Specify the lifetime of old visitor\'s tracks in seconds. Default is 600 seconds.','Specify the lifetime of old visitor\'s tracks in seconds. Default is 600 seconds.','645bbc1afe03f6a5219dfed23794305de78644fc'),(460,'en','','Maximum size of uploaded files','Maximum size of uploaded files','2f511e29b45320bde2fc20f56aa1cc8563be5e84'),(461,'en','','The upper limit of uploaded files (avatars) in bytes. Default is 100000 bytes.','The upper limit of uploaded files (avatars) in bytes. Default is 100000 bytes.','456c56d28e29f901690c90d67473874891c8b4f2'),(462,'en','','Beware that statistics is aggregated up to yesterday.','Beware that statistics is aggregated up to yesterday.','540dead46f2d98d674e82d4ebcb6a627addfd265'),(463,'en','','Select dates','Select dates','c16182e3847bde3a450d4c673075966200ca2046'),(464,'en','','From:','From:','4f31931df8725e21b13297d864cdfebb258b1fbc'),(465,'en','','Till:','Till:','7a5515d2145d8518c3f0f2056dac4d0dcd3d2985'),(466,'en','','Date','Date','493e277369d9eb99347dd0b7a5c57c11874a3e71'),(467,'en','','Chat threads','Chat threads','41baf4587ae5bac0d77d0ff800625f0c7f551487'),(468,'en','','Missed threads','Missed threads','ed93838d071b502ad60c9e1419f4a450356e3b39'),(469,'en','','Messages from operators','Messages from operators','657c8f383069200f35cf829c911d604ebb1e4b3e'),(470,'en','','Messages from visitors','Messages from visitors','637fc86e970b4b77624339968782725244c6cc2d'),(471,'en','','Average waiting time (in seconds)','Average waiting time (in seconds)','eef312ddee886a93cb428e68b5b72fc1c3b2827b'),(472,'en','','Average chat time (in seconds)','Average chat time (in seconds)','2278cd5525c5ae55c5e7caf5fcb719682e6cb1db'),(473,'en','','Invitations sent','Invitations sent','805d17c5798bcaa92ae6928be0e2d16f89583eee'),(474,'en','','Invitations accepted','Invitations accepted','d2b02611717cf5c30e02efd06ad5be27afc5e01b'),(475,'en','','Invitations rejected','Invitations rejected','7bab666714300e0186a3816ec73fbdf87a8e69df'),(476,'en','','Invitations ignored','Invitations ignored','f57c82e13368848cd74ede128efbc4a3c514e3a9'),(477,'en','','Total:','Total:','5457d5d8557d2082840d0b622a3c3a2713a86219'),(478,'en','','Not enough data','Not enough data','6489b6b5e3e673db65f71ed2a7f7e7e8d65afdd5'),(479,'en','','Chat Threads','Chat Threads','c616961bdabb03181f21824c3596247ebddcc9e5'),(480,'en','','Messages','Messages','6b945ad52f3b5173555e898e3d38dea60fd3e7e6'),(481,'en','','Average message length (in chars)','Average message length (in chars)','3b00fa0aaf80c6577c6027e9ecda108cc87d9ad6'),(482,'en','','Page','Page','fececff96e3fd3aa9bb1c4294c372b9e45767acd'),(483,'en','','View times','View times','c1b9418d75ad697bae5083151a286448ac340451'),(484,'en','','You can view the list of themes you currently have installed here.','You can view the list of themes you currently have installed here.','38c579b0f52a3a4f11ea66bffee3faad895de50d'),(485,'en','','Choose style','Choose style','614e19a1a27592f738d35a1eb69985c110139b9d'),(486,'en','','This page displays tracked history of visitor\'s activity on site.','This page displays tracked history of visitor\'s activity on site.','a1355428c0151abe629992c2314d206f82f3e5c6'),(487,'en','','Visitor came from','Visitor came from','291058937580ddb0fe4cea30a6bba57178017aff'),(488,'en','','direct visit','direct visit','c099a2e8cf01d63abb3d961389b87efd5b1120c1'),(489,'en','','Visit time','Visit time','fa181ce308ce23660315f8b1d77c305b4f92ae5e'),(490,'en','','Visited page','Visited page','222802c9fe884a83fbc3d45cbda72515b51cf6f0'),(491,'en','','Your translation is saved.','Your translation is saved.','6c303ad761bd03e1c08d5dc8446c7a7c6e96c973'),(492,'en','','Enter your translation.','Enter your translation.','ff530f8f798579e014f7a04bcde80515303c8a9d'),(493,'en','','Source string','Source string','5455d7334fcd49485c5cf07b853d84abb3965e3c'),(494,'en','','On this page you can download translations.','On this page you can download translations.','608c954cb9c17e5554766af1b4f72f267e80e073'),(495,'en','','On this page you can upload a custom translation file.','On this page you can upload a custom translation file.','b9c21e3a0519aeed119508e4c1711151930136e0'),(496,'en','','Translation imported','Translation imported','73606f04a236bd40a62e79b997532f5feede3c1f'),(497,'en','','Override existing translations','Override existing translations','62fe1f0f9fcc8a9ff6025ecbb4c98bc31b92e379'),(498,'en','','Replaces translated strings in the database with values from the imported file.','Replaces translated strings in the database with values from the imported file.','44e377b1324dcc59da287cc57d51a1f187dbc2d2'),(499,'en','','Upload translation','Upload translation','496c0244df540dc4251c5be116303b5a080bc252'),(500,'en','','Choose the translation file to upload.','Choose the translation file to upload.','dd3306217ac687e9305ba42488c60bbb8668818b'),(501,'en','','Upload','Upload','1fec1d3f4939edd9a13e4fdf307ed6004b15c66e'),(502,'en','','If you don\'t agree with the translation please send us an update.','If you don\'t agree with the translation please send us an update.','b41bf59f54ae7798d0f037c2cac401171492851f'),(503,'en','','Follow the wizard to update your database.','Follow the wizard to update your database.','4f2961845df7c3a2ad329256ee7207cb073af285'),(504,'en','','Backup the database','Backup the database','52957464e09b82603e8d6a33379e1d4a3ea72692'),(505,'en','','Backup the code','Backup the code','6d2dd25f128e2e568c43289cfbdc45435cf7ca18'),(506,'en','','Replace all files with ones from the new version','Replace all files with ones from the new version','b739c28d459ec356595831b94000f926a313143b'),(507,'en','','Update configs file if needed','Update configs file if needed','e590a3d4833c9c91bbf328310a75dcba83520a3b'),(508,'en','','Run the <a href=\"{0}\">update wizard</a>','Run the <a href=\"{0}\">update wizard</a>','daf855d3a2648dac505b41fe88314a64a1324535'),(509,'en','','Progress:','Progress:','f8c49c3136209a9aae60cb3b3239e4bba1b1980b'),(510,'en','','Update failed.','Update failed.','7453df10a8589e82e497688119b4b306d47b7c57'),(511,'en','','You can try to restore database from the backup and run the update wizard again.','You can try to restore database from the backup and run the update wizard again.','268013d712bbd0d122bfd9fd8cc7899106aa1ff4'),(512,'en','','Application successfully updated.','Application successfully updated.','e0b4e6f0952f563537496b5ce1a9d8c14917776f'),(513,'en','','Go to <a href=\"{0}\">home page</a>','Go to <a href=\"{0}\">home page</a>','29df04bb3be22cdeda55865d61ef328e76d2082f'),(514,'en','','Show menu','Show menu','3801a7e24332bce889d2e168cd1d9bc77185d790'),(515,'en','','Hide menu','Hide menu','353bc4c8993da6793574394f9913627bd09d26d4'),(516,'en','','This page displays a list of visitors who are waiting.','This page displays a list of visitors who are waiting.','a72b3800e7919fc3eaad259522f0f4cb780b896c'),(517,'en','','To answer the visitor click their name in the list.','To answer the visitor click their name in the list.','07b633c4ed5dc18217e986934c55e263c9e7f92e'),(518,'en','','Visitors on site','Visitors on site','c9c730992aef76fcacafa13f1fb6be37ef7e0b1e'),(519,'en','','The table below represents a list of visitors ready to chat on your site.','The table below represents a list of visitors ready to chat on your site.','cd01d370a897fff8f3aca47fc9167c15e2f25f77'),(520,'en','','To invite the visitor to chat click on his/her name in the list.','To invite the visitor to chat click on his/her name in the list.','685fc5178be8e1a3f53077098b8953ba178b8edc'),(521,'en','','PHP version {0}','PHP version {0}','2633449cf8b1b0e65b342ae37662c39641553358'),(522,'en','','All necessary PHP extensions are loaded','All necessary PHP extensions are loaded','926a432fe82168a7fbddca04d471f9c805ef8918'),(523,'en','','Directories permissions are correct','Directories permissions are correct','59b49a62a704ac33bbcfafa965fd19de4a417c8a'),(524,'en','','You are connected to MySQL server version {0}','You are connected to MySQL server version {0}','5da24b038140616641c84a7cbd0698633d1a78aa'),(525,'en','','The tables are alredy in place but outdated. Run the updater to fix it.','The tables are alredy in place but outdated. Run the updater to fix it.','854fe102faba855ea7bd4bc5b40f1d2aa949affb'),(526,'en','','Tables structure is up to date.','Tables structure is up to date.','3e3986bc87bbfd6a3886c5d21de8d4f3a0d01675'),(527,'en','','Tables are created.','Tables are created.','9c5af34f32c8e6e4f9adc7d85c70fd605ed1d6e4'),(528,'en','','Tables are pre popluated with necessary info.','Tables are pre popluated with necessary info.','9985c217ce69e599fa09d6861373e9a3ebab2299'),(529,'en','','Cannot set password. Error: {0}','Cannot set password. Error: {0}','6a9ee37f9d44635aad1501d77a994c1cf340e052'),(530,'en','','Locales are imported.','Locales are imported.','f3a2758f24364a2d84937dac1c884212a69f4b27'),(531,'en','','Locales content is imported.','Locales content is imported.','90a28c3bb1d17a3e9883cae59810bffe857d4ab1'),(532,'en','','Cannot create tables. Error: {0}','Cannot create tables. Error: {0}','d475865dbcc09de94a75e14a5f2caba4a60e2b55'),(533,'en','','Cannot create the first administrator. Error {0}','Cannot create the first administrator. Error {0}','933070a99fa7a956cc78e87f067f646d1520dc36'),(534,'en','','Cannot initialize chat revision sequence. Error {0}','Cannot initialize chat revision sequence. Error {0}','a52c6114692f724df6d92f386a67fd0c3867b113'),(535,'en','','Cannot store database structure version. Error {0}','Cannot store database structure version. Error {0}','56b085c35b39808f63cb6c232286c4d29b47596e'),(536,'en','','Cannot store instance ID. Error {0}','Cannot store instance ID. Error {0}','5d167e4f91b86d3cbd576e4c8c0198f701e323a5'),(537,'en','','PHP version is {0}, but Mibew Messenger works with {1} and later versions.','PHP version is {0}, but Mibew Messenger works with {1} and later versions.','08adb9da1cddfe478c52cc4b006f520567488877'),(538,'en','','PHP {0} extension is not loaded','PHP {0} extension is not loaded','703940b8a985e4d89d48712580a21bd3d82ef077'),(539,'en','','Cache directory \"{0}\" is not writable.','Cache directory \"{0}\" is not writable.','0e727af376e29eac3294ae00b0222d081c8027cb'),(540,'en','','Avatars directory \"{0}\" is not writable.','Avatars directory \"{0}\" is not writable.','ea35056c609e0dfbe57534a0d7f12bbb9deca020'),(541,'en','','Cannot import locales. Error: {0}','Cannot import locales. Error: {0}','3d55f5447afce6533d371481d5af3db1a1f834df'),(542,'en','','Cannot import locales content. Error: {0}','Cannot import locales content. Error: {0}','8dc8eda25c89b1486d5c39959ffe7b47c28166a8'),(543,'en','','Could not connect. Please check server settings in config.yml. Error: {0}','Could not connect. Please check server settings in config.yml. Error: {0}','3a03ab19c45f2a505ed6927fb5bf2c8fd64534dd'),(544,'en','','Up to date','Up to date','83b414c1489d64475d66b5a8b89c0d19a1d07e81'),(545,'en','','The list of visitors waiting is empty','The list of visitors waiting is empty','8dfed22156efe788b1a0715a84c32119ee58bb0c'),(546,'en','','The current version ({0}) is unknown or wrongly formatted','The current version ({0}) is unknown or wrongly formatted','e96a779cab3b199d93bcf7098bba50d536dd4fe7'),(547,'en','','The database is already up to date','The database is already up to date','aa475a5d7e1fd04a6d806e098b8f0fdcc18892b3'),(548,'en','','You can update the system only from {0} and later versions. The current version is {1}','You can update the system only from {0} and later versions. The current version is {1}','de529b581e73996e465c975e828e9ad12f1881a6'),(549,'en','','Cannot update to {0}','Cannot update to {0}','e0cf3c0248f91d8284483407c912d0fbb7d6006c'),(550,'en','','Updated to {0}','Updated to {0}','4fcd1a196ecaa5cb9b477cd01d32f609d002c1d7'),(551,'en','','Update failed: {0}','Update failed: {0}','5413d0330d8d3eabfa781c917bcac1e3032e5beb'),(552,'en','','Could not retrieve database instance. Error: {0}','Could not retrieve database instance. Error: {0}','5f15a547c77830d0be18fea2f164d46ef1436c49'),(553,'en','','Cannot store new version number','Cannot store new version number','b0e597baf641897f51b88e6b44c152a32542d67a'),(554,'en','','Cannot update content: {0}','Cannot update content: {0}','5714508960529e3f6cabb3eb12471129b15f1ab7'),(555,'en','','Cannot update tables: {0}','Cannot update tables: {0}','23a846985c21e839bce2a6070ee1990cf6923eeb'),(556,'en','','There are no visitors ready to chat on your site at present time','There are no visitors ready to chat on your site at present time','c5fe5ed3b707fe0ce01db36cc2ac96ab72ba14ce'),(557,'en','','Click to chat with the visitor','Click to chat with the visitor','8e918e70b8c9e6474418ecd1e77dd14723df586c'),(558,'en','','Watch the chat','Watch the chat','4cd8569484c923f094ed3bf96bce88e4db14d35f'),(559,'en','','[spam]','[spam]','7c4c10ba89b561b29ac6c764f459e9c11fdf71f0'),(560,'en','','Tracked visitor\'s path','Tracked visitor\'s path','ff14b4a9436e3b8dbbcf346b15fd56ca756e93eb'),(561,'en','','Ban this visitor','Ban this visitor','756d5a32e632fcabeacc14604c9a76d9f160b82e'),(562,'en','','Set status as \"Available\"','Set status as \"Available\"','35ed4a2cbcc688f73f41571d817eb29b9439b64b'),(563,'en','','Set status as \"Away\"','Set status as \"Away\"','e90262a9fab39beedb760c9a37526a2b3cb32d7c'),(564,'en','','Actions','Actions','a3b175d4c7c942ee6aafd207d186eb9cbb237ae7'),(565,'en','','Total time','Total time','b7cd06121675c7afb255b3c8a967fca8924d4214'),(566,'en','','Waiting time','Waiting time','8990bb9fe89f311aa46f32fd6bff88319ab63925'),(567,'en','','Misc','Misc','1c93f35ce985c87908821ee2fd82126ef2014689'),(568,'en','','Invite to chat','Invite to chat','5bd82e50bb27c489d79635c9275ef3a36d001bad'),(569,'en','','First seen','First seen','e3a8030acf5494f804da61b4500af6ea898ed028'),(570,'en','','Last seen','Last seen','6837814c50e3ab50b82db37ba0f691b5a41e5924'),(571,'en','','Invited by','Invited by','2a321d7de8a057a35bd7490a83879dca4cbdbe3d'),(572,'en','','Invitation time','Invitation time','9b402b1b482ed81b7c4cd44993110ddcbf832d15'),(573,'en','','Invitations / Chats','Invitations / Chats','7a98758173548dcf9054d04431d62d1bb2bf47bb'),(574,'en','','The letters you typed don\'t match the letters that were shown in the picture.','The letters you typed don\'t match the letters that were shown in the picture.','0d4f487674a6b1a60565ce4ae00bda9a7c131879'),(575,'en','','E-Mail: {0}','E-Mail: {0}','3c7eb9cbcc3eaa733a2fd65a88da716ce2719af0'),(576,'en','','Name is required.','Name is required.','4ae10f312acfb633098432516cb30b79b14984c9'),(577,'en','','Wrong email address.','Wrong email address.','fb7e5f84bd7734659cee78b7aa31cfba34c98799'),(578,'en','','Wrong thread','Wrong thread','8e042f588a2d099fbe3400bec04672637cb8b590'),(579,'en','','Cannot take over','Cannot take over','e28059967a38d8bdc8e59aed0fbebacd0b694a24'),(580,'en','','Change operator','Change operator','894c2e7800f3759694d44f2dbb5e2fb012cd3d3c'),(581,'en','','Cannot take thread','Cannot take thread','318132d55230a3b51e5a7b6fa46d21ce0846c3e5'),(582,'en','','Cannot view threads','Cannot view threads','682c58643613a9889040a4a7735d96f57083e8c0'),(583,'en','','The visitor has been placed in a priorty queue of the group {0}.','The visitor has been placed in a priorty queue of the group {0}.','876d0326b3df9cca659c615bd38fd1dc8f4ef266'),(584,'en','','You are not chatting with the visitor.','You are not chatting with the visitor.','5a1d7b9d30360c45092b5427505745d5808b21c3'),(585,'en','','The visitor has been placed in the priorty queue of the operator {0}.','The visitor has been placed in the priorty queue of the operator {0}.','80679681cf5f31adb2d8e2419d89a50136ddf36a'),(586,'en','','Operator {0} redirected you to another operator. Please wait a while.','Operator {0} redirected you to another operator. Please wait a while.','84269089eec9a52ce4579ce75e24b373d2672ba0'),(587,'en','','General','General','1da1f10d482816613237eeaebd072729d4add618'),(588,'en','','Members','Members','9b91ecdb46c381b5540076f247a41360a2824599'),(589,'en','','descending','descending','4d544ea47cb23ae152d9de705236f90ca0d94050'),(590,'en','','ascending','ascending','4e3bd9f472de34fa494981587e78b46e13c747c9'),(591,'en','','Group details','Group details','9b6146819ccce9dc369d55d50a8485f52334f246'),(592,'en','','Please choose another name because a group with that name already exists.','Please choose another name because a group with that name already exists.','86794b9b9276125d91d26099a4119c7fbd6b3138'),(593,'en','','Translations import','Translations import','1dc353a9be0054bbd609b074c944002c5e847035'),(594,'en','','Translations export','Translations export','8ea73eccbed4f38a9b228f6a54309c5e8f0b25da'),(595,'en','','Locales','Locales','d0e069c05cb021671de5f0f5f5289dd58bd89ffd'),(596,'en','','Cannot disable all locales.','Cannot disable all locales.','5ecccd4aa5f8dc94a705e4537da7cb36e48f900c'),(597,'en','','Locale details','Locale details','c94618b33383e0d812c7c418655c978cb37ad8f4'),(598,'en','','Translation','Translation','a636b5f6c9b3c43444aec24b25dc14df706a1998'),(599,'en','','Uploaded file size exceeded','Uploaded file size exceeded','6e935fb069b594f0e5b4352103d28ea2c14cef37'),(600,'en','','Invalid file type','Invalid file type','5f1b1550115ff094f1fc6dc89755386373c06315'),(601,'en','','No file selected','No file selected','1316b9d9972dc97206350e7edb784f56b2542624'),(602,'en','','Photo','Photo','02b70cede0951675802f2f39deaeb6a04d5a8ee1'),(603,'en','','Permissions','Permissions','7ac419ca1412558b2f3d06381cf41065908e028b'),(604,'en','','-not found-','-not found-','6cf3470af4d67e245b973e5857da7b3b81c84da9'),(605,'en','','Upload photo','Upload photo','61c653b8a1cc320deb7dabd9feb8be4e4f955291'),(606,'en','','Error moving file','Error moving file','30502b3b3d0275720de1450bdc2121c46939840f'),(607,'en','','Operator groups','Operator groups','e879296fd5e92f35892faa5217d88c4510d2d7bd'),(608,'en','','Cannot remove self.','Cannot remove self.','d84f827659045af9883fd22624d8f15c0c21fb5a'),(609,'en','','Cannot disable self.','Cannot disable self.','18aef3c9bfc50194fd76e1a548b21427687489e7'),(610,'en','','No Password set for the Administrator','No Password set for the Administrator','f359d12ff2e6903447b0b89f07bf8fe3a20d5cf2'),(611,'en','','Operator details','Operator details','b42c9024ef4b6ca55be442b77ca6555435d10e25'),(612,'en','','Login should contain only latin characters, numbers and underscore symbol.','Login should contain only latin characters, numbers and underscore symbol.','ac803c939c3a7039b8ba2e73779342b5abace737'),(613,'en','','Code should contain only latin characters, numbers and underscore symbol.','Code should contain only latin characters, numbers and underscore symbol.','4ec611fc975d903b7a59f9eb03bbde7dcdd1a66c'),(614,'en','','Please choose another login because an operator with that login is already registered in the system.','Please choose another login because an operator with that login is already registered in the system.','42f63ff84c22fedf7dbeacb1f73d8331daaab54e'),(615,'en','','Please choose another email because an operator with that email is already registered in the system.','Please choose another email because an operator with that email is already registered in the system.','471b5040f530c4079bb4a3313a1c3faf8531825d'),(616,'en','','Optional Services','Optional Services','e33fa803d44cc6d65539607bb7b030636949ad61'),(617,'en','','Performance','Performance','6fd7022fba9c81edf91bf8b92d85f55254f01b07'),(618,'en','','Messenger settings','Messenger settings','326baafac85362582e216c8c2292c957d63b2b79'),(619,'en','','Enter a valid email address','Enter a valid email address','a73d7222e5fd9882152f33f778233f7dbe881edb'),(620,'en','','Use only Latin letters(upper and lower case) and numbers in cron key.','Use only Latin letters(upper and lower case) and numbers in cron key.','08e4b43ca1f8fe96bde37a0434314e1b850ada7f'),(621,'en','','\"Max number of threads\" field should be a number','\"Max number of threads\" field should be a number','fd28f881717822978a3c722a1666400603ec5a40'),(622,'en','','\"Thread lifetime\" field should be a number','\"Thread lifetime\" field should be a number','9f20699b1d2e0aa6debe235f7f47e7bcfbbaa74d');
/*!40000 ALTER TABLE `translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitedpage`
--

DROP TABLE IF EXISTS `visitedpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitedpage` (
  `pageid` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(1024) DEFAULT NULL,
  `visittime` int(11) NOT NULL DEFAULT '0',
  `visitorid` int(11) DEFAULT NULL,
  `calculated` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pageid`),
  KEY `visitorid` (`visitorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitedpage`
--

LOCK TABLES `visitedpage` WRITE;
/*!40000 ALTER TABLE `visitedpage` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitedpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitedpagestatistics`
--

DROP TABLE IF EXISTS `visitedpagestatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitedpagestatistics` (
  `pageid` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL DEFAULT '0',
  `address` varchar(1024) DEFAULT NULL,
  `visits` int(11) NOT NULL DEFAULT '0',
  `chats` int(11) NOT NULL DEFAULT '0',
  `sentinvitations` int(11) NOT NULL DEFAULT '0',
  `acceptedinvitations` int(11) NOT NULL DEFAULT '0',
  `rejectedinvitations` int(11) NOT NULL DEFAULT '0',
  `ignoredinvitations` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitedpagestatistics`
--

LOCK TABLES `visitedpagestatistics` WRITE;
/*!40000 ALTER TABLE `visitedpagestatistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitedpagestatistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-13 14:03:47
