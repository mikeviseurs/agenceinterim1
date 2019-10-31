-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 25 oct. 2019 à 06:28
-- Version du serveur :  5.7.26
-- Version de PHP :  7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `agenceinterim`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `idAdmin` int(11) NOT NULL AUTO_INCREMENT,
  `motDePasse` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAdmin`),
  UNIQUE KEY `idAdmin_UNIQUE` (`idAdmin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`idAdmin`, `motDePasse`) VALUES
(1, 'd033e22ae348aeb5660fc2140aec35850c4da997');

-- --------------------------------------------------------

--
-- Structure de la table `candidats`
--

DROP TABLE IF EXISTS `candidats`;
CREATE TABLE IF NOT EXISTS `candidats` (
  `idCandidat` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `motDePasse` varchar(45) NOT NULL,
  `adresse` varchar(150) DEFAULT NULL,
  `codePostal` varchar(5) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `dateNaissance` date DEFAULT NULL,
  `dateInscription` date DEFAULT NULL,
  `cv` tinyint(4) DEFAULT '0',
  `actif` tinyint(4) DEFAULT '1',
  `secteurActivite_idsecteurActivite` int(11) DEFAULT NULL,
  `experience_idexperience` int(11) DEFAULT NULL,
  `niveauEtudes_idniveauEtudes` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCandidat`),
  UNIQUE KEY `idCandidat_UNIQUE` (`idCandidat`),
  KEY `fk_Candidat_secteurActivite1_idx` (`secteurActivite_idsecteurActivite`),
  KEY `fk_Candidat_experience1_idx` (`experience_idexperience`),
  KEY `fk_Candidats_niveauEtudes1_idx` (`niveauEtudes_idniveauEtudes`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `candidats`
--

INSERT INTO `candidats` (`idCandidat`, `nom`, `prenom`, `motDePasse`, `adresse`, `codePostal`, `ville`, `email`, `tel`, `dateNaissance`, `dateInscription`, `cv`, `actif`, `secteurActivite_idsecteurActivite`, `experience_idexperience`, `niveauEtudes_idniveauEtudes`) VALUES
(6, 'Otto', 'Toto', 'd54b76b2bad9d9946011ebc62a1d272f4122c7b5', '6 rue de Toto', '59000', 'Lille', 'toto@email.fr', '0123456789', '1998-08-11', '2019-10-17', 0, 1, NULL, NULL, NULL),
(7, 'Dupont', 'Henri', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '111 rue de Paris', '59000', 'Lille', 'DupontHenri@email.com', '1123456789', '1962-09-11', '2019-10-23', 0, 1, 1708, 1, 8),
(8, 'Smith', 'John', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '77 rue de Lille', '75000', 'Paris', 'JSmith@email.com', '1234567990', '1995-11-05', '2019-10-23', 0, 1, NULL, NULL, NULL),
(9, 'Truc', 'Muche', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '5 rue machin', '62300', 'Lens', 'Trucmuche@email.fr', '9876523140', '2011-06-07', '2019-10-23', 0, 1, NULL, NULL, NULL),
(10, 'Valjean', 'Jean', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'qsqsdfqsds', '75000', 'Paris', 'Valjean@email.com', 'undefined', '1936-11-11', '2019-10-24', 0, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `competences`
--

DROP TABLE IF EXISTS `competences`;
CREATE TABLE IF NOT EXISTS `competences` (
  `idcompetences` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcompetences`),
  UNIQUE KEY `idcompetences_UNIQUE` (`idcompetences`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `competences`
--

INSERT INTO `competences` (`idcompetences`, `nom`) VALUES
(1, 'Capacité d’adaptation'),
(2, 'Gestion du stress'),
(3, 'Travail en équipe'),
(4, 'Capacité à fédérer'),
(5, 'Sens de la communication'),
(6, ' Capacité de décision'),
(7, ' Autonomie'),
(8, 'Sens de l’organisation'),
(9, 'Rigueur'),
(10, 'Curiosité');

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

DROP TABLE IF EXISTS `entreprises`;
CREATE TABLE IF NOT EXISTS `entreprises` (
  `idEntreprise` int(11) NOT NULL AUTO_INCREMENT,
  `siret` varchar(14) NOT NULL,
  `motDePasse` varchar(45) NOT NULL,
  `nomEntreprise` varchar(45) NOT NULL,
  `interlocuteur` varchar(45) DEFAULT NULL,
  `adresse` varchar(150) DEFAULT NULL,
  `codePostal` varchar(5) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `internet` varchar(150) DEFAULT NULL,
  `dateInscription` date DEFAULT NULL,
  `actif` tinyint(4) DEFAULT '1',
  `codeAPE` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`idEntreprise`),
  UNIQUE KEY `idEntreprise_UNIQUE` (`idEntreprise`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `entreprises`
--

INSERT INTO `entreprises` (`idEntreprise`, `siret`, `motDePasse`, `nomEntreprise`, `interlocuteur`, `adresse`, `codePostal`, `ville`, `email`, `tel`, `internet`, `dateInscription`, `actif`, `codeAPE`) VALUES
(1, '12345678901234', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Toto inc', 'Toto', '6 rue de Toto', '62200', 'Lens', 'toto@email.fr', '9876543210', NULL, '2019-10-17', 1, NULL),
(2, '98765432101234', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Arnaque Inc.', 'toto', '11 rue azer', '62300', 'Lens', 'arnaque@email.com', '8574963210', 'ttooto.com', '2019-10-23', 1, '1245d'),
(3, '74185296309876', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tartempion', 'Bidule', 'dfslksdfsdlfsdf', '59000', 'Lille', 'Tartempion@email.com', 'undefined', 'wwww.ahahaha.com', '2019-10-24', 1, '6547G');

-- --------------------------------------------------------

--
-- Structure de la table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
CREATE TABLE IF NOT EXISTS `experiences` (
  `idexperience` int(11) NOT NULL AUTO_INCREMENT,
  `interval` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idexperience`),
  UNIQUE KEY `idexperience_UNIQUE` (`idexperience`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `experiences`
--

INSERT INTO `experiences` (`idexperience`, `interval`) VALUES
(1, '- de 6 mois'),
(2, 'de 6 mois à 1 an'),
(3, '1 à 5 ans'),
(4, '5 à 10 ans'),
(5, '10 à 15 ans'),
(6, '15 ans et plus');

-- --------------------------------------------------------

--
-- Structure de la table `listecompetencescandidat`
--

DROP TABLE IF EXISTS `listecompetencescandidat`;
CREATE TABLE IF NOT EXISTS `listecompetencescandidat` (
  `Competences_idcompetences` int(11) NOT NULL,
  `Candidats_idCandidat` int(11) NOT NULL,
  PRIMARY KEY (`Competences_idcompetences`,`Candidats_idCandidat`),
  KEY `fk_Competences_has_Candidats_Candidats1_idx` (`Candidats_idCandidat`),
  KEY `fk_Competences_has_Candidats_Competences1_idx` (`Competences_idcompetences`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `listecompetencesdemandees`
--

DROP TABLE IF EXISTS `listecompetencesdemandees`;
CREATE TABLE IF NOT EXISTS `listecompetencesdemandees` (
  `Offres_idOffre` int(11) NOT NULL,
  `Competences_idcompetences` int(11) NOT NULL,
  PRIMARY KEY (`Offres_idOffre`,`Competences_idcompetences`),
  KEY `fk_Offres_has_Competences_Competences1_idx` (`Competences_idcompetences`),
  KEY `fk_Offres_has_Competences_Offres1_idx` (`Offres_idOffre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `niveauetudes`
--

DROP TABLE IF EXISTS `niveauetudes`;
CREATE TABLE IF NOT EXISTS `niveauetudes` (
  `idniveauEtudes` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idniveauEtudes`),
  UNIQUE KEY `idniveauEtudes_UNIQUE` (`idniveauEtudes`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `niveauetudes`
--

INSERT INTO `niveauetudes` (`idniveauEtudes`, `intitule`) VALUES
(1, 'sans diplôme'),
(2, 'CAP'),
(3, 'BEP'),
(4, 'BEPC'),
(5, 'BAC'),
(6, 'BAC+1'),
(7, 'BAC+2'),
(8, 'BAC+3'),
(9, 'BAC+4'),
(10, 'BAC+5'),
(11, 'BAC+6 ET PLUS');

-- --------------------------------------------------------

--
-- Structure de la table `offres`
--

DROP TABLE IF EXISTS `offres`;
CREATE TABLE IF NOT EXISTS `offres` (
  `idOffre` int(11) NOT NULL AUTO_INCREMENT,
  `titreOffre` varchar(45) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `actif` tinyint(4) DEFAULT '1',
  `dateCreation` datetime DEFAULT NULL,
  `Entreprise_idEntreprise` int(11) NOT NULL,
  `secteurActivite_idsecteurActivite` int(11) NOT NULL,
  `experience_idexperience` int(11) NOT NULL,
  `niveauEtudes_idniveauEtudes` int(11) NOT NULL,
  `Type_idType` int(11) NOT NULL,
  PRIMARY KEY (`idOffre`),
  UNIQUE KEY `idOffre_UNIQUE` (`idOffre`),
  KEY `fk_Offre_Entreprise_idx` (`Entreprise_idEntreprise`),
  KEY `fk_Offre_secteurActivite1_idx` (`secteurActivite_idsecteurActivite`),
  KEY `fk_Offre_experience1_idx` (`experience_idexperience`),
  KEY `fk_Offres_niveauEtudes1_idx` (`niveauEtudes_idniveauEtudes`),
  KEY `Type_idType` (`Type_idType`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `offres`
--

INSERT INTO `offres` (`idOffre`, `titreOffre`, `description`, `dateDebut`, `dateFin`, `actif`, `dateCreation`, `Entreprise_idEntreprise`, `secteurActivite_idsecteurActivite`, `experience_idexperience`, `niveauEtudes_idniveauEtudes`, `Type_idType`) VALUES
(2, 'travail de la mort', 'undefined', '2019-10-21', '2019-10-31', 1, '2019-10-18 11:00:00', 1, 1709, 2, 7, 1),
(3, 'un autre boulot', 'undefined', '2019-10-28', '2019-11-13', 1, '2019-10-18 09:00:00', 1, 1708, 4, 5, 1),
(4, 'un autre boulot', 'super bien payé c\'est sur', '2019-10-28', '2019-11-13', 1, '2019-10-18 13:00:00', 1, 1708, 4, 5, 2),
(5, 'Laveur de vitres', 'Laveur de vitres sur la tour Montparnasse à Paris', '2019-10-31', '2019-11-13', 1, '2019-10-24 09:40:18', 2, 1708, 1, 1, 2),
(6, 'Chirurgien cardiaque', 'kqsdlkqsdlqsls,cls,csd', '2019-10-30', '2019-11-06', 1, '2019-10-24 13:35:35', 2, 1713, 4, 11, 3),
(7, 'développeur WEB', 'sdfdfsdfs', '2019-10-31', '2020-02-13', 1, '2019-10-24 15:12:28', 2, 1710, 1, 7, 2),
(8, 'Formateur', 'Formateur pour le développent WEB', '2019-10-25', '2020-02-13', 1, '2019-10-24 16:07:35', 3, 1717, 2, 5, 3);

-- --------------------------------------------------------

--
-- Structure de la table `secteursactivite`
--

DROP TABLE IF EXISTS `secteursactivite`;
CREATE TABLE IF NOT EXISTS `secteursactivite` (
  `idsecteurActivite` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idsecteurActivite`),
  UNIQUE KEY `idsecteurActivite_UNIQUE` (`idsecteurActivite`)
) ENGINE=InnoDB AUTO_INCREMENT=1718 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `secteursactivite`
--

INSERT INTO `secteursactivite` (`idsecteurActivite`, `nom`, `image`) VALUES
(1708, 'Batiment', NULL),
(1709, 'Mécanique', NULL),
(1710, 'Informatique', 'icons8-informatique-100.png'),
(1711, 'Logistique', 'icons8-paramètres-de-la-boîte-96.png'),
(1712, 'Web', 'icons8-internet-100.png'),
(1713, 'Santé', 'icons8-santé-mentale-100.png'),
(1714, 'Commerce', 'icons8-e-commerce-160.png'),
(1715, 'Banque', 'icons8-banque-96.png'),
(1716, 'Espace vert', 'icons8-feuille-150.png'),
(1717, 'Education', 'icons8-université-100.png');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `idType` int(11) NOT NULL AUTO_INCREMENT,
  `nomType` varchar(50) NOT NULL,
  PRIMARY KEY (`idType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`idType`, `nomType`) VALUES
(1, 'Interim'),
(2, 'CDD'),
(3, 'CDI');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `candidats`
--
ALTER TABLE `candidats`
  ADD CONSTRAINT `fk_Candidat_experience1` FOREIGN KEY (`experience_idexperience`) REFERENCES `experiences` (`idexperience`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Candidat_secteurActivite1` FOREIGN KEY (`secteurActivite_idsecteurActivite`) REFERENCES `secteursactivite` (`idsecteurActivite`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Candidats_niveauEtudes1` FOREIGN KEY (`niveauEtudes_idniveauEtudes`) REFERENCES `niveauetudes` (`idniveauEtudes`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `listecompetencescandidat`
--
ALTER TABLE `listecompetencescandidat`
  ADD CONSTRAINT `fk_Competences_has_Candidats_Candidats1` FOREIGN KEY (`Candidats_idCandidat`) REFERENCES `candidats` (`idCandidat`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Competences_has_Candidats_Competences1` FOREIGN KEY (`Competences_idcompetences`) REFERENCES `competences` (`idcompetences`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `listecompetencesdemandees`
--
ALTER TABLE `listecompetencesdemandees`
  ADD CONSTRAINT `fk_Offres_has_Competences_Competences1` FOREIGN KEY (`Competences_idcompetences`) REFERENCES `competences` (`idcompetences`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Offres_has_Competences_Offres1` FOREIGN KEY (`Offres_idOffre`) REFERENCES `offres` (`idOffre`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `offres`
--
ALTER TABLE `offres`
  ADD CONSTRAINT `fk_Offre_Entreprise` FOREIGN KEY (`Entreprise_idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Offre_experience1` FOREIGN KEY (`experience_idexperience`) REFERENCES `experiences` (`idexperience`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Offre_secteurActivite1` FOREIGN KEY (`secteurActivite_idsecteurActivite`) REFERENCES `secteursactivite` (`idsecteurActivite`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Offres_niveauEtudes1` FOREIGN KEY (`niveauEtudes_idniveauEtudes`) REFERENCES `niveauetudes` (`idniveauEtudes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `offres_ibfk_1` FOREIGN KEY (`Type_idType`) REFERENCES `type` (`idType`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
