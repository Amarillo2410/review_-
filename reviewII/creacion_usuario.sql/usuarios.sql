/* creacion de secretario, puede: añadir,ver,actualizar,alterar y borrar informacion de la tabla 
citas */

CREATE USER 'secretario'@'localhost' IDENTIFIED BY 'secretario1234';

GRANT SELECT, INSERT, UPDATE, DELETE,ALTER
ON reviewII.citas
TO 'secretario'@'localhost';


/* creaacion del usuario medico el cual puede ver la informacion de los pacientes,actualizarla
*/
CREATE USER 'medico'@'localhost' IDENTIFIED BY 'medico1234';

GRANT SELECT,UPDATE,DELETE,ALTER
ON reviewII.pacientes
TO 'medico'@'localhost';


/* creacion del usuario paciente el cual solo puede ver su informacion
y las citas que tiene programadas colocanto tambien datos personales*/

CREATE USER 'paciente'@'localhost' IDENTIFIED BY 'paciente1234';

GRANT SELECT,UPDATE
ON reviewII.pacientes
TO 'paciente'@'localhost';

/*se crea el usuario gerente el cual tendra todos los permisos de la empresa*/
CREATE USER 'generente'@'localhost' IDENTIFIED BY 'gerente1234';

GRANT ALL PRIVILEGES
ON reviewII.*
TO 'generente'@'localhost'
WITH GRANT OPTION;

