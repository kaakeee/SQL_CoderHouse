/* en el campo columna poner alguna columna de la tabla pedidos, y order_by establecer la forma, es decir 'ASC' o 'DESC'*/


DELIMITER //
CREATE PROCEDURE `buscador_PEDIDOS` (IN columna VARCHAR(20), IN order_by VARCHAR(4))
BEGIN
/*aca entra la columna deseada para poder buscar por esa*/
IF columna <> '' THEN
	SET @colum = CONCAT('ORDER BY ', columna);
ELSE 
	SET @colum = ''; 
END IF;

/*aca termino segun lo ingresado en colunna*/
SET @resultado = CONCAT('SELECT * FROM pyme_stickers.pedidos ', @colum);


/*aca entra el desc o asc para ordenar*/
IF order_by <> '' THEN
	SET @orderby = CONCAT(@resultado,' ', order_by);
else
	SET @orderby = CONCAT(@resultado);
END IF;

/*aca entra la concatenacion final con toda la consulta hecha*/
SET @resultado_final = CONCAT(@orderby);



/* lo de abajo simplemente prepara de procedure a una consulta para sql*/
PREPARE querySQL FROM @resultado_final;   /*prepara el sting a consulta SQL*/
EXECUTE querySQL;                   /* la ejecuta*/
DEALLOCATE PREPARE querySQL;        /* deallocate la sql*/
END //




/* este otro SP crea un proveedor con los 3 datos, el primero es INT y el resto es varchar */

DELIMITER //
CREATE PROCEDURE `crear_proveedor`(IN proveedor INT, IN email VARCHAR(75), telefono VARCHAR(60))
BEGIN
/*aca entra los datos*/
IF proveedor > 100 THEN
	/* concateno para introducir los datos*/
	SET @dato = CONCAT('insert into pyme_stickers.proveedores (id_proveedor, email, telefono) values (" ', proveedor, ' ", ', ' " ', email,' ", ', ' " ', telefono,' ")');  
ELSE   
	SET @dato = '';
END IF;


/* lo de abajo simplemente prepara de procedure a una consulta para sql*/
PREPARE resultadoSQL FROM @dato;   /*prepara el sting a consulta SQL*/
EXECUTE resultadoSQL;                   /* la ejecuta*/
DEALLOCATE PREPARE resultadoSQL;        /* deallocate la sql*/

END //
