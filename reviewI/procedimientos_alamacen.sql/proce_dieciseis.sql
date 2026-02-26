DROP PROCEDURE IF EXISTS eliminar_diagnostico;
DELIMITER $$

CREATE PROCEDURE eliminar_diagnostico(IN p_id INT)
BEGIN
    DECLARE v_codigo_error INT;
    DECLARE v_mensaje TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo_error = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO Log_Errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('Diagnosticos', v_codigo_error, v_mensaje);
    END;

    DELETE FROM Diagnosticos
    WHERE id_diagnostico = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe el diagnóstico' AS mensaje;
    ELSE
        SELECT 'Diagnóstico eliminado correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL eliminar_diagnostico(3);