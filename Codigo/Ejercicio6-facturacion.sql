CREATE DATABASE Facturacion;
GO

USE Facturacion;
GO

CREATE TABLE Proveedores (
    CodProveedor_Pr INT IDENTITY(1,1) PRIMARY KEY,
    RazonSocial_Pr VARCHAR(100) NOT NULL,
    Direccion_Pr VARCHAR(150),
    Cuidad_Pr VARCHAR(50),
    Provincia_Pr VARCHAR(50),
    Cuil_Pr VARCHAR(13),
    Telefono_Pr VARCHAR(20),
    Contacto_Pr VARCHAR(100),
    Web_Pr VARCHAR(150),
    Email_Pr VARCHAR(100)
);
GO

CREATE TABLE Articulos (
    CodArticulo_Ar INT IDENTITY(1,1) PRIMARY KEY,
    CodProveedor_Ar INT NOT NULL,
    Descripcion_Ar VARCHAR(100) NOT NULL,
    Stock_Ar INT,
    PrecioUnitario_Ar DECIMAL(12,2),

    CONSTRAINT FK_Articulos_Proveedores
        FOREIGN KEY (CodProveedor_Ar)
        REFERENCES Proveedores(CodProveedor_Pr)
);
GO

CREATE TABLE Clientes (
    Dni_Cl VARCHAR(15) PRIMARY KEY,
    Nombre_Cl VARCHAR(50),
    Apellido_Cl VARCHAR(50),
    Direccion_Cl VARCHAR(150),
    Telefono_Cl VARCHAR(20)
);
GO

CREATE TABLE Cuentas (
    CodCuenta_Cu INT IDENTITY(1,1) PRIMARY KEY,
    Dni_Cu VARCHAR(15) NOT NULL UNIQUE,
    LimiteCuenta_Cu DECIMAL(12,2),
    SaldoCuenta_Cu DECIMAL(12,2),

    CONSTRAINT FK_Cuentas_Clientes
        FOREIGN KEY (Dni_Cu)
        REFERENCES Clientes(Dni_Cl)
);
GO

CREATE TABLE Facturas (
    CodFactura_Fa INT IDENTITY(1,1) PRIMARY KEY,
    CodCuenta_Fa INT NOT NULL,
    TotalFactura_Fa DECIMAL(12,2),
    FechaFactura_Fa DATE,

    CONSTRAINT FK_Facturas_Cuentas
        FOREIGN KEY (CodCuenta_Fa)
        REFERENCES Cuentas(CodCuenta_Cu)
);
GO

CREATE TABLE DetalleFactura (
    CodFactura_Df INT NOT NULL,
    CodProveedor_Df INT NOT NULL,
    CodArticulo_Df INT NOT NULL,
    Cantidad_Df INT,
    PrecioUnitario_Df DECIMAL(12,2),

    CONSTRAINT PK_DetalleFactura
        PRIMARY KEY (CodFactura_Df, CodArticulo_Df),

    CONSTRAINT FK_DetalleFactura_Facturas
        FOREIGN KEY (CodFactura_Df)
        REFERENCES Facturas(CodFactura_Fa),

    CONSTRAINT FK_DetalleFactura_Proveedores
        FOREIGN KEY (CodProveedor_Df)
        REFERENCES Proveedores(CodProveedor_Pr),

    CONSTRAINT FK_DetalleFactura_Articulos
        FOREIGN KEY (CodArticulo_Df)
        REFERENCES Articulos(CodArticulo_Ar)
);
GO

INSERT INTO Proveedores (
    RazonSocial_Pr,
    Direccion_Pr,
    Cuidad_Pr,
    Provincia_Pr,
    Cuil_Pr,
    Telefono_Pr,
    Contacto_Pr,
    Web_Pr,
    Email_Pr
)
VALUES
    (
        'Distribuidora Central',
        'Av. Rivadavia 1500',
        'Moron',
        'Buenos Aires',
        '30-12345678-9',
        '1144556677',
        'Juan Perez',
        'www.central.com.ar',
        'central@email.com'
    ),
    (
        'Comercial del Sur',
        'San Martin 850',
        'La Matanza',
        'Buenos Aires',
        '30-23456789-0',
        '1144667788',
        'Maria Lopez',
        'www.comercialsur.com.ar',
        'sur@email.com'
    ),
    (
        'Insumos Argentinos',
        'Belgrano 420',
        'Lomas de Zamora',
        'Buenos Aires',
        '30-34567890-1',
        '1144778899',
        'Carlos Gomez',
        'www.insumos.com.ar',
        'insumos@email.com'
    );
GO

INSERT INTO Articulos (
    CodProveedor_Ar,
    Descripcion_Ar,
    Stock_Ar,
    PrecioUnitario_Ar
)
VALUES
    (1, 'Teclado', 50, 15000.00),
    (1, 'Mouse', 80, 8500.00),
    (2, 'Monitor', 20, 180000.00),
    (2, 'Impresora', 15, 125000.00),
    (3, 'Cable USB', 100, 3500.00),
    (3, 'Auriculares', 40, 22000.00);
GO

INSERT INTO Clientes (
    Dni_Cl,
    Nombre_Cl,
    Apellido_Cl,
    Direccion_Cl,
    Telefono_Cl
)
VALUES
    ('30111222', 'Miguel', 'Salazar', 'San Justo 120', '1111222233'),
    ('31222333', 'Laura', 'Fernandez', 'Ramos Mejia 450', '1122334455'),
    ('32333444', 'Pedro', 'Martinez', 'Moron 780', '1133445566');
GO

INSERT INTO Cuentas (
    Dni_Cu,
    LimiteCuenta_Cu,
    SaldoCuenta_Cu
)
VALUES
    ('30111222', 500000.00, 15000.00),
    ('31222333', 300000.00, 45000.00),
    ('32333444', 200000.00, 0.00);
GO

INSERT INTO Facturas (
    CodCuenta_Fa,
    TotalFactura_Fa,
    FechaFactura_Fa
)
VALUES
    (1, 38500.00, '2026-10-20'),
    (1, 180000.00, '2026-10-22'),
    (2, 125000.00, '2026-10-23'),
    (3, 25500.00, '2026-10-24');
GO

INSERT INTO DetalleFactura (
    CodFactura_Df,
    CodProveedor_Df,
    CodArticulo_Df,
    Cantidad_Df,
    PrecioUnitario_Df
)
VALUES
    (1, 1, 1, 2, 15000.00),
    (1, 1, 2, 1, 8500.00),
    (2, 2, 3, 1, 180000.00),
    (3, 2, 4, 1, 125000.00),
    (4, 3, 5, 1, 3500.00),
    (4, 3, 6, 1, 22000.00);
GO