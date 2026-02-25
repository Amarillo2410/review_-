INSERT INTO facultad_origen (id_facultad, facultad, decano) VALUES
(1, 'Medicina', 'Dr. Wilson'),
(2, 'Ciencias', 'Dr. Palmer');

INSERT INTO hospitales (id_hospital, hospital_sede, direccion_sede) VALUES
(1, 'Centro Médico', 'Calle 5 #10'),
(2, 'Clínica Norte', 'Av. Libertador');

INSERT INTO pacientes (id_pacientes, codigo, nombre_paciente, apellido_pacinete, telefonno) VALUES
(1, 501, 'Juan', 'Rivas', 600111),
(2, 502, 'Ana', 'Soto', 600222),
(3, 503, 'Luis', 'Paz', 600333);

INSERT INTO medicos (id_medicos, medico_id, nombre_medico, especialidad, id_facultad) VALUES
(1, 10, 'Dr. House', 'Infectología', 1),
(2, 20, 'Dra. Grey', 'Cardiología', 1),
(3, 30, 'Dr. Strange', 'Neurología', 2);

INSERT INTO citas (id_citas, cod_citas, fecha_cita, id_hospital, id_pacientes, id_medicos) VALUES
(1, 1001, '2024-05-10', 1, 1, 1),
(2, 1002, '2024-05-11', 1, 2, 2),
(3, 1003, '2024-05-12', 2, 1, 3),
(4, 1004, '2024-05-15', 2, 3, 1);

INSERT INTO diagnosticos (id_diagnosticos, medicamento_recetas) VALUES
(1, 'Gripe Fuerte'),
(2, 'Infección'),
(3, 'Arritmia'),
(4, 'Migraña');

INSERT INTO recetas (id_recetas, medicamento, dosis, id_citas, id_diagnosticos) VALUES
(1, 'Paracetamol', 500, 1, 1),
(2, 'Ibuprofeno', 400, 1, 1),
(3, 'Amoxicilina', 875, 2, 2),
(4, 'Aspirina', 100, 3, 3),
(5, 'Ergotamina', 1, 4, 4);

