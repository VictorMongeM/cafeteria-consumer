-- Crear base de datos
drop database if exists cafeteria;
CREATE DATABASE IF NOT EXISTS cafeteria;
USE cafeteria;

-- Crear usuario que utiliza el sistema
CREATE USER cafeteria@localhost IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON cafeteria.* TO cafeteria@localhost;
FLUSH PRIVILEGES;

-- Crear tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- Crear tabla Puestos
CREATE TABLE Puestos (
    puesto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_puesto VARCHAR(255) NOT NULL
);

-- Crear tabla Empleados
CREATE TABLE Empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    RFC VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    sueldo DECIMAL(10,2) NOT NULL,
    puesto_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    FOREIGN KEY (puesto_id) REFERENCES Puestos(puesto_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursales(sucursal_id)
);

-- Crear tabla Proveedores
CREATE TABLE Proveedores (
    proveedor_id INT AUTO_INCREMENT PRIMARY KEY,
    RFC VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- Crear tabla Insumos
CREATE TABLE Insumos (
    insumo_id VARCHAR(6) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    proveedor_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL,
    fecha_compra DATE NOT NULL,
    cantidad_restante INT NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

-- Crear tabla Categorias
CREATE TABLE Categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(255) NOT NULL
);

-- Crear tabla Productos
CREATE TABLE Productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

-- Crear tabla Ventas
CREATE TABLE Ventas (
    venta_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    numero_mesa INT NOT NULL,
    empleado_id INT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

-- Crear tabla intermedia Insumos_Proveedores para relación muchos a muchos entre Insumos y Proveedores
CREATE TABLE Insumos_Proveedores (
    insumo_id VARCHAR(7),
    proveedor_id INT,
    PRIMARY KEY (insumo_id, proveedor_id),
    FOREIGN KEY (insumo_id) REFERENCES Insumos(insumo_id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES
('Sucursal Centro', 'Av. Reforma 123, Centro, Ciudad de México', '5551234567'),
('Sucursal Norte', 'Av. Insurgentes 456, Norte, Ciudad de México', '5559876543'),
('Sucursal Sur', 'Calle 5 de Febrero 789, Sur, Ciudad de México', '5552345678');

INSERT INTO Puestos (nombre_puesto)
VALUES
('Mesero'),
('Cajero'),
('Cocinero');

INSERT INTO Empleados (RFC, nombre, apellido, direccion, fecha_contratacion, telefono, sueldo, puesto_id, sucursal_id)
VALUES
('EMP001234567', 'Juan', 'Pérez', 'Calle 1, Colonia ABC, Ciudad de México', '2025-03-01', '5550001111', 15000.00, 1, 1),
('EMP002345678', 'Ana', 'Gómez', 'Calle 2, Colonia XYZ, Ciudad de México', '2025-03-05', '5551112222', 12000.00, 2, 2),
('EMP003456789', 'Carlos', 'López', 'Calle 3, Colonia DEF, Ciudad de México', '2025-03-10', '5552223333', 18000.00, 3, 3),
('EMP004567890', 'María', 'Hernández', 'Calle 4, Colonia GHI, Ciudad de México', '2025-03-15', '5553334444', 16000.00, 1, 1),
('EMP005678901', 'José', 'Gutiérrez', 'Calle 5, Colonia JKL, Ciudad de México', '2025-03-18', '5554445555', 14000.00, 2, 2),
('EMP006789012', 'Laura', 'Ramírez', 'Calle 6, Colonia MNO, Ciudad de México', '2025-03-20', '5555556666', 17000.00, 3, 3),
('EMP007890123', 'Raúl', 'Fernández', 'Calle 7, Colonia PQR, Ciudad de México', '2025-03-22', '5556667777', 15000.00, 1, 1),
('EMP008901234', 'Elena', 'Vargas', 'Calle 8, Colonia STU, Ciudad de México', '2025-03-25', '5557778888', 14500.00, 2, 2);


INSERT INTO Proveedores (RFC, nombre, apellido, telefono)
VALUES
('PROV001234567', 'Marta', 'Romero', '5553334444'),
('PROV002345678', 'Pedro', 'Sánchez', '5554445555'),
('PROV003456789', 'Luis', 'Martínez', '5555556666'),
('PROV004567890', 'Claudia', 'Moreno', '5556667777'),
('PROV005678901', 'Carlos', 'Díaz', '5557778888'),
('PROV006789012', 'Marta', 'López', '5558889999'),
('PROV007890123', 'Miguel', 'García', '5559990000'),
('PROV008901234', 'Sofía', 'Jiménez', '5550001112');

describe insumos;

ALTER TABLE Insumos MODIFY insumo_id varchar(7);

INSERT INTO Insumos (insumo_id, nombre, proveedor_id, precio, costo, cantidad, fecha_compra, cantidad_restante)
VALUES
('INS001A', 'Café en grano', 1, 200.00, 150.00, 100, '2025-03-01', 40),
('INS002B', 'Leche', 2, 50.00, 30.00, 200, '2025-03-03', 80),
('INS003C', 'Azúcar', 3, 30.00, 20.00, 150, '2025-03-05', 60),
('INS004D', 'Chocolate en polvo', 1, 150.00, 100.00, 50, '2025-03-10', 20),
('INS005E', 'Miel', 2, 70.00, 45.00, 80, '2025-03-12', 30),
('INS006F', 'Jarabe de vainilla', 3, 120.00, 90.00, 60, '2025-03-14', 25),
('INS007G', 'Café en cápsulas', 4, 250.00, 180.00, 30, '2025-03-16', 15),
('INS008H', 'Leche en polvo', 5, 80.00, 50.00, 100, '2025-03-18', 45),
('INS009I', 'Fruta congelada', 6, 200.00, 140.00, 40, '2025-03-20', 18),
('INS010J', 'Manteca', 7, 90.00, 60.00, 120, '2025-03-22', 60),
('INS011K', 'Harina de trigo', 8, 30.00, 20.00, 150, '2025-03-24', 80),
('INS012L', 'Sal', 1, 15.00, 10.00, 200, '2025-03-26', 100),
('INS013M', 'Pimienta', 2, 50.00, 30.00, 50, '2025-03-28', 25),
('INS014N', 'Pasta de tomate', 1, 60.00, 40.00, 60, '2025-03-30', 35),
('INS015O', 'Aceite de oliva', 2, 180.00, 120.00, 90, '2025-04-01', 50),
('INS016P', 'Queso parmesano', 3, 220.00, 150.00, 40, '2025-04-03', 30),
('INS017Q', 'Aguacate', 4, 50.00, 35.00, 100, '2025-04-05', 45),
('INS018R', 'Té verde', 5, 70.00, 40.00, 70, '2025-04-07', 40),
('INS019S', 'Jengibre fresco', 6, 30.00, 20.00, 150, '2025-04-09', 75),
('INS020T', 'Tomate', 7, 20.00, 12.00, 200, '2025-04-11', 120),
('INS021U', 'Leche de almendra', 8, 100.00, 70.00, 90, '2025-04-13', 60),
('INS022V', 'Nuez de macadamia', 1, 250.00, 170.00, 30, '2025-04-15', 15),
('INS023W', 'Almendras', 2, 180.00, 120.00, 50, '2025-04-17', 20);

INSERT INTO Categorias (nombre_categoria)
VALUES
('Bebidas Calientes'),
('Bebidas Frías'),
('Postres'),
('Bocadillos'),
('Comidas');

INSERT INTO Productos (nombre_producto, precio, categoria_id)
VALUES
('Café Americano', 45.00, 1),
('Café Latte', 50.00, 1),
('Frapuccino', 60.00, 2),
('Pastel de Chocolate', 35.00, 3),
('Tostada con Aguacate', 40.00, 4),
('Sándwich de Pollo', 60.00, 5);

INSERT INTO Ventas (producto_id, cantidad_vendida, total_venta, numero_mesa, empleado_id)
VALUES
(1, 2, 90.00, 5, 1),
(3, 1, 60.00, 7, 2),
(4, 3, 105.00, 2, 3),
(2, 1, 50.00, 1, 1),
(5, 4, 160.00, 6, 2),
(1, 1, 45.00, 3, 1),
(2, 2, 100.00, 4, 2),
(3, 3, 180.00, 8, 3),
(4, 2, 70.00, 9, 1),
(5, 1, 40.00, 2, 2),
(6, 2, 120.00, 6, 3),
(1, 4, 160.00, 1, 1),
(2, 1, 50.00, 5, 2),
(3, 3, 135.00, 7, 3),
(1, 2, 100.00, 10, 1),
(2, 4, 200.00, 12, 2),
(1, 1, 50.00, 13, 3),
(5, 2, 110.00, 14, 1),
(5, 3, 180.00, 15, 2),
(2, 1, 60.00, 16, 3),
(6, 2, 140.00, 17, 1),
(4, 3, 150.00, 18, 2),
(6, 2, 140.00, 19, 3),
(1, 4, 240.00, 20, 1),
(2, 1, 60.00, 21, 2);


INSERT INTO Insumos_Proveedores (insumo_id, proveedor_id)
VALUES
('INS001A', 1),
('INS002B', 2),
('INS003C', 3),
('INS004D', 4),
('INS005E', 5);