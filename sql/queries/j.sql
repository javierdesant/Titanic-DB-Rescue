# j) Obtener los planetas donde la cantidad de pasajeros nacidos en él, y que
# han gastado en al menos 4 tipos diferentes de entretenimiento, es mayor al
# 25% del total de pasajeros de dicho planeta, mostrando además del nombre del
# planeta y sistema al que pertenece, tanto el total de pasajeros nacidos en él,
# así como el número de pasajeros del mismo que gastaron en los tipos de
# entretenimiento

SELECT sistema_natal                           AS sistema,
       planeta_natal                           AS planeta,
       (SELECT COUNT(*)
        FROM pasajeros p2
        WHERE p1.sistema_natal = p2.sistema_natal
          AND p1.planeta_natal = p2.planeta_natal
        GROUP BY sistema_natal, planeta_natal) AS total_pasajeros,
       COUNT(*)                                AS consumidores_estrella
FROM pasajeros p1
WHERE id IN (SELECT pasajero
             FROM gastos
             GROUP BY pasajero
             HAVING COUNT(DISTINCT entretenimiento) >= 4)
GROUP BY sistema_natal, planeta_natal
HAVING COUNT(*) > total_pasajeros / 4;