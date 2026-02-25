DROP PROCEDURE IF EXISTS crear_hospital;
DELIMITER $$

CREATE PROCEDURE crear_hospital(
    IN p_sede VARCHAR(150),
    IN p_dir VARCHAR(150)
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
        VALUES('Hospitales', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 FROM Hospitales 
        WHERE hospital_sede = p_sede
    ) THEN

        INSERT INTO Hospitales(hospital_sede, dir_sede)
        VALUES(p_sede, p_dir);

        COMMIT;
        SELECT 'Hospital creado correctamente' AS mensaje;

    ELSE
        ROLLBACK;
        SELECT 'La sede ya existe' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL crear_hospital('Sede Norte','Av 45 #12-30');