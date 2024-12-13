#m) Se quiere crear una función que permita obtener el porcentaje de pasajeros que
#viajan a un destino concreto (sistema y planeta), para una cubierta determi-
#nada, cuyos datos pasaremos como parámetro. A fin de comprobar su correcto
#funcionamiento, crear una consulta que muestre la ocupación de todas las cu-
#biertas disponibles para el destino “55 Cancri e” sistema “Copernico” ordenada
#alfabéticamente por la letra de la cubierta.
DELIMITER //

CREATE FUNCTION obtener_porcentaje_pasajeros(planeta_destino VARCHAR(255), sistema_destino VARCHAR(255), letra_cubierta VARCHAR(1))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_pasajeros INT;
    DECLARE pasajeros_cubierta INT;
    DECLARE porcentaje DECIMAL(5,2);

    SELECT COUNT(*) INTO total_pasajeros
    FROM pasajeros
    WHERE planeta_destino = planeta_destino AND sistema_destino = sistema_destino;

    SELECT COUNT(*) INTO pasajeros_cubierta
    FROM pasajeros
    WHERE planeta_destino = planeta_destino AND sistema_destino = sistema_destino AND cubierta = letra_cubierta;

    SET porcentaje = (pasajeros_cubierta / total_pasajeros) * 100;

    RETURN porcentaje;
END //

DELIMITER;

SELECT letra, obtener_porcentaje_pasajeros('55 Cancri e', 'Copernico', letra) AS porcentaje_ocupacion
FROM cubiertas
ORDER BY letra;