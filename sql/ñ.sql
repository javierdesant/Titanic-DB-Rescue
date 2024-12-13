#n) Para mejorar la satisfacción de los pasajeros, se ha decidido asignar automáti-
#camente la condición de VIP a cualquier pasajero cuyo gasto total en entrete-
#nimientos supere la cantidad de 5000. Actualice la condición de VIP a todos
#los pasajeros que ya hayan superado los 5000 en gastos mediante una senten-
#cia UPDATE y, además, cree los triggers necesarios para otorgar dicha condición a
#futuros pasajeros.
UPDATE pasajeros p
SET p.vip = 1
WHERE (SELECT SUM(g.cantidad) FROM gastos g WHERE g.pasajero = p.id) > 5000;

DELIMITER //

CREATE TRIGGER actualizar_vip
AFTER INSERT ON gastos
FOR EACH ROW
BEGIN
    DECLARE total_gastos DECIMAL(10, 2);

    SELECT SUM(cantidad) INTO total_gastos
    FROM gastos
    WHERE pasajero = NEW.pasajero;

    IF total_gastos > 5000 THEN
        UPDATE pasajeros
        SET vip = 1
        WHERE pasajero = NEW.pasajero;
    END IF;
END //

DELIMITER ;
