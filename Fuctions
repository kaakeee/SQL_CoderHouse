DELIMITER //
Create FUNCTION Calcular_IVA(factura INT) 
RETURNS decimal(15,2)
DETERMINISTIC
BEGIN


    DECLARE resultado DECIMAL(15,2);
    DECLARE iva DECIMAL(15,2);
    DECLARE factura_total DECIMAL(15,2);
    SET iva = 1.21;
    

    SELECT total_compra INTO factura_total
    FROM facturacion
    WHERE factura = id_factura;
    /*aca busco el total de la factura*/
    
    
    SET resultado = factura_total * iva;
	RETURN resultado;
	
END //

/*esta funcion calcula el iva de la factura con el id_factura*/



--------------------------------


/* esta funcion busca el numero de seguimiento con el id_pedido*/
DELIMITER //

CREATE FUNCTION Buscar_Pedido(Pedido INT)
RETURNS varchar(70)
DETERMINISTIC
BEGIN
DECLARE numero_pedido VARCHAR(70);
SET numero_pedido = '';
SELECT numero_de_seguimiento INTO numero_pedido
FROM envios
WHERE Pedido = id_pedido;

RETURN numero_pedido;
END //
