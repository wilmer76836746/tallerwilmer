CREATE DATABASE taller_mecanico;
-- tabla taller
CREATE TABLE taller (
    id_taller INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20)  NOT NULL,
    email VARCHAR(100)  NOT NULL,
    logo VARCHAR(20) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL
)ENGINE=INNODB;
-- tabla clientes
CREATE TABLE clientes (
    id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_taller INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ap VARCHAR(15) ,
    am VARCHAR(15) ,
    telefono VARCHAR(20) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_taller) REFERENCES taller(id_taller),
    INDEX idx_ap (ap),
    INDEX idx_am (am)
)ENGINE=INNODB;
-- tabla vehiculos
CREATE TABLE vehiculos (
    id_vehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio CHAR(4) NOT NULL,
    placa VARCHAR(20) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    INDEX idx_id_cliente (id_cliente),
    UNIQUE idx_placa (placa)   
)ENGINE=INNODB;
-- tabla mecanicos
CREATE TABLE mecanicos (
    id_mecanico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_taller INT NOT NULL,
    ci VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ap VARCHAR(15),
    am VARCHAR(15),
    especialidad VARCHAR(100) NOT NULL,
    fecha_na DATE,
    fecha_ini DATE,
    fecha_fin DATE,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_taller) REFERENCES taller(id_taller),
    INDEX idx_ap (ap),
    INDEX idx_am (am),
    UNIQUE idx_ci (ci)
)ENGINE=INNODB;
-- tabla tipos_servicios
CREATE TABLE tipos_servicios (
    id_tipo_servicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_taller INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_taller) REFERENCES taller(id_taller)
)ENGINE=INNODB;
-- tabla cita
CREATE TABLE citas (
    id_cita INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_tipo_servicio INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    fecha_ini DATE NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_tipo_servicio) REFERENCES tipos_servicios(id_tipo_servicio)
)ENGINE=INNODB;
-- tabla historial_servicios
CREATE TABLE historial_servicios (
    id_historial_servicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_cita INT NOT NULL,
    id_mecanico INT NOT NULL,
    id_tipo_servicio INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    costo FLOAT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_cita) REFERENCES citas(id_cita),
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico),
    FOREIGN KEY (id_tipo_servicio) REFERENCES tipos_servicios(id_tipo_servicio)
)ENGINE=INNODB;
-- tabla promociones
CREATE TABLE promociones (
    id_promocion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_taller INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_taller) REFERENCES taller(id_taller)
)ENGINE=INNODB;
-- tabla proveedores
CREATE TABLE proveedores (
    id_proveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_taller INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_taller) REFERENCES taller(id_taller)
)ENGINE=INNODB;
-- tabla inventario
CREATE TABLE inventario (
    id_producto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL, 
    precio FLOAT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    INDEX idx_nombre (nombre)
)ENGINE=INNODB;
-- tabla personas

CREATE TABLE personas(
    id_persona INT NOT NULL AUTO_INCREMENT,
    id_taller INT NOT NULL,
    ci VARCHAR(15) NOT NULL,
    nombres VARCHAR(25) NOT NULL,
    ap VARCHAR(15) NOT NULL,
    am VARCHAR(15) NOT NULL,
    telefono VARCHAR(25) NOT NULL,
    direccion VARCHAR(25),
    genero CHAR(1),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_persona),
    FOREIGN KEY(id_taller) REFERENCES Taller(id_taller)
)ENGINE=INNODB;

-- tabla usuarios
CREATE TABLE usuarios(
    id_usuario INT NOT NULL AUTO_INCREMENT,
    id_persona INT NOT NULL,
    usuario1 VARCHAR(40) NOT NULL,
    clave VARCHAR(100) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_usuario),
    FOREIGN KEY(id_persona) REFERENCES personas(id_persona)
)ENGINE=INNODB;
-- tabla roles
CREATE TABLE roles(
    id_rol INT NOT NULL AUTO_INCREMENT,
    rol VARCHAR(25) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_rol)
)ENGINE=INNODB;
-- tabla usuarios_roles
CREATE TABLE usuarios_roles(
    id_usuario_rol INT NOT NULL AUTO_INCREMENT,
    id_rol INT NOT NULL,
    id_usuario INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_usuario_rol),
    FOREIGN KEY(id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
)ENGINE=INNODB;
-- tabla grupos
CREATE TABLE grupos(
    id_grupo INT NOT NULL AUTO_INCREMENT,
    grupo VARCHAR(25) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_grupo)
)ENGINE=INNODB;
-- tabla opciones
CREATE TABLE opciones(
    id_opcion INT NOT NULL AUTO_INCREMENT,
    id_grupo INT NOT NULL,
    opcion VARCHAR(100) NOT NULL,
    contenido VARCHAR(50) NOT NULL,
    orden INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_opcion),
    FOREIGN KEY(id_grupo) REFERENCES grupos(id_grupo)
)ENGINE=INNODB;
-- tabla accesos
CREATE TABLE accesos(
    id_acceso INT NOT NULL AUTO_INCREMENT,
    id_rol INT NOT NULL,
    id_opcion INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_acceso),
    FOREIGN KEY(id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY(id_opcion) REFERENCES opciones(id_opcion)
)ENGINE=INNODB;


INSERT INTO taller (nombres, direccion, telefono, email, logo, fec_insercion, fec_modificacion, usuario, estado) VALUES
('Taller Rapido y Furioso', 'Barrio Paraiso', '76836746', 'wilmertf2@gmail.com','logo1.png', NOW(), NOW(), 1, 'A');

INSERT INTO clientes (id_taller, nombre, ap, am, telefono, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Juan', 'López', 'García', '1122334455', NOW(), NOW(), 1, 'A'),
(1, 'María', 'Martínez', 'Fernández', '2233445566', NOW(), NOW(), 1, 'A'),
(1, 'Pedro', 'González', 'Pérez', '3344556677', NOW(), NOW(), 1, 'A'),
(1, 'Ana', 'Rodríguez', 'Sánchez', '4455667788', NOW(), NOW(), 1, 'A'),
(1, 'Sofía', 'Hernández', 'López', '5566778899', NOW(), NOW(), 1, 'A'),
(1, 'Carlos', 'Díaz', 'Martínez', '6677889900', NOW(), NOW(), 1, 'A'),
(1, 'Laura', 'Gómez', 'Ruiz', '7788990011', NOW(), NOW(), 1, 'A'),
(1, 'Javier', 'Pérez', 'Gómez', '8899001122', NOW(), NOW(), 1, 'A'),
(1, 'Elena', 'Ruiz', 'Hernández', '9900112233', NOW(), NOW(), 1, 'A'),
(1, 'Diego', 'Sánchez', 'Fernández', '0011223344', NOW(), NOW(), 1, 'A');

INSERT INTO vehiculos (id_cliente, marca, modelo, anio, placa, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Toyota', 'Corolla', '1980', 'ABC123', NOW(), NOW(), 1, 'A'),
(2, 'Honda', 'Civic', '2001', 'DEF456', NOW(), NOW(), 1, 'A'),
(3, 'Ford', 'Fiesta', '2019', 'GHI789', NOW(), NOW(), 1, 'A'),
(4, 'Chevrolet', 'Spark', '2020', 'JKL012', NOW(), NOW(), 1, 'A'),
(5, 'Volkswagen', 'Jetta', '2007', 'MNO345', NOW(), NOW(), 1, 'A'),
(6, 'Nissan', 'Sentra', '2016', 'PQR678', NOW(), NOW(), 1, 'A'),
(7, 'Mazda', '3', '2018', 'STU901', NOW(), NOW(), 1, 'A'),
(8, 'Hyundai', 'Accent', '2019', 'VWX234', NOW(), NOW(), 1, 'A'),
(9, 'Kia', 'Rio', '2020', 'YZA567', NOW(), NOW(), 1, 'A'),
(10, 'Renault', 'Clio', '2000', 'BCD890', NOW(), NOW(), 1, 'A');


INSERT INTO mecanicos (id_taller, ci, nombre, ap, am, especialidad, fecha_na, fecha_ini, fecha_fin, fec_insercion, fec_modificacion, usuario, estado) 
VALUES
(1, '1234567890', 'Juan', 'Pérez', 'Gómez', 'Mecánica General', '1985-05-10', '2020-01-15', NULL, NOW(), NOW(), 1, 'A'),
(1, '0987654321', 'María', 'López', 'García',  'Electricidad Automotriz', '1990-08-20', '2018-06-20', NULL, NOW(), NOW(), 1, 'A'),
(1, '2345678901', 'Pedro', 'González', 'Martínez', 'Mecánica de Motores', '1980-03-15', '2015-10-05', NULL, NOW(), NOW(), 1, 'A'),
(1, '3456789012', 'Ana', 'Martínez', 'Sánchez', 'Reparación de Frenos', '1976-11-25', '2010-04-12', NULL, NOW(), NOW(), 1, 'A'),
(1, '4567890123', 'Carlos', 'Sánchez', 'Seco', 'Alineación y Balanceo', '1972-09-30', '2005-09-08', NULL, NOW(), NOW(), 1, 'A'),
(1, '5678901234', 'Laura', 'Rodríguez', 'Fernández', 'Transmisiones Automáticas', '1988-12-05', '2012-08-22', NULL, NOW(), NOW(), 1, 'A'),
(1, '6789012345', 'José', 'Ramírez', 'López', 'Sistemas de Suspensión', '1983-04-18', '2019-03-10', NULL, NOW(), NOW(), 1, 'A'),
(1, '7890123456', 'Sofía', 'Pérez', 'Gómez', 'Reparación de Aire Acondicionado', '1995-07-08', '2017-11-30', NULL, NOW(), NOW(), 1, 'A'),
(1, '8901234567', 'Daniel', 'Gómez', 'Hernández', 'Sistemas de Dirección', '1979-06-12', '2013-12-18', NULL, NOW(), NOW(), 1, 'A'),
(1, '9012345678', 'Elena', 'Hernández', 'Díaz', 'Reparación de Inyección Electrónica', '1987-02-28', '2016-05-25', NULL, NOW(), NOW(), 1, 'A');

INSERT INTO tipos_servicios (id_taller, nombre, descripcion, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Cambio de Aceite', 'Cambio de aceite y filtro', NOW(), NOW(), 1, 'A'),
(1, 'Revisión de Frenos', 'Revisión y mantenimiento de frenos', NOW(), NOW(), 1, 'A'),
(1, 'Alineación y Balanceo', 'Alineación y balanceo de llantas', NOW(), NOW(), 1, 'A'),
(1, 'Reparación de Motor', 'Reparación y ajuste de motor', NOW(), NOW(), 1, 'A'),
(1, 'Cambio de Batería', 'Cambio de batería y sistema eléctrico', NOW(), NOW(), 1, 'A'),
(1, 'Diagnóstico Electrónico', 'Diagnóstico electrónico de fallas', NOW(), NOW(), 1, 'A'),
(1, 'Cambio de Llantas', 'Cambio y rotación de llantas', NOW(), NOW(), 1, 'A'),
(1, 'Reparación de Suspensión', 'Reparación y mantenimiento de suspensión', NOW(), NOW(), 1, 'A'),
(1, 'Servicio de Aire Acondicionado', 'Revisión y recarga de aire acondicionado', NOW(), NOW(), 1, 'A'),
(1, 'Cambio de Correa de Distribución', 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A');

INSERT INTO citas (id_cliente, id_vehiculo, id_tipo_servicio, fecha, hora, fecha_ini, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 1, 1, '2024-05-05', '09:00:00', '2024-05-05', NOW(), NOW(), 1, 'A'),
(2, 2, 2, '2024-05-06', '10:00:00', '2024-05-06', NOW(), NOW(), 1, 'A'),
(3, 3, 3, '2024-05-07', '11:00:00', '2024-05-07', NOW(), NOW(), 1, 'A'),
(4, 4, 4, '2024-05-08', '12:00:00', '2024-05-08', NOW(), NOW(), 1, 'A'),
(5, 5, 5, '2024-05-09', '13:00:00', '2024-05-09', NOW(), NOW(), 1, 'A'),
(6, 6, 6, '2024-05-10', '14:00:00', '2024-05-10', NOW(), NOW(), 1, 'A'),
(7, 7, 7, '2024-05-11', '15:00:00', '2024-05-11', NOW(), NOW(), 1, 'A'),
(8, 8, 8, '2024-05-12', '16:00:00', '2024-05-12', NOW(), NOW(), 1, 'A'),
(9, 9, 9, '2024-05-13', '17:00:00', '2024-05-13', NOW(), NOW(), 1, 'A'),
(10, 10, 10, '2024-05-14', '18:00:00', '2024-05-14', NOW(), NOW(), 1, 'A');

INSERT INTO historial_servicios (id_vehiculo, id_cita, id_mecanico, id_tipo_servicio, fecha_inicio, fecha_fin, costo, descripcion, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 1, 1, 1, '2024-05-05', '2024-05-05', 50.00, 'Cambio de aceite y filtro', NOW(), NOW(), 1, 'A'),
(2, 2, 2, 2, '2024-05-06', '2024-05-06', 100.00, 'Revisión y mantenimiento de frenos', NOW(), NOW(), 1, 'A'),
(3, 3, 3, 3, '2024-05-07', '2024-05-07', 80.00, 'Alineación y balanceo de llantas', NOW(), NOW(), 1, 'A'),
(4, 4, 4, 4, '2024-05-08', '2024-05-08', 200.00, 'Reparación y ajuste de motor', NOW(), NOW(), 1, 'A'),
(5, 5, 5, 5, '2024-05-09', '2024-05-09', 150.00, 'Cambio de batería y sistema eléctrico', NOW(), NOW(), 1, 'A'),
(6, 6, 6, 6, '2024-05-10', '2024-05-10', 120.00, 'Diagnóstico electrónico de fallas', NOW(), NOW(), 1, 'A'),
(7, 7, 7, 7, '2024-05-11', '2024-05-11', 70.00, 'Cambio y rotación de llantas', NOW(), NOW(), 1, 'A'),
(8, 8, 8, 8, '2024-05-12', '2024-05-12', 90.00, 'Reparación y mantenimiento de suspensión', NOW(), NOW(), 1, 'A'),
(9, 9, 9, 9, '2024-05-13', '2024-05-13', 60.00, 'Revisión y recarga de aire acondicionado', NOW(), NOW(), 1, 'A'),
(10, 10, 10, 10, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A'),

(1, 2, 3, 10, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A'),
(3, 5, 7, 1, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A'),
(2, 7, 9, 4, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A'),
(7, 1, 5, 3, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A'),
(7, 7, 7, 7, '2024-05-14', '2024-05-14', 110.00, 'Cambio y ajuste de correa de distribución', NOW(), NOW(), 1, 'A');



-- Insertar datos de muestra para la tabla promociones
INSERT INTO promociones (id_taller, nombre, descripcion, fecha_inicio, fecha_fin, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Descuento de Primavera', '¡Disfruta de un 20% de descuento en todos los servicios de mantenimiento esta primavera!', '2024-04-01', '2024-06-30', NOW(), NOW(), 1, 'A'),
(1, 'Oferta de Neumáticos', 'Compra 4 neumáticos y recibe el montaje gratuito en nuestro taller.', '2024-05-01', '2024-05-31', NOW(), NOW(), 1, 'A'),
(1, 'Promoción de Aire Acondicionado', 'Recarga el gas de tu sistema de aire acondicionado por solo $50.', '2024-06-01', '2024-07-31', NOW(), NOW(), 1, 'A'),
(1, 'Servicio de Mantenimiento Completo', 'Mantenimiento completo para tu vehículo con cambio de aceite, revisión de frenos y más por $150.', '2024-05-15', '2024-08-15', NOW(), NOW(), 1, 'A'),
(1, 'Oferta de Baterías', 'Obtén un 15% de descuento en todas las baterías de nuestra selección.', '2024-05-01', '2024-05-31', NOW(), NOW(), 1, 'A'),
(1, 'Promoción de Verano', '¡Llegó el verano! Ven a nuestro taller y recibe un obsequio por cada servicio realizado.', '2024-06-21', '2024-09-21', NOW(), NOW(), 1, 'A'),
(1, 'Descuento por Referencia', 'Referencia a un amigo y ambos recibirán un descuento del 10% en su próximo servicio.', '2024-05-01', '2024-12-31', NOW(), NOW(), 1, 'A'),
(1, 'Paquete de Frenos', 'Paquete especial de cambio de frenos delanteros y traseros por solo $200.', '2024-05-01', '2024-06-30', NOW(), NOW(), 1, 'A'),
(1, 'Oferta de Aceite', 'Compra 5 litros de aceite y recibe el sexto gratis.', '2024-05-01', '2024-05-31', NOW(), NOW(), 1, 'A'),
(1, 'Promoción de Fin de Año', 'Celebra el fin de año con nosotros y disfruta de descuentos especiales en todos nuestros servicios.', '2024-11-01', '2024-12-31', NOW(), NOW(), 1, 'A');

-- Insertar datos de muestra para la tabla proveedores
INSERT INTO proveedores (id_taller, nombre, telefono, email, direccion, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Suministros Automotrices S.A.', '+1234567890', 'info@suministrosautomotrices.com', 'Calle Suministros #123, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Repuestos y Accesorios Martínez', '+2345678901', 'ventas@repuestosmartinez.com', 'Avenida Repuestos #456, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Tecnología Automotriz Avanzada', '+3456789012', 'contacto@tecnologiaavanzada.com', 'Boulevard Tecnología #789, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Neumáticos del Sur', '+4567890123', 'ventas@neumaticosdelsur.com', 'Calle Neumáticos #1011, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Baterías Energía Total', '+5678901234', 'info@bateriasenergiatotal.com', 'Avenida Baterías #1213, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Lubricantes Vigo', '+6789012345', 'contacto@lubricantesvigo.com', 'Boulevard Lubricantes #1415, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Herramientas Profesionales García', '+7890123456', 'ventas@herramientasgarcia.com', 'Calle Herramientas #1617, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Suministros Eléctricos Hernández', '+8901234567', 'info@suministroselectricos.com', 'Avenida Eléctrica #1819, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Repuestos Motorizados Pérez', '+9012345678', 'ventas@repuestosperez.com', 'Boulevard Repuestos #2021, Ciudad Principal', NOW(), NOW(), 1, 'A'),
(1, 'Accesorios Automotrices Gómez', '+0123456789', 'contacto@accesoriosgomez.com', 'Calle Accesorios #2223, Ciudad Principal', NOW(), NOW(), 1, 'A');


INSERT INTO inventario (id_proveedor, nombre, descripcion, cantidad, precio, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'Aceite de Motor', 'Aceite sintético para motor', 100, 25.00, NOW(), NOW(), 1, 'A'),
(2, 'Pastillas de Freno', 'Juego de pastillas de freno delanteras', 50, 40.00, NOW(), NOW(), 1, 'A'),
(3, 'Llantas', 'Llantas de perfil bajo para automóviles', 30, 100.00, NOW(), NOW(), 1, 'A'),
(4, 'Baterías', 'Baterías de 12V para vehículos', 20, 80.00, NOW(), NOW(), 1, 'A'),
(5, 'Scanner Automotriz', 'Herramienta de diagnóstico electrónico', 10, 500.00, NOW(), NOW(), 1, 'A'),
(6, 'Llaves de Impacto', 'Juego de llaves de impacto neumáticas', 15, 150.00, NOW(), NOW(), 1, 'A'),
(7, 'Amortiguadores', 'Amortiguadores para suspensión delantera', 25, 70.00, NOW(), NOW(), 1, 'A'),
(8, 'Gas Refrigerante', 'Gas refrigerante R134a para aire acondicionado', 40, 30.00, NOW(), NOW(), 1, 'A'),
(9, 'Correas de Distribución', 'Correas de distribución para motores', 30, 20.00, NOW(), NOW(), 1, 'A'),
(10, 'Aceite de Transmisión', 'Aceite para transmisión automática', 50, 35.00, NOW(), NOW(), 1, 'A');


INSERT INTO personas (id_taller, ci, nombres, ap, am, telefono, direccion, genero, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, '7921216', 'Wilmer', 'Tejerina', 'Flores', '76866746', 'Calle Aroma', 'M', NOW(), NOW(), 1, 'A'),
(1, '23456789B', 'Maria', 'Lopez', 'Diaz', '555-5678', 'Avenida Siempre Viva 742', 'F', NOW(), NOW(), 1, 'A'),
(1, '34567890C', 'Carlos', 'Garcia', 'Torres', '555-6789', 'Calle Principal 456', 'M', NOW(), NOW(), 1, 'A'),
(1, '45678901D', 'Ana', 'Martinez', 'Hernandez', '555-7890', 'Calle Secundaria 789', 'F', NOW(), NOW(), 1, 'A'),
(1, '56789012E', 'Luis', 'Rodriguez', 'Sanchez', '555-8901', 'Boulevard Central 101', 'M', NOW(),NOW(), 1, 'A'),
(1, '67890123F', 'Elena', 'Gonzalez', 'Ramirez', '555-9012', 'Avenida Libertad 202', 'F', NOW(),NOW(), 1, 'A'),
(1, '78901234G', 'Jorge', 'Fernandez', 'Ruiz', '555-0123', 'Pasaje Victoria 303', 'M', NOW(), NOW(), 1, 'A'),
(1, '89012345H', 'Laura', 'Hernandez', 'Martinez', '555-2345', 'Calle Esperanza 404', 'F', NOW(), NOW(), 1, 'A'),
(1, '90123456I', 'David', 'Ruiz', 'Gomez', '555-3456', 'Avenida Paz 505', 'M', NOW(), NOW(), 1, 'A'),
(1, '12345678A', 'Juan', 'Perez', 'Gomez', '555-1234', 'Calle Falsa 123', 'M', NOW(), NOW(), 1, 'A');

INSERT INTO usuarios (id_persona, usuario1, clave, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 'ADMIN', '$2y$10$HxB1sZ3p/ok/Aa3cyATcsuGZoUrZzW5.TtmaiYh61S38axFgKVmXK', NOW(), NOW(), 1, 'A'),
(2, 'ENCARGADO', '$2y$10$xQ57vNWDfuKALm71SUggY.Qb18rR3P.p4qVYjAgYuIoda0E2gqrdy', NOW(), NOW(), 1, 'A'),
(2, 'PERSONAL', '$2y$10$kLqD03I/knhbFPE8/nVKYuoDDUBN3bPfpBZm2BtjCWFxoH9OBMHfG', NOW(), NOW(), 1, 'A');

INSERT INTO roles (rol, fec_insercion, fec_modificacion, usuario, estado) VALUES
('Administrador', NOW(), NOW(), 1, 'A'),
('Encargado', NOW(), NOW(), 1, 'A'),
('Personal', NOW(), NOW(), 1, 'A');

INSERT INTO usuarios_roles (id_rol, id_usuario, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 1, NOW(), NOW(), 1, 'A'),
(2, 2, NOW(), NOW(), 1, 'A'),
(3, 3, NOW(), NOW(), 1, 'A');

INSERT INTO grupos (grupo, fec_insercion, fec_modificacion, usuario, estado) VALUES
('HERRAMIENTAS', NOW(), NOW(), 1, 'A'),
('TALLER', NOW(), NOW(), 1, 'A'),
('REPORTES', NOW(), NOW(), 1, 'A'),
('API', NOW(), NOW(), 1, 'A'),
('CUARTO BIMESTRE-DWII', NOW(), NOW(), 1, 'A');


INSERT INTO opciones (id_grupo, opcion, contenido, orden, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1,'PERSONAS','../privada/PERSONAS/PERSONAS.PHP',10, NOW(), now(),1,'A'),
(1,'USUARIOS','../privada/USUARIOS/USUARIOS.PHP',20, NOW(), now(),1,'A'),
(1,'GRUPOS','../privada/GRUPOS/GRUPOS.PHP',30, NOW(), now(),1,'A'),
(1,'ROLES','../privada/ROLES/ROLES.PHP',40,NOW(), now(),1,'A'),
(1,'USUARIOS ROLES','../privada/USUARIOS_ROLES/USUARIOS_ROLES',50, NOW(), now(),1,'A'),
(1,'OPCIONES','../privada/OPCIONES/OPCIONES.PHP',60, NOW(), now(),1,'A'),
(1,'ACCESOS','../privada/ACCESOS/ACCESOS.PHP',70, NOW(), now(),1,'A'),
(2,'TALLER','../privada/TALLER/TALLER.PHP',10, NOW(), now(),1,'A'),
(2,'CLIENTES','../privada/CLIENTES/CLIENTES.PHP',20, NOW(), now(),1,'A'),
(2,'VEHICULOS','../privada/VEHICULOS/VEHICULOS.PHP',30, NOW(), now(),1,'A'),
(2,'TIPOS_SERVIVIOS','../privada/TIPOS_SERVICIOS/TIPOS_SERVICIOS.PHP',40, NOW(), now(),1,'A'),
(2,'MECANICOS','../privada/MECANICOS/MECANICOS.PHP',50, NOW(), now(),1,'A'),
(2,'CITAS','../privada/CITAS/CITAS.PHP',60, NOW(), now(),1,'A'),
(2,'HISTORIAL_SERVICIOS','../privada/HISTORIAL_SERVICIOS/HISTORIAL_SERVICIOS.PHP',70, NOW(), now(),1,'A'),
(2,'PROVEEDORES','../privada/PROVEEDORES/PROVEEDORES.PHP',80, NOW(), now(),1,'A'),
(2,'INVENTARIO','../privada/INVENTARIO/INVENTARIO.PHP',90, NOW(), now(),1,'A'),
(2,'PROMOCIONES','../privada/PROMOCIONES/PROMOCIONES.PHP',100, NOW(), now(),1,'A'),
(3,'RPT PERSONAS CON USUARIOS','../privada/REPORTES/personas_usuarios.PHP',10, NOW(), now(),1,'A'),
(3,'RPT VEHICULOS CON CLIENTES','../privada/REPORTES/vehiculos_reportes.PHP',20, NOW(), now(),1,'A'),
(3,'RPT PRODUCTOS CON PROVEEDORES','../privada/REPORTES/inventario_proveedor.PHP',30, NOW(), now(),1,'A'),
(3,'RPT PERSONAS X GENERO','../privada/REPORTES/personas_genero.PHP',40, NOW(), now(),1,'A'),
(3,'RPT VEHICULOS X ANTIGUEDAD','../privada/REPORTES/vehiculos_genero.PHP',50, NOW(), now(),1,'A'),
(3,'FICHA TECNICA DE PERSONAS','../privada/REP/ficha_tec_personas.php',60, NOW(), now(),1,'A'),
(3,'FICHA TECNICA DE VEHICULOS','../privada/REP V/ficha_tec_vehiculos.php',70, NOW(), now(),1,'A'),
(3,'RESPALDO-REPORTES ESTADISTICOS','../privada/REPORTES/Highcharts/examples/line-basic/index.php',80, NOW(), now(),1,'A'),
(3,'REPORTES ESTADISTICOS','../privada/REPORTES/reportes_graficos.php',90, NOW(), now(),1,'A'),
(4,'API_Wilmer','../privada/apiw/index.html',10, NOW(), now(),1,'A'),
(5,'FORMULARIO DINAMICO','../privada/formulario/formulario.php',10, NOW(), now(),1,'A');

INSERT INTO accesos (id_rol, id_opcion, fec_insercion, fec_modificacion, usuario, estado) VALUES
(1, 1, NOW(), NOW(), 1, 'A'),
(1, 2, NOW(), NOW(), 1, 'A'),
(1, 3, NOW(), NOW(), 1, 'A'),
(1, 4, NOW(), NOW(), 1, 'A'),
(1, 5, NOW(), NOW(), 1, 'A'),
(1, 6, NOW(), NOW(), 1, 'A'),
(1, 7, NOW(), NOW(), 1, 'A'),
(1, 8, NOW(), NOW(), 1, 'A'),
(1, 9, NOW(), NOW(), 1, 'A'),
(1, 10, NOW(), NOW(), 1, 'A'),
(1, 11, NOW(), NOW(), 1, 'A'),
(1, 12, NOW(), NOW(), 1, 'A'),
(1, 13, NOW(), NOW(), 1, 'A'),
(1, 14, NOW(), NOW(), 1, 'A'),
(1, 15, NOW(), NOW(), 1, 'A'),
(1, 16, NOW(), NOW(), 1, 'A'),
(1, 17, NOW(), NOW(), 1, 'A'),
(1, 18, NOW(), NOW(), 1, 'A'),
(1, 19, NOW(), NOW(), 1, 'A'),
(1, 20, NOW(), NOW(), 1, 'A'),
(1, 21, NOW(), NOW(), 1, 'A'),
(1, 22, NOW(), NOW(), 1, 'A'),
(1, 23, NOW(), NOW(), 1, 'A'),
(1, 24, NOW(), NOW(), 1, 'A'),
(1, 25, NOW(), NOW(), 1, 'A'),
(1, 26, NOW(), NOW(), 1, 'A'),
(1, 27, NOW(), NOW(), 1, 'A'),
(1, 28, NOW(), NOW(), 1, 'A'),

(2, 1, NOW(), NOW(), 1, 'A'),
(2, 2, NOW(), NOW(), 1, 'A'),
(2, 3, NOW(), NOW(), 1, 'A'),
(2, 4, NOW(), NOW(), 1, 'A'),
(2, 5, NOW(), NOW(), 1, 'A'),
(2, 6, NOW(), NOW(), 1, 'A'),
(2, 7, NOW(), NOW(), 1, 'A'),
(3, 8, NOW(), NOW(), 1, 'A'),
(3, 9, NOW(), NOW(), 1, 'A'),
(3, 10, NOW(), NOW(), 1, 'A'),
(3, 11, NOW(), NOW(), 1, 'A'),
(3, 12, NOW(), NOW(), 1, 'A'),
(3, 13, NOW(), NOW(), 1, 'A'),
(3, 14, NOW(), NOW(), 1, 'A'),
(3, 15, NOW(), NOW(), 1, 'A'),
(3, 16, NOW(), NOW(), 1, 'A');






CREATE VIEW vista_ve_cli AS
                      SELECT CONCAT_WS(' ', ve.marca,ve.modelo,ve.anio,ve.placa) as vehiculo, cli.nombre as cliente
                     FROM clientes cli
                     INNER JOIN vehiculos ve ON cli.id_cliente=ve.id_cliente
                     WHERE ve.estado = 'A'
                     AND cli.estado = 'A'
                     ORDER BY cli.id_cliente;

CREATE VIEW vista_per_usu AS
                        SELECT CONCAT_WS(' ', pe.nombres, pe.ap, pe.am) AS persona,usu.usuario1
                        FROM personas pe
                        INNER JOIN usuarios usu ON pe.id_persona = usu.id_persona
                        WHERE pe.estado = 'A'
                        AND usu.estado = 'A'
                        ORDER BY usu.id_persona;

CREATE VIEW vista_in_pro AS
                      SELECT inv.nombre AS nombre, inv.cantidad AS cantidad, inv.precio AS precio, pro.nombre as proveedor
                     FROM proveedores pro
                     INNER JOIN inventario inv ON pro.id_proveedor=inv.id_proveedor
                     WHERE inv.estado = 'A'
                     AND pro.estado = 'A'
                     ORDER BY pro.id_proveedor;    






CREATE TABLE rubros(
    id_rubro INT NOT NULL AUTO_INCREMENT,
    rubro VARCHAR(30)NOT NULL,
    vida_util INT NOT NULL,
    porcen_depreciacion FLOAT NOT NULL,
    depreciacion VARCHAR(10)NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_rubro)
)ENGINE=INNODB;

INSERT INTO rubros VALUES (1, 'Terrenos', 10, 10.00, 'NO', NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (2, 'Edificaciones', 40, 2.5, 'SI', NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (3, 'Muebles y Enseres de oficina', 10, 10.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (4, 'Equipos de Computacion', 4, 25.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (5, 'Vehiculo Automotores', 5, 20.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (6, 'Herramientas en Generales', 4, 25.00, 'SI', NOW(), NOW(), 1, 'A');

CREATE TABLE categorias(
    id_categoria INT NOT NULL AUTO_INCREMENT,
    id_rubro INT NOT NULL,
    categoria_rubro VARCHAR(30)NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_categoria),
    FOREIGN KEY(id_rubro)REFERENCES rubros(id_rubro)
)ENGINE=INNODB;

INSERT INTO categorias VALUES (1, 1,'Terreno', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (2, 2,'Edificacion',  NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (3, 2,'Vivienda',  NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (4, 3,'Pupitre', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (5, 3,'Silla', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (6, 3,'Mesa de Escritorio', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (7, 3,'Casillero Metalico', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (8, 3,'Casillero Madera', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (9, 3,'Ventilador', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (11, 4,'Computadora', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (12, 4,'Impresora', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (13, 4,'Proyector', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (14, 5,'Vehiculo', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (15, 6,'Taladro', NOW(), NOW(), 1, 'A');

CREATE TABLE activos_fijos(
    id_activo_fijo INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_adquisicion DATE NOT NULL, 
    fecha_activacion DATE, 
    fotografia VARCHAR(30),
    nro_documento VARCHAR(50),
    valor FLOAT,
    valor_residual FLOAT,
    responsable VARCHAR(50),
    depreciacion VARCHAR(50), /*del id_categoria 4 al 15*/
    marca_del_activo VARCHAR(25),  /*del id_categoria 9 al 15*/
    nro_serie_placa VARCHAR(20),  /*solo id_categoria 14*/
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_activo_fijo),
    FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria)
)ENGINE=INNODB;
