CREATE DATABASE  IF NOT EXISTS `quizstorm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `quizstorm`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: quizstorm
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) NOT NULL,
  `color_categoria` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Entretenimiento','rojo'),(2,'Cultura','verde'),(3,'Historia','violeta'),(4,'Ciencia','azul'),(5,'Deporte','naranja');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dificultad`
--

DROP TABLE IF EXISTS `dificultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dificultad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrip` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dificultad`
--

LOCK TABLES `dificultad` WRITE;
/*!40000 ALTER TABLE `dificultad` DISABLE KEYS */;
INSERT INTO `dificultad` VALUES (1,'facil'),(2,'medio'),(3,'dificil');
/*!40000 ALTER TABLE `dificultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadisticas`
--

DROP TABLE IF EXISTS `estadisticas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadisticas` (
  `id_estadistica` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_partida` int DEFAULT NULL,
  `fecha` date NOT NULL,
  `cantidad_jugadores` int DEFAULT NULL,
  `cantidad_partidas_jugadas` int DEFAULT NULL,
  `cantidad_preguntas` int DEFAULT NULL,
  `cantidad_usuarios_nuevos` int DEFAULT NULL,
  `porcentaje_respuestas_correctas` decimal(5,2) DEFAULT NULL,
  `usuarios_por_pais` text,
  `usuarios_por_sexo` text,
  `usuarios_por_grupo_edad` text,
  PRIMARY KEY (`id_estadistica`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_partida` (`id_partida`),
  CONSTRAINT `estadisticas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `estadisticas_ibfk_2` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadisticas`
--

LOCK TABLES `estadisticas` WRITE;
/*!40000 ALTER TABLE `estadisticas` DISABLE KEYS */;
/*!40000 ALTER TABLE `estadisticas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partida`
--

DROP TABLE IF EXISTS `partida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partida` (
  `id_partida` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha_partida` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `puntos_obtenidos` int NOT NULL,
  `finalizada` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_partida`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `partida_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partida`
--

LOCK TABLES `partida` WRITE;
/*!40000 ALTER TABLE `partida` DISABLE KEYS */;
/*!40000 ALTER TABLE `partida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partida_pregunta`
--

DROP TABLE IF EXISTS `partida_pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partida_pregunta` (
  `id_partida_pregunta` int NOT NULL AUTO_INCREMENT,
  `id_partida` int DEFAULT NULL,
  `id_pregunta` int DEFAULT NULL,
  `respuesta_usuario` enum('A','B','C','D') DEFAULT NULL,
  `correcto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_partida_pregunta`),
  KEY `id_partida` (`id_partida`),
  KEY `id_pregunta` (`id_pregunta`),
  CONSTRAINT `partida_pregunta_ibfk_1` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE,
  CONSTRAINT `partida_pregunta_ibfk_2` FOREIGN KEY (`id_pregunta`) REFERENCES `pregunta` (`id_pregunta`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partida_pregunta`
--

LOCK TABLES `partida_pregunta` WRITE;
/*!40000 ALTER TABLE `partida_pregunta` DISABLE KEYS */;
/*!40000 ALTER TABLE `partida_pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta`
--

DROP TABLE IF EXISTS `pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pregunta` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT,
  `categoria` int DEFAULT NULL,
  `dificultad` int NOT NULL,
  `contenido` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `opcion_A` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `opcion_B` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `opcion_C` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `opcion_D` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `respuesta_correcta` enum('A','B','C','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `estado` enum('aprobada','pendiente','reportada') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'pendiente',
  `id_editor` int DEFAULT NULL,
  `cant_total_aciertos` int NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitado` enum('ACTIVA','INACTIVA') DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`),
  KEY `dificultad` (`dificultad`),
  KEY `categoria` (`categoria`),
  KEY `id_editor` (`id_editor`),
  CONSTRAINT `pregunta_ibfk_1` FOREIGN KEY (`dificultad`) REFERENCES `dificultad` (`id`),
  CONSTRAINT `pregunta_ibfk_2` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `pregunta_ibfk_3` FOREIGN KEY (`id_editor`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta`
--

LOCK TABLES `pregunta` WRITE;
/*!40000 ALTER TABLE `pregunta` DISABLE KEYS */;
INSERT INTO `pregunta` VALUES (76,1,1,'¿Cuál es el personaje principal de la serie \"Breaking Bad\"?','Jesse Pinkman','Saul Goodman','Walter White','Hank Schrader','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(77,1,1,'¿En qué año se lanzó la película \"Titanic\"?','1994','1997','2000','1995','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(78,1,1,'¿Qué videojuego popular tiene una batalla llamada \"Battle Royale\"?','FIFA','Minecraft','Fortnite','Call of Duty','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(79,1,1,'¿Cuál de los siguientes es un personaje de \"Mario Bros\"?','Link','Sonic','Luigi','Master Chief','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(80,1,1,'¿Quién es el actor principal de la película \"Iron Man\"?','Chris Hemsworth','Robert Downey Jr.','Chris Evans','Tom Holland','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(81,1,2,'¿Cuál es la plataforma de streaming más usada en el mundo?','Amazon Prime Video','HBO Max','Netflix','Disney+','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(82,1,2,'¿Qué serie tiene como protagonistas a un grupo de amigos en Nueva York?','Friends','The Office','Brooklyn Nine-Nine','How I Met Your Mother','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(83,1,2,'¿Cuál es el videojuego más vendido de la historia?','Minecraft','Tetris','GTA V','Super Mario Bros','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(84,1,2,'¿En qué año se lanzó la primera PlayStation?','1992','1994','1996','1998','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(85,1,2,'¿Quién interpreta a Thor en el Universo Cinematográfico de Marvel?','Chris Hemsworth','Tom Hiddleston','Mark Ruffalo','Chris Pratt','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(86,1,3,'¿Qué película ganó el premio Óscar a la mejor película en 1994?','Pulp Fiction','Forrest Gump','The Shawshank Redemption','The Lion King','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(87,1,3,'¿Quién fue el primer actor en interpretar a James Bond en cine?','Roger Moore','Pierce Brosnan','Sean Connery','Daniel Craig','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(88,1,3,'¿Qué videojuego popular fue creado por Mojang?','Fortnite','Roblox','Minecraft','Overwatch','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(89,1,3,'¿En qué año se lanzó la primera película de \"Star Wars\"?','1977','1980','1983','1999','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(90,1,3,'¿Cuál es la película con mayor recaudación de la historia?','Avengers: Endgame','Avatar','Titanic','Star Wars: The Force Awakens','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(91,2,1,'¿Cuál es la capital de Francia?','Berlín','Madrid','París','Londres','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(92,2,1,'¿En qué continente se encuentra Egipto?','Europa','África','Asia','América','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(93,2,1,'¿Qué instrumento musical toca Paco de Lucía?','Violín','Guitarra','Piano','Flauta','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(94,2,1,'¿Qué civilización construyó las pirámides de Giza?','Los griegos','Los romanos','Los egipcios','Los mayas','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(95,2,1,'¿Qué pintor es famoso por cortar parte de su oreja?','Salvador Dalí','Pablo Picasso','Vincent van Gogh','Claude Monet','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(96,2,2,'¿En qué año se inauguró la Torre Eiffel?','1889','1895','1900','1870','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(97,2,2,'¿Quién es el autor de \"Don Quijote de la Mancha\"?','Lope de Vega','Miguel de Cervantes','Gustavo Adolfo Bécquer','Jorge Luis Borges','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(98,2,2,'¿Qué país es conocido como la Tierra del Sol Naciente?','China','Corea del Sur','Japón','India','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(99,2,2,'¿Qué escritor es famoso por la obra \"Cien años de soledad\"?','Gabriel García Márquez','Mario Vargas Llosa','Julio Cortázar','Jorge Luis Borges','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(100,2,2,'¿Cuál es el nombre de la famosa catedral de Moscú con cúpulas en forma de cebolla?','Catedral de San Pedro','Catedral de San Basilio','Catedral de San Marcos','Catedral de Notre-Dame','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(101,2,3,'¿Qué emperador romano ordenó la construcción del Coliseo?','Nerón','Julio César','Trajano','Vespasiano','D','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(102,2,3,'¿Qué filósofo griego fue maestro de Alejandro Magno?','Sócrates','Platón','Aristóteles','Epicuro','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(103,2,3,'¿Quién pintó \"La noche estrellada\"?','Claude Monet','Paul Gauguin','Vincent van Gogh','Henri Matisse','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(104,2,3,'¿Cuál es el templo religioso más grande del mundo?','La Basílica de San Pedro','La Mezquita de La Meca','Angkor Wat','El Templo del Cielo','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(105,2,3,'¿En qué país se encuentra el Machu Picchu?','Chile','Bolivia','Perú','Argentina','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(106,3,1,'¿En qué año comenzó la Segunda Guerra Mundial?','1914','1939','1945','1929','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(107,3,1,'¿Quién fue el primer presidente de los Estados Unidos?','Abraham Lincoln','George Washington','Thomas Jefferson','John Adams','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(108,3,1,'¿Quién fue el primer hombre en pisar la Luna?','Yuri Gagarin','Buzz Aldrin','Neil Armstrong','John Glenn','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(109,3,1,'¿Qué país fue responsable del ataque a Pearl Harbor en 1941?','Alemania','Japón','Italia','Rusia','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(110,3,1,'¿Cuál fue el último emperador de Roma?','Julio César','Constantino','Nerón','Rómulo Augústulo','D','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(111,3,2,'¿En qué año cayó el Muro de Berlín?','1989','1991','1987','1985','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(112,3,2,'¿Quién fue el líder del Imperio Mongol?','Atila','Gengis Kan','Carlos Magno','Kublai Kan','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(113,3,2,'¿Cuál fue el conflicto más largo del siglo XX?','La Guerra de Vietnam','La Guerra Fría','La Guerra del Golfo','La Guerra Civil Española','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(114,3,2,'¿Quién fue el líder de la Revolución Cubana?','Che Guevara','Fulgencio Batista','Raúl Castro','Fidel Castro','D','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(115,3,2,'¿En qué país tuvo lugar la Revolución de Octubre en 1917?','Francia','Rusia','China','Alemania','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(116,3,3,'¿Cuál fue la primera civilización conocida?','Los griegos','Los romanos','Los sumerios','Los egipcios','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(117,3,3,'¿Qué guerra fue conocida como la \"Gran Guerra\"?','La Guerra de los Cien Años','La Guerra de Corea','La Primera Guerra Mundial','La Guerra del Golfo','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(118,3,3,'¿Qué emperador fue asesinado el 15 de marzo del 44 a.C.?','Julio César','Augusto','Nerón','Marco Aurelio','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(119,3,3,'¿En qué año cayó Constantinopla a manos de los otomanos?','1204','1453','1492','1521','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(120,3,3,'¿Qué tratado puso fin a la Primera Guerra Mundial?','El Tratado de Versalles','El Tratado de París','El Tratado de Utrecht','El Tratado de Ginebra','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(121,4,1,'¿Qué elemento químico tiene el símbolo O?','Oxígeno','Oro','Osmio','Plata','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(122,4,1,'¿Cuántos huesos tiene el cuerpo humano adulto?','206','210','180','220','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(123,4,1,'¿Cómo se llama el proceso por el cual las plantas producen su alimento?','Fotosíntesis','Fermentación','Respiración','Metabolismo','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(124,4,1,'¿Cuál es el planeta más cercano al Sol?','Venus','Marte','Mercurio','Júpiter','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(125,4,1,'¿Qué animal es conocido como el rey de la selva?','Tigre','Elefante','León','Gorila','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(126,4,2,'¿Qué científico propuso la teoría de la relatividad?','Isaac Newton','Albert Einstein','Galileo Galilei','Stephen Hawking','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(127,4,2,'¿Qué órgano humano es responsable de filtrar la sangre?','Pulmones','Hígado','Riñones','Corazón','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(128,4,2,'¿Qué partícula subatómica tiene carga negativa?','Protones','Electrones','Neutrones','Quarks','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(129,4,2,'¿Qué ley describe la relación entre la masa y la aceleración?','Ley de la gravedad','Ley de la conservación de la energía','Ley de Hooke','Segunda ley de Newton','D','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(130,4,2,'¿Qué planeta del sistema solar tiene anillos visibles?','Urano','Saturno','Júpiter','Marte','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(131,4,3,'¿Qué molécula es conocida como la molécula de la vida?','ATP','ADN','ARN','Glucosa','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(132,4,3,'¿Quién descubrió la penicilina?','Louis Pasteur','Marie Curie','Alexander Fleming','Joseph Lister','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(133,4,3,'¿Cuál es la unidad de medida de la resistencia eléctrica?','Voltios','Amperios','Ohmios','Julios','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(134,4,3,'¿Qué fenómeno explica la expansión acelerada del universo?','La materia oscura','La energía oscura','La radiación cósmica de fondo','La teoría de cuerdas','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(135,4,3,'¿Qué elemento químico es el más abundante en la atmósfera terrestre?','Oxígeno','Nitrógeno','Hidrógeno','Carbono','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(136,5,1,'¿En qué deporte se utiliza una raqueta?','Fútbol','Béisbol','Tenis','Boxeo','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(137,5,1,'¿Qué país ganó la Copa Mundial de Fútbol en 2018?','Brasil','Alemania','Francia','Argentina','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(138,5,1,'¿Quién es conocido como \"La Pulga\" en el fútbol?','Cristiano Ronaldo','Lionel Messi','Neymar','Zlatan Ibrahimović','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(139,5,1,'¿Cuántos jugadores hay en un equipo de baloncesto?','6','5','7','11','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(140,5,1,'¿Qué país es famoso por su dominio en el rugby?','España','Nueva Zelanda','Francia','Italia','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(141,5,2,'¿En qué deporte se destacan Rafael Nadal y Roger Federer?','Fútbol','Tenis','Baloncesto','Boxeo','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(142,5,2,'¿Qué país ganó el primer Mundial de Fútbol?','Brasil','Uruguay','Italia','Alemania','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(143,5,2,'¿En qué deporte se compite en \"los 100 metros planos\"?','Natación','Esquí','Atletismo','Remo','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(144,5,2,'¿Cuántas medallas de oro ganó Michael Phelps en los Juegos Olímpicos de Pekín 2008?','8','6','9','7','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(145,5,2,'¿Qué equipo de fútbol tiene más títulos de la UEFA Champions League?','Barcelona','Liverpool','Real Madrid','Bayern Múnich','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(146,5,3,'¿Qué gimnasta es la más condecorada de la historia?','Simone Biles','Nadia Comăneci','Shannon Miller','Lilia Podkopayeva','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(147,5,3,'¿En qué ciudad se celebraron los primeros Juegos Olímpicos modernos?','París','Atenas','Londres','Roma','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(148,5,3,'¿Qué atleta tiene el récord mundial en los 100 metros planos?','Usain Bolt','Carl Lewis','Tyson Gay','Yohan Blake','A','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(149,5,3,'¿Cuántos equipos compiten en la NBA?','28','30','32','26','B','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA'),(150,5,3,'¿Qué boxeador fue apodado \"El más grande\"?','Floyd Mayweather','Mike Tyson','Muhammad Ali','Joe Frazier','C','aprobada',1,0,'2024-10-17 04:02:17','ACTIVA');
/*!40000 ALTER TABLE `pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta_reportada`
--

DROP TABLE IF EXISTS `pregunta_reportada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pregunta_reportada` (
  `id_reporte` int NOT NULL AUTO_INCREMENT,
  `id_pregunta` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `opcion_1` text NOT NULL,
  `opcion_2` text NOT NULL,
  `opcion_3` text NOT NULL,
  `opcion_4` text NOT NULL,
  `opcion_5` text NOT NULL,
  `opcion_6` text NOT NULL,
  `opcion_7` text NOT NULL,
  `opcion_8` text NOT NULL,
  `opcion_9` text NOT NULL,
  `opcion_10` text NOT NULL,
  `fecha_reporte` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado_reporte` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  PRIMARY KEY (`id_reporte`),
  KEY `id_pregunta` (`id_pregunta`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pregunta_reportada_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `pregunta` (`id_pregunta`) ON DELETE CASCADE,
  CONSTRAINT `pregunta_reportada_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_reportada`
--

LOCK TABLES `pregunta_reportada` WRITE;
/*!40000 ALTER TABLE `pregunta_reportada` DISABLE KEYS */;
/*!40000 ALTER TABLE `pregunta_reportada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta_sugerida`
--

DROP TABLE IF EXISTS `pregunta_sugerida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pregunta_sugerida` (
  `id_sugerencia` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `categoria` int NOT NULL,
  `contenido` text NOT NULL,
  `opcion_A` text NOT NULL,
  `opcion_B` text NOT NULL,
  `opcion_C` text NOT NULL,
  `opcion_D` text NOT NULL,
  `respuesta_correcta` enum('A','B','C','D') NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('pendiente','aprobada','rechazada') DEFAULT 'pendiente',
  PRIMARY KEY (`id_sugerencia`),
  KEY `id_usuario` (`id_usuario`),
  KEY `categoria` (`categoria`),
  CONSTRAINT `pregunta_sugerida_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `pregunta_sugerida_ibfk_2` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_sugerida`
--

LOCK TABLES `pregunta_sugerida` WRITE;
/*!40000 ALTER TABLE `pregunta_sugerida` DISABLE KEYS */;
/*!40000 ALTER TABLE `pregunta_sugerida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranking`
--

DROP TABLE IF EXISTS `ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranking` (
  `id_ranking` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `puntos_acumulados` int NOT NULL,
  PRIMARY KEY (`id_ranking`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ranking_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking`
--

LOCK TABLES `ranking` WRITE;
/*!40000 ALTER TABLE `ranking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` enum('Masculino','Femenino','Prefiero no cargarlo') DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `puntos_totales` int DEFAULT '0',
  `nivel` int NOT NULL DEFAULT '1',
  `rol` enum('jugador','editor','administrador') DEFAULT 'jugador',
  `estado_cuenta` enum('activo','pendiente de validación') DEFAULT 'pendiente de validación',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_conexion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `intentos_fallidos_login` int DEFAULT '0',
  `token` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan Pérez','juanp_editor','juanperez@example.com','ContraseñaEncriptada','ruta/a/foto.jpg','1990-05-15','Masculino','Argentina',0,1,'editor','activo','2024-10-17 03:59:51','2024-10-17 03:59:51',0,NULL),(2,'Laura Lopez','Lau_admin','lauperez@example.com','ContraseñaEncriptada','ruta/a/foto.jpg','1995-07-12','Femenino','Argentina',0,1,'administrador','activo','2024-10-17 04:06:58','2024-10-17 04:06:58',0,NULL),(3,'Lautaro Gomez','Lauti903','lautagomez@example.com','ContraseñaEncriptada','ruta/a/foto.jpg','1995-07-12','Masculino','Argentina',0,1,'jugador','activo','2024-10-21 14:47:12','2024-10-21 14:47:12',0,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validacion_cuenta`
--

DROP TABLE IF EXISTS `validacion_cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validacion_cuenta` (
  `id_validacion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `token_validacion` varchar(255) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_expiracion` timestamp NOT NULL,
  `fecha_validacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_validacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `validacion_cuenta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validacion_cuenta`
--

LOCK TABLES `validacion_cuenta` WRITE;
/*!40000 ALTER TABLE `validacion_cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `validacion_cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vistapreguntas`
--

DROP TABLE IF EXISTS `vistapreguntas`;
/*!50001 DROP VIEW IF EXISTS `vistapreguntas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistapreguntas` AS SELECT 
 1 AS `id_pregunta`,
 1 AS `categoria`,
 1 AS `dificultad`,
 1 AS `contenido`,
 1 AS `opcion_A`,
 1 AS `opcion_B`,
 1 AS `opcion_C`,
 1 AS `opcion_D`,
 1 AS `respuesta_correcta`,
 1 AS `habilitado`,
 1 AS `estado`,
 1 AS `cant_total_aciertos`,
 1 AS `fecha`,
 1 AS `editor`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vistapreguntas`
--

/*!50001 DROP VIEW IF EXISTS `vistapreguntas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistapreguntas` AS select `p`.`id_pregunta` AS `id_pregunta`,`p`.`categoria` AS `categoria`,`p`.`dificultad` AS `dificultad`,`p`.`contenido` AS `contenido`,`p`.`opcion_A` AS `opcion_A`,`p`.`opcion_B` AS `opcion_B`,`p`.`opcion_C` AS `opcion_C`,`p`.`opcion_D` AS `opcion_D`,`p`.`respuesta_correcta` AS `respuesta_correcta`,`p`.`habilitado` AS `habilitado`,`p`.`estado` AS `estado`,`p`.`cant_total_aciertos` AS `cant_total_aciertos`,`p`.`fecha` AS `fecha`,`u`.`nombre_usuario` AS `editor` from (`pregunta` `p` left join `usuario` `u` on((`p`.`id_editor` = `u`.`id_usuario`))) */;
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

-- Dump completed on 2024-10-27 15:28:46
