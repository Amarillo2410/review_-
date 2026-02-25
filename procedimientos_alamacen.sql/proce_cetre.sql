DROP PROCEDURE IF EXISTS crear_diagnostico;
DELIMITER $$

CREATE PROCEDURE crear_diagnostico(
    IN p_diagnostico VARCHAR(150)
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
        VALUES('Diagnosticos', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 FROM Diagnosticos
        WHERE diagnostico = p_diagnostico
    ) THEN

        INSERT INTO Diagnosticos(diagnostico)
        VALUES(p_diagnostico);

        COMMIT;
        SELECT 'Diagnóstico creado correctamente' AS mensaje;

    ELSE
        ROLLBACK;
        SELECT 'El diagnóstico ya existe' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL crear_diagnostico('Hipertensión');