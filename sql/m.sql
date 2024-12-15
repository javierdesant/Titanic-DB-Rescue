# m) Se quiere crear una función que permita obtener el porcentaje de pasajeros que
# viajan a un destino concreto (sistema y planeta), para una cubierta determinada,
# cuyos datos pasaremos como parámetro. A fin de comprobar su correcto funcionamiento,
# crear una consulta que muestre la ocupación de todas las cubiertas disponibles para
# el destino “55 Cancri e” sistema “Copernico” ordenada alfabéticamente por la letra de
# la cubierta.

DELIMITER //
CREATE FUNCTION calcularPorcentajePasajeros(p_destino VARCHAR(50), s_destino VARCHAR(50), letra VARCHAR(1))
    RETURNS DECIMAL(5, 2)
    DETERMINISTIC
BEGIN
    DECLARE total_pasajeros INT;
    DECLARE pasajeros_destino INT;
    DECLARE res DECIMAL(5, 2);

    SELECT COUNT(*)
    INTO total_pasajeros
    FROM pasajeros
    WHERE cubierta = letra;

    SELECT COUNT(*)
    INTO pasajeros_destino
    FROM pasajeros
    WHERE planeta_destino = p_destino
      AND sistema_destino = s_destino
      AND cubierta = letra;

    SET res = IF(total_pasajeros <> 0, (pasajeros_destino / total_pasajeros) * 100, 0);

    RETURN res;
END //
DELIMITER ;

SELECT letra, calcularPorcentajePasajeros('55 Cancri e', 'Copernico', letra) AS porcentaje_ocupacion
FROM cubiertas
ORDER BY letra;


DROP FUNCTION calcularPorcentajePasajeros;