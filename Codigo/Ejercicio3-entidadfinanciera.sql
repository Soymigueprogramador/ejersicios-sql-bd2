CREATE DATABASE EntidadFinanciera;
GO

USE EntidadFinanciera;
GO

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    dni VARCHAR(20),
    direccion VARCHAR(150)
);

CREATE TABLE SUCURSAL (
    id_sucursal INT PRIMARY KEY,
    ciudad VARCHAR(50),
    direccion_sucursal VARCHAR(150)
);

CREATE TABLE CUENTA (
    id_cuenta INT PRIMARY KEY,
    numero_cuenta INT,
    tipo_cuenta VARCHAR(20),
    saldo_cuenta DECIMAL(12,2),
    cbu VARCHAR(22),
    id_sucursal INT,
    FOREIGN KEY (id_sucursal) REFERENCES SUCURSAL(id_sucursal),
    UNIQUE (numero_cuenta, id_sucursal),
    UNIQUE (cbu),
    CHECK (tipo_cuenta IN ('Caja de ahorro', 'Plazo fijo'))
);

CREATE TABLE CLIENTE_CUENTA (
    id_cliente INT,
    id_cuenta INT,
    PRIMARY KEY (id_cliente, id_cuenta),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_cuenta)
);

CREATE TABLE TRANSACCION (
    num_transaccion INT PRIMARY KEY,
    id_cuenta_principal INT,
    fecha DATE,
    monto DECIMAL(12,2),
    tipo_transaccion VARCHAR(20),
    cbu_cuenta_destino VARCHAR(22),
    FOREIGN KEY (id_cuenta_principal) REFERENCES CUENTA(id_cuenta),
    FOREIGN KEY (cbu_cuenta_destino) REFERENCES CUENTA(cbu),
    CHECK (tipo_transaccion IN ('Extracción', 'Depósito', 'Movimiento'))
);