DROP PROCEDURE IF EXISTS buscar_paciente;
DELIMITER $$

CREATE PROCEDURE buscar_paciente(
    IN p_id INT
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
        VALUES('Pacientes', v_codigo_error, v_mensaje);
    END;

    SELECT * 
    FROM Pacientes
    WHERE id_paciente = p_id;

END$$

DELIMITER ;

CALL buscar_paciente(1);