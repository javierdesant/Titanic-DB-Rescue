# d) Obtener para cada zona de entretenimiento el gasto total que han tenido
# los pasajeros VIP en ella mostrando el nombre de la zona, el gasto total y
# el tipo de pasajero (“VIP”), haciendo lo mismo con el gasto correspondiente
# a los pasajeros que no sean VIP para los cuales se mostrará el valor
# “NO VIP” en el tipo de pasajero. Tipo de pasajero se mostrará como una
# columna que podrá tomar los dos posibles valores mencionados anteriormente
# (“VIP” o “NO VIP”).

SELECT entretenimiento,
       SUM(cantidad)                AS gasto,
       IF(vip = 1, 'VIP', 'NO VIP') AS tipo_pasajero
FROM pasajeros p
         JOIN gastos g ON p.id = g.pasajero
GROUP BY entretenimiento, vip
ORDER BY entretenimiento;