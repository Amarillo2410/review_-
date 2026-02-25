USE reviewii;

DELIMITER $$

CREATE TRIGGER validar_fecha_cita_insert
BEFORE INSERT ON citas
FOR EACH ROW
BEGIN

    IF NEW.fecha_cita > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permiten fechas futuras para la cita';
    END IF;

END$$

DELIMITER ;