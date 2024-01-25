-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `ID_medical` INT NOT NULL,
  `Overtime_rate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_medical`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `ID_doctor` INT NOT NULL,
  `Name_doctor` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATETIME NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` INT NOT NULL,
  `Medical_ID_medical` INT NOT NULL,
  PRIMARY KEY (`ID_doctor`),
  INDEX `fk_Doctor_Medical1_idx` (`Medical_ID_medical` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical1`
    FOREIGN KEY (`Medical_ID_medical`)
    REFERENCES `mydb`.`Medical` (`ID_medical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `id_specialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_specialist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` MEDIUMTEXT NOT NULL,
  `Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `id_Patient` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` INT(10) NOT NULL,
  `date_of_birth` DATETIME NOT NULL,
  `Doctor_ID_doctor` INT NOT NULL,
  `Specialist_id_specialist` INT NOT NULL,
  `Payment_idPayment` INT NOT NULL,
  PRIMARY KEY (`id_Patient`),
  INDEX `fk_patient_Doctor1_idx` (`Doctor_ID_doctor` ASC) VISIBLE,
  INDEX `fk_patient_Specialist1_idx` (`Specialist_id_specialist` ASC) VISIBLE,
  INDEX `fk_patient_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_patient_Doctor1`
    FOREIGN KEY (`Doctor_ID_doctor`)
    REFERENCES `mydb`.`Doctor` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_Specialist1`
    FOREIGN KEY (`Specialist_id_specialist`)
    REFERENCES `mydb`.`Specialist` (`id_specialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`appointment` (
  `date` DATETIME NOT NULL,
  `time` TIME NOT NULL,
  `patient_id_Patient` INT NOT NULL,
  `Doctor_ID_doctor` INT NOT NULL,
  INDEX `fk_appointment_patient1_idx` (`patient_id_Patient` ASC) VISIBLE,
  INDEX `fk_appointment_Doctor1_idx` (`Doctor_ID_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`patient_id_Patient`)
    REFERENCES `mydb`.`patient` (`id_Patient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_Doctor1`
    FOREIGN KEY (`Doctor_ID_doctor`)
    REFERENCES `mydb`.`Doctor` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Total` INT NOT NULL,
  PRIMARY KEY (`Total`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_idPayment` INT NOT NULL,
  `Bill_Total` INT NOT NULL,
  PRIMARY KEY (`Payment_idPayment`, `Bill_Total`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_Total` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_Total`)
    REFERENCES `mydb`.`Bill` (`Total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
