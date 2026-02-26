DELIMITER $$

CREATE FUNCTION pacientes_atendidos(p_id_medico INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_codigo INT;
    DECLARE v_mensaje TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO log_errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('citas', v_codigo, v_mensaje);

        RETURN 0;
    END;

    SELECT COUNT(DISTINCT id_pacientes)
    INTO v_total
    FROM citas
    WHERE id_medicos = p_id_medico;

    RETURN v_total;
END$$

DELIMITER ;

SELECT pacientes_atendidos(1) AS total_pacientes;