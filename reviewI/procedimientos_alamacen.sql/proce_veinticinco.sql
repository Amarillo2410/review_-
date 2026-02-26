DROP PROCEDURE IF EXISTS listar_receta;
DELIMITER $$

CREATE PROCEDURE listar_receta(IN p_id INT)
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

    IF p_id IS NULL THEN
        SELECT * FROM Recetas;
    ELSE
        SELECT *
        FROM Recetas
        WHERE id_receta = p_id;

        IF ROW_COUNT() = 0 THEN
            SELECT 'No existe la receta' AS mensaje;
        END IF;
    END IF;

END$$
DELIMITER ;

CALL listar_receta(NULL);