CREATE FUNCTION contar_especialidad(p_especialidad VARCHAR(30))
RETURNS INT
READS SQL DATA

DELIMITER $$

CREATE FUNCTION contar_especialidad(p_especialidad VARCHAR(30))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_total
    FROM medicos
    WHERE especialidad = p_especialidad;

    RETURN v_total;
END$$

DELIMITER ;




    SELECT contar_especialidad('Cardiología');