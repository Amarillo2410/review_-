DROP PROCEDURE IF EXISTS eliminar_receta;
DELIMITER $$

CREATE PROCEDURE eliminar_receta(IN p_id INT)
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

    DELETE FROM Recetas
    WHERE id_receta = p_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'No existe la receta para eliminar' AS mensaje;
    ELSE
        SELECT 'Receta eliminada correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL eliminar_receta(4);