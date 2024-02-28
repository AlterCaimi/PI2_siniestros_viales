CREATE DATABASE siniestros;

USE siniestros;

SELECT @@global.secure_file_priv;
-- 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

SET GLOBAL local_infile=true;
DROP TABLE IF EXISTS homicidios;
CREATE TABLE homicidios (
	ID VARCHAR(10) NOT NULL PRIMARY KEY,
    n_victimas INT,
    fecha DATE,
    año INT,
    mes INT,
    dia INT,
    hora TIME,
    franja_horaria INT,
    tipo_de_calle VARCHAR(20),
    comuna INT,
    longitud DECIMAL(10,8),
    latitud DECIMAL(10,8),
    participantes VARCHAR(50),
    victima VARCHAR(50),
    acusado VARCHAR(50)
);

TRUNCATE TABLE homicidios;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/homicidios_hechos.csv'
INTO TABLE homicidios
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM homicidios LIMIT 10;

DROP TABLE IF EXISTS victima;
CREATE TABLE victima (
	ID_victima INT NOT NULL auto_increment primary key,
	ID_hecho VARCHAR(10),
    fecha DATE,
    año INT,
    mes INT,
    dia INT, 
    rol VARCHAR(30),
    victima VARCHAR(20),
    sexo VARCHAR(20),
    edad INT NULL
    )
;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/homicidios_victimas.csv'
INTO TABLE victima
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_hecho, fecha , año , mes , dia , rol , victima , sexo , edad )
;

SELECT * FROM victima LIMIT 10;	

UPDATE victima
SET edad = NULL
WHERE edad = 0;

select * from victima
where edad < 2;

CREATE TABLE poblacion (
	comuna VARCHAR(6),
    año INT,
    poblacion INT
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/poblacion_large.csv'
INTO TABLE poblacion
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

