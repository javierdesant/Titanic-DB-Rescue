# k) Se pide crear una nueva vista denominada entretenimiento_pasajeros
# que contenga los siguientes datos:
#  - id, nombre, y edad de cada pasajero.
#  - Si el pasajero fue o no transportado.
#  - nombre y sistema del planeta al que está viajando el pasajero.
#  - numero, lado y cubierta de la cabina en la que está hospedado y la
#  clase de la cubierta asociada.
#  - nombre del entretenimiento en el que más ha gastado el pasajero, junto
#  con la cantidad gastada en dicho entretenimiento.

CREATE VIEW entretenimiento_pasajeros AS
SELECT p.id,
       p.nombre,
       edad,
       transportado,
       planeta_destino,
       sistema_destino,
       numero_cabina,
       lado_cabina,
       letra,
       clase,
       e.nombre AS entretenimiento,
       cantidad AS gasto
FROM pasajeros p
         LEFT JOIN cubiertas c ON p.cubierta = c.letra
         LEFT JOIN (SELECT g1.pasajero, g1.cantidad, g1.entretenimiento
                    FROM gastos g1
                    WHERE g1.cantidad = (SELECT MAX(g2.cantidad)
                                         FROM gastos g2
                                         WHERE g1.pasajero = g2.pasajero)) g ON p.id = g.pasajero
         LEFT JOIN entretenimientos e ON g.entretenimiento = e.id;

#  Además, se pide crear un usuario nuevo conocido como analista datos y
#  restringir el acceso a dicho usuario para que ´unicamente pueda acceder
#  a la vista en modo lectura.

CREATE USER analista_datos IDENTIFIED BY 'cosmere';

GRANT SELECT ON entretenimiento_pasajeros TO analista_datos;


SELECT *
FROM entretenimiento_pasajeros;
SHOW GRANTS FOR analista_datos;
DROP VIEW entretenimiento_pasajeros;
DROP USER analista_datos;