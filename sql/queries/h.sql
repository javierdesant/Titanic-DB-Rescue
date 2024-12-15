# h) Obtener los nombres de los planetas, así como el sistema al que pertenecen,
# de aquellos planetas a los que no han viajado pasajeros VIP y que además son
# los planetas donde han nacido alguno de los pasajeros con mayor edad.

SELECT DISTINCT sistema_natal AS sistema, planeta_natal AS planeta
FROM pasajeros
WHERE (sistema_natal, planeta_natal) IN
      (SELECT DISTINCT sistema_natal, planeta_natal
       FROM pasajeros
       WHERE edad >= ALL (SELECT edad
                          FROM pasajeros))
  AND (sistema_natal, planeta_natal) NOT IN (SELECT DISTINCT sistema_destino, planeta_destino
                                             FROM pasajeros
                                             WHERE vip = 1);