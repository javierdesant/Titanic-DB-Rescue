# c) Obtener el listado de los pasajeros que han
# embarcado obteniendo para cada uno su nombre, cabina asignada (con formato:
# Letra Cubierta-Número Cabina-Lado Cabina, por ejemplo “B-1-P”) y planeta destino
# al que viajaban (incluyendo el sistema al que pertenece), de aquellos pasajeros
# cuya cabina esta localizada en una cubierta de tercera clase desde la letra A a
# la D y que no están en criosueño.

SELECT nombre,
       CONCAT(c.letra, '-', numero_cabina, '-', lado_cabina) AS cabina_asignada,
       CONCAT(planeta_destino, ' (', sistema_destino, ')')   AS destino
FROM pasajeros p
         JOIN cubiertas c ON p.cubierta = c.letra
WHERE clase = 3
  AND (c.letra BETWEEN 'A' AND 'D')
  AND criosueño = 0;