--CONSULTAS 

--LISTA DE ESPACIOS DE TRABAJO


SELECT *
FROM coworking.espacio
LEFT JOIN coworking.reservas ON coworking.espacio.espacios_ID = coworking.reservas.espacios_ID
WHERE coworking.reservas.sesion_ID = 72 
  AND (coworking.reservas.reserva_ID IS NULL OR coworking.reservas.status = 'cancelled'); 


SELECT *
FROM coworking.espacio
LEFT JOIN coworking.reservas ON coworking.espacio.espacios_ID = coworking.reservas.espacios_ID
WHERE coworking.reservas.sesion_ID = 30
  AND (coworking.reservas.reserva_ID IS NULL OR coworking.reservas.status = 'confirmed');
  
   

SELECT
    coworking.sesiones.sesion_ID,
    coworking.sesiones.nombre,
    coworking.sesiones.hora_inicio,
    coworking.sesiones.hora_fin,
    COUNT (coworking.reservas.reserva_ID) AS numero_reservas
FROM coworking.sesiones
LEFT JOIN coworking.reservas ON coworking.sesiones.sesion_ID = coworking.reservas.sesion_ID
GROUP BY 
    coworking.sesiones.sesion_ID,
    coworking.sesiones.nombre,
    coworking.sesiones.hora_inicio,
    coworking.sesiones.hora_fin
ORDER BY numero_reservas DESC;



SELECT
    s.sesion_id,
    s.nombre,
    s.hora_inicio,
    s.hora_fin,
    COALESCE(COUNT(r.reserva_id), 0) AS num_reservas
FROM
    coworking.sesiones s
LEFT JOIN
    coworking.reservas r ON s.sesion_id = r.sesion_id
GROUP BY
    s.sesion_id, s.nombre, s.hora_inicio, s.hora_fin
ORDER BY
    num_reservas ASC;


/*  Asigned SESIONES */
SELECT 
 coworking.sesiones.sesion_ID,
 coworking.sesiones.nombre,
 coworking.espacio.espacios_ID,
 coworking.espacio.fila,
 coworking.espacio.columna
 FROM coworking.sesiones
 JOIN coworking.reservas ON coworking.sesiones.sesion_ID = coworking.reservas.sesion_ID
 JOIN coworking.espacio ON coworking.reservas.espacios_ID = coworking.espacio.espacios_ID
 WHERE coworking.sesiones.sesion_ID = 30




/* Assignes Users*/

SELECT
coworking.usuarios.usuario_ID,
coworking.usuarios.nombre,
coworking.usuarios.apellido,
coworking.espacio.espacios_ID,
coworking.espacio.fila,
coworking.espacio.columna,
coworking.reservas.status
FROM coworking.usuarios
JOIN coworking.reservas ON coworking.usuarios.usuario_ID = coworking.reservas.usuario_ID
JOIN coworking.espacio ON coworking.reservas.espacios_ID = coworking.espacio.espacios_ID
WHERE coworking.usuarios.usuario_ID = 14