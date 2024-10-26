-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pfa
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add content type',4,'add_contenttype'),
(14,'Can change content type',4,'change_contenttype'),
(15,'Can delete content type',4,'delete_contenttype'),
(16,'Can view content type',4,'view_contenttype'),
(17,'Can add session',5,'add_session'),
(18,'Can change session',5,'change_session'),
(19,'Can delete session',5,'delete_session'),
(20,'Can view session',5,'view_session'),
(21,'Can add blacklisted token',6,'add_blacklistedtoken'),
(22,'Can change blacklisted token',6,'change_blacklistedtoken'),
(23,'Can delete blacklisted token',6,'delete_blacklistedtoken'),
(24,'Can view blacklisted token',6,'view_blacklistedtoken'),
(25,'Can add outstanding token',7,'add_outstandingtoken'),
(26,'Can change outstanding token',7,'change_outstandingtoken'),
(27,'Can delete outstanding token',7,'delete_outstandingtoken'),
(28,'Can view outstanding token',7,'view_outstandingtoken'),
(29,'Can add user',8,'add_user'),
(30,'Can change user',8,'change_user'),
(31,'Can delete user',8,'delete_user'),
(32,'Can view user',8,'view_user'),
(33,'Can add project',9,'add_project'),
(34,'Can change project',9,'change_project'),
(35,'Can delete project',9,'delete_project'),
(36,'Can view project',9,'view_project'),
(37,'Can add product',10,'add_product'),
(38,'Can change product',10,'change_product'),
(39,'Can delete product',10,'delete_product'),
(40,'Can view product',10,'view_product');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'contenttypes','contenttype'),
(10,'products','product'),
(9,'projects','project'),
(5,'sessions','session'),
(6,'token_blacklist','blacklistedtoken'),
(7,'token_blacklist','outstandingtoken'),
(8,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2024-04-01 20:57:38.781537'),
(2,'contenttypes','0002_remove_content_type_name','2024-04-01 20:57:39.076925'),
(3,'auth','0001_initial','2024-04-01 20:57:40.372370'),
(4,'auth','0002_alter_permission_name_max_length','2024-04-01 20:57:40.527963'),
(5,'auth','0003_alter_user_email_max_length','2024-04-01 20:57:41.128062'),
(6,'auth','0004_alter_user_username_opts','2024-04-01 20:57:41.144852'),
(7,'auth','0005_alter_user_last_login_null','2024-04-01 20:57:41.158291'),
(8,'auth','0006_require_contenttypes_0002','2024-04-01 20:57:41.171163'),
(9,'auth','0007_alter_validators_add_error_messages','2024-04-01 20:57:41.188460'),
(10,'auth','0008_alter_user_username_max_length','2024-04-01 20:57:41.208073'),
(11,'auth','0009_alter_user_last_name_max_length','2024-04-01 20:57:41.231051'),
(12,'auth','0010_alter_group_name_max_length','2024-04-01 20:57:41.504763'),
(13,'auth','0011_update_proxy_permissions','2024-04-01 20:57:41.517621'),
(14,'auth','0012_alter_user_first_name_max_length','2024-04-01 20:57:41.529428'),
(15,'users','0001_initial','2024-04-01 20:57:42.746588'),
(16,'admin','0001_initial','2024-04-01 20:57:43.290472'),
(17,'admin','0002_logentry_remove_auto_add','2024-04-01 20:57:43.304716'),
(18,'admin','0003_logentry_add_action_flag_choices','2024-04-01 20:57:43.319570'),
(19,'sessions','0001_initial','2024-04-01 20:57:43.631867'),
(20,'token_blacklist','0001_initial','2024-04-01 20:57:44.423899'),
(21,'token_blacklist','0002_outstandingtoken_jti_hex','2024-04-01 20:57:45.292057'),
(22,'token_blacklist','0003_auto_20171017_2007','2024-04-01 20:57:45.308927'),
(23,'token_blacklist','0004_auto_20171017_2013','2024-04-01 20:57:45.693614'),
(24,'token_blacklist','0005_remove_outstandingtoken_jti','2024-04-01 20:57:45.801611'),
(25,'token_blacklist','0006_auto_20171017_2113','2024-04-01 20:57:46.284039'),
(26,'token_blacklist','0007_auto_20171017_2214','2024-04-01 20:57:48.083422'),
(27,'token_blacklist','0008_migrate_to_bigautofield','2024-04-01 20:57:50.690663'),
(28,'token_blacklist','0010_fix_migrate_to_bigautofield','2024-04-01 20:57:50.708324'),
(29,'token_blacklist','0011_linearizes_history','2024-04-01 20:57:50.723847'),
(30,'token_blacklist','0012_alter_outstandingtoken_user','2024-04-01 20:57:50.738956'),
(31,'users','0002_rename_name_user_username','2024-04-01 20:57:50.844923'),
(32,'users','0003_alter_user_password','2024-04-01 20:57:50.859439'),
(33,'users','0003_user_uid_alter_user_password','2024-04-06 12:41:26.758445'),
(34,'users','0004_remove_user_uid','2024-04-06 12:41:27.118119'),
(35,'projects','0001_initial','2024-04-06 15:16:40.177467'),
(36,'projects','0002_project_description','2024-04-06 16:35:44.419516'),
(37,'projects','0003_rename_name_project_projectname','2024-04-06 16:57:45.301075'),
(38,'products','0001_initial','2024-04-07 11:41:56.275785'),
(39,'products','0002_alter_product_category_alter_product_description_and_more','2024-04-08 01:08:32.162034'),
(40,'products','0003_remove_product_creator_remove_product_modifier_and_more','2024-04-08 01:28:40.256096'),
(41,'products','0004_remove_product_image_product','2024-04-08 01:34:56.833422'),
(42,'products','0005_alter_product_name','2024-04-08 11:23:42.769383'),
(43,'products','0006_product_quantity','2024-04-08 11:54:51.034791'),
(44,'users','0005_user_permission_level','2024-04-09 14:26:55.075681'),
(45,'users','0006_alter_user_permission_level','2024-04-09 14:51:00.511804'),
(46,'products','0007_remove_product_permission_level','2024-04-09 15:04:12.157119'),
(47,'projects','0004_project_creation_date','2024-04-18 13:10:37.377420');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_product`
--

DROP TABLE IF EXISTS `products_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `creation_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) NOT NULL,
  `previous_project_id` int(11) DEFAULT NULL,
  `change_date` datetime(6) DEFAULT NULL,
  `change_reason` longtext DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `modifier_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_product_name_fa23bcd2_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_product`
--

LOCK TABLES `products_product` WRITE;
/*!40000 ALTER TABLE `products_product` DISABLE KEYS */;
INSERT INTO `products_product` VALUES
(27,'Plastic',NULL,'material','plastic','2024-04-18 13:26:07.838897','2024-04-18 13:26:07.838928',NULL,NULL,NULL,1,NULL,12,3),
(28,'Wheels',NULL,'mechanical','wheels','2024-04-18 13:27:45.024823','2024-04-18 13:27:45.024852',NULL,NULL,NULL,47,NULL,13,4),
(29,'Sensor',NULL,'material','sensor','2024-04-18 13:28:14.457712','2024-04-18 13:29:18.526297',13,'2024-04-18 13:29:18.217579',NULL,47,49,12,4);
/*!40000 ALTER TABLE `products_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_project`
--

DROP TABLE IF EXISTS `projects_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `projectName` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_project`
--

LOCK TABLES `projects_project` WRITE;
/*!40000 ALTER TABLE `projects_project` DISABLE KEYS */;
INSERT INTO `projects_project` VALUES
(12,'project1','material staff','2024-04-18 13:22:27.244677'),
(13,'project2','mechanical staff','2024-04-18 13:24:45.936923');
/*!40000 ALTER TABLE `projects_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES
(1,'2024-04-08 17:18:08.249158',39),
(2,'2024-04-08 17:18:08.546734',40);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `jti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_users_use` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES
(1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMwMTM3MywiaWF0IjoxNzEyMDA1MzczLCJqdGkiOiJmNzQ0NzZlYmRiODU0ODhiYjAzMTBjYTAyY2RjOWU3YSIsInVzZXJfaWQiOjF9.QFho89nk6VGELFeiME3Z30W0KtMFB7NAULVJrTZQKKw','2024-04-01 21:02:53.674230','2024-04-16 21:02:53.000000',1,'f74476ebdb85488bb0310ca02cdc9e7a'),
(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMwNjA4MywiaWF0IjoxNzEyMDEwMDgzLCJqdGkiOiIwNDA4OGE5Y2NhZjA0MjAyODZjNmY4YTRkNmU3NzU1OSIsInVzZXJfaWQiOjF9.SiMDwMwwHFj1H-l5JWnSSI-k3-7x8uuFJXzw8c4pQOQ','2024-04-01 22:21:23.677534','2024-04-16 22:21:23.000000',1,'04088a9ccaf0420286c6f8a4d6e77559'),
(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMwNjU1MiwiaWF0IjoxNzEyMDEwNTUyLCJqdGkiOiIwYmIxYjdmZTJhZTY0NDVjODVlNDg5ZjRmNjBmNTM0OCIsInVzZXJfaWQiOjF9.gPfqjQtGEkEzA0YwQDMIm1EvRrq4btuh0QA-ud3YzJQ','2024-04-01 22:29:12.911585','2024-04-16 22:29:12.000000',1,'0bb1b7fe2ae6445c85e489f4f60f5348'),
(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMwNjYyNiwiaWF0IjoxNzEyMDEwNjI2LCJqdGkiOiJkMjU2NGIzN2UxZDM0ZDQwYTJkNDBjZTU3NTZiMDcxOCIsInVzZXJfaWQiOjF9.JyjOaChhVN-bCnNS-h6w2atiZ5aq5HAnZG2AW9NMZ4A','2024-04-01 22:30:26.524771','2024-04-16 22:30:26.000000',1,'d2564b37e1d34d40a2d40ce5756b0718'),
(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMwODE5NiwiaWF0IjoxNzEyMDEyMTk2LCJqdGkiOiI3ZGU0NTVhNGRlNzI0MzVkYjY3OTNmMzVjMTRjYmRhYyIsInVzZXJfaWQiOjF9.JPiVn1Mdy0KpjoKFF3ntv8_kXtCo0uiN_NBQFPdwhuM','2024-04-01 22:56:36.997059','2024-04-16 22:56:36.000000',1,'7de455a4de72435db6793f35c14cbdac'),
(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMxMTc5NiwiaWF0IjoxNzEyMDE1Nzk2LCJqdGkiOiJmODE4NDE4Nzk1ODk0MDdkOTg5ZTQ1N2YxZmI4NjcxZSIsInVzZXJfaWQiOjF9.9IYZ9yYvpHpEfpmIj6YevhRd_2pCfDJrO_AoLd_ux88','2024-04-01 23:56:36.708916','2024-04-16 23:56:36.000000',1,'f81841879589407d989e457f1fb8671e'),
(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzMxNDc4NiwiaWF0IjoxNzEyMDE4Nzg2LCJqdGkiOiJlYzUzMWZmOWMwZTE0YjdhYmNiMGY2NDBjMTMyOTJjOCIsInVzZXJfaWQiOjF9.13lVXK42ugcoz29M9VGiLOLEtV1iLw_7X2uuAWOIzb4','2024-04-02 00:46:26.175571','2024-04-17 00:46:26.000000',1,'ec531ff9c0e14b7abcb0f640c13292c8'),
(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzYwNDk1NSwiaWF0IjoxNzEyMzA4OTU1LCJqdGkiOiI5M2MwODgzOGEwZGI0MWYwODkyNzU3MmRhZGJlOTIwOSIsInVzZXJfaWQiOjF9.WHgKM2E7AfQFQ3yDNsn4M0ealSUfO53iePc-UBtNAkU','2024-04-05 09:22:35.191713','2024-04-20 09:22:35.000000',1,'93c08838a0db41f08927572dadbe9209'),
(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzYwNTA4NywiaWF0IjoxNzEyMzA5MDg3LCJqdGkiOiJiODkyMzZkYzRlYjc0YWRiYTc1Y2EwNGM5NGNhZGNiYiIsInVzZXJfaWQiOjF9.PoAMQNFUZs1cNHHd_rDYd9z7QkchRwUVDQfUlHOdsog','2024-04-05 09:24:47.873442','2024-04-20 09:24:47.000000',1,'b89236dc4eb74adba75ca04c94cadcbb'),
(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzYwNTMwOSwiaWF0IjoxNzEyMzA5MzA5LCJqdGkiOiIxNGJhYzY1YjMzYzc0N2FmYTEzZWYwYWYyZTQxYWRmMyIsInVzZXJfaWQiOjF9.ji8K1h4noHXb847h1cf4Qnf0_KuX8pySO_pWb7hMtjU','2024-04-05 09:28:29.577404','2024-04-20 09:28:29.000000',1,'14bac65b33c747afa13ef0af2e41adf3'),
(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwMDk4MSwiaWF0IjoxNzEyNDA0OTgxLCJqdGkiOiIwNjNlZmUxZWYyZTI0ZGU2OTI2ZGU1MTA4N2E5Y2ZmZiIsInVzZXJfaWQiOjF9.eHfRKiwXLbwjpHsJYrkkkDgawRkMx6c_6j9zAvJYDbM','2024-04-06 12:03:01.421169','2024-04-21 12:03:01.000000',1,'063efe1ef2e24de6926de51087a9cfff'),
(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwNDU1MiwiaWF0IjoxNzEyNDA4NTUyLCJqdGkiOiIzNGU4MGNkNTgxODg0ZDE4YjY2MzZlYTdmZTUzYzQ1OSIsInVzZXJfaWQiOjF9.r8BYuUUFGDfVT6GsGovHSEB9s8wp_XwJPzCdOX-sB4c','2024-04-06 13:02:32.428512','2024-04-21 13:02:32.000000',1,'34e80cd581884d18b6636ea7fe53c459'),
(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwNDczOCwiaWF0IjoxNzEyNDA4NzM4LCJqdGkiOiI2MjBlYzZlM2I4Nzc0YmY1OTllM2FmY2JkMGM3OTkxNiIsInVzZXJfaWQiOjF9.DmQvi75WaHCNVoq2q3P2K_vZZRmv9fVyzpDcIlptGxE','2024-04-06 13:05:38.903770','2024-04-21 13:05:38.000000',1,'620ec6e3b8774bf599e3afcbd0c79916'),
(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODQ2MCwiaWF0IjoxNzEyNDEyNDYwLCJqdGkiOiJmOTljZjVkNjkwNmY0MWQ5OWJmMTc3MThlMjYwZjI2NyIsInVzZXJfaWQiOjF9.jb7uvNW8VtgJ7QGGStyuie1Uix-y7uNXA-M82H33fLA','2024-04-06 14:07:40.226242','2024-04-21 14:07:40.000000',1,'f99cf5d6906f41d99bf17718e260f267'),
(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODYxNywiaWF0IjoxNzEyNDEyNjE3LCJqdGkiOiI3NjViMDY5OTAzYzY0MDhkYTQ4MTNkMWUzYTkyMTMyYiIsInVzZXJfaWQiOjF9.kfQCHrVcVnHvBUxFZ5E7qpjsRAC3QKto2lsyQ-Loioc','2024-04-06 14:10:17.801544','2024-04-21 14:10:17.000000',1,'765b069903c6408da4813d1e3a92132b'),
(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODYyNiwiaWF0IjoxNzEyNDEyNjI2LCJqdGkiOiIyNWM5ZmE3YTZjNTM0YTNmODdlMWY3YzA0OTY5NzRkNCIsInVzZXJfaWQiOjF9.VtMXYoVBdLUZLaOx4XYRxd4jcbIm_O3Asi7XNr5UX0M','2024-04-06 14:10:26.492276','2024-04-21 14:10:26.000000',1,'25c9fa7a6c534a3f87e1f7c0496974d4'),
(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODY3MiwiaWF0IjoxNzEyNDEyNjcyLCJqdGkiOiIxYzk4NmEwMWRjMDk0ZTg3OTgwNzJhZmEzM2E0ZmM4NCIsInVzZXJfaWQiOjF9.obEt3WzcOi3zZjN5VETaa8ija7FUZkfriBzaY7C4zY0','2024-04-06 14:11:12.434413','2024-04-21 14:11:12.000000',1,'1c986a01dc094e8798072afa33a4fc84'),
(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODczOCwiaWF0IjoxNzEyNDEyNzM4LCJqdGkiOiI4OWNlZjFkY2RlMTY0MjE1ODEzM2I0MjNhNWQ3ZDgxNSIsInVzZXJfaWQiOjF9.Y_5mLKzSxkFluE4CiXmhVrJeHHP8IHBEx2xKE8VjUGc','2024-04-06 14:12:18.801957','2024-04-21 14:12:18.000000',1,'89cef1dcde1642158133b423a5d7d815'),
(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwODkzNiwiaWF0IjoxNzEyNDEyOTM2LCJqdGkiOiJiNDg4ZWEwNzhlYzM0OWM1YjIyYTQ0ZjVlNzFhZWRhMiIsInVzZXJfaWQiOjF9._57PsJv44loEjA6OYOk3W2kMRmfoZVYvgaGP2zVCXXE','2024-04-06 14:15:36.331797','2024-04-21 14:15:36.000000',1,'b488ea078ec349c5b22a44f5e71aeda2'),
(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTAwNywiaWF0IjoxNzEyNDEzMDA3LCJqdGkiOiJjMTgzMDVkMjk3ZTA0YjdkODBkNDk2NDFkZDUzMjMxNiIsInVzZXJfaWQiOjF9.gWD0MIQWTr8NRRuDCkBUx1JGriIR9fpvWACc2e-NEvU','2024-04-06 14:16:47.385349','2024-04-21 14:16:47.000000',1,'c18305d297e04b7d80d49641dd532316'),
(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTA4NiwiaWF0IjoxNzEyNDEzMDg2LCJqdGkiOiI4NjVkYjFkMGI0NGI0MGFiOWZjYmE4NmY3YjRlZjFkNCIsInVzZXJfaWQiOjF9.UFJ7rva6YdX6s5w8XwFIy0xZvIrtZaa11ybTqxZKFRU','2024-04-06 14:18:06.741515','2024-04-21 14:18:06.000000',1,'865db1d0b44b40ab9fcba86f7b4ef1d4'),
(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTExMywiaWF0IjoxNzEyNDEzMTEzLCJqdGkiOiI4YTQ0NDA1NDk5ZDI0MTFiOWVhM2RhNWQzN2Y4ZmI2YyIsInVzZXJfaWQiOjF9.b25fxxgB1E25uNo4p8bDtL2tXCf0rYYOjZdMQdxybwc','2024-04-06 14:18:33.081777','2024-04-21 14:18:33.000000',1,'8a44405499d2411b9ea3da5d37f8fb6c'),
(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTE1NCwiaWF0IjoxNzEyNDEzMTU0LCJqdGkiOiIyNzZlZjc1MjZjYTA0NGFkOTM0M2JiZjEyYzE2NTA4ZiIsInVzZXJfaWQiOjF9.g5VUWi9IhwcGfnrJBwTu9e_hQ9lJbLMqGBM9aQOddXs','2024-04-06 14:19:14.464423','2024-04-21 14:19:14.000000',1,'276ef7526ca044ad9343bbf12c16508f'),
(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTI4MSwiaWF0IjoxNzEyNDEzMjgxLCJqdGkiOiIzNTFmNjhhNjNmZTg0MDA5ODNkOTVkMGIwZDM4MmI3YiIsInVzZXJfaWQiOjF9.PJXMedOxCNIdmYCm6ovhMIqwV-srjkQzgWL3B7iNJ40','2024-04-06 14:21:21.898287','2024-04-21 14:21:21.000000',1,'351f68a63fe8400983d95d0b0d382b7b'),
(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTM2MSwiaWF0IjoxNzEyNDEzMzYxLCJqdGkiOiJmZTk1OTA0NzYzN2M0ZDI1OTE3OGUyY2Y5Y2FmYmM5NiIsInVzZXJfaWQiOjF9.Kipte26JB0ZP6vU65tEfiJVzbAwyx9YL1sBWvMl_KpM','2024-04-06 14:22:41.973691','2024-04-21 14:22:41.000000',1,'fe959047637c4d259178e2cf9cafbc96'),
(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTQ0MywiaWF0IjoxNzEyNDEzNDQzLCJqdGkiOiJlNzVkODVlNThkMDQ0ZWQyODM4ZWFmYjFhN2E4ZmQ0YSIsInVzZXJfaWQiOjF9.X_yCaT3TnKlA4GjzFu7LQEg-rD-DfCvdxxfMalxsn-M','2024-04-06 14:24:03.809378','2024-04-21 14:24:03.000000',1,'e75d85e58d044ed2838eafb1a7a8fd4a'),
(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTQ5OCwiaWF0IjoxNzEyNDEzNDk4LCJqdGkiOiJkZDY4Nzc5NjBmYjg0ZmU4OTM3MjcxMDk2NTUxMzc1MCIsInVzZXJfaWQiOjF9.ktXuy1a1oPWN36-x_U4-lr21tBRIufosVQ49J-iGNBA','2024-04-06 14:24:58.106273','2024-04-21 14:24:58.000000',1,'dd6877960fb84fe89372710965513750'),
(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcwOTU5MSwiaWF0IjoxNzEyNDEzNTkxLCJqdGkiOiI2OTYyMjIyODZkOTI0MTI0ODBiNDBjMWYyMDc5ZGIxNiIsInVzZXJfaWQiOjF9.V66cm-z3mnPJk4ZtMzO6rUXQDVKrzd6COi0RAGX3cFQ','2024-04-06 14:26:31.976678','2024-04-21 14:26:31.000000',1,'696222286d92412480b40c1f2079db16'),
(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMDE4MCwiaWF0IjoxNzEyNDE0MTgwLCJqdGkiOiI3MzA1MmI4MjEyYjc0YjcxYTNhOTY5YjdjODdhMWUxMSIsInVzZXJfaWQiOjF9.xSkIxisJWVc6EOCVGhd_wotx6u_RcPRI_AFPBNgfcjM','2024-04-06 14:36:20.213740','2024-04-21 14:36:20.000000',1,'73052b8212b74b71a3a969b7c87a1e11'),
(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMDgyNywiaWF0IjoxNzEyNDE0ODI3LCJqdGkiOiJiYTBkN2U3YTkyNTI0ZGQ2OTY5Y2ZlZTQyNjRkNmQ1MSIsInVzZXJfaWQiOjF9.RQTFeIArF__p4nmDaddU0RhAM02RqK3-1GT34WQy06Y','2024-04-06 14:47:07.731943','2024-04-21 14:47:07.000000',1,'ba0d7e7a92524dd6969cfee4264d6d51'),
(31,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMTE4OSwiaWF0IjoxNzEyNDE1MTg5LCJqdGkiOiJkMDZjMjlmYjYyMjI0Y2QxYjlkNDJhMjFhNjg2ZmQ2MSIsInVzZXJfaWQiOjF9.fMLNwDREnmyV_MEa9AyXAe_7LkCgvHvrxTG8hVyuGVc','2024-04-06 14:53:09.551020','2024-04-21 14:53:09.000000',1,'d06c29fb62224cd1b9d42a21a686fd61'),
(32,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMTIyMSwiaWF0IjoxNzEyNDE1MjIxLCJqdGkiOiI4Zjk3ZDYwN2M1OWI0ZTJiOTc1NzRjYjk3MTkzMWJmNiIsInVzZXJfaWQiOjF9.YLVkCABEMo43JKsX7peYae45fHSL0x1Jlwdms3N-mM4','2024-04-06 14:53:41.471524','2024-04-21 14:53:41.000000',1,'8f97d607c59b4e2b97574cb971931bf6'),
(33,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMTI1MSwiaWF0IjoxNzEyNDE1MjUxLCJqdGkiOiI5ZmI5ZjcxMWU5N2Q0YjY3YTQ1MjA4NWZlZjIyYTI1ZiIsInVzZXJfaWQiOjF9.C8y1xIKBVAAJdS2jz51MgjkWcaH-8sWEVRXuf6NMKC0','2024-04-06 14:54:11.022195','2024-04-21 14:54:11.000000',1,'9fb9f711e97d4b67a452085fef22a25f'),
(34,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMTU4OSwiaWF0IjoxNzEyNDE1NTg5LCJqdGkiOiJkODg3YzNjOTM0NTM0YWM4OTUzOTlhMjNkOTIyYTcwOCIsInVzZXJfaWQiOjF9.R9A-76MtsURJehdIzi_WN2GJLUV-82paDxRUIRjf5M0','2024-04-06 14:59:49.068711','2024-04-21 14:59:49.000000',1,'d887c3c934534ac895399a23d922a708'),
(35,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxMzk0NCwiaWF0IjoxNzEyNDE3OTQ0LCJqdGkiOiI4MjkzNmU2ZTNhMWU0NjM2ODg3MzVlMTVhZTc3M2RhNiIsInVzZXJfaWQiOjF9.3IS5FNgTWNpkf53sVQyi32mTV2emhUfyz4roYybAaCA','2024-04-06 15:39:04.579165','2024-04-21 15:39:04.000000',1,'82936e6e3a1e463688735e15ae773da6'),
(36,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcxOTg0MiwiaWF0IjoxNzEyNDIzODQyLCJqdGkiOiJkN2MwM2VlMGIzMmM0YmJjODdjMDRhMzUyMGY5MGNkNSIsInVzZXJfaWQiOjF9.1MQIl1L6Bcyan8lvDf99nssCkWh7k3bmsUucQwFWUkQ','2024-04-06 17:17:22.572201','2024-04-21 17:17:22.000000',1,'d7c03ee0b32c4bbc87c04a3520f90cd5'),
(37,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzcyMDYzMCwiaWF0IjoxNzEyNDI0NjMwLCJqdGkiOiJmYzQ5MGZiODM0ZmY0ZDdlYTUxYzkyMTY3YjQ2M2EyZSIsInVzZXJfaWQiOjF9.7SpQzmdVqksCFTZfu_eKCuzRRJ86IF23MKlf0tjS1mY','2024-04-06 17:30:30.598012','2024-04-21 17:30:30.000000',1,'fc490fb834ff4d7ea51c92167b463a2e'),
(38,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzc4Mjk5NCwiaWF0IjoxNzEyNDg2OTk0LCJqdGkiOiI5Y2RhOWE4NDZjYzg0NjdjYWZkMWJmOTNmOWEyNmU4ZCIsInVzZXJfaWQiOjF9.GzOGseeksgpdth9Yden1hfHM3_5wPTu9BQz1u1gE5Hs','2024-04-07 10:49:54.434486','2024-04-22 10:49:54.000000',1,'9cda9a846cc8467cafd1bf93f9a26e8d'),
(39,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzgwNjA2NCwiaWF0IjoxNzEyNTEwMDY0LCJqdGkiOiJmNjViOGY0ZDE4YmM0ZTIyYjE3ZjhmMTIwMzJiYjJhOSIsInVzZXJfaWQiOjF9.ejTPm06egT8aOg761nGaywzEvqtPnPkYXqV_F4cQ1wk','2024-04-07 17:14:24.628311','2024-04-22 17:14:24.000000',1,'f65b8f4d18bc4e22b17f8f12032bb2a9'),
(40,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzg5MjY4OCwiaWF0IjoxNzEyNTk2Njg4LCJqdGkiOiJlMDFhMWEwMzU3OGM0YTk4OWZmNjIzNTM3YmMxNmQ3YyIsInVzZXJfaWQiOjF9.4LjVafRnUQ1l-d5Cuo8cdILkJsbd9znOSasQ3fakamo',NULL,'2024-04-23 17:18:08.000000',NULL,'e01a1a03578c4a989ff623537bc16d7c'),
(41,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzg5MjcwNCwiaWF0IjoxNzEyNTk2NzA0LCJqdGkiOiJmNWJjZWUyZmZiMDA0MDk2ODE3MTJjZjY4ZGZkMGI3ZiIsInVzZXJfaWQiOjF9.6puGBvxU8p1XEZzVGZfDVOW7BWqWBUI14hEAxQcOco8','2024-04-08 17:18:24.718534','2024-04-23 17:18:24.000000',1,'f5bcee2ffb00409681712cf68dfd0b7f'),
(42,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzk3MTU5OCwiaWF0IjoxNzEyNjc1NTk4LCJqdGkiOiJjYjc1OGQzYzAxYzU0NWIyODI0ZGU4ZTdkNmNiOTAxOCIsInVzZXJfaWQiOjF9.-a0W1sTCQwDA46kwED-Z5ahvaH4SxsxXO55QX6MROTM','2024-04-09 15:13:18.698605','2024-04-24 15:13:18.000000',1,'cb758d3c01c545b2824de8e7d6cb9018'),
(43,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzk3MTk2MiwiaWF0IjoxNzEyNjc1OTYyLCJqdGkiOiIxZDc1NWJhNDEzNzc0NjlmODJmODVlMzEzMGIwNzI2ZSIsInVzZXJfaWQiOjF9.XR28oFOgBhxTbifft05b-O6RdU0mbo4JyKBcRKUv4HA','2024-04-09 15:19:22.077180','2024-04-24 15:19:22.000000',1,'1d755ba41377469f82f85e3130b0726e'),
(44,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzk3NjEyNywiaWF0IjoxNzEyNjgwMTI3LCJqdGkiOiI4MWNjMDMyOGRjNTU0MjM2Yjk3ZGVhODFkMzBmNDQxOCIsInVzZXJfaWQiOjMwfQ.Q8jbaSAxv8XADAquhxX6g-MmN5sPGZZcGAxwuvmlhEM','2024-04-09 16:28:47.477536','2024-04-24 16:28:47.000000',NULL,'81cc0328dc554236b97dea81d30f4418'),
(45,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMzk3NjE1NSwiaWF0IjoxNzEyNjgwMTU1LCJqdGkiOiI5ODg3NDA4MDM0YTY0NDFlYjFmMjY3OTA3NTYwMTE3MSIsInVzZXJfaWQiOjF9.S-452UmhAfwAGJMjOzC5RMlkzgaa2wLSBX_NSc_wz58','2024-04-09 16:29:15.887534','2024-04-24 16:29:15.000000',1,'9887408034a6441eb1f2679075601171'),
(46,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDA4OTEyNiwiaWF0IjoxNzEyNzkzMTI2LCJqdGkiOiIyYjQyMGJlMmFiZGI0ZWQwOWQyYmY2OWQ3N2U1NmU3OCIsInVzZXJfaWQiOjF9.lhgk4AQsSXpAXzCjwG8XFQ7BNXD3MQmP-PlI-ePbvkM','2024-04-10 23:52:06.540006','2024-04-25 23:52:06.000000',1,'2b420be2abdb4ed09d2bf69d77e56e78'),
(47,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEyOTYxMywiaWF0IjoxNzEyODMzNjEzLCJqdGkiOiI5MWUyN2IxZDk5ODQ0YmVlYjg4NDdmYzJhZmMzZWEyNSIsInVzZXJfaWQiOjF9.0YJA_Jlnh9kHGM2p7HvlcW1zmj7yZDVABM5hZ-ohlHg','2024-04-11 11:06:53.612057','2024-04-26 11:06:53.000000',1,'91e27b1d99844beeb8847fc2afc3ea25'),
(48,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEzNTEwNiwiaWF0IjoxNzEyODM5MTA2LCJqdGkiOiI4YWQzMjM5YzM3NWI0Y2E3YTlhMmE1ZGU0YzIxNjFkZiIsInVzZXJfaWQiOjMyfQ.S_O4B7FAblOVX1apnS5Q1BUWXAKzvqWZ2s9MHgECtak','2024-04-11 12:38:26.322385','2024-04-26 12:38:26.000000',NULL,'8ad3239c375b4ca7a9a2a5de4c2161df'),
(49,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEzNzczNSwiaWF0IjoxNzEyODQxNzM1LCJqdGkiOiJiNjVmNjI2NWVkMGU0YzA0ODE1YjBkZWJjMTU1NzgxNSIsInVzZXJfaWQiOjF9.AUASYA9d4u-_-hCUwQmFnKHTYduHnB5JBlXlsMvK1Hg','2024-04-11 13:22:15.860634','2024-04-26 13:22:15.000000',1,'b65f6265ed0e4c04815b0debc1557815'),
(50,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEzNzc3NywiaWF0IjoxNzEyODQxNzc3LCJqdGkiOiI5NmUyMDg4MjQ4M2Q0YjhhOThjYjM4NzBkZTk2MTUzYyIsInVzZXJfaWQiOjMzfQ.5-jtCGImRg44qsq6n3ywpsx5r4iSYh5HDr7oejY6h70','2024-04-11 13:22:57.801220','2024-04-26 13:22:57.000000',NULL,'96e20882483d4b8a98cb3870de96153c'),
(51,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEzODAzNywiaWF0IjoxNzEyODQyMDM3LCJqdGkiOiJkMTZhNjA5MWJkNjE0ODJkOTA2NDFjM2U1OTRmMDE3OSIsInVzZXJfaWQiOjF9.O-AtzxwfpigCAdpKBs5iCZ1MgtJlMH9pW5g8-zFX7vc','2024-04-11 13:27:17.873288','2024-04-26 13:27:17.000000',1,'d16a6091bd61482d90641c3e594f0179'),
(52,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDEzOTY0MSwiaWF0IjoxNzEyODQzNjQxLCJqdGkiOiIyYTVjYWRiOTYzM2U0MTczYWM5YWM3MzJjNWI3MmU1ZiIsInVzZXJfaWQiOjMyfQ.UWdkySiD_PqF7bVabseO_RrSrw5L-_HT0JBJgCeIl9w','2024-04-11 13:54:01.155495','2024-04-26 13:54:01.000000',NULL,'2a5cadb9633e4173ac9ac732c5b72e5f'),
(53,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MDI1OCwiaWF0IjoxNzEyODQ0MjU4LCJqdGkiOiJkMzQxNDIyNGExMjY0MDM1YjNjNzY0Y2E2YWY2NWZkNyIsInVzZXJfaWQiOjMzfQ.GJH8hJJEgi9EvOlYHAmsDRiUZK_glWggVdMEsSQJpa4','2024-04-11 14:04:18.066139','2024-04-26 14:04:18.000000',NULL,'d3414224a1264035b3c764ca6af65fd7'),
(54,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MTA5MCwiaWF0IjoxNzEyODQ1MDkwLCJqdGkiOiJlMzcwZDZhNjMyNTk0OTdkYWYxMWFiMjI5NDI2NGY2NyIsInVzZXJfaWQiOjMyfQ.YLXBX8RqeekIe6KuXGHphhfYzb9aWQMoW6wLibEYpak','2024-04-11 14:18:10.677401','2024-04-26 14:18:10.000000',NULL,'e370d6a63259497daf11ab2294264f67'),
(55,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MTE0MSwiaWF0IjoxNzEyODQ1MTQxLCJqdGkiOiI2OWRlN2JhYmI3MDU0NzJkYjIyN2VhOTA3Yjk0OWEwYSIsInVzZXJfaWQiOjF9.FiVYruD9j7sLfYQO3cLUD3SAHBr28ADsx31enxZ8bb0','2024-04-11 14:19:01.090779','2024-04-26 14:19:01.000000',1,'69de7babb705472db227ea907b949a0a'),
(56,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MTY1NCwiaWF0IjoxNzEyODQ1NjU0LCJqdGkiOiJiNjZiY2RiZGUyZTg0ZjlkOTgwYWIzODRiZGY3MGRjNCIsInVzZXJfaWQiOjMzfQ.OPuE1_NbHj6D1n3KuFrC5rozhWUaoQJKltaruTlfCSc','2024-04-11 14:27:34.062944','2024-04-26 14:27:34.000000',NULL,'b66bcdbde2e84f9d980ab384bdf70dc4'),
(57,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MTc4OSwiaWF0IjoxNzEyODQ1Nzg5LCJqdGkiOiIwNjI5MTQ5MWFjOGI0YjdlOGQ0ZTQ5NDdkNGViYzJkNiIsInVzZXJfaWQiOjF9.3atvzJa42PJ_gvX4o1exPYX5QjymyFewcsXoMO8ZyxY','2024-04-11 14:29:49.208943','2024-04-26 14:29:49.000000',1,'06291491ac8b4b7e8d4e4947d4ebc2d6'),
(58,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0MjQyNywiaWF0IjoxNzEyODQ2NDI3LCJqdGkiOiI4ZWUxNDRhNjdhOTI0ODE2YWQ1NDBhZWZlOGY1Yjg3ZiIsInVzZXJfaWQiOjMzfQ.Y9K6zgZ2hq3fYX82ccQdqf9qLDOSwhxLmWXb2hltQ7E','2024-04-11 14:40:27.555160','2024-04-26 14:40:27.000000',NULL,'8ee144a67a924816ad540aefe8f5b87f'),
(59,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0NjUzNiwiaWF0IjoxNzEyODUwNTM2LCJqdGkiOiIxMDY5ODM2MzU2NjM0ZDc4YWQ2OTE5OTljMWI4MmUyMSIsInVzZXJfaWQiOjF9.JDTBwk44eMf_bK3di5fsWZix44PCrFYXO5sQkE0SGhE','2024-04-11 15:48:56.046892','2024-04-26 15:48:56.000000',1,'1069836356634d78ad691999c1b82e21'),
(60,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0OTAwOCwiaWF0IjoxNzEyODUzMDA4LCJqdGkiOiI5YTdlYTk3MzQ3M2M0ZDJmYmYwZmI5MWZiOThhN2UwNSIsInVzZXJfaWQiOjF9.plOeM3JQCeEy4tCw38GLXK1-Z3Eipr7BVrHnw3RfD2k','2024-04-11 16:30:08.238502','2024-04-26 16:30:08.000000',1,'9a7ea973473c4d2fbf0fb91fb98a7e05'),
(61,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0OTUzNywiaWF0IjoxNzEyODUzNTM3LCJqdGkiOiJhZWE5Njg2MWNhYTE0MDg3OWE0MGYwNTQxOTc1NmJlOCIsInVzZXJfaWQiOjMzfQ.fPtaOjxJhmiIxm16wlzQFLux6DRpOTLbZ1ZSSrrcgPk','2024-04-11 16:38:57.455475','2024-04-26 16:38:57.000000',NULL,'aea96861caa140879a40f05419756be8'),
(62,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE0OTY2NywiaWF0IjoxNzEyODUzNjY3LCJqdGkiOiJhZGJhOTQ3YmJhZDM0OWE1OWUzMDBmY2FhYzA3NzI5ZCIsInVzZXJfaWQiOjF9.RjeQ-GAXWyE1ovUbysh1TA5Ei0fGCEtGIr2Tu1VE4fg','2024-04-11 16:41:07.605994','2024-04-26 16:41:07.000000',1,'adba947bbad349a59e300fcaac07729d'),
(63,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE1MDU5NCwiaWF0IjoxNzEyODU0NTk0LCJqdGkiOiIyYmYyMjVmYTQyZDY0YTNhOWI3ZGRiNDA5MmEzMGMzMyIsInVzZXJfaWQiOjM3fQ.A1VE10cGDk34iQXXBy0x-PsM2ujQvWnX-ZsJOMNMbvU','2024-04-11 16:56:34.167945','2024-04-26 16:56:34.000000',NULL,'2bf225fa42d64a3a9b7ddb4092a30c33'),
(64,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDE1MDY1NiwiaWF0IjoxNzEyODU0NjU2LCJqdGkiOiIwMGEwY2NlZDI4YWU0MTQ3YTZiMjFkOWI0MDFhYTVkYSIsInVzZXJfaWQiOjMyfQ.96ZKME-0SSNRNlhTHVlc5q5BMEKy0e58uTNoXyNKja8','2024-04-11 16:57:36.981868','2024-04-26 16:57:36.000000',NULL,'00a0cced28ae4147a6b21d9b401aa5da'),
(65,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIxNjUzNywiaWF0IjoxNzEyOTIwNTM3LCJqdGkiOiIyY2NhMWM2OGExN2Y0OTA1ODMzNDM5NTJlOGJiZDY3NyIsInVzZXJfaWQiOjF9.sGdyTXbsZKCImAM97Bpg6f6zsaJViqccjxLPHF9yVww','2024-04-12 11:15:37.276129','2024-04-27 11:15:37.000000',1,'2cca1c68a17f490583343952e8bbd677'),
(66,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyNzMwNywiaWF0IjoxNzEyOTMxMzA3LCJqdGkiOiI1ZDRmNjUwNGMzYzk0YzU2YmYxOTViMWVkMDMzYmNhOSIsInVzZXJfaWQiOjQzfQ.n2UNzqhYdNdN65kVFZM4JpfpM4tIfUo431k9j7sbsRY','2024-04-12 14:15:07.537279','2024-04-27 14:15:07.000000',NULL,'5d4f6504c3c94c56bf195b1ed033bca9'),
(67,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyNzczNiwiaWF0IjoxNzEyOTMxNzM2LCJqdGkiOiI2NTJkOTMxNTY2MWQ0YjJhYjUzY2Q4ZDljNGJhMTM4NSIsInVzZXJfaWQiOjQ0fQ.fKoCR5RdanykoEMonJur_fcTr6LKzYqovYzsfmHXcHI','2024-04-12 14:22:16.669243','2024-04-27 14:22:16.000000',NULL,'652d9315661d4b2ab53cd8d9c4ba1385'),
(68,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyNzkzMiwiaWF0IjoxNzEyOTMxOTMyLCJqdGkiOiI4YzgzZTdkNTNmYTQ0NThiOGNiYWI1NjViZDk5N2ZmYyIsInVzZXJfaWQiOjQzfQ.qdZ-9082pufaXH5N2QxSx5MUn3k3qAmjP7-9usgZTk4','2024-04-12 14:25:32.736791','2024-04-27 14:25:32.000000',NULL,'8c83e7d53fa4458b8cbab565bd997ffc'),
(69,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyODc1NSwiaWF0IjoxNzEyOTMyNzU1LCJqdGkiOiIwOGI5OWM2ZGMzZDc0OWFhYmMzZjUwMjVjZTUwNTVhYSIsInVzZXJfaWQiOjQ0fQ.C5q81tAT6CK4pRL2cEmaahZDb0IvAwSDj4r9J8ZqD9g','2024-04-12 14:39:15.764701','2024-04-27 14:39:15.000000',NULL,'08b99c6dc3d749aabc3f5025ce5055aa'),
(70,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyOTIwMywiaWF0IjoxNzEyOTMzMjAzLCJqdGkiOiI4NTA3ZDEzYzEyOTg0NTQ2OTFkYWI3MzY2ZWMxNmQzYiIsInVzZXJfaWQiOjQzfQ.d80NaqBWU_25nIizVv9sbfeYzIkdlyk5ExbVpsGkijY','2024-04-12 14:46:43.629567','2024-04-27 14:46:43.000000',NULL,'8507d13c1298454691dab7366ec16d3b'),
(71,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyOTI5NSwiaWF0IjoxNzEyOTMzMjk1LCJqdGkiOiJmOGEzNjljMmQ0ZDc0OGM5YmNiOWE2MWY5ZTEzMjNhNyIsInVzZXJfaWQiOjQ0fQ.CZh89Y0L8JRXopx0TZXY6qN1qezq5Vg0qkK4WuBQJjM','2024-04-12 14:48:15.041599','2024-04-27 14:48:15.000000',NULL,'f8a369c2d4d748c9bcb9a61f9e1323a7'),
(72,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyOTQxMSwiaWF0IjoxNzEyOTMzNDExLCJqdGkiOiJiYjE3ZjYwYTE4NzA0YWJmODJiMTcxMjg4NmU0OGJjZiIsInVzZXJfaWQiOjQzfQ.pNRIDflb74TKbBBqCpDn5E_Geu1CyC4oaZUhsXs4W6M','2024-04-12 14:50:11.193677','2024-04-27 14:50:11.000000',NULL,'bb17f60a18704abf82b1712886e48bcf'),
(73,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIyOTg4NSwiaWF0IjoxNzEyOTMzODg1LCJqdGkiOiJmMjdmMTRiN2JmMWU0YmUwODIyNmZkMDBkZjJmNzgyNyIsInVzZXJfaWQiOjQ0fQ.q28sScrG_fY2y45I6DNtgE6bt43yXcmntN_0B2fhebA','2024-04-12 14:58:05.797129','2024-04-27 14:58:05.000000',NULL,'f27f14b7bf1e4be08226fd00df2f7827'),
(74,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIzMDAyNCwiaWF0IjoxNzEyOTM0MDI0LCJqdGkiOiI5M2RjZWRiNmIzODA0OWUxYmYxNWUzNGViMWVjNzVhYSIsInVzZXJfaWQiOjQzfQ.EXQy3YktrcpjFbRDw8K_c_08_tn5hx6Z8_pF59wrDwU','2024-04-12 15:00:24.088025','2024-04-27 15:00:24.000000',NULL,'93dcedb6b38049e1bf15e34eb1ec75aa'),
(75,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIzMTA5MywiaWF0IjoxNzEyOTM1MDkzLCJqdGkiOiI1MmYyMDgwYTBmZWY0NTBlOTc5NjRmMmU0MWY3NzVkYSIsInVzZXJfaWQiOjQ0fQ.Q5m7HkJYjqOhLTZTrgRanIUKY0uQwb7OJlMkEHac__Q','2024-04-12 15:18:13.367496','2024-04-27 15:18:13.000000',NULL,'52f2080a0fef450e97964f2e41f775da'),
(76,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIzMzU0NCwiaWF0IjoxNzEyOTM3NTQ0LCJqdGkiOiI2MTllNTc0MWNlY2I0MWU0YjE0NjY5ZWRjZjRlYjJlOCIsInVzZXJfaWQiOjQzfQ.QceIOwsguhyDiR4onMMPP3_ICWgH1bivfg0FRGGVeVw','2024-04-12 15:59:04.210136','2024-04-27 15:59:04.000000',NULL,'619e5741cecb41e4b14669edcf4eb2e8'),
(77,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDIzMzYwNCwiaWF0IjoxNzEyOTM3NjA0LCJqdGkiOiI0ZDI4MmU5Y2E3OGY0OTk0ODA5YTIyNDJiNWZhYzk2OSIsInVzZXJfaWQiOjQzfQ.u0Y-BFnAfybw8MJ8c4ZZIq4M_slUnJBFE4sut6-s1fM','2024-04-12 16:00:04.704898','2024-04-27 16:00:04.000000',NULL,'4d282e9ca78f4994809a2242b5fac969'),
(78,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI0MTg1MSwiaWF0IjoxNzEyOTQ1ODUxLCJqdGkiOiI1NWJkNWQ0MTRmYzY0YWM4OGJhOWE5ZTIyMWJhZTdlNSIsInVzZXJfaWQiOjQzfQ.45vLg8IayYjk7NRL3263FXmixaY7lRGUNVZLZL6X63Q','2024-04-12 18:17:31.294118','2024-04-27 18:17:31.000000',NULL,'55bd5d414fc64ac88ba9a9e221bae7e5'),
(79,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI0MTkwOCwiaWF0IjoxNzEyOTQ1OTA4LCJqdGkiOiJjYzIyZjRiYTNiOWQ0YTljODA0OTBjYTBjMTJkZTkwMiIsInVzZXJfaWQiOjF9.QxaWcJ67kMQW_8JjX7PqzQzQIERIWshTQC0H8X_8pLI','2024-04-12 18:18:28.811488','2024-04-27 18:18:28.000000',1,'cc22f4ba3b9d4a9c80490ca0c12de902'),
(80,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI0Mzk3MywiaWF0IjoxNzEyOTQ3OTczLCJqdGkiOiJlMTUzYjMxYzY4OTk0NTE2YTI2MTQ2M2U3MDFlOTM0YSIsInVzZXJfaWQiOjQ0fQ.SkKv4oaGBRKSmh-bB-w8btZ-Qc1EjDeYX5ByuAjziSo','2024-04-12 18:52:53.607288','2024-04-27 18:52:53.000000',NULL,'e153b31c68994516a261463e701e934a'),
(81,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI0NDgzOSwiaWF0IjoxNzEyOTQ4ODM5LCJqdGkiOiJjZDBmNGQxMTA0YTc0YjA3YWQzM2E1ZTZhYTJiNzI3NyIsInVzZXJfaWQiOjF9.yoivvQ-BxlP1AmWbYbxNGA15z8IvE8mHKxhCfv3Ut-E','2024-04-12 19:07:19.184332','2024-04-27 19:07:19.000000',1,'cd0f4d1104a74b07ad33a5e6aa2b7277'),
(82,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI1ODg5NywiaWF0IjoxNzEyOTYyODk3LCJqdGkiOiI2MjU2ZmE0YjU3ZGQ0ODA4OGY1YTU4ZjA4ZDM0MmQwYiIsInVzZXJfaWQiOjQ0fQ.2Pp8OM93gVkRGDNzNMn5iPSgidBWujlTaySSkb1SvnU','2024-04-12 23:01:37.213074','2024-04-27 23:01:37.000000',NULL,'6256fa4b57dd48088f5a58f08d342d0b'),
(83,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI1OTI1NSwiaWF0IjoxNzEyOTYzMjU1LCJqdGkiOiIxZmZlMGUwZmI3MmM0ZWJkODczNmI0ZmMzN2NjMmE5MSIsInVzZXJfaWQiOjQ0fQ.SQaBiMpgsViqvBU6kbEXpiylrtKldoqdMCw9u5wvhIA','2024-04-12 23:07:35.578154','2024-04-27 23:07:35.000000',NULL,'1ffe0e0fb72c4ebd8736b4fc37cc2a91'),
(84,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI1OTk4OCwiaWF0IjoxNzEyOTYzOTg4LCJqdGkiOiJlMjExZjdiOGYyMmM0ODE2OGI0NDc3NzYyYzdhNGMyYyIsInVzZXJfaWQiOjF9.W0-NyZNwtqQGqcBB2hr936gkzGHWnHOOEEqaHMYxups','2024-04-12 23:19:48.332876','2024-04-27 23:19:48.000000',1,'e211f7b8f22c48168b4477762c7a4c2c'),
(85,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MDM4NiwiaWF0IjoxNzEyOTc0Mzg2LCJqdGkiOiJkZjYwZWJiMTY1ODE0OTY5OTMzNjY5YWEzOGE5MGZhNSIsInVzZXJfaWQiOjQ2fQ.wb2_zEvYrRFceGIKhlR3SeZ36QKc3JyhSNMA1hGCY40','2024-04-13 02:13:06.871943','2024-04-28 02:13:06.000000',46,'df60ebb165814969933669aa38a90fa5'),
(86,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MDQxNCwiaWF0IjoxNzEyOTc0NDE0LCJqdGkiOiIxN2NhMWU3NTAyMWI0ZGVhYTc1ZTc5ZTQwN2ViMzM1ZiIsInVzZXJfaWQiOjQ3fQ.m2-jbWS0Dg5_oZEOaGQDgcyaANCuH-_JlKRAVZ5r6zk','2024-04-13 02:13:34.418530','2024-04-28 02:13:34.000000',47,'17ca1e75021b4deaa75e79e407eb335f'),
(87,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MDQ2MCwiaWF0IjoxNzEyOTc0NDYwLCJqdGkiOiIyNGFiZTBjMTA1YmM0NmNkODFhNWUwMmEzNTI3NzJkYSIsInVzZXJfaWQiOjQ4fQ.bVuRqru8VlpYqALvE9tVVJFS4sOOLulN_kKzNjt2SUM','2024-04-13 02:14:20.710014','2024-04-28 02:14:20.000000',48,'24abe0c105bc46cd81a5e02a352772da'),
(88,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MDk5NiwiaWF0IjoxNzEyOTc0OTk2LCJqdGkiOiI1NjY3ZGRlNjUwM2I0YmYwYWE0Yzc1OTg0NWRmZjc3MiIsInVzZXJfaWQiOjQ2fQ.vRb2bRRrzEXekp8Cf-FV3N8IAlZPN26vejAEIK5rnUM','2024-04-13 02:23:16.440445','2024-04-28 02:23:16.000000',46,'5667dde6503b4bf0aa4c759845dff772'),
(89,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTAxOSwiaWF0IjoxNzEyOTc1MDE5LCJqdGkiOiIwMjdlMTEyMGZhNzU0ZmJmYmJlOTQwY2I0ODcwYzI4NCIsInVzZXJfaWQiOjQ3fQ.XxvEaeW6xb1D12xcQHeuGX0tFvMlW7GuG2Fq3BLv1BM','2024-04-13 02:23:39.842262','2024-04-28 02:23:39.000000',47,'027e1120fa754fbfbbe940cb4870c284'),
(90,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTA4MSwiaWF0IjoxNzEyOTc1MDgxLCJqdGkiOiIzODhjMzc1NWQ1MDk0MjQ1YTEyZDFjNDY3YjlkNjZjNSIsInVzZXJfaWQiOjQ5fQ.jvaZhqmM0Qai1XppHQ1Yv8Qx5dzg7KjdGzH3OzTFOwE','2024-04-13 02:24:41.686635','2024-04-28 02:24:41.000000',49,'388c3755d5094245a12d1c467b9d66c5'),
(91,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTE0MiwiaWF0IjoxNzEyOTc1MTQyLCJqdGkiOiI2YzBjZmUyYTY5ZGE0OTYwODFlMzQyNjNlMDdhZGVlNSIsInVzZXJfaWQiOjF9.Z6K75U5dPIoAL74qkmLOoHBMfskpB3D2QA0tUBRGUcA','2024-04-13 02:25:42.909847','2024-04-28 02:25:42.000000',1,'6c0cfe2a69da496081e34263e07adee5'),
(92,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTUxMSwiaWF0IjoxNzEyOTc1NTExLCJqdGkiOiIzNWU1Mzc2NzkyYjM0ZTY0OGQ1Yzc2ZGI0Zjc2ZmUyNSIsInVzZXJfaWQiOjQ2fQ.mIUITSJWvvTuLwd6kBufpmXY2vrvFD2oEPqhuJHhZhY','2024-04-13 02:31:51.880655','2024-04-28 02:31:51.000000',46,'35e5376792b34e648d5c76db4f76fe25'),
(93,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTUzNCwiaWF0IjoxNzEyOTc1NTM0LCJqdGkiOiJhMmE3YjI4MGQ2OTI0NjZmYTE3MzUwMjc4MjlmYmQ5ZiIsInVzZXJfaWQiOjQ3fQ.Tv8o6lQEBoRyvkOPoJbL7BxqZ9d2M0OYh59r_93mOlw','2024-04-13 02:32:14.676040','2024-04-28 02:32:14.000000',47,'a2a7b280d692466fa1735027829fbd9f'),
(94,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI3MTYwMCwiaWF0IjoxNzEyOTc1NjAwLCJqdGkiOiJjMDdiMTYxNjM1NDI0NGQzYjIwNTlhNGYzYjhlZGIyZCIsInVzZXJfaWQiOjQ5fQ.4oFSRxcUWtNg0UBkFKb2aJGcbsQOpASgR9oHVAuaxGk','2024-04-13 02:33:20.957797','2024-04-28 02:33:20.000000',49,'c07b1616354244d3b2059a4f3b8edb2d'),
(95,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDMwMDMzMywiaWF0IjoxNzEzMDA0MzMzLCJqdGkiOiI0MjY2ZGMxZTQyMjc0MjlhYjhiZDAxMGI2MWQwMWFmMyIsInVzZXJfaWQiOjF9.G_NqHVb_8JXcvYd4h7GDBk7CfN8zjgkx9DhCGd5_zpw','2024-04-13 10:32:13.187273','2024-04-28 10:32:13.000000',1,'4266dc1e4227429ab8bd010b61d01af3'),
(96,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDUwOTkyOCwiaWF0IjoxNzEzMjEzOTI4LCJqdGkiOiI2MjI5MWNhMTUwNDg0ZThiOTY5Nzg1YTc2Y2NjNzRjMSIsInVzZXJfaWQiOjF9.dMMutaM2t6XSKfIfZ5GR8dGCjfNcpvDqowR5SLL_gfA','2024-04-15 20:45:28.568673','2024-04-30 20:45:28.000000',1,'62291ca150484e8b969785a76ccc74c1'),
(97,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDUxMzQ5MCwiaWF0IjoxNzEzMjE3NDkwLCJqdGkiOiI4ZmI5NjgwZjFlOGE0YTdjOTBiMzYzMmIzYTMyMjJmOSIsInVzZXJfaWQiOjQ3fQ.8fUaEWPPVjKLOQ5z0JIgkix4QE_l7mG00fvXw1hm-UY','2024-04-15 21:44:50.463474','2024-04-30 21:44:50.000000',47,'8fb9680f1e8a4a7c90b3632b3a3222f9'),
(98,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDUxNDYxNCwiaWF0IjoxNzEzMjE4NjE0LCJqdGkiOiIyNDFiM2RjMjNmZmM0ZTRjODgyOTQ0OGYzZjEwYmRlZSIsInVzZXJfaWQiOjQ3fQ.jxlE7bStNAk221HWfjb8Pj0y_9lUjm_Sli9SNYnS2PU','2024-04-15 22:03:34.109788','2024-04-30 22:03:34.000000',47,'241b3dc23ffc4e4c8829448f3f10bdee'),
(99,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDUxNDY4NCwiaWF0IjoxNzEzMjE4Njg0LCJqdGkiOiJmNmIxZjBkNTE2OWY0M2JiOWZlYTg4N2Q0MzUyM2UwOCIsInVzZXJfaWQiOjQ2fQ.BBFq9j3hLIiYmTayDrQJnOB0S5WGYfO_x9Xy75g9Fnc','2024-04-15 22:04:44.810056','2024-04-30 22:04:44.000000',46,'f6b1f0d5169f43bb9fea887d43523e08'),
(100,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDUxNDczMCwiaWF0IjoxNzEzMjE4NzMwLCJqdGkiOiI4MGYxMzY3MzBmNzU0YmQxYjgwZjBhZjhmOWJiZDgwNCIsInVzZXJfaWQiOjF9.kd1rqgVv0qgJwBTead9MHOPQcaJV72OneyZ23OQQ8bw','2024-04-15 22:05:30.808592','2024-04-30 22:05:30.000000',1,'80f136730f754bd1b80f0af8f9bbd804'),
(101,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0NjU1MiwiaWF0IjoxNzEzMzUwNTUyLCJqdGkiOiI2YjhlNzhiMGIyMmY0ZjViOTJlZmFkMjRjNGVhNGE2NSIsInVzZXJfaWQiOjF9.1HbqrzY9xFYRm-xry5cqkmBb5HtF2ycQHkZ_d7PWHdo','2024-04-17 10:42:32.131222','2024-05-02 10:42:32.000000',1,'6b8e78b0b22f4f5b92efad24c4ea4a65'),
(102,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0NzcxNSwiaWF0IjoxNzEzMzUxNzE1LCJqdGkiOiJmMzkwNmMwYzZkMDA0MzJiOTViNTQ3YmRjMWVjZmRlNCIsInVzZXJfaWQiOjF9.kRGk3BWiwJXMa0WY2JlV2vOklo4SHgSNQ35ryKB8-mU','2024-04-17 11:01:55.945225','2024-05-02 11:01:55.000000',1,'f3906c0c6d00432b95b547bdc1ecfde4'),
(103,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0Nzc3MCwiaWF0IjoxNzEzMzUxNzcwLCJqdGkiOiI5ODZhZjVkMDY3ZjE0NDdlYWY3ZWY2MzVkODZlNDg4OCIsInVzZXJfaWQiOjQ2fQ.Zkh5s96f3kq1hVzcGGvRCXG-z4H8u_BU4kU9ZjEcVE4','2024-04-17 11:02:50.658045','2024-05-02 11:02:50.000000',46,'986af5d067f1447eaf7ef635d86e4888'),
(104,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0Nzg3MCwiaWF0IjoxNzEzMzUxODcwLCJqdGkiOiIyOWM4NDhhZjA2YzY0YTI3OGY5NmEyOTA3ODE5NmEwMCIsInVzZXJfaWQiOjF9.i97Prokbi9zskosoyQm1Pje89rJguo42cdVoRNTmXy4','2024-04-17 11:04:30.123112','2024-05-02 11:04:30.000000',1,'29c848af06c64a278f96a29078196a00'),
(105,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0OTExMSwiaWF0IjoxNzEzMzUzMTExLCJqdGkiOiJkMWYyN2RmYzY4Njg0ODFlOTZhZjYxMzAwMGQ2NTIzZSIsInVzZXJfaWQiOjUyfQ.3wWOkWDhUrqfuaRFuntaGqU8SsL6D5eRPRjQ1F7I4vw','2024-04-17 11:25:11.492089','2024-05-02 11:25:11.000000',NULL,'d1f27dfc6868481e96af613000d6523e'),
(106,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0OTEzNCwiaWF0IjoxNzEzMzUzMTM0LCJqdGkiOiIxZTVhZGViNmJkMmQ0Mjc4OWM3MmFiNmZmZTk4ODA2YSIsInVzZXJfaWQiOjQ3fQ.6M4Eb-zkZNTXuUqQDU2o7mgB_yJ0L1PdviFOprBfhg0','2024-04-17 11:25:34.081602','2024-05-02 11:25:34.000000',47,'1e5adeb6bd2d42789c72ab6ffe98806a'),
(107,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0OTUxNCwiaWF0IjoxNzEzMzUzNTE0LCJqdGkiOiJjMDM0OTE4ZjcyMGI0NzEyOTU1MzhhMmU4ZThiYjg2NyIsInVzZXJfaWQiOjQ2fQ.G_xf-92JOPjEC8qO8OF9UBUkJprpoY3FEtqWDaHn_Gw','2024-04-17 11:31:54.723224','2024-05-02 11:31:54.000000',46,'c034918f720b471295538a2e8e8bb867'),
(108,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY0OTUzNiwiaWF0IjoxNzEzMzUzNTM2LCJqdGkiOiJkODRlZGYyMjc4YjY0NDRjOGVkMTZmMmNlODgxZTBmMSIsInVzZXJfaWQiOjQ3fQ.5yh3I6ggG_aLVEsD4IyAJwRS0w23ZcdTO7Auc9jqdj4','2024-04-17 11:32:16.460902','2024-05-02 11:32:16.000000',47,'d84edf2278b6444c8ed16f2ce881e0f1'),
(109,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY1MDA5OSwiaWF0IjoxNzEzMzU0MDk5LCJqdGkiOiJkNmM2NTk4NGJlNWQ0ZTkxODJlOTVhMzM4NmM2ZDk4YiIsInVzZXJfaWQiOjF9.yk5mhCs7iMYFUzk3typ1dg9rBNdrwJAL5PX1x1RL18g','2024-04-17 11:41:39.365555','2024-05-02 11:41:39.000000',1,'d6c65984be5d4e9182e95a3386c6d98b'),
(110,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY5NjEwMywiaWF0IjoxNzEzNDAwMTAzLCJqdGkiOiIxMzQ3MjhjODgxN2Y0OWNkYjdjODRlNmYzNzhlY2IyYiIsInVzZXJfaWQiOjF9.VZplFhUVldUdCPEAKpnSmg1edgVDbARhM9MTz1CCe_I','2024-04-18 00:28:23.399366','2024-05-03 00:28:23.000000',1,'134728c8817f49cdb7c84e6f378ecb2b'),
(111,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY5NjQ4NiwiaWF0IjoxNzEzNDAwNDg2LCJqdGkiOiJjMzYwNWIwYmEwNDY0ZmY1YmE1YTE0NTViMjYwMTU4ZCIsInVzZXJfaWQiOjQ3fQ.z49iJROy85kUVyDNlw1H4J0vTUZzRzROzkW7nidnL4M','2024-04-18 00:34:46.927236','2024-05-03 00:34:46.000000',47,'c3605b0ba0464ff5ba5a1455b260158d'),
(112,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY5OTQ0OSwiaWF0IjoxNzEzNDAzNDQ5LCJqdGkiOiI3NDQ0YmI0ZWE4OGI0NDJhYmNjYzY0YzU4ZGYyYjRlNiIsInVzZXJfaWQiOjQ2fQ.v54lsX9kN3kO2yFAYL0uyPKIe_2pjfX_HXghsNGuvoE','2024-04-18 01:24:09.737477','2024-05-03 01:24:09.000000',46,'7444bb4ea88b442abccc64c58df2b4e6'),
(113,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDY5OTkyOCwiaWF0IjoxNzEzNDAzOTI4LCJqdGkiOiIwMTUxMDA0NTEzZjg0NWIzYjk1YmU0MzdkYThhMjg1NSIsInVzZXJfaWQiOjQ3fQ.24ahJSOWrrTUYUGrPxCgiKnlzFgjQBHVgz3kre-8jww','2024-04-18 01:32:08.521909','2024-05-03 01:32:08.000000',47,'0151004513f845b3b95be437da8a2855'),
(114,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMDA5OSwiaWF0IjoxNzEzNDA0MDk5LCJqdGkiOiIwZjhhMjY5YzIyNTA0YjQ1YThkNTM4Y2EzYjJiNjdkZCIsInVzZXJfaWQiOjQ3fQ.megWK8uSHXeQEZC7WYBrZnvWuUNpd4JVdGX29ii0bDc','2024-04-18 01:34:59.196411','2024-05-03 01:34:59.000000',47,'0f8a269c22504b45a8d538ca3b2b67dd'),
(115,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMDI2MiwiaWF0IjoxNzEzNDA0MjYyLCJqdGkiOiIzYWM2M2M1MTU5ZWU0NjE4YmU0NGQ5NTQ5YzE0YjZmYiIsInVzZXJfaWQiOjF9.8YH3T8fHhXt5zKyy7nvSMzrnqH5KQ_Km0kfcKqV5QJE','2024-04-18 01:37:42.768547','2024-05-03 01:37:42.000000',1,'3ac63c5159ee4618be44d9549c14b6fb'),
(116,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMDYzMywiaWF0IjoxNzEzNDA0NjMzLCJqdGkiOiI2OTZhYTdkZmE4MmE0YTk1YjQxMDY1ZDgwOWYyNTcwMyIsInVzZXJfaWQiOjF9.Jv4Vu-8Ld1OtBR-9nLcyBIeiKvV4sCovSoZvny0eX7A','2024-04-18 01:43:53.074311','2024-05-03 01:43:53.000000',1,'696aa7dfa82a4a95b41065d809f25703'),
(117,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMTE5NywiaWF0IjoxNzEzNDA1MTk3LCJqdGkiOiI5NzFjYWYwZDk0ZDU0MTg5OWI0NDBhMGYyNmRjMTA3NyIsInVzZXJfaWQiOjQ2fQ.MBJ3hGthCkwmL8a1iXRBBB-rm-PVCUoFqMQic2Ie3js','2024-04-18 01:53:17.862079','2024-05-03 01:53:17.000000',46,'971caf0d94d541899b440a0f26dc1077'),
(118,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMzU2NSwiaWF0IjoxNzEzNDA3NTY1LCJqdGkiOiJmMTM2NDUxNWQ4ZmU0ZGRkOTE2ZjliY2UzMzVkYTc4NyIsInVzZXJfaWQiOjQ2fQ.RTSQZMeBqI9s7b9JV7aP77ktA_qcSwWs1SDP8qA_M4Q','2024-04-18 02:32:45.174216','2024-05-03 02:32:45.000000',46,'f1364515d8fe4ddd916f9bce335da787'),
(119,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwMzc0NiwiaWF0IjoxNzEzNDA3NzQ2LCJqdGkiOiI1ZmY3YmM5YzA0NTY0MzlmOTBjODFmMmZiZjAzMzVhMyIsInVzZXJfaWQiOjQ2fQ.14-JUrzDYzm75uUDl76mUKd3bQ-7F5LHZmDx7BbTZIY','2024-04-18 02:35:46.910401','2024-05-03 02:35:46.000000',46,'5ff7bc9c0456439f90c81f2fbf0335a3'),
(120,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNDQxNSwiaWF0IjoxNzEzNDA4NDE1LCJqdGkiOiJiMDU2ZDNhY2Y4Njg0Nzc4OTExNWEzNjExNDNkMmQxZCIsInVzZXJfaWQiOjF9.DjTaRu1JdTmC5bnnLvRXhMi4uRrDpeIP58V3bngAvLk','2024-04-18 02:46:55.715024','2024-05-03 02:46:55.000000',1,'b056d3acf86847789115a361143d2d1d'),
(121,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNDc5NywiaWF0IjoxNzEzNDA4Nzk3LCJqdGkiOiI4YmM1YjdjMmI0Mzc0NzQ3OWUwYzBiYjlmNjNiNzU5MiIsInVzZXJfaWQiOjQ2fQ.Ab2Q6vuMnmwpNP717yFV36dpkQ765gNiaslhslbNybk','2024-04-18 02:53:17.627086','2024-05-03 02:53:17.000000',46,'8bc5b7c2b43747479e0c0bb9f63b7592'),
(122,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzUyMiwiaWF0IjoxNzEzNDExNTIyLCJqdGkiOiJjNTYzY2ExMDk2MWE0YjdjODQ3ZTkzOGU3NzU5ZjljMCIsInVzZXJfaWQiOjQ2fQ.XyrduyWAeGDKGg2cXrdIyW0Vgx9RQlt110cXymKhXao','2024-04-18 03:38:42.069391','2024-05-03 03:38:42.000000',46,'c563ca10961a4b7c847e938e7759f9c0'),
(123,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzc0MCwiaWF0IjoxNzEzNDExNzQwLCJqdGkiOiJlNWY3NWZjNGQ1NmI0OTdhODY0MGIwZmQzZjMyYThmMSIsInVzZXJfaWQiOjQ2fQ.YBh4wRpQ7eunfSti8d6S7aCSRgVEtsUhzPjCp4gWRDo','2024-04-18 03:42:20.395096','2024-05-03 03:42:20.000000',46,'e5f75fc4d56b497a8640b0fd3f32a8f1'),
(124,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzc2OCwiaWF0IjoxNzEzNDExNzY4LCJqdGkiOiI4OWNjOTk1MzRkNzk0Mzk3ODk4N2Y3MGUyZjEzYTE2YSIsInVzZXJfaWQiOjQ2fQ.GbuXyngyThZ5gayI1TmhR5VxKTsDNrSap5it3w7jo8s','2024-04-18 03:42:48.597752','2024-05-03 03:42:48.000000',46,'89cc99534d7943978987f70e2f13a16a'),
(125,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzgzNSwiaWF0IjoxNzEzNDExODM1LCJqdGkiOiJhZWFiYjQ5YmQ1Nzk0ZjU5YmZkYjNiMTNlYTI4YWU2OSIsInVzZXJfaWQiOjQ2fQ.GJW3M930b5FkERrPheWbpYCDoHqkz-IPWxUwJQezmOw','2024-04-18 03:43:55.425177','2024-05-03 03:43:55.000000',46,'aeabb49bd5794f59bfdb3b13ea28ae69'),
(126,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzk3OSwiaWF0IjoxNzEzNDExOTc5LCJqdGkiOiI5MzJhMjM0MDg5OTI0YjI5OGZlOTYzOWQ2NmY0YmMxMSIsInVzZXJfaWQiOjQ2fQ.Zyybio1WjmoQLgikj_YmxPK54oMfetcTp6gcNyDMzUM','2024-04-18 03:46:19.888076','2024-05-03 03:46:19.000000',46,'932a234089924b298fe9639d66f4bc11'),
(127,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwNzk5MCwiaWF0IjoxNzEzNDExOTkwLCJqdGkiOiJkYWY5YzI2YTViMmU0ODhlYWRiYzQ4NzQwMjBiZDdjZCIsInVzZXJfaWQiOjF9.zxcQM3eyfc29sV70ISck_LjiKVwijWqhVCSklc7qD-E','2024-04-18 03:46:30.161999','2024-05-03 03:46:30.000000',1,'daf9c26a5b2e488eadbc4874020bd7cd'),
(128,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDcwODExMiwiaWF0IjoxNzEzNDEyMTEyLCJqdGkiOiI3MTQ5OTljOWIzNDE0NzdmODgzY2JiZTRkZDE3YWZmMyIsInVzZXJfaWQiOjQ2fQ.2r3K05Irx-OEa9vU3rG8Ue76_XCFr28PPP0mU5E0E3A','2024-04-18 03:48:32.483054','2024-05-03 03:48:32.000000',46,'714999c9b341477f883cbbe4dd17aff3'),
(129,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDczODA4MSwiaWF0IjoxNzEzNDQyMDgxLCJqdGkiOiJlYzA1NzQzZTVlZWY0MjgxODU3MTNkMWRiOWMxMDM0OSIsInVzZXJfaWQiOjF9.sI8DLaavEua9UJbrybxeKiB3P3NtjdY2A0WY_G75ALw','2024-04-18 12:08:01.147065','2024-05-03 12:08:01.000000',1,'ec05743e5eef428185713d1db9c10349'),
(130,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDczODEwMCwiaWF0IjoxNzEzNDQyMTAwLCJqdGkiOiJiMjlmM2NmMDgwMDY0MDc3ODI3ZGVlOGVhNmY4NWRmMCIsInVzZXJfaWQiOjQ2fQ.faajnGX-hHphfiJb6AzjPlawtUUXC4GQRZu93bhbURw','2024-04-18 12:08:20.099301','2024-05-03 12:08:20.000000',46,'b29f3cf080064077827dee8ea6f85df0'),
(131,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDc0MjgxNiwiaWF0IjoxNzEzNDQ2ODE2LCJqdGkiOiJmZTYxNWY2ODQ1N2M0MWM4YWYzODg3ZDE3MmM0YTBiZSIsInVzZXJfaWQiOjQ3fQ.TG2-YAYhgMAJiGKtB0doUAusLCfmcBotx46V-eoxYd8','2024-04-18 13:26:56.475694','2024-05-03 13:26:56.000000',47,'fe615f68457c41c8af3887d172c4a0be'),
(132,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDc0MjkxNiwiaWF0IjoxNzEzNDQ2OTE2LCJqdGkiOiIwN2FiNWRlZGY1ZTI0MTU3OWU2OGYwNTVmZTRkNDg0NCIsInVzZXJfaWQiOjQ4fQ.tmbvMQ1IKXPMrLT8rw0SKVTgsA1Zh-qSzWR4FZMibIU','2024-04-18 13:28:36.390473','2024-05-03 13:28:36.000000',48,'07ab5dedf5e241579e68f055fe4d4844'),
(133,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDc0MjkzNiwiaWF0IjoxNzEzNDQ2OTM2LCJqdGkiOiIxMTIxYWVkZGQyMzU0MWNiOTZjNDI2NTFmMDUxOGQxNiIsInVzZXJfaWQiOjQ5fQ.KkaQWHys2Oky38m1pnpJiZ_yPF0fFI_ioaAbsDd0mQo','2024-04-18 13:28:56.986773','2024-05-03 13:28:56.000000',49,'1121aeddd23541cb96c42651f0518d16'),
(134,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDc0MzAzOSwiaWF0IjoxNzEzNDQ3MDM5LCJqdGkiOiIyMmE4OTVmM2VlZTA0NTI4OTIxODI2Y2M1YWUwYTljMiIsInVzZXJfaWQiOjF9.eUA_sadO_er9GZ-UA3wXCNxO6XlrisPCMAtzFidlUn0','2024-04-18 13:30:39.531288','2024-05-03 13:30:39.000000',1,'22a895f3eee04528921826cc5ae0a9c2');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `permission_level` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES
(1,'2024-04-12 23:32:38.670036',1,'','',1,1,'2024-04-01 21:01:11.663152','mouadh','mouadh@test.com','pbkdf2_sha256$600000$yWBEeC4SV3sNDRS8ARSnbj$ZFRHwFGN1cdKjPgdl0cselg/x8bYtRqpMfc+iisMNxM=','0'),
(46,NULL,0,'','',0,1,'2024-04-13 02:10:41.346245','regular','regular@regular.com','pbkdf2_sha256$600000$4l0HauLWZSvQsgoo3UEzrY$mMQS/NkKrN1HUbIsdcbFhvzXb51miam+qFYP5gQ8eWo=','Viewer'),
(47,NULL,0,'','',1,1,'2024-04-13 02:11:02.300229','staff','staff@staff.com','pbkdf2_sha256$600000$NXH25Sn7slfsamgIsNTqJ1$4P2s5JPcZyqn00sLoKoCy3MmrzHsvNJZSyCuTXpALV0=','Create'),
(48,NULL,0,'','',1,1,'2024-04-13 02:11:28.606064','staff2','staff2@staff.com','pbkdf2_sha256$600000$FEalIyDpOAwbv04mC7BrAt$kq7cHOZHJFN6Ep9ahOZMVTzoo6j8JP+s3x2o8GqtS7g=','Edit'),
(49,NULL,0,'','',1,1,'2024-04-13 02:22:53.431992','staff3','staff3@staff.com','pbkdf2_sha256$600000$PWCnSnMrPw8f9fDLySa26J$bIgKrir6IOgHbCnK3UkK1wl1rD/4VlAEVlInHgEoP78=','Refine'),
(50,NULL,0,'','',1,1,'2024-04-13 02:31:31.626685','staff4','staff4@staff.com','pbkdf2_sha256$600000$WO3f14N8XeB80hrAiS0AIw$xOB+Op8y0Kj8KmKMZjt1Xb8Ojwwj4d8dfxdilewL2t0=','Emend'),
(56,NULL,1,'','',1,1,'2024-04-18 01:36:49.504719','hamma','hama132@hama.com','pbkdf2_sha256$600000$3BljiOR9DX6YA6iUYxDYOR$cKKLEnuD+OVP7gtHpFFKLKAuqLUBKxkc4Q7VS6YizdA=',''),
(57,NULL,1,'','',1,1,'2024-04-18 01:45:16.920338','hammatest','test@hama.com','pbkdf2_sha256$600000$LMlHfxsczQYc14Y2YIEVPw$qOvaeD83pyCgMHQpgkaK1NTRMo7+kVNg5hCbleqRZtw=','');
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_groups`
--

LOCK TABLES `users_user_groups` WRITE;
/*!40000 ALTER TABLE `users_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_user_permissions`
--

LOCK TABLES `users_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18 13:30:50
