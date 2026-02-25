DROP PROCEDURE IF EXISTS listar_facultad;
DELIMITER $$

CREATE PROCEDURE listar_facultad(IN p_id INT)
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

    IF p_id IS NULL THEN
        SELECT * FROM Facultad_Origen;
    ELSE
        SELECT * FROM Facultad_Origen
        WHERE id_facultad = p_id;
    END IF;

END$$
DELIMITER ;

CALL listar_facultad(NULL);