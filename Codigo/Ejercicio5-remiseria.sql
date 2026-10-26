CREATE DATABASE Remiseria;
GO

USE Remiseria;
GO

CREATE TABLE Propietario (
    Id_propietario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Dni VARCHAR(15) NOT NULL UNIQUE,
    Teléfono VARCHAR(20),
    email VARCHAR(100)
);
GO

CREATE TABLE Automóvil (
    Id_auto INT IDENTITY(1,1) PRIMARY KEY,
    Id_propietario INT NOT NULL,
    Patente VARCHAR(10) NOT NULL UNIQUE,
    Nro_movil INT NOT NULL UNIQUE,

    CONSTRAINT FK_Automovil_Propietario
        FOREIGN KEY (Id_propietario)
        REFERENCES Propietario(Id_propietario)
);
GO

CREATE TABLE Chofer (
    Id_chofer INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Dni VARCHAR(15) NOT NULL UNIQUE,
    Teléfono VARCHAR(20)
);
GO

CREATE TABLE Chofer_movil (
    Id_chofer INT NOT NULL,
    Id_movil INT NOT NULL,
    Fecha_autorizacion DATE NOT NULL,

    CONSTRAINT PK_Chofer_movil
        PRIMARY KEY (Id_chofer, Id_movil),

    CONSTRAINT FK_Chofer_movil_Chofer
        FOREIGN KEY (Id_chofer)
        REFERENCES Chofer(Id_chofer),

    CONSTRAINT FK_Chofer_movil_Automovil
        FOREIGN KEY (Id_movil)
        REFERENCES Automóvil(Id_auto)
);
GO

CREATE TABLE Viaje (
    Id_viaje INT IDENTITY(1,1) PRIMARY KEY,
    Id_chofer INT NOT NULL,
    Id_movil INT NOT NULL,
    Origen VARCHAR(100) NOT NULL,
    Destino VARCHAR(100) NOT NULL,
    Kilometro DECIMAL(10,2) NOT NULL,
    Fecha_hora DATETIME NOT NULL,

    CONSTRAINT FK_Viaje_Chofer_movil
        FOREIGN KEY (Id_chofer, Id_movil)
        REFERENCES Chofer_movil(Id_chofer, Id_movil),

    CONSTRAINT CK_Viaje_Kilometro
        CHECK (Kilometro > 0)
);
GO

CREATE TABLE Destino (
    Id_destino INT IDENTITY(1,1) PRIMARY KEY,
    Id_viaje INT NOT NULL,
    Orden INT NOT NULL,
    Lugar VARCHAR(100) NOT NULL,

    CONSTRAINT FK_Destino_Viaje
        FOREIGN KEY (Id_viaje)
        REFERENCES Viaje(Id_viaje),

    CONSTRAINT UQ_Destino_Viaje_Orden
        UNIQUE (Id_viaje, Orden)
);
GO

INSERT INTO Propietario (
    Nombre,
    Apellido,
    Dni,
    Teléfono,
    email
)
VALUES
    ('Carlos', 'Gomez', '20111222', '1122334455', 'carlos@email.com'),
    ('Maria', 'Lopez', '22333444', '1144556677', 'maria@email.com'),
    ('Roberto', 'Perez', '25444555', '1166778899', 'roberto@email.com');
GO

INSERT INTO Automóvil (
    Id_propietario,
    Patente,
    Nro_movil
)
VALUES
    (1, 'AB123CD', 101),
    (1, 'AC456EF', 102),
    (2, 'AD789GH', 103),
    (3, 'AE123JK', 104);
GO

INSERT INTO Chofer (
    Nombre,
    Apellido,
    Dni,
    Teléfono
)
VALUES
    ('Juan', 'Martinez', '30111222', '1111222233'),
    ('Pedro', 'Fernandez', '31222333', '1122334455'),
    ('Luis', 'Ramirez', '32333444', '1133445566');
GO

INSERT INTO Chofer_movil (
    Id_chofer,
    Id_movil,
    Fecha_autorizacion
)
VALUES
    (1, 1, '2026-01-10'),
    (1, 2, '2026-01-15'),
    (2, 1, '2026-02-01'),
    (2, 3, '2026-02-05'),
    (3, 2, '2026-02-10'),
    (3, 4, '2026-02-15');
GO

INSERT INTO Viaje (
    Id_chofer,
    Id_movil,
    Origen,
    Destino,
    Kilometro,
    Fecha_hora
)
VALUES
    (1, 1, 'Moron', 'Palermo', 25.50, '2026-10-20T08:30:00'),
    (2, 1, 'Ramos Mejia', 'Microcentro', 30.00, '2026-10-20T10:00:00'),
    (1, 2, 'San Justo', 'Aeroparque', 28.75, '2026-10-21T14:15:00'),
    (3, 4, 'Haedo', 'Liniers', 12.00, '2026-10-22T09:00:00');
GO

INSERT INTO Destino (
    Id_viaje,
    Orden,
    Lugar
)
VALUES
    (1, 1, 'Villa Luro'),
    (1, 2, 'Caballito'),
    (1, 3, 'Palermo'),
    (2, 1, 'Flores'),
    (2, 2, 'Microcentro'),
    (3, 1, 'Ciudad Universitaria'),
    (3, 2, 'Aeroparque'),
    (4, 1, 'Liniers');
GO