# f) Obtener el nombre de los pasajeros y su gasto total por zona de
# entretenimiento de aquellos pasajeros alojados en la cubierta ‘A’ y que
# han realizado gastos en todas los zonas de entretenimiento, ordenados
# por nombre de pasajero en orden alfabético y por cada pasajero que
# aparezcan los gastos de mayor importe primero.

SELECT nombre,
       entretenimiento,
       SUM(cantidad) AS gasto
FROM pasajeros p
         JOIN gastos g ON p.id = g.pasajero
WHERE id IN (SELECT id
             FROM pasajeros p
                      JOIN gastos g ON p.id = g.pasajero
             WHERE cubierta = 'A'
             GROUP BY id
             HAVING COUNT(DISTINCT entretenimiento) = (SELECT COUNT(*)
                                                       FROM entretenimientos))
GROUP BY id, nombre, entretenimiento
ORDER BY nombre, gasto DESC;