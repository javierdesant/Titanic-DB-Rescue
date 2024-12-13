# l) Para facilitar una identificación más rápida y precisa de los tutores
# legales de los menores en cada cabina, se ha determinado la necesidad de añadir
# un parámetro adicional en el registro de cada pasajero. Este parámetro permitirá
# identificar al tutor legal en caso de que el pasajero sea menor de edad. Para
# implementar este cambio, es necesario actualizar la tabla pasajeros y añadir un
# nuevo campo denominado tutor.

ALTER TABLE pasajeros
    ADD tutor VARCHAR(7),
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
    -- TODO
END $$
DELIMITER ;


CALL asignarTutores();
SELECT *
FROM pasajeros;
DROP PROCEDURE asignarTutores;
ALTER TABLE pasajeros
    DROP CONSTRAINT fk_tutor,
    DROP COLUMN tutor;