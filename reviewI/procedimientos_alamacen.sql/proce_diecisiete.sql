CALL crear_medico('M-101','Carlos Pérez','Cardiología',2);DROP PROCEDURE IF EXISTS crear_medico;
DELIMITER $$

CREATE PROCEDURE crear_medico(
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
        ROLLBACK;

        GET DIAGNOSTICS CONDITION 1
            v_codigo_error = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO Log_Errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('Medicos', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    -- Validar que la facultad exista
    IF NOT EXISTS (
        SELECT 1 FROM Facultad_Origen
        WHERE id_facultad = p_id_facultad
    ) THEN

        ROLLBACK;
        SELECT 'La facultad no existe' AS mensaje;

    -- Validar que el código no esté repetido
    ELSEIF EXISTS (
        SELECT 1 FROM Medicos
        WHERE Codigo = p_codigo
    ) THEN

        ROLLBACK;
        SELECT 'El código del médico ya existe' AS mensaje;

    ELSE

        INSERT INTO Medicos(Codigo, nombre_medico, especialidad, id_facultad)
        VALUES(p_codigo, p_nombre, p_especialidad, p_id_facultad);

        COMMIT;
        SELECT 'Médico creado correctamente' AS mensaje;

    END IF;

END$$
DELIMITER ;

CALL crear_medico('M-101','Carlos Pérez','Cardiología',2);