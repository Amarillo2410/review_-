/* 
realizar procedimiento de almacenar,actualizar y borrar
*/
create database reviewII;

use reviewII;




CREATE TABLE facultad_origen(
    id_facultad INT PRIMARY KEY,
    facultad VARCHAR(30),
    decano VARCHAR(30)
);

CREATE TABLE hospitales(
    id_hospital INT PRIMARY KEY,
    hospital_sede VARCHAR(30) NOT NULL,
    direccion_sede VARCHAR(30) NOT NULL
);

CREATE TABLE pacientes(
    id_pacientes INT PRIMARY KEY,
    codigo INT,
    nombre_paciente VARCHAR(20) NOT NULL,
    apellido_pacinete VARCHAR(20),
    telefonno NUMERIC(10)
);

CREATE TABLE medicos(
    id_medicos INT PRIMARY KEY,
    medico_id INT,
    nombre_medico VARCHAR(30) NOT NULL,
    especialidad VARCHAR(30),
    id_facultad INT,
    FOREIGN KEY (id_facultad) REFERENCES facultad_origen(id_facultad)
);

CREATE TABLE citas(
    id_citas INT PRIMARY KEY,
    cod_citas INT UNIQUE,
    fecha_cita DATE NOT NULL,
    id_hospital INT,
    id_pacientes INT,
    id_medicos INT,
    FOREIGN KEY (id_hospital) REFERENCES hospitales(id_hospital),
    FOREIGN KEY (id_pacientes) REFERENCES pacientes(id_pacientes),
    FOREIGN KEY (id_medicos) REFERENCES medicos(id_medicos)
);

CREATE TABLE diagnosticos(
    id_diagnosticos INT PRIMARY KEY,
    medicamento_recetas VARCHAR(30)
);

CREATE TABLE recetas(
    id_recetas INT PRIMARY KEY,
    medicamento VARCHAR(30),
    dosis FLOAT,
    id_citas INT NOT NULL,
    id_diagnosticos INT NOT NULL,
    FOREIGN KEY (id_citas) REFERENCES citas(id_citas),
    FOREIGN KEY (id_diagnosticos) REFERENCES diagnosticos(id_diagnosticos)
);
