INSERT INTO coworking.espacio (sala_ID, fila, columna)
SELECT
    salas.sala_ID,
    FLOOR(RANDOM() * 10) + 1, -- Fila aleatoria entre 1 y 10
    CHR((FLOOR(RANDOM() * 26) + 65)::INT) || (FLOOR(RANDOM() * 10) + 1)::TEXT -- Columna aleatoria como A1, B2, ..., Z10
FROM
    (SELECT sala_ID FROM coworking.salas ORDER BY RANDOM() LIMIT 100) AS salas
CROSS JOIN
    generate_series(1, 10);
    

INSERT INTO coworking.sesiones (nombre, hora_inicio, hora_fin)
SELECT
    'Sesión ' || generate_series(1, 100), -- Nombres de sesión como "Sesión 1", "Sesión 2", ..., "Sesión 100"
    TIME '08:00:00' + (RANDOM() * (TIME '10:00:00' - TIME '08:00:00')), -- Horarios de inicio aleatorios entre las 08:00 y las 10:00
    TIME '09:00:00' + (RANDOM() * (TIME '12:00:00' - TIME '09:00:00'))  -- Horarios de fin aleatorios entre las 10:00 y las 12:00
FROM
    generate_series(1, 100);



DO $$
DECLARE
    statuses TEXT[] := ARRAY['confirmed', 'cancelled'];
    i INTEGER;
    randomUserId INTEGER;
    randomWorkspaceId INTEGER;
    randomSessionId INTEGER;
    randomReservationTime TIMESTAMP;
    randomStatus VARCHAR(20);

BEGIN
    FOR i IN 1..160 LOOP
        
        randomUserId := 1 + (random() * 100)::integer;
        randomWorkspaceId := 1 + (random() * 100)::integer;
        randomSessionId := 1 + (random() * 100)::integer;
        randomReservationTime := NOW() + (random() * INTERVAL '30 days'); 
        randomStatus := statuses[1 + (random() * array_length(statuses, 1))::integer];
      

        IF randomStatus IS NULL THEN
            randomStatus := 'confirmed';
        END IF;

        IF EXISTS (SELECT 1 FROM coworking.usuarios WHERE usuario_ID = randomUserId) AND
           EXISTS (SELECT 1 FROM coworking.espacio WHERE espacios_ID = randomWorkspaceId
                    AND NOT EXISTS (
                        SELECT 1 FROM coworking.reservas
                        WHERE espacios_ID = randomWorkspaceId
                        AND sesion_ID = randomSessionId
                        AND (status = 'confirmed' OR status IS NULL)
                    )) AND
           EXISTS (SELECT 1 FROM coworking.sesiones WHERE sesion_ID = randomSessionId) THEN
           
            INSERT INTO coworking.reservas (usuario_ID, espacios_ID, sesion_ID, fecha, status)
            VALUES (randomUserId, randomWorkspaceId, randomSessionId, randomReservationTime, randomStatus);
           
        END IF;
        
    END LOOP;
END $$;

SELECT * FROM coworking.reservas

