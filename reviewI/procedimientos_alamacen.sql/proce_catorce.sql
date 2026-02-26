DROP PROCEDURE IF EXISTS listar_diagnostico;
DELIMITER $$

CREATE PROCEDURE listar_diagnostico(IN p_id INT)
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

    IF p_id IS NULL THEN
        SELECT * FROM Diagnosticos;
    ELSE
        SELECT *
        FROM Diagnosticos
        WHERE id_diagnostico = p_id;
    END IF;

END$$
DELIMITER ;

CALL listar_diagnostico(NULL);
