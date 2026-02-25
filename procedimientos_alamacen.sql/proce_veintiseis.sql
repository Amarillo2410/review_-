DROP PROCEDURE IF EXISTS actualizar_receta;
DELIMITER $$

CREATE PROCEDURE actualizar_receta(
    IN p_id INT,
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

    UPDATE Recetas
    SET id_diagnostico = p_id_diagnostico,
        medicamento_recetado = p_medicamento,
        dosis_medicamento = p_dosis,
        id_cita = p_id_cita
    WHERE id_receta = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe la receta para actualizar' AS mensaje;
    ELSE
        SELECT 'Receta actualizada correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL actualizar_receta(4,2,'Ibuprofeno','400mg cada 6 horas',5 );