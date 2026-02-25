DROP PROCEDURE IF EXISTS crear_cita;
DELIMITER $$

CREATE PROCEDURE crear_cita(
    IN p_codigo VARCHAR(10),
    IN p_fecha DATE,
    IN p_id_hospital INT,
    IN p_id_paciente INT,
    IN p_id_medico INT
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
        VALUES('Citas', v_codigo_error, v_mensaje);
    END;

    START TRANSACTION;

    -- Validar hospital
    IF NOT EXISTS (SELECT 1 FROM Hospitales WHERE id_hospital = p_id_hospital) THEN
        ROLLBACK;
        SELECT 'El hospital no existe' AS mensaje;

    -- Validar paciente
    ELSEIF NOT EXISTS (SELECT 1 FROM Pacientes WHERE id_paciente = p_id_paciente) THEN
        ROLLBACK;
        SELECT 'El paciente no existe' AS mensaje;

    -- Validar médico
    ELSEIF NOT EXISTS (SELECT 1 FROM Medicos WHERE id_medico = p_id_medico) THEN
        ROLLBACK;
        SELECT 'El médico no existe' AS mensaje;

    -- Validar código repetido
    ELSEIF EXISTS (SELECT 1 FROM Citas WHERE cod_cita = p_codigo) THEN
        ROLLBACK;
        SELECT 'El código de la cita ya existe' AS mensaje;

    ELSE
        INSERT INTO Citas(cod_cita, fecha_cita, id_hospital, id_paciente, id_medicos)
        VALUES(p_codigo, p_fecha, p_id_hospital, p_id_paciente, p_id_medico);

        COMMIT;
        SELECT 'Cita creada correctamente' AS mensaje;
    END IF;

END$$
DELIMITER ;

CALL crear_cita('C-001','2026-02-20',1,3,2);