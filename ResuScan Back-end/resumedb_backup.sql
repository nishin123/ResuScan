-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: resumedb
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'company'),(1,'user');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add company',7,'add_company'),(26,'Can change company',7,'change_company'),(27,'Can delete company',7,'delete_company'),(28,'Can view company',7,'view_company'),(29,'Can add complaints',8,'add_complaints'),(30,'Can change complaints',8,'change_complaints'),(31,'Can delete complaints',8,'delete_complaints'),(32,'Can view complaints',8,'view_complaints'),(33,'Can add exam_result',9,'add_exam_result'),(34,'Can change exam_result',9,'change_exam_result'),(35,'Can delete exam_result',9,'delete_exam_result'),(36,'Can view exam_result',9,'view_exam_result'),(37,'Can add exam_schedule',10,'add_exam_schedule'),(38,'Can change exam_schedule',10,'change_exam_schedule'),(39,'Can delete exam_schedule',10,'delete_exam_schedule'),(40,'Can view exam_schedule',10,'view_exam_schedule'),(41,'Can add feedback',11,'add_feedback'),(42,'Can change feedback',11,'change_feedback'),(43,'Can delete feedback',11,'delete_feedback'),(44,'Can view feedback',11,'view_feedback'),(45,'Can add question',12,'add_question'),(46,'Can change question',12,'change_question'),(47,'Can delete question',12,'delete_question'),(48,'Can view question',12,'view_question'),(49,'Can add review',13,'add_review'),(50,'Can change review',13,'change_review'),(51,'Can delete review',13,'delete_review'),(52,'Can view review',13,'view_review'),(53,'Can add user',14,'add_user'),(54,'Can change user',14,'change_user'),(55,'Can delete user',14,'delete_user'),(56,'Can view user',14,'view_user'),(57,'Can add vaccancy',15,'add_vaccancy'),(58,'Can change vaccancy',15,'change_vaccancy'),(59,'Can delete vaccancy',15,'delete_vaccancy'),(60,'Can view vaccancy',15,'view_vaccancy'),(61,'Can add vaccancy_request',16,'add_vaccancy_request'),(62,'Can change vaccancy_request',16,'change_vaccancy_request'),(63,'Can delete vaccancy_request',16,'delete_vaccancy_request'),(64,'Can view vaccancy_request',16,'view_vaccancy_request'),(65,'Can add mock_interview',17,'add_mock_interview'),(66,'Can change mock_interview',17,'change_mock_interview'),(67,'Can delete mock_interview',17,'delete_mock_interview'),(68,'Can view mock_interview',17,'view_mock_interview'),(69,'Can add mock_interview_question',18,'add_mock_interview_question'),(70,'Can change mock_interview_question',18,'change_mock_interview_question'),(71,'Can delete mock_interview_question',18,'delete_mock_interview_question'),(72,'Can view mock_interview_question',18,'view_mock_interview_question');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$TpYqgkW0k1L79rfNKbvHHB$F8RhgDPhWE2fLXfyA+uuZ1CZcUbaTcqNZOexR1aOlCk=','2026-02-25 12:33:50.196171',1,'admin@gmail.com','','','admin@gmail.com',1,1,'2026-02-25 12:06:17.477922'),(2,'pbkdf2_sha256$1000000$KA5C7st5Rqp89n3w1SWI30$1u+Rh68y7/lXnfzswGVKylJsn5QVo21TGPkCRRju2rY=',NULL,0,'jghshqxvg@gmail.com','','','',0,1,'2026-02-25 12:11:57.599483'),(5,'pbkdf2_sha256$1000000$Knv0kx44eigzrTXOVhA3eK$/IwUjPV+kw07re8v3TlNhlCGzn5h0czirXncCxjAj9M=','2026-02-25 12:27:04.683022',1,'aju','','','aju@gmail.com',1,1,'2026-02-25 12:26:50.194092'),(6,'pbkdf2_sha256$1000000$rGhjinnitDBiXWBL83CfIQ$mp+jz0A8pQuXsUjvfCfPE09JyFmuLti51s2/8poa6+o=','2026-02-25 12:42:21.325612',0,'saran@gmail.com','','','',0,1,'2026-02-25 12:31:06.450607'),(7,'pbkdf2_sha256$1000000$CBQzFZ9SIEGm4et2EG0xad$T2CP5J+v+PVAjY/NZVMu6gdf5tewLD4fMU6D4ml1amk=','2026-02-27 06:44:37.233159',1,'admin123@gmail.com','','','',1,1,'2026-02-26 10:03:32.924117'),(8,'pbkdf2_sha256$1000000$pUKrFi3BcL2DD8THxYL1W2$thFGGtcbdf1Kb7Tc5ctmD9xadWNPAt8VHVeGM+17800=',NULL,0,'nishinpv123@gmail.com','','','',0,1,'2026-02-26 10:06:08.504871'),(10,'pbkdf2_sha256$1000000$V3OowpwcAVSnQbNei4xD2f$GgBIiI1IrvgbcudYmk9s7V/ntS1U1TgnmVnB/AowvXM=',NULL,0,'nishinpv1234@gmail.com','','','',0,1,'2026-02-26 10:10:57.894315'),(11,'pbkdf2_sha256$1000000$SK4Ie25wqDZKv360Orc7NZ$ckJEzqd/UaChuUPXdQVU3zncW89pQS58hFK+z7+cuAM=',NULL,0,'nishinputhiyaveetil123@gmail.com','','','',0,1,'2026-02-26 10:19:39.343312'),(12,'pbkdf2_sha256$1000000$rVJHJDP0M725Le8nnrP0qC$sSchFwYzQrQJ6Kts3JhAAVLjwXuECs7y4HDqWK8se0U=',NULL,0,'n123@gmail.com','','','',0,1,'2026-02-26 10:24:13.071006'),(13,'pbkdf2_sha256$1000000$zFskvaKV1hIXVFtGpqfoR0$QDO3WHnXfRIC4vgyjM5lIy5A0G5nurOi+6c/IQjKG6k=','2026-02-27 15:21:39.095993',0,'scanresu@gmail.com','','','',0,1,'2026-02-26 10:42:03.421879'),(16,'pbkdf2_sha256$1000000$3HZw0sQWD8m2FNzgwCEKl4$zvX8n9q9YwuJter6oHIgv3mYwaXaPxSfxU3dHJlbKTs=','2026-02-27 11:08:54.952960',0,'nishinputhiyaveetil@gmail.com','','','',0,1,'2026-02-26 10:55:05.612483');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,6,1),(2,12,2),(3,13,2),(4,16,1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'myapp','company'),(8,'myapp','complaints'),(9,'myapp','exam_result'),(10,'myapp','exam_schedule'),(11,'myapp','feedback'),(17,'myapp','mock_interview'),(18,'myapp','mock_interview_question'),(12,'myapp','question'),(13,'myapp','review'),(14,'myapp','user'),(15,'myapp','vaccancy'),(16,'myapp','vaccancy_request'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-02-25 12:05:50.765846'),(2,'auth','0001_initial','2026-02-25 12:05:51.205845'),(3,'admin','0001_initial','2026-02-25 12:05:51.325770'),(4,'admin','0002_logentry_remove_auto_add','2026-02-25 12:05:51.335823'),(5,'admin','0003_logentry_add_action_flag_choices','2026-02-25 12:05:51.341941'),(6,'contenttypes','0002_remove_content_type_name','2026-02-25 12:05:51.401931'),(7,'auth','0002_alter_permission_name_max_length','2026-02-25 12:05:51.457405'),(8,'auth','0003_alter_user_email_max_length','2026-02-25 12:05:51.476009'),(9,'auth','0004_alter_user_username_opts','2026-02-25 12:05:51.476009'),(10,'auth','0005_alter_user_last_login_null','2026-02-25 12:05:51.525704'),(11,'auth','0006_require_contenttypes_0002','2026-02-25 12:05:51.525704'),(12,'auth','0007_alter_validators_add_error_messages','2026-02-25 12:05:51.544047'),(13,'auth','0008_alter_user_username_max_length','2026-02-25 12:05:51.598903'),(14,'auth','0009_alter_user_last_name_max_length','2026-02-25 12:05:51.655811'),(15,'auth','0010_alter_group_name_max_length','2026-02-25 12:05:51.677631'),(16,'auth','0011_update_proxy_permissions','2026-02-25 12:05:51.685888'),(17,'auth','0012_alter_user_first_name_max_length','2026-02-25 12:05:51.732070'),(18,'myapp','0001_initial','2026-02-25 12:05:52.464425'),(19,'myapp','0002_auto_20250913_0924','2026-02-25 12:05:52.505895'),(20,'myapp','0003_auto_20251226_0958','2026-02-25 12:05:52.620613'),(21,'myapp','0004_remove_exam_result_question','2026-02-25 12:05:52.686051'),(22,'myapp','0005_mock_interview_mock_interview_question','2026-02-25 12:05:52.815692'),(23,'myapp','0006_mock_interview_question_audio_file','2026-02-25 12:05:52.828065'),(24,'myapp','0007_mock_interview_total_score','2026-02-25 12:05:52.851774'),(25,'sessions','0001_initial','2026-02-25 12:05:52.884081');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1rltj68pejwtfolcignzvzrw4wzgeo1v','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvsag:dH4VBDuoJFIehddATOBN0lqezUGUwLhGznlQoOHDTaU','2026-03-13 07:48:50.208559'),('4ha2j97mokki0g5nezvls7mr71slw57f','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvtZX:tSH3HMSsXA7DDN8kz3DC4NCnbCa840dYrp2TbVUi-OI','2026-03-13 08:51:43.719127'),('7rx7az3q4cj51wtg8n3zmyv8a5aft4qp','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvbyJ:hzwlwU0ZJK8NZr0pHSQ5MiPv_5yK1lgVJWscbxWzXSs','2026-03-12 14:04:07.915298'),('825zuq2qkezdvcthczm3hlwrv0yxl2hb','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvuGZ:UCu5vZBKH4YreqrrpiKXUist8gdB7vcS2_I2HMI7bag','2026-03-13 09:36:11.560696'),('86p0ktr63l5rvm91717n73yqhfwxxq70','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvuS4:VDQCNr2GSkhug20ko0fxDNSsxFwf8Em-jEO6jOjQF60','2026-03-13 09:48:04.990107'),('8fkpcn3ruymoollyf86wdrl2w75vosru','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvuLq:6BCWG0lCXgY9H4Dl0cPgIZXzL1GzaG5WU5WF1zTfZkY','2026-03-13 09:41:38.188612'),('cy22asg86lu86nxy7lpg4d4m7vgb63y0','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvt4A:rC_paAP2YPgMNXpSo0UezlYu_PsGnAO9kMZBEXI1-jo','2026-03-13 08:19:18.916706'),('d6qqfs4x2umoek7gyfyhhawx5ixr3h5e','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvZ1j:qqV6cmSvupgcuFfXVS5yRNDG0lasbtN4HVpP__53cMQ','2026-03-12 10:55:27.012154'),('dz9jk9tqxfwty1q92lpork119sbq0t0a','.eJxVjEEOwiAQRe_C2hBmKlBcuvcMZIBBqgaS0q6Md7dNutDtf--_t_C0LsWvnWc_JXERRpx-t0DxyXUH6UH13mRsdZmnIHdFHrTLW0v8uh7uX6BQL9sbg-bBEhkNqFgrtuhyADKZYQCNwZ2tIwNmVBE46jGSwi0fHGSNicXnC9jGN-4:1vvEDd:gHMPVBJgrS8sE98N7cyybcTkaMhDs0XKOm28cBMNX9Q','2026-03-11 12:42:21.333448'),('ef9tw6y1k5ot7rzy3kw0ritcb4aaee43','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvuBF:6ETfhMPj8odbSwUjkRWKIqgZexROqwJHVY_qGKSB7Ok','2026-03-13 09:30:41.074395'),('igbhge09jep69124g0drg05qvwuefaf6','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvroZ:y9iwXipsjiLn3TCcBf62sTge97lSWxolIT5T46VkG5Y','2026-03-13 06:59:07.556929'),('ijmeochg6jg5bl2u3gb1uswso2215fug','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvrun:FeH3b2lYw_VPu16ypCdQNKt0OtMOgArz77iq1gVQ7Zk','2026-03-13 07:05:33.138770'),('k0hpw37fzfw7aczf6il0o8k8z3uvkisp','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvt3H:KrhoZaNMU1LP3sP7yVpmSELqtsxEU7WcW7u4vZFP0xg','2026-03-13 08:18:23.205146'),('k8z5o4d2lptaxht5k2zb3n847txeep66','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvrpQ:1-4GkphuILL9ecBhzzxs5TpVxsod6XPiCtiVivQyg5w','2026-03-13 07:00:00.685367'),('meg4c6oxlbad14j9lggo05ofsgt64m3v','.eJxVjMsOwiAQRf-FtSFQ3i7d-w1khgGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2JkZdvrdENIjtx3QHdqt89TbuszId4UfdPBrp_y8HO7fQYVRv3WS5Apm8AhaiGRVEgSkUKIuVrrgnBcQJlmCtC5P2hBiIEnZKC8UIXt_AAL0OFY:1vvDyq:1kpIitdcTcbw0Lm_0fGP64uRtW1F7TmJcDCldBkkD-U','2026-03-11 12:27:04.685966'),('mnxe8igtdqg1j1uqsaa1ej0ndjeg0r3i','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvtjc:bJLZAwUFApxDt00sDChX3SHpXnl4R5Hg3rVg8FcvTLY','2026-03-13 09:02:08.015266'),('msb7je6x5pezb9luzh32tqvye9jkutlw','.eJxVjjsOwyAQRO9CHSE-y8cp0_sMaFlwcBJhydhVlLvHSC6Sdt7M07xZwH0rYW95DXNiVyY1u_yGEemZayfpgfW-cFrqts6R9wo_aePjkvLrdnb_BAVbOdbKREMWNSB6TQJSVEJIYwdQYCbpDbrkzZC1BiILhGgxaeckCJjIxkNK_aD6fAGyWTmb:1vvzet:Q5iu8lpvbiFc42lmQ74hpfXqbBa5ZT4dyOVMCnQO6iA','2026-03-13 15:21:39.097888'),('n6gemxh8juankscdhl8orpraeh1amm9o','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvuae:kS_2OkeOybp4APBZ014JGolUCV5QwaVWTB-tkWuKOfQ','2026-03-13 09:56:56.988635'),('p0x7d5ywvr021naw17xa2g21k3ihraz3','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvviI:Gi0yCXktUlmny_hMjCw0U-Ia9eOe3oHETKJ42R1z9s4','2026-03-13 11:08:54.962935'),('qpe73rlf0m46ay8x3brubgvq1o7crx1p','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvaQQ:zkAXTdq_PLvfnOF4gpXg2EyLo_hpjdLgkiY9h_0rw2s','2026-03-12 12:25:02.438019'),('rboovdcexmhrk7oqulog8oox42we618a','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvc26:uMxIppI14dBaWl7yd_iZrF-eddywPUDnRk_mogu2R5A','2026-03-12 14:08:02.480541'),('tciwy0ui8pubzg3a5uppko924kl61acw','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvrtA:Mw76B-4RI2WwEGjiTXhG1PZXArUkZmoMxFZ_eOKUbWE','2026-03-13 07:03:52.984924'),('xwabnn7ukentxn48s6noec2l5npcpwvw','.eJxVjEEOwiAQRe_C2hBmKlBcuvcMZIBBqgaS0q6Md7dNutDtf--_t_C0LsWvnWc_JXERRpx-t0DxyXUH6UH13mRsdZmnIHdFHrTLW0v8uh7uX6BQL9sbg-bBEhkNqFgrtuhyADKZYQCNwZ2tIwNmVBE46jGSwi0fHGSNicXnC9jGN-4:1vvE8A:rk8ppM3SI5HD9TKnymHt4NpN863sS6fM7StPwy_kn18','2026-03-11 12:36:42.216556'),('y8b5lq1uyts4rbqf802r3crtaye90pem','.eJxVjMEOwiAQRP-FsyHUIrt49N5vIMuy2KqBpLQn47_bJj3obTLvzbxVoHUZw9pkDlNSV9U5dfotI_FTyk7Sg8q9aq5lmaeod0UftOmhJnndDvfvYKQ2bmtJ4H0nHiL2bFgSI4GTCzoLFj1Qts7YJExsEM8OM_d5iyIAsEX1-QIZzDic:1vvtwh:aRY920LViWXd5QONzaN7aqyRMjBhUuhw1JZ00o-BPCg','2026-03-13 09:15:39.449499'),('z2ttmo3m8i7nxturv2mnlriyhd551emf','.eJxVjEEOwiAQRe_C2hBmKlBcuvcMZIBBqgaS0q6Md7dNutDtf--_t_C0LsWvnWc_JXERRpx-t0DxyXUH6UH13mRsdZmnIHdFHrTLW0v8uh7uX6BQL9sbg-bBEhkNqFgrtuhyADKZYQCNwZ2tIwNmVBE46jGSwi0fHGSNicXnC9jGN-4:1vvECf:FS3Io3KG9fRhJqTm6qH9vz9YfZbG2fImmjtS8PhCFtA','2026-03-11 12:41:21.392843');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_company`
--

DROP TABLE IF EXISTS `myapp_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `LOGIN_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_company_LOGIN_id_fa8b4b3c_fk_auth_user_id` (`LOGIN_id`),
  CONSTRAINT `myapp_company_LOGIN_id_fa8b4b3c_fk_auth_user_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_company`
--

LOCK TABLES `myapp_company` WRITE;
/*!40000 ALTER TABLE `myapp_company` DISABLE KEYS */;
INSERT INTO `myapp_company` VALUES (1,'Karthik','Kannur','n123@gmail.com','+91 7012631184','30.67456','-130.50746','pending',12),(2,'Enterprices','kannur','scanresu@gmail.com','7025505467','40.86865','-8566.987','accepted',13);
/*!40000 ALTER TABLE `myapp_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_complaints`
--

DROP TABLE IF EXISTS `myapp_complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_complaints` (
  `id` int NOT NULL AUTO_INCREMENT,
  `complaints` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `reply` varchar(100) NOT NULL,
  `reply_date` varchar(100) NOT NULL,
  `USER_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_complaints_USER_id_f1892848_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_complaints_USER_id_f1892848_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_complaints`
--

LOCK TABLES `myapp_complaints` WRITE;
/*!40000 ALTER TABLE `myapp_complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_exam_result`
--

DROP TABLE IF EXISTS `myapp_exam_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_exam_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` varchar(100) NOT NULL,
  `VACCANCY_REQUEST_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_exam_result_VACCANCY_REQUEST_id_fa48e459_fk_myapp_vac` (`VACCANCY_REQUEST_id`),
  CONSTRAINT `myapp_exam_result_VACCANCY_REQUEST_id_fa48e459_fk_myapp_vac` FOREIGN KEY (`VACCANCY_REQUEST_id`) REFERENCES `myapp_vaccancy_request` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_exam_result`
--

LOCK TABLES `myapp_exam_result` WRITE;
/*!40000 ALTER TABLE `myapp_exam_result` DISABLE KEYS */;
INSERT INTO `myapp_exam_result` VALUES (1,'10',1);
/*!40000 ALTER TABLE `myapp_exam_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_exam_schedule`
--

DROP TABLE IF EXISTS `myapp_exam_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_exam_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `venue` varchar(100) NOT NULL,
  `VACCANCY_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_exam_schedule_VACCANCY_id_2d85197d_fk_myapp_vaccancy_id` (`VACCANCY_id`),
  CONSTRAINT `myapp_exam_schedule_VACCANCY_id_2d85197d_fk_myapp_vaccancy_id` FOREIGN KEY (`VACCANCY_id`) REFERENCES `myapp_vaccancy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_exam_schedule`
--

LOCK TABLES `myapp_exam_schedule` WRITE;
/*!40000 ALTER TABLE `myapp_exam_schedule` DISABLE KEYS */;
INSERT INTO `myapp_exam_schedule` VALUES (1,'2026-02-26','01:32:43','c',1),(2,'2026-02-27','08:34','ekm',1),(3,'2026-02-27','10:30','tcr',1),(4,'','','',1),(5,'2026-02-27','13:01','ven 5',1),(6,'2026-02-27','13:49','ven 5',5),(7,'2026-02-27','16:40','ven 5',6);
/*!40000 ALTER TABLE `myapp_exam_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_feedback`
--

DROP TABLE IF EXISTS `myapp_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `USER_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_feedback_USER_id_fce7ccff_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_feedback_USER_id_fce7ccff_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_feedback`
--

LOCK TABLES `myapp_feedback` WRITE;
/*!40000 ALTER TABLE `myapp_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_mock_interview`
--

DROP TABLE IF EXISTS `myapp_mock_interview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_mock_interview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `VACCANCY_REQUEST_id` int NOT NULL,
  `total_score` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_mock_interview_VACCANCY_REQUEST_id_9aa2fb5a_fk_myapp_vac` (`VACCANCY_REQUEST_id`),
  CONSTRAINT `myapp_mock_interview_VACCANCY_REQUEST_id_9aa2fb5a_fk_myapp_vac` FOREIGN KEY (`VACCANCY_REQUEST_id`) REFERENCES `myapp_vaccancy_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_mock_interview`
--

LOCK TABLES `myapp_mock_interview` WRITE;
/*!40000 ALTER TABLE `myapp_mock_interview` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_mock_interview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_mock_interview_question`
--

DROP TABLE IF EXISTS `myapp_mock_interview_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_mock_interview_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `answer_key` longtext,
  `user_answer` longtext,
  `created_at` datetime(6) NOT NULL,
  `MOCK_INTERVIEW_id` int NOT NULL,
  `audio_file` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_mock_interview_MOCK_INTERVIEW_id_1999312c_fk_myapp_moc` (`MOCK_INTERVIEW_id`),
  CONSTRAINT `myapp_mock_interview_MOCK_INTERVIEW_id_1999312c_fk_myapp_moc` FOREIGN KEY (`MOCK_INTERVIEW_id`) REFERENCES `myapp_mock_interview` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_mock_interview_question`
--

LOCK TABLES `myapp_mock_interview_question` WRITE;
/*!40000 ALTER TABLE `myapp_mock_interview_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_mock_interview_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_question`
--

DROP TABLE IF EXISTS `myapp_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `questions` varchar(100) NOT NULL,
  `option_a` varchar(100) NOT NULL,
  `option_b` varchar(100) NOT NULL,
  `option_c` varchar(100) NOT NULL,
  `option_d` varchar(100) NOT NULL,
  `corrected_answer` varchar(100) NOT NULL,
  `EXAM_SCHEDULE_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_question_EXAM_SCHEDULE_id_b5723b0c_fk_myapp_exa` (`EXAM_SCHEDULE_id`),
  CONSTRAINT `myapp_question_EXAM_SCHEDULE_id_b5723b0c_fk_myapp_exa` FOREIGN KEY (`EXAM_SCHEDULE_id`) REFERENCES `myapp_exam_schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_question`
--

LOCK TABLES `myapp_question` WRITE;
/*!40000 ALTER TABLE `myapp_question` DISABLE KEYS */;
INSERT INTO `myapp_question` VALUES (1,'advbj','a','b','c','d','D',1),(2,'sample','s','a','m','p','A',1),(3,'dI','S','SF','J','K','B',1),(4,'JDSUJ','A','H','K','V','D',1),(5,'admin','AD','MI','N','AS','C',1),(6,'BDD','v','KJ','SV','OM','C',1),(7,'VL','SG','RA','BH','RE','B',1),(8,'GO','MP','DY','WM','FH','D',1),(9,'FE','PW','NM','SN','KD','A',1),(10,'DJDJ','HDJ','MDJ','NDJ','UDJ','B',1),(11,'abcs','gjj','gh','j','j','A',1),(12,'a','d','d','d','d','A',1),(13,'ad','d','f','f','f','A',1),(14,'admin123@gmail.com','dgh','g','h','h','A',1),(15,'company1@gmail.com','a','a','fg','gh','A',1),(16,'gsjskj','kj','hj','gjhj','hj','A',1),(17,'wooxos','jhhj','hjhj','sjnjhs','snns','A',6);
/*!40000 ALTER TABLE `myapp_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_review`
--

DROP TABLE IF EXISTS `myapp_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reviews` varchar(100) NOT NULL,
  `rating` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `COMPANY_id` int NOT NULL,
  `USER_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_review_USER_id_0e923f15_fk_myapp_user_id` (`USER_id`),
  KEY `myapp_review_COMPANY_id_e6126bb6_fk_myapp_company_id` (`COMPANY_id`),
  CONSTRAINT `myapp_review_COMPANY_id_e6126bb6_fk_myapp_company_id` FOREIGN KEY (`COMPANY_id`) REFERENCES `myapp_company` (`id`),
  CONSTRAINT `myapp_review_USER_id_0e923f15_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_review`
--

LOCK TABLES `myapp_review` WRITE;
/*!40000 ALTER TABLE `myapp_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_user`
--

DROP TABLE IF EXISTS `myapp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `pin` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `LOGIN_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_user_LOGIN_id_da832ded_fk_auth_user_id` (`LOGIN_id`),
  CONSTRAINT `myapp_user_LOGIN_id_da832ded_fk_auth_user_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_user`
--

LOCK TABLES `myapp_user` WRITE;
/*!40000 ALTER TABLE `myapp_user` DISABLE KEYS */;
INSERT INTO `myapp_user` VALUES (1,'saran','ekm','876543','ekm','saran@gmail.com','9087654321',6),(2,'Nishin ','Kannur','670331','kannur','nishinputhiyaveetil@gmail.com','7025505269',16);
/*!40000 ALTER TABLE `myapp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_vaccancy`
--

DROP TABLE IF EXISTS `myapp_vaccancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_vaccancy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_title` varchar(100) NOT NULL,
  `job_description` varchar(100) NOT NULL,
  `required_skills` varchar(100) NOT NULL,
  `experience` varchar(100) NOT NULL,
  `salary_range` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `fromdate` varchar(100) NOT NULL,
  `todate` varchar(100) NOT NULL,
  `COMPANY_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_vaccancy_COMPANY_id_6054fd9f_fk_myapp_company_id` (`COMPANY_id`),
  CONSTRAINT `myapp_vaccancy_COMPANY_id_6054fd9f_fk_myapp_company_id` FOREIGN KEY (`COMPANY_id`) REFERENCES `myapp_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_vaccancy`
--

LOCK TABLES `myapp_vaccancy` WRITE;
/*!40000 ALTER TABLE `myapp_vaccancy` DISABLE KEYS */;
INSERT INTO `myapp_vaccancy` VALUES (1,'SE','SE','Pttt','2','4000','2026-02-27','Active','2026-02-27','2026-02-28',2),(2,'SE','SE','py','5','40000','2026-02-27','Active','2026-02-28','2026-03-14',2),(3,'SE','SE','PY','4','4000','2026-02-26','Active','2026-02-26','2026-02-27',2),(4,'Soft','a soft ware ','\'Python,react','3','70000','2026-02-27','Active','2026-02-27','2026-02-28',2),(5,'SEeeee','Asddd','Pytrhon ','4','60000','2026-02-27','Active','2026-02-27','2026-02-28',2),(6,'Devloper','Developer','Python','4','40007','2026-02-27','Active','2026-02-27','2026-03-02',2);
/*!40000 ALTER TABLE `myapp_vaccancy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_vaccancy_request`
--

DROP TABLE IF EXISTS `myapp_vaccancy_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_vaccancy_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `resume` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `schedule` varchar(100) NOT NULL,
  `USER_id` int NOT NULL,
  `VACCANCY_id` int NOT NULL,
  `interview_date` varchar(100) NOT NULL,
  `interview_time` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_vaccancy_request_USER_id_1e578f7e_fk_myapp_user_id` (`USER_id`),
  KEY `myapp_vaccancy_request_VACCANCY_id_8b46c9e7_fk_myapp_vaccancy_id` (`VACCANCY_id`),
  CONSTRAINT `myapp_vaccancy_request_USER_id_1e578f7e_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`),
  CONSTRAINT `myapp_vaccancy_request_VACCANCY_id_8b46c9e7_fk_myapp_vaccancy_id` FOREIGN KEY (`VACCANCY_id`) REFERENCES `myapp_vaccancy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_vaccancy_request`
--

LOCK TABLES `myapp_vaccancy_request` WRITE;
/*!40000 ALTER TABLE `myapp_vaccancy_request` DISABLE KEYS */;
INSERT INTO `myapp_vaccancy_request` VALUES (1,'2026-02-26','resumes/resume_16_1_20260226_162907.jpg','Failed','tcr',2,1,'2026-02-27','10:30','','16:29:07');
/*!40000 ALTER TABLE `myapp_vaccancy_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-27 20:56:49
