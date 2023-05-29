-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Restaurant` DEFAULT CHARACTER SET utf8 ;
USE `Restaurant` ;

-- -----------------------------------------------------
-- Table `Restaurant`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Freguesia` VARCHAR(45) NOT NULL,
  `Concelho` VARCHAR(45) NOT NULL,
  `CP` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Produto` (
  `idProduto` INT NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Validade` DATE NOT NULL,
  `Fornecedor` VARCHAR(45) NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`),
  INDEX `fk_Produto_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Restaurant`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Funcionario` (
  `idFuncionario` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Data Nacimento` DATE NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Freguesia` VARCHAR(45) NOT NULL,
  `Concelho` VARCHAR(45) NOT NULL,
  `CP` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Telefone_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Telefone_func` (
  `Telefone` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`Telefone`, `Funcionario_idFuncionario`),
  INDEX `fk_Telefone_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `Restaurant`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Mesa` (
  `idMesa` INT NOT NULL,
  `Capacidade` INT NOT NULL,
  PRIMARY KEY (`idMesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Mesa_idMesa` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Mesa_idx` (`Mesa_idMesa` ASC) VISIBLE,
  INDEX `fk_Pedido_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Mesa`
    FOREIGN KEY (`Mesa_idMesa`)
    REFERENCES `Restaurant`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `Restaurant`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Receita` (
  `idReceita` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idReceita`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Pedido_has_Receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Pedido_has_Receita` (
  `Pedido_idPedido` INT NOT NULL,
  `Receita_idReceita` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Receita_idReceita`),
  INDEX `fk_Pedido_has_Receita_Receita1_idx` (`Receita_idReceita` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Receita_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Receita_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Restaurant`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Receita_Receita1`
    FOREIGN KEY (`Receita_idReceita`)
    REFERENCES `Restaurant`.`Receita` (`idReceita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Receita_has_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Receita_has_Produto` (
  `Receita_idReceita` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Unidade Medida` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Receita_idReceita`, `Produto_idProduto`),
  INDEX `fk_Receita_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Receita_has_Produto_Receita1_idx` (`Receita_idReceita` ASC) VISIBLE,
  CONSTRAINT `fk_Receita_has_Produto_Receita1`
    FOREIGN KEY (`Receita_idReceita`)
    REFERENCES `Restaurant`.`Receita` (`idReceita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receita_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Restaurant`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`.`Telefone_forn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant`.`Telefone_forn` (
  `Telefone` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Telefone`, `Fornecedor_idFornecedor`),
  INDEX `fk_Telefone_forn_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_forn_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Restaurant`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
