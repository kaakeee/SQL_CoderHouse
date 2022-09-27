CREATE USER 'Data_Analist'@'localhost' IDENTIFIED BY 'iLoveData32';  /*esto crea el ususario que solo lee las tablas*/
CREATE USER 'IT'@'localhost' IDENTIFIED BY 'IamADM68';    /*este las puede cambiay leer pero no eliminar */

GRANT SELECT ON *.* TO 'Data_Analist'@'localhost'; /*solo leer*/
GRANT SELECT, UPDATE, INSERT ON *.* TO 'IT'@'localhost';  /*permisos para ver, modificar y crear*/


/* DROP USER 'IT'@'localhost'; */ /*PARA ELIMINARLOS*/
/* DROP USER 'Data_Analist'@'localhost'; */

SELECT * FROM mysql.user WHERE user LIKE 'IT%';              /*para comprobar sus permisos*/
SELECT * FROM mysql.user WHERE user LIKE 'Data_Analist%';   /*para comprobar sus permisos*/
