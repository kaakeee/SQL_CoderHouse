CREATE DATABASE IF NOT EXISTS  PYME_DROP_SHIPPING;
USE PYME_DROP_SHIPPING;
/*DER https://drive.google.com/file/d/1IAkyLe8vKdq37fqXS9MOKFmY8whUt86w/view?usp=sharing */
/* El trabajo final lo implemento en ingles, para que todo siga un mismo idioma*/
/* The final work is implemented in English, so that everything follows the same language */
/*creation of tables*/

CREATE TABLE IF NOT EXISTS Customers ( /* info the customer*/
customer_id int NOT NULL UNIQUE PRIMARY KEY,
first_name varchar(30) not null,
last_name varchar(30),
phone varchar(40), 
email varchar(50)
);

CREATE TABLE IF NOT EXISTS Supplier (  /* the supplier o shop*/
id_supplier INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
email varchar(50),     
phone varchar(40),
first_name varchar(30) not null

);

CREATE TABLE IF NOT EXISTS Products(  /*products of shop/stock*/
id_model INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_supplier INT NOT NULL,
category varchar(25),  
name varchar(50),
FOREIGN KEY (id_supplier) REFERENCES Supplier (id_supplier)
);

CREATE TABLE IF NOT EXISTS Orders ( /*orders of customers*/
id_order INT NOT NULL PRIMARY KEY,
amount DECIMAL(12,2),
id_model INT,
FOREIGN KEY (id_model) REFERENCES Products (id_model)
);

CREATE TABLE IF NOT EXISTS Billing (
id_billing INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
type varchar(10),
tax_number varchar(60),
total_purchase DECIMAL(12,2),
id_order INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Seller (
id_seller INT NOT NULL UNIQUE auto_increment PRIMARY KEY,
name varchar(30) not null,
phone varchar(40),
email varchar(50),
cbu VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS Commission (
id_billing INT NOT NULL,
id_seller INT NOT NULL,
condition_purchase int,
cbu VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS Shipments (
tracking_number VARCHAR(60) NOT NULL,
id_order INT,
address varchar(60),
country varchar(50),
condition_purchase int
);

/*insert test data*/
insert into Customers (customer_id, first_name, last_name, phone, email) 
values  
 ('1', 'Athena' , 'Haydn','7207130279', 'csoane0@census.gov'),
 ('2', 'Freida' , 'Knowlys', '9207130279', 'eheball1@oaic.gov.au'),
 ('3', 'Brook' , 'Boothebie', '607130279', 'csoane0@census.gov'),
 ('4', 'Hilario' , 'Morten', '1713552116', 'eheball1@oaic.gov.au'),
 ('5', 'Ronda' , 'Duetschens' , '7507130279', 'csoll0@census.gov'),
 ('6', 'Devora' ,'Voase' ,'17552116', 'eheball1@oaic.gov.au');
 
insert into Supplier  (id_supplier, email, phone, first_name) 
values 
 (1, 'gyashanovg@ft.com', '4931281133', 'Deal Extreme'),
 (2, 'jrobiouh@deviantart.com', '4089915295', 'Miner Shop'),
 (3, 'rcattermulli@yandex.ru', '7181423851', 'EshopPRO'),
 (4, 'dhuxhamj@guardian.co.uk', '6830856590', 'TitanXP');
 
insert into Products (id_model, id_supplier, category , name)
values
(1, 1, 'L','Mouse'),
 (2, 2, 'XS', 'Monitor_27'),
 (3, 3, 'M' , 'Pad'),
 (4, 4, 'L', 'Phone_S9' ),
 (5, 4, '2XL', 'Bottle_Furius'),
 (6, 3, 'L', 'CD_700Mb'),
 (7, 3, 'S', 'Rexona'),
 (8, 1, 'XL', 'Wired'),
 (9, 2, 'S','3D_printer_Generic'),
 (10, 3, 'XL','3D_printer_HellBot_SE'),
 (11, 2, 'S', 'Filament_1Kg'),
 (12, 2, 'XS', 'Filament_250gr'),
 (13, 2, 'S', 'PenDrive_1TB'),
 (14, 1, 'M', 'SSD_250Gb');
 
 insert into Orders (id_order, amount, id_model)
 values
(1, '34', 3),
(2, '3', 2),
(3, '45', 5),
(4, '348', 6),
(5, '52', 10),
(6, '38', 11),
(7, '50', 14),
(8, '35', 13),
(9, '49', 3),
(10, '7', 9);

insert into Billing (id_billing, type, tax_number, total_purchase, id_order)
values
(1, 'A', '543557846135_768', '45635', 1),
(2, 'B','5435546135_5478','857653' , 2),
(3, 'C','8769786135_5468', '5468541', 3),
(4, 'B','94613645_5498', '687923' ,4),
(5, 'B','543678135_5498', '86789' ,5),
(6, 'B','5435546135_5468', '689145', 6),
(7, 'B','5435366135_568', '6897987', 7),
(8, 'C','6546135_5468', '894123' , 8),
(9, 'A','6546135_5968', '89485987', 9),
(10, 'A','543035_5498', '9874213563' , 10);

insert into Seller (id_seller, name, phone, email, cbu)
values
(1, 'Ramiro_Sanabria', '1124836969', 'ramineu@hotmail.com' , 'ramiro.quiere.plata' ),
(2, 'Tirrin Push' , '11564987' , 'yatusabe@gmail.com' , '11357983879');

insert into Commission (id_billing, id_seller, condition_purchase, cbu)
values
(1, 1, 1, 'ramiro.quiere.plata'),
(2, 1, 0,'ramiro.quiere.plata'),
(3, 1, 2, 'ramiro.quiere.plata'),
(4, 2, 0, '11357983879'),
(5, 2, 1, '11357983879'),
(6, 2, 1, '11357983879'),
(7, 1, 2, 'ramiro.quiere.plata'),
(8, 2, 2, '11357983879'),
(9, 1, 2, 'ramiro.quiere.plata'),
(10, 2, 1, '11357983879');

insert into Shipments (tracking_number, id_order, address, country, condition_purchase)
values 
('60161235ff22ddccf0dfc28779c267e2db27b4b4', 1, '3 Commercial Parkway', 'China' , '1'),
('bee368c2ca3f79366e5e595c5cebc3dbd8e46f6a', 2, '15439 Burning Wood Street', 'Japan', '0'),
('fbf751cdda7abc283ca4e042a2f0c8231985c0ac', 3, '1157 Sloan Way', 'Finland', '2'),
('cc7762d77623dd8a5a94d52bfee5a615b006567d', 4, '007 Harbort Road', 'Indonesia', '0'),
('73f7f97e88e93dafeb1107513103f4a7c2e1171e', 5, '55923 Oxford Road', 'Sri Lanka', '1'),
('20b2f05efbb1719afda69f8419dc49afef950248', 6, '124 Butternut Place', 'China','1'),
('e586623001ecfe9396739a6ed615c0b00c9b999c', 7, '6985 Melody Point', 'China','2'),
('0fc4e9006a46255c3b4e064a8e00f8cc2f184b7b', 8, '45 Clarendon Pass', 'Indonesia','2'),
('deacfd6b00beea2fbb67e2c7a54abae8b02c7740', 9, '49150 Muir Lane', 'Mexico','2'),
('bdac11b1aa117086f7d9f6ef51283539accb093a', 10, '9 Duke Parkway', 'Solomon Islands','1');

