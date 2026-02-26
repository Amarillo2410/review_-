DROP PROCEDURE IF EXISTS actualizar_facultad;
DELIMITER $$

CREATE PROCEDURE actualizar_facultad(
    IN p_id INT,
    IN p_facultad VARCHAR(100),
    IN p_decano VARCHAR(100)
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
        VALUES('Facultad_Origen', v_codigo_error, v_mensaje);
    END;

    UPDATE Facultad_Origen
    SET facultad_origen = p_facultad,
        decano_facultad = p_decano
    WHERE id_facultad = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe la facultad' AS mensaje;
    ELSE
        SELECT 'Facultad actualizada correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL actualizar_facultad(3,'Ingeniería','Ana Torres');