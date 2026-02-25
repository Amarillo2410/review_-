 DROP PROCEDURE IF EXISTS eliminar_facultad;
DELIMITER $$

CREATE PROCEDURE eliminar_facultad(IN p_id INT)
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

    DELETE FROM Facultad_Origen
    WHERE id_facultad = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe la facultad' AS mensaje;
    ELSE
        SELECT 'Facultad eliminada correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL eliminar_facultad(3);