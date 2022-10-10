/*
Triggers
I create tables to have a follow-up with the triggers
log table of new invoices with their amounts and users who created the table and modifications*/

CREATE TRIGGER tr_billing 
AFTER update ON billing                       
FOR EACH ROW
INSERT INTO old_billing (id_billing, tax_number, total_purchase, id_order, user, date_hour)  
VALUES (old.id_billing, old.tax_number, old.total_purchase, old.id_order, session_user(), current_timestamp());  


/*this table is in charge of seeing who enters the new orders and who does it*/

CREATE TRIGGER tr_orders
BEFORE INSERT on orders
FOR EACH ROW
INSERT INTO new_orders (id_order, amount, user, date_hour)   
VALUES (NEW.id_order, NEW.amount, session_user(), current_timestamp());

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

Funcions

search tracking number with id_order*/

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


DELIMITER //
/*calculate the tax*/
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
select pyme_drop_shipping.Search_Tracking_number(3);


            
