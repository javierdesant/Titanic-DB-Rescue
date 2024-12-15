# i) Obtener aquellas cabinas (mostrando la información de cubierta, número
# y lado) con más de 3 pasajeros NO VIP y cuyos pasajeros han gastado más
# del doble del gasto promedio total por cabina.

SELECT cubierta, lado_cabina AS lado, numero_cabina AS numero
FROM pasajeros p
         JOIN gastos g ON p.id = g.pasajero
GROUP BY cubierta, lado_cabina, numero_cabina
HAVING SUM(cantidad) > 2 * (SELECT AVG(total)
                            FROM (SELECT SUM(cantidad) AS total
                                  FROM pasajeros p
                                           JOIN gastos g ON p.id = g.pasajero
                                  GROUP BY cubierta, lado_cabina, numero_cabina) AS t1)
   AND (cubierta, lado_cabina, numero_cabina) IN (SELECT cubierta, lado_cabina, numero_cabina
                                                  FROM pasajeros p
                                                  WHERE vip = 0
                                                  GROUP BY cubierta, lado_cabina, numero_cabina
                                                  HAVING COUNT(p.id) > 3);