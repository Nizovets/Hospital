-- MySQL Script generated by MySQL Workbench
-- 01/08/19 00:11:41
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hospital` ;

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`patients` ;

CREATE TABLE IF NOT EXISTS `hospital`.`patients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`staff` ;

CREATE TABLE IF NOT EXISTS `hospital`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL,
  `role` ENUM('DOCTOR', 'NURSE') NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`diagnosis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`diagnosis` ;

CREATE TABLE IF NOT EXISTS `hospital`.`diagnosis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`diagnosis_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`diagnosis_history` ;

CREATE TABLE IF NOT EXISTS `hospital`.`diagnosis_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diagnosis_date` DATETIME NOT NULL,
  `patient_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  `diagnosis_id` INT NOT NULL,
  `type` ENUM('PRIMARY', 'FINAL') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_patients_idx` (`patient_id` ASC),
  INDEX `fk_staff_idx` (`staff_id` ASC),
  INDEX `fk_diagnosis_idx` (`diagnosis_id` ASC),
  CONSTRAINT `fk_patients`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `hospital`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diagnosis`
    FOREIGN KEY (`diagnosis_id`)
    REFERENCES `hospital`.`diagnosis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`drugs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`drugs` ;

CREATE TABLE IF NOT EXISTS `hospital`.`drugs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`procedures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`procedures` ;

CREATE TABLE IF NOT EXISTS `hospital`.`procedures` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`surgeries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`surgeries` ;

CREATE TABLE IF NOT EXISTS `hospital`.`surgeries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`assignations_drugs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`assignations_drugs` ;

CREATE TABLE IF NOT EXISTS `hospital`.`assignations_drugs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diagnosis_history_id` INT NOT NULL,
  `drug_id` INT NOT NULL,
  `num_units` INT NOT NULL,
  `num_times` INT NOT NULL,
  `num_days` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_drugs_idx` (`drug_id` ASC),
  INDEX `fk_diagnosis_history_idx` (`diagnosis_history_id` ASC),
  CONSTRAINT `fk_drug`
    FOREIGN KEY (`drug_id`)
    REFERENCES `hospital`.`drugs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_diagnosis_history`
    FOREIGN KEY (`diagnosis_history_id`)
    REFERENCES `hospital`.`diagnosis_history` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`assignations_procedures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`assignations_procedures` ;

CREATE TABLE IF NOT EXISTS `hospital`.`assignations_procedures` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diagnosis_history_id` INT NOT NULL,
  `procedure_id` INT NOT NULL,
  `num_days` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_procedure_idx` (`procedure_id` ASC),
  INDEX `fk_diagnosis_history_idx` (`diagnosis_history_id` ASC),
  CONSTRAINT `fk_procedure`
    FOREIGN KEY (`procedure_id`)
    REFERENCES `hospital`.`procedures` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_procedure_diagnosis_history`
    FOREIGN KEY (`diagnosis_history_id`)
    REFERENCES `hospital`.`diagnosis_history` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`assignations_surgeries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`assignations_surgeries` ;

CREATE TABLE IF NOT EXISTS `hospital`.`assignations_surgeries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diagnosis_history_id` INT NOT NULL,
  `surgery_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surgery_idx` (`surgery_id` ASC),
  INDEX `fk_diagnosis_history_idx` (`diagnosis_history_id` ASC),
  CONSTRAINT `fk_surgery`
    FOREIGN KEY (`surgery_id`)
    REFERENCES `hospital`.`surgeries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surgery_diagnosis_history`
    FOREIGN KEY (`diagnosis_history_id`)
    REFERENCES `hospital`.`diagnosis_history` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hospital`.`patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`patients` (`id`, `lastname`, `firstname`, `surname`) VALUES (DEFAULT, 'Лазоренко', 'Дмитро', 'Валерійович');
INSERT INTO `hospital`.`patients` (`id`, `lastname`, `firstname`, `surname`) VALUES (DEFAULT, 'Гайдамака', 'Юлія', 'Володимирівнаа');
INSERT INTO `hospital`.`patients` (`id`, `lastname`, `firstname`, `surname`) VALUES (DEFAULT, 'Єршов', 'Григорій', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`staff` (`id`, `lastname`, `firstname`, `surname`, `role`, `email`, `password`) VALUES (DEFAULT, 'Єрьомін', 'Олександр', 'Данилович', 'DOCTOR', 'doctor@i.ua', 'doctor');
INSERT INTO `hospital`.`staff` (`id`, `lastname`, `firstname`, `surname`, `role`, `email`, `password`) VALUES (DEFAULT, 'Павленко', 'Інна', NULL, 'NURSE', 'nurse@i.ua', 'nurse');
INSERT INTO `hospital`.`staff` (`id`, `lastname`, `firstname`, `surname`, `role`, `email`, `password`) VALUES (DEFAULT, 'Док', 'Док', 'Док', 'DOCTOR', 'd', 'd');
INSERT INTO `hospital`.`staff` (`id`, `lastname`, `firstname`, `surname`, `role`, `email`, `password`) VALUES (DEFAULT, 'мс', 'мс', 'мс', 'NURSE', 'n', 'n');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`diagnosis`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Аппендицит');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Ангина');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Отит');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'ОРЗ');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'ОРВИ');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Скарлатина');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Свинка');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Аллергия');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Ринит');
INSERT INTO `hospital`.`diagnosis` (`id`, `name`) VALUES (DEFAULT, 'Ветрянка');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`diagnosis_history`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/8/12', 2, 2, 3, 'PRIMARY');
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/8/15', 2, 1, 3, 'FINAL');
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/12/4', 1, 1, 5, 'PRIMARY');
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/1/4', 3, 1, 4, 'PRIMARY');
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/1/30', 3, 2, 8, 'FINAL');
INSERT INTO `hospital`.`diagnosis_history` (`id`, `diagnosis_date`, `patient_id`, `staff_id`, `diagnosis_id`, `type`) VALUES (DEFAULT, '2016/10/18', 2, 2, 1, 'PRIMARY');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`drugs`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Но-шпа');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Анальгин');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Аспирин');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Эритромицин');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Фукорцин');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Лидокаин');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Аммиак');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Витамин C');
INSERT INTO `hospital`.`drugs` (`id`, `name`) VALUES (DEFAULT, 'Називин');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`procedures`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'Кварц');
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'Ингаляции');
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'Велоренажер');
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'Электрофарез');
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'ЛФК');
INSERT INTO `hospital`.`procedures` (`id`, `name`) VALUES (DEFAULT, 'Массаж');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`surgeries`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Миотомия');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Ринопластика');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Имплантация');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Удаление зуба');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Ампутация');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Резекция');
INSERT INTO `hospital`.`surgeries` (`id`, `name`) VALUES (DEFAULT, 'Стомия');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`assignations_drugs`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 6, 6, 1, 3, 5);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 4, 3, 2, 1, 10);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 4, 1, 1, 2, 1);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 6, 5, 2, 1, 4);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 6, 3, 4, 2, 3);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 4, 2, 1, 2, 7);
INSERT INTO `hospital`.`assignations_drugs` (`id`, `diagnosis_history_id`, `drug_id`, `num_units`, `num_times`, `num_days`) VALUES (DEFAULT, 6, 4, 2, 1, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`assignations_procedures`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`assignations_procedures` (`id`, `diagnosis_history_id`, `procedure_id`, `num_days`) VALUES (DEFAULT, 1, 5, 30);
INSERT INTO `hospital`.`assignations_procedures` (`id`, `diagnosis_history_id`, `procedure_id`, `num_days`) VALUES (DEFAULT, 4, 1, 7);
INSERT INTO `hospital`.`assignations_procedures` (`id`, `diagnosis_history_id`, `procedure_id`, `num_days`) VALUES (DEFAULT, 4, 2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`assignations_surgeries`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`assignations_surgeries` (`id`, `diagnosis_history_id`, `surgery_id`) VALUES (DEFAULT, 1, 7);

COMMIT;

