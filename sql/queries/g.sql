# g) Obtener las cabinas (mostrando la información de cubierta, número 
# y lado) ocupadas por pasajeros que han gastado en el entretenimiento
# más popular, es decir en aquel en el que han participado más pasajeros.

SELECT cubierta, lado_cabina AS lado, numero_cabina AS numero
FROM pasajeros p
         JOIN gastos g ON p.id = g.pasajero
WHERE entretenimiento =
      (SELECT entretenimiento
       FROM gastos
       GROUP BY entretenimiento
       HAVING SUM(cantidad) >= ALL (SELECT SUM(cantidad)
                                    FROM gastos
                                    GROUP BY entretenimiento))
GROUP BY cubierta, lado_cabina, numero_cabina;