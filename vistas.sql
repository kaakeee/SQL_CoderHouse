/*Estas vistas funcionan con la BD de abajo (la anterior)*/
/*  https://github.com/kaakeee/SQL_CoderHouse/blob/main/Base%20%2B%20Datos%20tp%202.sql    */
/* seleccione todo y ejecute, crea y muestra todas las vistas */



USE PYME_STICKERS;
CREATE OR replace view v_clientes_pedidos
AS (
 SELECT
 c.nombre as Cliente,      /*el cliente*/
 p.id_pedido as Compra     /*su compra*/
FROM clientes as c
INNER JOIN pedidos as p
ON p.cuit_cuil = c.cuit_cuil
);
/*esta vista relaciona la compra con el nombre del cliente*/
SELECT * FROM pyme_stickers.v_clientes_pedidos;

-----------------------------------------------------------------------------------------------------------


USE PYME_STICKERS;
CREATE OR replace view v_Clientes_numero_de_seguimiento
AS
(
SELECT c.nombre as Cliente, e.numero_de_seguimiento as 'Numero de seguimiento'
FROM clientes as c
JOIN pedidos as p ON p.cuit_cuil = c.cuit_cuil
JOIN envios as e ON e.id_pedido = p.id_pedido
);
/* esta vista solo seleciona nombre y numero de seguimiento*/
SELECT * FROM pyme_stickers.v_Clientes_numero_de_seguimiento;

-----------------------------------------------------------------------------------------------------------

USE PYME_STICKERS;
CREATE OR replace view v_Categoria_Proveedores
AS
(
SELECT pr.id_modelo as Modelo, pr.id_proveedor as Proveedor, p.email as Email
FROM productos as pr
JOIN proveedores as p
ON p.id_proveedor = pr.id_proveedor
);
/*Esta vista muestra las categorias de los proveedores con su mail*/
SELECT * FROM pyme_stickers.v_categoria_proveedores;

-----------------------------------------------------------------------------------------------------------


USE PYME_STICKERS;
CREATE OR REPLACE VIEW v_Total_comprado_clientes_premium
AS
(
SELECT fa.total_compra as 'Total Comprado', cl.nombre as Nombre
FROM clientes as cl
JOIN facturacion as fa
ON fa.cuit_cuil = cl.cuit_cuil
WHERE fa.total_compra > 1000
);
/* esta vista muestra los clientes que gastaron mas de 1000*/
SELECT * FROM pyme_stickers.v_total_comprado_clientes_premium;

-----------------------------------------------------------------------------------------------------------

USE PYME_STICKERS;
CREATE OR REPLACE VIEW v_Paises_Clientes
AS
(
SELECT pais
FROM envios
GROUP BY pais
ORDER BY pais asc
);
/*esta vista selecciona todos los paises de los clientes, los agrupa y los ordena alfabeticamente*/
SELECT * FROM pyme_stickers.v_paises_clientes;
