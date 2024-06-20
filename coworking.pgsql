CREATE SCHEMA coworking;

CREATE TABLE coworking.usuarios (
    usuario_ID SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    telefono INT
);

SELECT * FROM coworking.usuarios

CREATE TABLE coworking.salas (
    sala_ID SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    fila_num INT,
    colum_num INT
);

SELECT * FROM coworking.salas

CREATE TABLE coworking.espacio (
    espacios_ID SERIAL PRIMARY KEY,
    sala_ID INT REFERENCES coworking.salas (sala_ID),
    fila INT,
    columna VARCHAR(50)
);

SELECT * FROM coworking.espacio

CREATE TABLE coworking.sesiones (
    sesion_ID SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    hora_inicio TIME,
    hora_fin TIME
);

SELECT * FROM coworking.sesiones

CREATE TABLE coworking.reservas (
    reserva_ID SERIAL PRIMARY KEY,
    usuario_ID INT REFERENCES coworking.usuarios (usuario_ID),
    espacios_ID INT REFERENCES coworking.espacio (espacios_ID),
    sesion_ID INT REFERENCES coworking.sesiones (sesion_ID),
    fecha DATE,
    status VARCHAR(20) NOT NULL
);

SELECT * FROM coworking.reservas

DROP TABLE coworking.reservas;