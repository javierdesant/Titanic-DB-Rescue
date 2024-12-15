# n) Para evitar que pueda haber algún ciber-delincuente en alguno de los entretenimientos
# ofrecidos por en la nave, se quieren crear tantos triggers como sean necesarios para
# evitar que existan gastos en entretenimientos con saldo negativo, es decir, la cantidad
# en gastos sea menor que 0. En caso de producirse el ciberataque, deberá mostraserse el
# siguiente mensaje de error: “ERROR: Bienvenido ciber-delincuente, pero no puedes sacar
# dinero en un entretenimiento”.

DELIMITER //
CREATE TRIGGER prevent_negative_expense_before_insert
    BEFORE INSERT
    ON gastos
    FOR EACH ROW
BEGIN
    IF NEW.cantidad < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                    'ERROR: Bienvenido ciber-delincuente, pero no puedes sacar dinero en un entretenimiento';
    END IF;
END //

CREATE TRIGGER prevent_negative_expense_before_update
    BEFORE UPDATE
    ON gastos
    FOR EACH ROW
BEGIN
    IF NEW.cantidad < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                    'ERROR: Bienvenido ciber-delincuente, pero no puedes sacar dinero en un entretenimiento';
    END IF;
END //
DELIMITER ;