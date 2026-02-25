use  reviewii;
DELIMITER $$

CREATE TRIGGER validar_paciente_insert
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN

    -- Validar nombre vacío
    IF NEW.nombre_paciente IS NULL OR TRIM(NEW.nombre_paciente) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre del paciente no puede estar vacío';
    END IF;

    -- Validar teléfono nulo
    IF NEW.telefonno IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono no puede ser NULL';
    END IF;

    -- Validar que el telefono tenga 10 digitos
    IF LENGTH(NEW.telefonno) <> 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono debe tener exactamente 10 digitos';
    END IF;

    -- Validar que no sea negativo
    IF NEW.telefonno < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono no puede ser negativo';
    END IF;

END$$

DELIMITER ;



