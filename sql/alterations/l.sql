# l) Para facilitar una identificación más rápida y precisa de los tutores
# legales de los menores en cada cabina, se ha determinado la necesidad de añadir
# un parámetro adicional en el registro de cada pasajero. Este parámetro permitirá
# identificar al tutor legal en caso de que el pasajero sea menor de edad. Para
# implementar este cambio, es necesario actualizar la tabla pasajeros y añadir un
# nuevo campo denominado tutor.

ALTER TABLE pasajeros
    ADD tutor VARCHAR(7) NULL,
    ADD CONSTRAINT fk_tutor FOREIGN KEY (tutor) REFERENCES pasajeros (id)
        ON DELETE SET NULL
        ON UPDATE CASCADE;

# Tras modificar la estructura de la tabla, se desarrollará un procedimiento para
# asignar automáticamente el tutor de cada menor. Este procedimiento tomará en
# cuenta que el tutor de cada pasajero menor de 18 años debe ser un adulto de
# mayor edad que se encuentre en la misma cabina (con la misma letra, número
# y lado) que el menor. Si no hubiera un adulto en la misma cabina que pueda
# cumplir esta función, el menor deberá colocarse en criosueño, salvo que ya se
# encuentre en esta condición. Los menores que ya estén en criosueño no requerirán
# asignación de tutor, permaneciendo en esta condición sin cambios adicionales.

DELIMITER $$
CREATE PROCEDURE asignarTutores()
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE pasajero_id VARCHAR(7);
DECLARE letra_cubierta VARCHAR(1);
DECLARE numero_cabina INT;
DECLARE lado_cabina VARCHAR(1);
DECLARE tutor_id VARCHAR(7) DEFAULT NULL;
DECLARE cur CURSOR FOR
    SELECT p.id, p.cubierta, p.numero_cabina, p.lado_cabina
    FROM pasajeros p
    WHERE p.edad < 18 AND p.criosueño = 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cur;
read_loop: LOOP
    FETCH cur INTO pasajero_id, letra_cubierta, numero_cabina, lado_cabina;
    IF done THEN
        LEAVE read_loop;
    END IF;

    SELECT p.id INTO tutor_id
    FROM pasajeros p 
    WHERE p.cubierta = letra_cubierta AND p.numero_cabina = numero_cabina AND p.lado_cabina = lado_cabina AND p.edad >= 18
    ORDER BY p.edad DESC
    LIMIT 1;

    IF tutor_id IS NOT NULL THEN
        UPDATE pasajeros
        SET tutor = tutor_id
        WHERE id = pasajero_id;
    ELSE
        UPDATE pasajeros
        SET criosueño = 1
        WHERE id = pasajero_id;
    END IF;
END LOOP;

CLOSE cur;
END $$
DELIMITER ;


CALL asignarTutores();
SELECT *
FROM pasajeros;
DROP PROCEDURE asignarTutores;
ALTER TABLE pasajeros
    DROP CONSTRAINT fk_tutor,
    DROP COLUMN tutor;