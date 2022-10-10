/*
TCL
id_billing INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
type varchar(10),
tax_number varchar(60),
total_purchase DECIMAL(12,2),
id_order INT NOT NULL,
FOREIGN KEY (id_order) REFERENCES Orders (id_order)
SELECT * FROM pyme_drop_shipping.billing;  
start transaction;                        #start mode secure
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (11, 'A', 9915, 8974, 1);
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (12, 'C', 648, 90789, 2);        #test data
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (13, 'B', 5486, 546984, 3);
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (14, 'B', 457568, 4569, 4);
savepoint billing_4;                      #1 savepoint
 
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (15, 'G', 98, 24289, 2);
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (16, 'A', 88, 289, 2);           #test data
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (17, 'C', 99, 76789, 2);
insert into billing (id_billing, type, tax_number, total_purchase, id_order) VALUES (18, 'C', 6998, 8964, 2);
savepoint billing_8;                      #2 savepoint
SELECT * FROM pyme_drop_shipping.billing;  #SHOW CHANGES
#RELEASE savepoint billing_4;             #delete 1 savapoint
   rollback;                                #null changes
   commit;                                  #apply changes


SELECT * FROM pyme_drop_shipping.new_orders;                    #sample before changes
start transaction;                                              #start "safe" mode
DELETE FROM pyme_drop_shipping.new_orders WHERE id_order = 11; 
DELETE FROM pyme_drop_shipping.new_orders WHERE id_order = 12;
DELETE FROM pyme_drop_shipping.new_orders WHERE id_order = 13;
DELETE FROM pyme_drop_shipping.new_orders WHERE id_order = 14;

SELECT * FROM pyme_drop_shipping.new_orders;                    #show changes
rollback;                                                       #null changes
commit;                                                         #apply changes


*/

/*
Users
*/

#CREATE USER 'Data_Analist'@'localhost' IDENTIFIED BY 'iLoveData32';
#CREATE USER 'IT'@'localhost' IDENTIFIED BY 'IamADM68k';                /*users and passwords*/
#CREATE USER 'Boss'@'localhost' IDENTIFIED BY 'MeGaPlusUwU+OwO';

#GRANT SELECT ON *.* TO 'Data_Analist'@'localhost';                     /*just read*/
#GRANT SELECT, UPDATE, INSERT ON *.* TO 'IT'@'localhost';               /*read, modify and create*/
#GRANT ALL ON *.* TO 'Boss'@'localhost';                               /*all grant*/

/* 
GRANT SELECT ON pyme_drop_shipping.billing TO 'Data_Analist'@'localhost';
DROP USER 'IT'@'localhost'; 
DROP USER 'Data_Analist'@'localhost'; 
DROP USER 'Boss'@'localhost';
DROP DATABASE pyme_drop_shipping;
ALTER USER 'Boss'@'localhost' identified by 'newpass,notsecure';
RENAME USER 'Boss'@'localhost' TO 'MegaBoss'@'localhost';

 */

#SELECT * FROM mysql.user WHERE user LIKE 'IT%';               /*to check your permissions*/
#SELECT * FROM mysql.user WHERE user LIKE 'Data_Analist%';   
#SELECT * FROM mysql.user WHERE user LIKE 'Boss%';  
