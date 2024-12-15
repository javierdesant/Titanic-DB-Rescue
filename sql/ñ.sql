# ñ) Para mejorar la satisfacción de los pasajeros, se ha decidido asignar
# automáticamente la condición de VIP a cualquier pasajero cuyo gasto total
# en entretenimientos supere la cantidad de 5000. Actualice la condición de
# VIP a todos los pasajeros que ya hayan superado los 5000 en gastos mediante
# una sentencia UPDATE y, además, cree los triggers necesarios para otorgar
# dicha condición a futuros pasajeros.

DELIMITER $$
CREATE PROCEDURE actualizarVips()
BEGIN
    DECLARE done int DEFAULT FALSE;
    DECLARE pasa VARCHAR(7);
    DECLARE gasto DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT pasajero, SUM(cantidad)
                           FROM pasajeros p
                                    JOIN gastos g ON p.id = g.pasajero
                           WHERE vip = 0
                           GROUP BY pasajero;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop:
    LOOP
        FETCH cur INTO pasa, gasto;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF gasto > 5000 THEN
            UPDATE pasajeros
            SET vip = 1
            WHERE id = pasa;
        END IF;
    END LOOP;
END $$
DELIMITER ;

DELIMITER //
CREATE TRIGGER upd_vip
    AFTER UPDATE
    ON gastos
    FOR EACH ROW
BEGIN
    DECLARE gasto DECIMAL(10, 2) DEFAULT 0;

    SELECT SUM(cantidad)
    INTO gasto
    FROM gastos
    WHERE pasajero = NEW.pasajero;

    IF gasto > 5000 THEN
        UPDATE pasajeros
        SET vip = 1
        WHERE id = NEW.pasajero;
    END IF;
END //

CREATE TRIGGER ins_vip
    AFTER INSERT
    ON gastos
    FOR EACH ROW
BEGIN
    DECLARE gasto DECIMAL(10, 2) DEFAULT 0;

    SELECT SUM(cantidad)
    INTO gasto
    FROM gastos
    WHERE pasajero = NEW.pasajero;

    IF gasto > 5000 THEN
        UPDATE pasajeros
        SET vip = 1
        WHERE id = NEW.pasajero;
    END IF;
END //
DELIMITER ;