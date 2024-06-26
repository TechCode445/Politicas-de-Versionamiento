-- MySQL Script generated by MySQL Workbench
-- Sun Feb 18 13:39:29 2024
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRol`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `idRol_UNIQUE` (`idRol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `phoneNumber` VARCHAR(15) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `Rol_idRol`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_Usuario_Rol_idx` (`Rol_idRol` ASC) VISIBLE,
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `mydb`.`Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `caNombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCategoria`),
  UNIQUE INDEX `idCategoria_UNIQUE` (`idCategoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `prNombre` VARCHAR(50) NOT NULL,
  `prCantidad` INT NOT NULL,
  `prCosto` DOUBLE NULL,
  `prDescripcion` VARCHAR(255) NULL,
  `prImagen` LONGBLOB NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `prPrecio` FLOAT NOT NULL,
  PRIMARY KEY (`idProducto`, `Categoria_idCategoria`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_has_Producto` (
  `Usuario_idUsuario` INT NOT NULL,
  `Usuario_Rol_idRol` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`, `Usuario_Rol_idRol`, `Producto_idProducto`),
  INDEX `fk_Usuario_has_Producto_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Producto_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Producto_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Rol_idRol`)
    REFERENCES `mydb`.`Usuario` (`idUsuario` , `Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Producto_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrito` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `carFecha` DATE NOT NULL,
  `Total` FLOAT NOT NULL,
  PRIMARY KEY (`idCarrito`),
  UNIQUE INDEX `idCarrito_UNIQUE` (`idCarrito` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto_has_Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto_has_Carrito` (
  `Producto_idProducto` INT NOT NULL AUTO_INCREMENT,
  `Producto_Categoria_idCategoria` INT NOT NULL,
  `Carrito_idCarrito` INT NOT NULL,
  `prVendidos` INT NOT NULL,
  PRIMARY KEY (`Producto_idProducto`, `Producto_Categoria_idCategoria`, `Carrito_idCarrito`),
  INDEX `fk_Producto_has_Carrito_Carrito1_idx` (`Carrito_idCarrito` ASC) VISIBLE,
  INDEX `fk_Producto_has_Carrito_Producto1_idx` (`Producto_idProducto` ASC, `Producto_Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_has_Carrito_Producto1`
    FOREIGN KEY (`Producto_idProducto` , `Producto_Categoria_idCategoria`)
    REFERENCES `mydb`.`Producto` (`idProducto` , `Categoria_idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Carrito_Carrito1`
    FOREIGN KEY (`Carrito_idCarrito`)
    REFERENCES `mydb`.`Carrito` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
