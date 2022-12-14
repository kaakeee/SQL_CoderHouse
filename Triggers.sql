/*Tablas en donde van los datos de los triggers*/

USE pyme_stickers;
/* tabla de log de nuevas facturas con sus montos y usuarios que crearon la trabla y/o modificaciones*/
/* en esta tabla tomo mas datos porque es infomacion mas importante */
CREATE TABLE old_facturacion (
id_factura INT,       /* se elimina que sea primary key*/
cuit_cuil VARCHAR(40),
total_compra DECIMAL(30,2),
user CHAR(30),            /* user y fecha para saber quien hizo los cambios y cuando   */
fecha_hora timestamp
);

/*tabla de registro de nuevas ventas, de la tabla pedidos */ 

CREATE TABLE new_pedidos(
id_pedido INT,   /* se elimina que sea primary key*/
user CHAR(30),    /* user y fecha para saber quien hizo los cambios y cuando   */
fecha_hora timestamp
);


/* tabla de log de nuevas facturas con sus montos y usuarios que crearon la trabla y/o modificaciones*/
/* en esta tabla tomo mas datos porque es infomacion mas importante */

CREATE TRIGGER tr_facturas
AFTER update ON facturacion /* despues del update*/  /* la tabla*/
FOR EACH ROW /*cada fila q se inserte*/
INSERT INTO old_facturacion (id_factura, cuit_cuil, total_compra, user, fecha_hora)  /*columna copia */
VALUES (old.id_factura, old.cuit_cuil, old.total_compra, session_user(), current_timestamp());   /* la original*/


/*esta tabla se encarga de ver quien ingresa los nuevos pedidos y quien lo hace */

CREATE TRIGGER tr_pedidos
BEFORE INSERT on pedidos
FOR EACH ROW
INSERT INTO new_pedidos (id_pedido, user, fecha_hora)   /*la tabla original de donde toma los datos */
VALUES (NEW.id_pedido, session_user(), current_timestamp());   /* la tabla de los registros */


#DROP TRIGGER tr_facturas;
#DROP TRIGGEr tr_pedidos; 

/* valores para comprobar que funciona */

insert into Pedidos (id_pedido, cuit_cuil, id_modelo, cantidad)
values

(101, '770-89-9991', 45, 194),
(102, '346-74-2607', 46, 997),
(103, '416-88-2651', 77, 33),
(104, '304-56-9708', 32, 349);


UPDATE pyme_stickers.facturacion SET total_compra = '650' WHERE (id_factura = '4');
UPDATE pyme_stickers.facturacion SET total_compra = '6790' WHERE (id_factura = '6');
UPDATE pyme_stickers.facturacion SET total_compra = '6950' WHERE (id_factura = '7');
