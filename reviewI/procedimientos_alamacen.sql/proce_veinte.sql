DROP PROCEDURE IF EXISTS eliminar_medico;
DELIMITER $$

CREATE PROCEDURE eliminar_medico(IN p_id INT)
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

    DELETE FROM Medicos
    WHERE id_medico = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe el médico' AS mensaje;
    ELSE
        SELECT 'Médico eliminado correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL eliminar_medico(5);

