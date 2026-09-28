CREATE DATABASE Farmacia;
GO

USE Farmacia;
GO

CREATE TABLE LABORATORIO (
    cod_laboratorio INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(30),
    direccion VARCHAR(150),
    mail VARCHAR(150),
    contacto VARCHAR(100)
);

CREATE TABLE FAMILIA (
    cod_familia INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE MEDICAMENTO (
    cod_medicamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo_medicamento VARCHAR(50),
    unidades_stock INT,
    punto_pedido INT,
    precio DECIMAL(10,2),
    venta_libre BIT,
    cod_laboratorio INT,
    FOREIGN KEY (cod_laboratorio) REFERENCES LABORATORIO(cod_laboratorio)
);

CREATE TABLE MEDICAMENTO_FAMILIA (
    cod_medicamento INT,
    cod_familia INT,
    PRIMARY KEY (cod_medicamento, cod_familia),
    FOREIGN KEY (cod_medicamento) REFERENCES MEDICAMENTO(cod_medicamento),
    FOREIGN KEY (cod_familia) REFERENCES FAMILIA(cod_familia)
);

CREATE TABLE VENTA (
    cod_venta INT PRIMARY KEY
);

CREATE TABLE DETALLE_VENTA (
    cod_venta INT,
    cod_medicamento INT,
    cantidad INT,
    PRIMARY KEY (cod_venta, cod_medicamento),
    FOREIGN KEY (cod_venta) REFERENCES VENTA(cod_venta),
    FOREIGN KEY (cod_medicamento) REFERENCES MEDICAMENTO(cod_medicamento)
);