CREATE TABLE IF NOT EXISTS informe_diario (
    sede VARCHAR(30),
    medico VARCHAR(30),
    fecha DATE,
    numero_pacientes INT,
    PRIMARY KEY (sede, medico, fecha)
);



DELIMITER $$

CREATE TRIGGER generar_informe_diario
AFTER INSERT ON citas
FOR EACH ROW
BEGIN

    INSERT INTO informe_diario (sede, medico, fecha, numero_pacientes)
    SELECT 
        h.hospital_sede,
        m.nombre_medico,
        NEW.fecha_cita,
        1
    FROM hospitales h, medicos m
    WHERE h.id_hospital = NEW.id_hospital
      AND m.id_medicos = NEW.id_medicos
    ON DUPLICATE KEY UPDATE
        numero_pacientes = numero_pacientes + 1;

END$$

DELIMITER ;