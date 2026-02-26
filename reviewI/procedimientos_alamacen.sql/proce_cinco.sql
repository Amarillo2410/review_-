DROP PROCEDURE IF EXISTS crear_facultad;
DELIMITER $$

CREATE PROCEDURE crear_facultad(
    IN p_facultad VARCHAR(100),
    IN p_decano VARCHAR(100)
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
        VALUES('Facultad_Origen', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 FROM Facultad_Origen 
        WHERE facultad_origen = p_facultad
    ) THEN

        INSERT INTO Facultad_Origen(facultad_origen, decano_facultad)
        VALUES(p_facultad, p_decano);

        COMMIT;
        SELECT 'Facultad creada correctamente' AS mensaje;

    ELSE
        ROLLBACK;
        SELECT 'La facultad ya existe' AS mensaje;
    END IF;

END$$

DELIMITER ;

CALL crear_facultad('Ingeniería','Carlos Ramírez');