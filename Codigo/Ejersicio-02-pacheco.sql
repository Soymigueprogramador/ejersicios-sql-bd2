CREATE DATABASE Pacheco;
GO

USE Pacheco;
GO

CREATE TABLE PROVEEDOR (
    cod_proveedor INT PRIMARY KEY,
    razon_social VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    cuit VARCHAR(11),
    cbu VARCHAR(22),
    telefono VARCHAR(30),
    contacto VARCHAR(100),
    web VARCHAR(150),
    mail VARCHAR(150)
);

CREATE TABLE ARTICULO (
    cod_articulo INT PRIMARY KEY,
    nombre VARCHAR(100),
    cantidad INT,
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE CLIENTE (
    cod_cliente INT PRIMARY KEY,
    razon_social VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    cuit VARCHAR(11),
    telefono VARCHAR(30),
    contacto VARCHAR(100),
    web VARCHAR(150),
    mail VARCHAR(150)
);

CREATE TABLE PROVEEDOR_ARTICULO (
    cod_proveedor INT,
    cod_articulo INT,
    PRIMARY KEY (cod_proveedor, cod_articulo),
    FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(cod_proveedor),
    FOREIGN KEY (cod_articulo) REFERENCES ARTICULO(cod_articulo)
);

CREATE TABLE VENTA (
    num_factura INT PRIMARY KEY,
    cod_cliente INT,
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)
);

CREATE TABLE DETALLE_VENTA (
    num_factura INT,
    cod_articulo INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    PRIMARY KEY (num_factura, cod_articulo),
    FOREIGN KEY (num_factura) REFERENCES VENTA(num_factura),
    FOREIGN KEY (cod_articulo) REFERENCES ARTICULO(cod_articulo)
);