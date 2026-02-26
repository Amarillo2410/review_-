DROP PROCEDURE IF EXISTS actualizar_medico;
DELIMITER $$

CREATE PROCEDURE actualizar_medico(
    IN p_id INT,
    IN p_codigo VARCHAR(10),
    IN p_nombre VARCHAR(100),
    IN p_especialidad VARCHAR(100),
    IN p_id_facultad INT
)
BEGIN
    DECLARE v_codigo_error INT;
    DECLARE v_mensaje TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo_error = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO Log_Errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('Medicos', v_codigo_error, v_mensaje);
    END;

    -- Validar que el médico exista
    IF NOT EXISTS (
        SELECT 1 FROM Medicos WHERE id_medico = p_id
    ) THEN
        SELECT 'No existe el médico' AS mensaje;

    -- Validar que la facultad exista
    ELSEIF NOT EXISTS (
        SELECT 1 FROM Facultad_Origen WHERE id_facultad = p_id_facultad
    ) THEN
        SELECT 'La facultad no existe' AS mensaje;

    ELSE
        UPDATE Medicos
        SET Codigo = p_codigo,
            nombre_medico = p_nombre,
            especialidad = p_especialidad,
            id_facultad = p_id_facultad
        WHERE id_medico = p_id;

        SELECT 'Médico actualizado correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;	

CALL actualizar_medico(3,'M-102','Laura Gómez','Neurología',2);