DROP PROCEDURE IF EXISTS eliminar_paciente;
DELIMITER $$

CREATE PROCEDURE eliminar_paciente(
    IN p_id INT
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
        VALUES('Pacientes', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    IF EXISTS (SELECT 1 FROM Pacientes WHERE id_paciente = p_id) THEN
        
        DELETE FROM Pacientes
        WHERE id_paciente = p_id;

        COMMIT;
        SELECT 'Paciente eliminado correctamente' AS mensaje;

    ELSE
        ROLLBACK;
        SELECT 'Paciente no existe' AS mensaje;
    END IF;

END$$

DELIMITER ;

CALL eliminar_paciente(4);