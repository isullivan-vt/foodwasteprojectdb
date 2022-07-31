-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema foodwastedb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema foodwastedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `foodwastedb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `foodwastedb` ;

-- -----------------------------------------------------
-- Table `foodwastedb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`user` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(64) NOT NULL,
  `user_email` VARCHAR(64) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `create_user_id` INT NULL DEFAULT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NULL DEFAULT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE,
  INDEX `user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  INDEX `user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  CONSTRAINT `user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`food_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`food_type` (
  `food_type_id` INT NOT NULL AUTO_INCREMENT,
  `food_type_description` VARCHAR(64) NOT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`food_type_id`),
  INDEX `food_type_user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  INDEX `food_type_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `food_type_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `food_type_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`unit_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`unit_type` (
  `unit_type_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `unit_type_description` VARCHAR(64) NOT NULL,
  `unit_type_abbreviation` VARCHAR(10) NOT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NOT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NOT NULL,
  `record_status` CHAR(1) NOT NULL,
  PRIMARY KEY (`unit_type_id`),
  INDEX `unit_type_user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  INDEX `unit_type_user_update_user_id_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `unit_type_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `unit_type_user_update_user_id`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`food` (
  `food_id` INT NOT NULL AUTO_INCREMENT,
  `food_description` VARCHAR(64) NOT NULL,
  `food_type_id` INT NOT NULL,
  `food_shelf_life_days` SMALLINT NULL DEFAULT NULL,
  `unit_type_id` SMALLINT NOT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`food_id`),
  INDEX `food_food_type_food_type_id_fk_idx` (`food_type_id` ASC) VISIBLE,
  INDEX `food_unit_unit_type_id_fk_idx` (`unit_type_id` ASC) VISIBLE,
  INDEX `food_user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  INDEX `food_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `food_food_type_food_type_id_fk`
    FOREIGN KEY (`food_type_id`)
    REFERENCES `foodwastedb`.`food_type` (`food_type_id`),
  CONSTRAINT `food_unit_unit_type_id_fk`
    FOREIGN KEY (`unit_type_id`)
    REFERENCES `foodwastedb`.`unit_type` (`unit_type_id`),
  CONSTRAINT `food_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `food_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`food_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`food_inventory` (
  `food_inventory_id` INT NOT NULL AUTO_INCREMENT,
  `food_id` INT NOT NULL,
  `food_quantity` DECIMAL(8,2) NULL DEFAULT NULL,
  `food_unit_id` INT NULL DEFAULT NULL,
  `food_acquisition_date` DATE NOT NULL,
  `food_cost_usd` DECIMAL(8,2) NULL DEFAULT NULL,
  `notes` VARCHAR(128) NULL DEFAULT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`food_inventory_id`),
  UNIQUE INDEX `food_inventory_id_UNIQUE` (`food_inventory_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`unit` (
  `unit_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `unit_description` VARCHAR(64) NOT NULL,
  `unit_abbreviation` VARCHAR(10) NOT NULL,
  `unit_type_id` SMALLINT NOT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NOT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NOT NULL,
  `record_status` CHAR(1) NOT NULL,
  PRIMARY KEY (`unit_id`),
  INDEX `unit_unti_type_unit_type_id_fk_idx` (`unit_type_id` ASC) VISIBLE,
  INDEX `unit_user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  INDEX `unit_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `unit_unti_type_unit_type_id_fk`
    FOREIGN KEY (`unit_type_id`)
    REFERENCES `foodwastedb`.`unit_type` (`unit_type_id`),
  CONSTRAINT `unit_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `unit_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`food_waste_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`food_waste_log` (
  `food_waste_log_id` INT NOT NULL AUTO_INCREMENT,
  `food_id` INT NOT NULL,
  `food_quantity` DECIMAL(8,2) NULL DEFAULT NULL,
  `food_quantity_unit_id` SMALLINT NULL DEFAULT NULL,
  `food_expiration_date` DATE NOT NULL,
  `food_cost_usd` DECIMAL(8,2) NULL DEFAULT NULL,
  `notes` VARCHAR(256) NULL DEFAULT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`food_waste_log_id`),
  UNIQUE INDEX `food_id_UNIQUE` (`food_id` ASC) VISIBLE,
  UNIQUE INDEX `food_expiration_date_UNIQUE` (`food_expiration_date` ASC) VISIBLE,
  UNIQUE INDEX `create_user_id_UNIQUE` (`create_user_id` ASC) VISIBLE,
  INDEX `food_waste_log_unit_unit_id_idx` (`food_quantity_unit_id` ASC) VISIBLE,
  INDEX `food_waste_log_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `food_waste_log_food_food_id_fk`
    FOREIGN KEY (`food_id`)
    REFERENCES `foodwastedb`.`food` (`food_id`),
  CONSTRAINT `food_waste_log_unit_unit_id_fk`
    FOREIGN KEY (`food_quantity_unit_id`)
    REFERENCES `foodwastedb`.`unit` (`unit_id`),
  CONSTRAINT `food_waste_log_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `food_waste_log_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`hibernate_sequence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`hibernate_sequence` (
  `next_val` BIGINT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`meal_calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`meal_calendar` (
  `meal_calendar_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_id` INT NULL DEFAULT NULL,
  `meal_date` DATE NULL DEFAULT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`meal_calendar_id`),
  UNIQUE INDEX `meal_calendar_id_UNIQUE` (`meal_calendar_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`recipe_header`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`recipe_header` (
  `recipe_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_name` VARCHAR(64) NOT NULL,
  `recipe_content` VARCHAR(2048) NULL DEFAULT NULL,
  `recipe_user_notes` VARCHAR(256) NULL DEFAULT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NOT NULL,
  PRIMARY KEY (`recipe_id`),
  UNIQUE INDEX `recipe_name_UNIQUE` (`recipe_name` ASC) VISIBLE,
  UNIQUE INDEX `create_user_id_UNIQUE` (`create_user_id` ASC) VISIBLE,
  INDEX `recipe_header_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `recipe_header_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `recipe_header_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `foodwastedb`.`recipe_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`recipe_detail` (
  `recipe_detail_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_id` INT NOT NULL,
  `food_id` INT NOT NULL,
  `food_quantity` DECIMAL(8,2) NULL DEFAULT NULL,
  `food_quantity_unit_id` SMALLINT NULL DEFAULT NULL,
  `create_user_id` INT NOT NULL,
  `create_timestamp` DATETIME NULL DEFAULT NULL,
  `update_user_id` INT NOT NULL,
  `update_timestamp` DATETIME NULL DEFAULT NULL,
  `record_status` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`recipe_detail_id`),
  INDEX `recipe_detail_recipe_header_recipe_id_fk_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `recipe_detail_food_food_id_fk_idx` (`food_id` ASC) VISIBLE,
  INDEX `recipe_detail_unit_food_quantity_unit_id_fk_idx` (`food_quantity_unit_id` ASC) VISIBLE,
  INDEX `recipe_detail_user_create_user_id_fk_idx` (`create_user_id` ASC) VISIBLE,
  INDEX `recipe_detail_user_update_user_id_fk_idx` (`update_user_id` ASC) VISIBLE,
  CONSTRAINT `recipe_detail_food_food_id_fk`
    FOREIGN KEY (`food_id`)
    REFERENCES `foodwastedb`.`food` (`food_id`),
  CONSTRAINT `recipe_detail_recipe_header_recipe_id_fk`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `foodwastedb`.`recipe_header` (`recipe_id`),
  CONSTRAINT `recipe_detail_unit_food_quantity_unit_id_fk`
    FOREIGN KEY (`food_quantity_unit_id`)
    REFERENCES `foodwastedb`.`unit` (`unit_id`),
  CONSTRAINT `recipe_detail_user_create_user_id_fk`
    FOREIGN KEY (`create_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`),
  CONSTRAINT `recipe_detail_user_update_user_id_fk`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `foodwastedb`.`user` (`userid`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `foodwastedb` ;

-- -----------------------------------------------------
-- Placeholder table for view `foodwastedb`.`meal_planner_v`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`meal_planner_v` (`recipe_id` INT, `recipe_name` INT, `ingredient_count` INT, `recipe_content` INT);

-- -----------------------------------------------------
-- Placeholder table for view `foodwastedb`.`recipe_window_v`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`recipe_window_v` (`recipe_id` INT, `food_quantity` INT, `unit_description` INT, `food_description` INT, `exists_in_inventory` INT, `expiration_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `foodwastedb`.`shopping_list_v`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodwastedb`.`shopping_list_v` (`food_inventory_id` INT, `food_id` INT, `food_description` INT, `food_type_id` INT, `food_type_description` INT, `food_quantity` INT, `unit_id` INT, `unit_abbreviation` INT, `food_cost` INT, `expiration_date` INT, `food_acquisition_date` INT, `status` INT);

-- -----------------------------------------------------
-- procedure authenticate_user
-- -----------------------------------------------------

DELIMITER $$
USE `foodwastedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `authenticate_user`(IN userEmail VARCHAR(64), IN password VARCHAR(45), OUT user_code INT)
BEGIN
SELECT u.userid into user_code
FROM user u
WHERE userEmail = u.user_email AND password = u.password;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `foodwastedb`.`meal_planner_v`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodwastedb`.`meal_planner_v`;
USE `foodwastedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `foodwastedb`.`meal_planner_v` AS select `rh`.`recipe_id` AS `recipe_id`,`rh`.`recipe_name` AS `recipe_name`,count(`rd`.`recipe_detail_id`) AS `ingredient_count`,`rh`.`recipe_content` AS `recipe_content` from (`foodwastedb`.`recipe_header` `rh` join `foodwastedb`.`recipe_detail` `rd` on((`rh`.`recipe_id` = `rd`.`recipe_id`))) where (`rh`.`record_status` = 'A') group by `rh`.`recipe_id`;

-- -----------------------------------------------------
-- View `foodwastedb`.`recipe_window_v`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodwastedb`.`recipe_window_v`;
USE `foodwastedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `foodwastedb`.`recipe_window_v` AS select `foodwastedb`.`recipe_detail`.`recipe_id` AS `recipe_id`,`foodwastedb`.`recipe_detail`.`food_quantity` AS `food_quantity`,`foodwastedb`.`unit`.`unit_description` AS `unit_description`,`foodwastedb`.`food`.`food_description` AS `food_description`,(case when (`food_inventory`.`expiration_date` is null) then 'n' else 'y' end) AS `exists_in_inventory`,`food_inventory`.`expiration_date` AS `expiration_date` from (((`foodwastedb`.`recipe_detail` join `foodwastedb`.`food` on((`foodwastedb`.`food`.`food_id` = `foodwastedb`.`recipe_detail`.`food_id`))) join `foodwastedb`.`unit` on((`foodwastedb`.`unit`.`unit_id` = `foodwastedb`.`recipe_detail`.`food_id`))) left join (select `foodwastedb`.`shopping_list_v`.`food_id` AS `food_id`,max(`foodwastedb`.`shopping_list_v`.`expiration_date`) AS `expiration_date` from `foodwastedb`.`shopping_list_v` where (`foodwastedb`.`shopping_list_v`.`status` = 'A') group by `foodwastedb`.`shopping_list_v`.`food_id`) `food_inventory` on((`food_inventory`.`food_id` = `foodwastedb`.`recipe_detail`.`food_id`)));

-- -----------------------------------------------------
-- View `foodwastedb`.`shopping_list_v`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodwastedb`.`shopping_list_v`;
USE `foodwastedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `foodwastedb`.`shopping_list_v` AS select `foodwastedb`.`food_inventory`.`food_inventory_id` AS `food_inventory_id`,`foodwastedb`.`food`.`food_id` AS `food_id`,`foodwastedb`.`food`.`food_description` AS `food_description`,`foodwastedb`.`food`.`food_type_id` AS `food_type_id`,`foodwastedb`.`food_type`.`food_type_description` AS `food_type_description`,`foodwastedb`.`food_inventory`.`food_quantity` AS `food_quantity`,`foodwastedb`.`unit`.`unit_id` AS `unit_id`,`foodwastedb`.`unit`.`unit_abbreviation` AS `unit_abbreviation`,`foodwastedb`.`food_inventory`.`food_cost_usd` AS `food_cost`,(`foodwastedb`.`food_inventory`.`food_acquisition_date` + interval `foodwastedb`.`food`.`food_shelf_life_days` day) AS `expiration_date`,`foodwastedb`.`food_inventory`.`food_acquisition_date` AS `food_acquisition_date`,`foodwastedb`.`food_inventory`.`record_status` AS `status` from (((`foodwastedb`.`food_inventory` join `foodwastedb`.`food` on((`foodwastedb`.`food_inventory`.`food_id` = `foodwastedb`.`food`.`food_id`))) join `foodwastedb`.`food_type` on((`foodwastedb`.`food`.`food_type_id` = `foodwastedb`.`food_type`.`food_type_id`))) join `foodwastedb`.`unit` on((`foodwastedb`.`unit`.`unit_id` = `foodwastedb`.`food_inventory`.`food_unit_id`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
