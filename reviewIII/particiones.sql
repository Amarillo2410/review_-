/*PARTICION DE FECHA DE CITAS*/

CREATE TABLE citas (
    id_citas INT NOT NULL,
    cod_citas INT,
    fecha_cita DATE NOT NULL,
    id_hospital INT,
    id_pacientes INT,
    id_medicos INT,
    PRIMARY KEY (id_citas, fecha_cita)
)
PARTITION BY RANGE (YEAR(fecha_cita)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);


/*Paertion de recetas por medicamento */
CREATE TABLE recetas (
    id_recetas INT NOT NULL,
    medicamento VARCHAR(50) NOT NULL,
    id_citas INT,
    
    PRIMARY KEY (id_recetas, medicamento)
)
PARTITION BY LIST COLUMNS(medicamento) (
    PARTITION p_analgesicos VALUES IN ('Ibuprofeno', 'Paracetamol'),
    PARTITION p_antibioticos VALUES IN ('Amoxicilina'),
    PARTITION p_otros VALUES IN ('Otro')
);