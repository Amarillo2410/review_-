DELIMITER $$

CREATE PROCEDURE crear_receta(
    IN p_id_diagnostico INT,
    IN p_medicamento VARCHAR(150),
    IN p_dosis VARCHAR(50),
    IN p_id_cita INT
)
BEGIN
    DECLARE v_codigo INT;
    DECLARE v_mensaje TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;

        INSERT INTO Log_Errores(nombre_tabla, codigo_error, mensaje_error)
        VALUES('Recetas', v_codigo, v_mensaje);
    END;

    INSERT INTO Recetas(id_diagnostico, medicamento_recetado, dosis_medicamento, id_cita)
    VALUES(p_id_diagnostico, p_medicamento, p_dosis, p_id_cita);
END$$

DELIMITER ;

CALL crear_receta(2, 'Amoxicilina','500mg cada 8 horas',5);