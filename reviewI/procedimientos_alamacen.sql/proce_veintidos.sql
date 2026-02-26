DELIMITER $$

CREATE PROCEDURE listar_cita(IN p_id INT)
BEGIN
    DECLARE v_codigo INT;
    DECLARE v_mensaje TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO Log_Errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('Citas', v_codigo, v_mensaje);
    END;

    SELECT *
    FROM Citas
    WHERE id_cita = p_id OR p_id IS NULL;
END$$

DELIMITER ;
CALL listar_cita(NULL);