SELECT nombre, cubierta, numero_cabina, lado_cabina, planeta_destino, sistema_destino 
FROM pasajeros WHERE criosueño = 0 AND (cubierta BETWEEN 'A' AND 'D') 