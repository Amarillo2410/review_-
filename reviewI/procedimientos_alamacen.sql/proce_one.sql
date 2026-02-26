/*creacion pacientes*/

DROP PROCEDURE IF EXISTS crear_paciente;
DELIMITER $$

CREATE PROCEDURE crear_paciente(
    IN p_codigo VARCHAR(10),
    IN p_nombre VARCHAR(60),
    IN p_apellido VARCHAR(60),
    IN p_telefono VARCHAR(20)
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
        VALUES('Pacientes', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    INSERT INTO Pacientes(codigo, nombre_paciente, apellido_paciente, telefono_paciente)
    VALUES(p_codigo, p_nombre, p_apellido, p_telefono);

    COMMIT;
END$$

DELIMITER ;


CALL crear_paciente('P-504','Juan','Perez','600-888');