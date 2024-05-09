-- MySQL Script generated by MySQL Workbench
-- Tue Feb 13 22:30:22 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema easyshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema easyshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `easyshop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `easyshop` ;

-- -----------------------------------------------------
-- Table `easyshop`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`usuario` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `phoneNumber` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(50) NOT NULL,
  `rol_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  INDEX `rol_id` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `usuario_ibfk_1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `easyshop`.`rol` (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `cliente_ibfk_1` (`username` ASC) VISIBLE,
  CONSTRAINT `cliente_ibfk_1`
    FOREIGN KEY (`username`)
    REFERENCES `easyshop`.`usuario` (`username`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DOUBLE NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `imagen` LONGBLOB NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`carrito` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NULL DEFAULT NULL,
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`idCarrito`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  INDEX `carrito_ibfk_2` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `carrito_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `easyshop`.`cliente` (`cliente_id`),
  CONSTRAINT `carrito_ibfk_2`
    FOREIGN KEY (`producto_id`)
    REFERENCES `easyshop`.`producto` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`inventario` (
  `inventario_id` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `cantidad_disponible` INT NOT NULL,
  PRIMARY KEY (`inventario_id`),
  INDEX `inventario_ibfk_1` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `inventario_ibfk_1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `easyshop`.`producto` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `easyshop`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easyshop`.`venta` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `comprador_id` INT NULL DEFAULT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `comprador_id` (`comprador_id` ASC) VISIBLE,
  INDEX `venta_ibfk_2` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `venta_ibfk_1`
    FOREIGN KEY (`comprador_id`)
    REFERENCES `easyshop`.`cliente` (`cliente_id`),
  CONSTRAINT `venta_ibfk_2`
    FOREIGN KEY (`producto_id`)
    REFERENCES `easyshop`.`producto` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
