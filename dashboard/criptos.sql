CREATE DATABASE IF NOT EXISTS criptos;

USE criptos;

-- Crear tabla datos (criptos)
CREATE TABLE IF NOT EXISTS datos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cripto VARCHAR(50) NOT NULL,
    simbolo VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    INDEX idx_id_cripto (id_cripto)
);

-- Cargar datos en la tabla datos (criptos)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/criptos.csv'
INTO TABLE datos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dummy, id_cripto, simbolo, nombre);

-- Crear tabla historial con clave externa hacia la tabla datos
CREATE TABLE IF NOT EXISTS historial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cripto VARCHAR(50) NOT NULL,
    precio DECIMAL(18, 6) NOT NULL,
    fecha VARCHAR(50) NOT NULL,
    ranking_capitalizacion INT NOT NULL,
    capitalizacion BIGINT NOT NULL,
    volumen DECIMAL(18, 6) NOT NULL,
    FOREIGN KEY (id_cripto) REFERENCES datos(id_cripto)
);

-- Cargar datos en la tabla historial
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/historial.csv'
INTO TABLE historial
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dummy, id_cripto, precio, fecha, ranking_capitalizacion, capitalizacion, volumen);

-- Consultar registros relacionados
SELECT datos.*, historial.*
FROM datos
JOIN historial ON datos.id_cripto = historial.id_cripto;

select * from historial;
