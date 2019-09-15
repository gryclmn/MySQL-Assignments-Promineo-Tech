CREATE DATABASE IF NOT EXISTS customers;
USE customers;

CREATE TABLE `Users` (
	`user_id` INT NOT NULL AUTO_INCREMENT,
	`username` varchar(255) NOT NULL UNIQUE,
	`email` varchar(255),
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`user_id`)
);

CREATE TABLE `Posts` (
	`post_id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`post` TEXT,
	PRIMARY KEY (`post_id`)
);

CREATE TABLE `Comments` (
	`comment_id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`post_id` INT NOT NULL,
	`comment` TEXT NOT NULL,
	PRIMARY KEY (`comment_id`)
);

ALTER TABLE `Posts` ADD CONSTRAINT `Posts_fk0` FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`);

ALTER TABLE `Comments` ADD CONSTRAINT `Comments_fk0` FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`);

ALTER TABLE `Comments` ADD CONSTRAINT `Comments_fk1` FOREIGN KEY (`post_id`) REFERENCES `Posts`(`post_id`);
