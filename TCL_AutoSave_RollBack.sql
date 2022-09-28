/* Para que funcione este debe ingresar la BD + tablas de triggers
https://github.com/kaakeee/SQL_CoderHouse/blob/main/Triggers
https://github.com/kaakeee/SQL_CoderHouse/blob/main/Base%20%2B%20Datos%20tp%202.sql
*/


#si ejecuta todo de una, la primera transacción se pisa con la segunda, por ende la segunda esta comentada

use pyme_stickers;
SELECT * FROM pyme_stickers.new_pedidos;  #muestra antes de los cambios
start transaction;                        #empieza el modo "seguro"
delete FROM pyme_stickers.new_pedidos WHERE id_pedido = 101; #aca eliminamos
delete FROM pyme_stickers.new_pedidos WHERE id_pedido = 102;
delete FROM pyme_stickers.new_pedidos WHERE id_pedido = 103;
delete FROM pyme_stickers.new_pedidos WHERE id_pedido = 104;

SELECT * FROM pyme_stickers.new_pedidos;  #muestra los cambios
#rollback;                                #para eliminar los cambios
#commit;                                  #para ejecutar los cambios si estamos muy seguros

/* PARA REINSERTAR LOS DATOS
insert into Pedidos (id_pedido, cuit_cuil, id_modelo, cantidad)
values
 PARA INSERTAR LOS DATOS EN LA TABLA PEDIDOS   NOOOO LA NEW PEDIDOS YA QUE EN ESTA SE INGRESA CON LOS TRIGGERS
(101, '770-89-9991', 45, 194),
(102, '346-74-2607', 46, 997),
(103, '416-88-2651', 77, 33),
(104, '304-56-9708', 32, 349);

elimnar los datos para que el trigger pueda capturar de nuevo a la table new_pedidos
delete FROM pyme_stickers.pedidos WHERE id_pedido = 101;
delete FROM pyme_stickers.pedidos WHERE id_pedido = 102;  
delete FROM pyme_stickers.pedidos WHERE id_pedido = 103;
delete FROM pyme_stickers.pedidos WHERE id_pedido = 104;
*/

/*segunda tabla usada, comentada para que no se pise con la primera*/   
/* BORRAR
SELECT * FROM pyme_stickers.facturacion;  #antes de los cambios

start transaction;                        #empieza el modo seguro

insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (101, '102-07-6444', 9915);
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (102, '104-14-2862', 648);  #datos de prueba
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (103, '108-10-0386', 5486);
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (104, '109-21-2327', 457568);

savepoint factura_4;                      #el primer savepoint
 
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (105, '110-12-2796', 56768);
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (106, '116-22-4326', 8768);
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (107, '120-69-2099', 5876); #datos de prueba
insert into facturacion (id_factura, cuit_cuil, cantidad) VALUES (108, '124-51-6982', 78668);

savepoint factura_8;                      #segundo savepoint

SELECT * FROM pyme_stickers.facturacion;  #muestra los cambios

#RELEASE savepoint factura_4;             #elimina el primer savapoint
#rollback;                                #para eliminar los cambios
#commit;                                  #para ejecutar los cambios si estamos muy seguros

*/ #BORRAR 


