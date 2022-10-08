/*
Store Procedure

in the column field put some column from the orders table, and set the order_by form, ie 'ASC' or 'DESC'

*/
DELIMITER //
CREATE PROCEDURE `search_Orders` (IN column_a VARCHAR(20), IN order_by VARCHAR(4))
BEGIN
/*here between the desired column to be able to search for that*/
IF column_a <> '' THEN
	SET @colum = CONCAT('ORDER BY ', column_a);
ELSE 
	SET @colum = ''; 
END IF;

/*here term as entered in column*/
SET @result = CONCAT('SELECT * FROM PYME_DROP_SHIPPING.Orders ', @colum);


/*here enter the desc or asc to order*/
IF order_by <> '' THEN
	SET @orderby = CONCAT(@result,' ', order_by);
else
	SET @orderby = CONCAT(@result);
END IF;

/*here between the final concatenation with all the query made*/
SET @result_final = CONCAT(@orderby);

/*the below simply prepares from procedure to a query for sql*/
PREPARE querySQL FROM @result_final;  
EXECUTE querySQL;                  
DEALLOCATE PREPARE querySQL;       
END //


/*this other SP creates a provider with the 3 data, the first is INT and the rest is varchar */

DELIMITER //
CREATE PROCEDURE `create_supplier`(IN id_supplier INT, IN email VARCHAR(50), IN phone VARCHAR(40), IN first_name VARCHAR(30))
BEGIN
/*here he assured me that the number will be bigger*/
SET @max = concat('select MAX(ID_supplier) FROM PYME_DROP_SHIPPING.Supplier');
/*data enters here*/
IF id_supplier > @max THEN
	/* concatenate to enter the data*/
	SET @dat = CONCAT('insert into PYME_DROP_SHIPPING.supplier (id_supplier, email, phone, first_name) values (" ', id_supplier, ' ", ' , ' " ', email,' ", ' , ' " ', phone,' " , ', ' " ', first_name,' ")');  
ELSE   
	SET @dat = '';
END IF;

/*the below simply prepares from procedure to a query for sql*/
PREPARE resultSQL FROM @dat;   
EXECUTE resultSQL;                 
DEALLOCATE PREPARE resultSQL;        

END //


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

/*
Triggers
*/

/*I create tables to have a follow-up with the triggers*/
/*log table of new invoices with their amounts and users who created the table and modifications*/


CREATE TRIGGER tr_billing
AFTER update ON billing                                         /*who do you expect to be updated to shoot*/
FOR EACH ROW                                                   /*This means that for each row that the trigger updates, it acts*/
INSERT INTO old_billing (id_billing, tax_number, total_purchase, id_order, user, date_hour)  /*copy*/
VALUES (old.id_billing, old.tax_number, old.total_purchase, old.id_order, session_user(), current_timestamp());   /*original*/


/*this table is in charge of seeing who enters the new orders and who does it*/

CREATE TRIGGER tr_orders
BEFORE INSERT on orders
FOR EACH ROW
INSERT INTO new_orders (id_order, amount, user, date_hour)   
VALUES (NEW.id_order, NEW.amount, session_user(), current_timestamp());  

 
/*
DROP TRIGGER tr_billing;
DROP TRIGGEr tr_orders; 
DROP DATABASE pyme_drop_shipping;
*/

/* example values */


UPDATE pyme_drop_shipping.billing SET total_purchase = '9' WHERE (id_billing = '1');
UPDATE pyme_drop_shipping.billing SET total_purchase = '999' WHERE (id_billing = '2');
UPDATE pyme_drop_shipping.billing SET total_purchase = '999' WHERE (id_billing = '3');

insert into Orders (id_order, amount, id_model, customer_id)
 values
(11, '94', 5, 1),
(12, '35', 2, 3),
(13, '84', 6, 4),
(14, '62', 2, 5),
(15, '37', 9, 2),
(16, '74', 1, 1);

/*verify that the triggers work*/
SELECT * FROM old_billing;
SELECT * FROM new_orders;

/*

Funcions

*/

/*search tracking number with id_order*/

DELIMITER //
CREATE FUNCTION Search_Tracking_number(id1_order INT)
RETURNS varchar(90)
DETERMINISTIC
BEGIN
DECLARE number_order VARCHAR(90);
SET number_order = '';
SELECT tracking_number INTO number_order
FROM shipments
WHERE id1_order = id_order;

RETURN number_order;
END //
select pyme_drop_shipping.Search_Tracking_number(3);


/*calculate the tax*/

DELIMITER //
Create FUNCTION Calculate_tax(o1rder INT) 
RETURNS decimal(20,3)
DETERMINISTIC
BEGIN

    DECLARE result DECIMAL(15,2);
    DECLARE tax DECIMAL(15,2);
    DECLARE tax_total DECIMAL(15,2);
    SET tax = 0.21;                       /*0.21 only tax or 1.21 tax + purchase*/
   

    SELECT total_purchase INTO tax_total
    FROM billing
    WHERE o1rder = id_order;
    
    SET result = tax_total * tax;


    RETURN result;
END //

select pyme_drop_shipping.Calculate_tax(2);

/*

TCL

*/

/*
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
