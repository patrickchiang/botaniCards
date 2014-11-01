DROP DATABASE IF EXISTS botanicards;

CREATE DATABASE botanicards;

USE botanicards;

CREATE TABLE users
(
user_id int NOT NULL AUTO_INCREMENT,
device_id varchar(512) NOT NULL,
sharing_flag int NOT NULL,
PRIMARY KEY (user_id)
);

CREATE TABLE common_names
(
common_name_id int NOT NULL AUTO_INCREMENT,
common_name varchar(512) NOT NULL,
PRIMARY KEY (common_name_id)
);

CREATE TABLE scientific_names
(
scientific_name_id int NOT NULL AUTO_INCREMENT,
scientific_name varchar(512) NOT NULL,
scientific_name_family varchar(512),
scientific_name_species varchar(512),
scientific_name_infraspecies varchar(512),
PRIMARY KEY (scientific_name_id)
);

CREATE TABLE locations
(
location_id int NOT NULL AUTO_INCREMENT,
location_latitude varchar(128) NOT NULL,
location_longitude varchar(128) NOT NULL,
location_altitude varchar(128) NOT NULL,
PRIMARY KEY (location_id)
);

CREATE TABLE photos
(
photo_id int NOT NULL AUTO_INCREMENT,
photo_caption varchar(512) NOT NULL,
photo_desc varchar(512) NOT NULL,
photo_url varchar(512) NOT NULL,
location_id int,
owner_card_id int NOT NULL,
create_time datetime NOT NULL,
sharing_flag int NOT NULL,
PRIMARY KEY (photo_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id),
FOREIGN KEY (owner_card_id) REFERENCES users(user_id)
);

CREATE TABLE decks
(
deck_id int NOT NULL AUTO_INCREMENT,
deck_name varchar(512) NOT NULL,
deck_desc varchar(512) NOT NULL,
owner_id int NOT NULL,
create_time datetime NOT NULL,
modify_time datetime NOT NULL,
sharing_flag int NOT NULL,
PRIMARY KEY (deck_id),
FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

CREATE TABLE cards
(
card_id int NOT NULL AUTO_INCREMENT,
card_notes varchar(2048),
scientific_name_id int NOT NULL,
common_name_id int NOT NULL,
deck_id int NOT NULL,
location_id int,
create_time datetime NOT NULL,
modify_time datetime NOT NULL,
sharing_flag int NOT NULL,
PRIMARY KEY (card_id),
FOREIGN KEY (deck_id) REFERENCES decks(deck_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id),
FOREIGN KEY (common_name_id) REFERENCES common_names(common_name_id),
FOREIGN KEY (scientific_name_id) REFERENCES scientific_names(scientific_name_id)
);

CREATE TABLE cards_decks
(
deck_id int NOT NULL,
card_id int NOT NULL,
PRIMARY KEY (deck_id, card_id),
FOREIGN KEY (deck_id) REFERENCES decks(deck_id),
FOREIGN KEY (card_id) REFERENCES cards(card_id)
);