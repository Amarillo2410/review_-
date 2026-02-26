DROP PROCEDURE IF EXISTS actualizar_hospital;
DELIMITER $$

CREATE PROCEDURE actualizar_hospital(
    IN p_id INT,
    IN p_sede VARCHAR(150),
    IN p_dir VARCHAR(150)
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
        VALUES('Hospitales', v_codigo_error, v_mensaje);
    END;

    UPDATE Hospitales
    SET hospital_sede = p_sede,
        dir_sede = p_dir
    WHERE id_hospital = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe el hospital' AS mensaje;
    ELSE
        SELECT 'Hospital actualizado correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;


CALL actualizar_hospital(2,'Sede Sur','Calle 80 #45-20');