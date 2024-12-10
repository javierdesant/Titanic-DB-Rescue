# e) Obtener el nombre de los planetas, y el sistema al que pertenecen,
# de aquellos planetas en los que han nacido menos pasajeros que
# el promedio de nacimientos en todos los planetas.

SELECT planeta_natal AS planeta, sistema_natal AS sistema
FROM pasajeros
GROUP BY sistema_natal, planeta_natal
HAVING COUNT(*) < (SELECT AVG(nacimientos)
                   FROM (SELECT COUNT(*) AS nacimientos
                         FROM pasajeros
                         GROUP BY sistema_natal, planeta_natal) AS t1);