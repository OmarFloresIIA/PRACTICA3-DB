-- Clientes (uno nacional y uno de exportación)
INSERT INTO cliente (numeroCliente, razonSocial, correoCliente, telefonoCliente, tipoCliente, RFC, regimenFiscal, estadoOrigen, idFiscalGlobal, paisReceptor)
VALUES (1, 'Acme SA de CV', 'contacto@acme.mx', '5555555555', 'NACIONAL', 'ACM010101AAA', 'General', 'CDMX', NULL, NULL);

INSERT INTO cliente (numeroCliente, razonSocial, correoCliente, telefonoCliente, tipoCliente, RFC, regimenFiscal, estadoOrigen, idFiscalGlobal, paisReceptor)
VALUES (2, 'Globex Inc', 'info@globex.com', '12025550123', 'EXPORTACION', NULL, NULL, NULL, 'US-123456', 'Estados Unidos');

-- Transportistas (uno solo nacional y uno de ambos tipos, por ser solapada)
INSERT INTO transportista (claveTransportista, nombreEmpresa, esNacional, esInternacional, RFC, codigoAduanal, agenciaAduanal)
VALUES ('T01', 'Fletes del Centro', TRUE, FALSE, 'FDC010101AAA', NULL, NULL);

INSERT INTO transportista (claveTransportista, nombreEmpresa, esNacional, esInternacional, RFC, codigoAduanal, agenciaAduanal)
VALUES ('T02', 'Cargo Global', TRUE, TRUE, 'CGL010101AAA', 'AD-001', 'Agencia Norte');

-- Productos (uno por subtipo)
INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provMaquinaria, provTransformador, provTransporte)
VALUES ('P01', 100, 150, 'OMNIGOLD', 'Siemens', NULL, NULL);

INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provMaquinaria, provTransformador, provTransporte)
VALUES ('P02', 80, 120, 'HYVOLT', NULL, 'ABB', NULL);

INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provMaquinaria, provTransformador, provTransporte)
VALUES ('P03', 50, 75, 'HYPRENE', NULL, NULL, 'DHL');

-- Sucursal, pedido, detalle y envío
INSERT INTO sucursal (numeroCliente, claveSucursal, nombrePlanta) 
VALUES (1, 'S1', 'Planta Toluca');
INSERT INTO pedido (folio, numeroCliente, estatus, dia, mes, anio) 
VALUES (100, 1, 'PENDIENTE', 15, 10, 2026);
INSERT INTO detalle (folio, claveParcial, claveProducto, costoProduccion, precioAplicado, cantidad) 
VALUES (100, 1, 'P01', 100, 150, 5);
INSERT INTO envio (numeroGuia, folio, claveTransportista, numeroCliente, claveSucursal, costoFlete, dia, mes, anio)
VALUES ('G001', 100, 'T01', 1, 'S1', 800, 16, 10, 2026);

-- 1. NOT NULL: cliente sin discriminador (totalidad de la jerarquía)
INSERT INTO cliente (numeroCliente, razonSocial) 
VALUES (3, 'Sin tipo SA');

-- 2. CHECK de valores: discriminador fuera del dominio (disyunción)
INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provTransporte)
VALUES ('P04', 10, 20, 'OTRO', 'DHL');

-- 3. CHECK de jerarquía: producto HYVOLT con proveedor de maquinaria
INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provMaquinaria, provTransformador)
VALUES ('P05', 10, 20, 'HYVOLT', 'XYZ', 'ABB');

-- 4. CHECK de rango: precio negativo
INSERT INTO producto (claveProducto, costoUnitarioUSD, precioUnitarioUSD, tipoProducto, provTransporte)
VALUES ('P06', 10, -5, 'HYPRENE', 'DHL');

-- 5. CHECK de jerarquía solapada: transportista que no es nacional ni internacional (totalidad)
INSERT INTO transportista (claveTransportista, nombreEmpresa, esNacional, esInternacional)
VALUES ('T03', 'Sin tipo', FALSE, FALSE);

-- 6. PRIMARY KEY: clave duplicada
INSERT INTO cliente (numeroCliente, razonSocial, tipoCliente, RFC, regimenFiscal, estadoOrigen)
VALUES (1, 'Duplicado SA', 'NACIONAL', 'DUP010101AAA', 'General', 'CDMX');

-- 7. UNIQUE: RFC repetido
INSERT INTO cliente (numeroCliente, razonSocial, tipoCliente, RFC, regimenFiscal, estadoOrigen)
VALUES (4, 'Otro SA', 'NACIONAL', 'ACM010101AAA', 'General', 'CDMX');

-- 8. FOREIGN KEY: pedido de un cliente que no existe
INSERT INTO pedido (folio, numeroCliente, estatus, dia, mes, anio)
VALUES (101, 999, 'PENDIENTE', 1, 1, 2026);

-- 9. CHECK: cantidad cero en el detalle
INSERT INTO detalle (folio, claveParcial, claveProducto, costoProduccion, precioAplicado, cantidad)
VALUES (100, 2, 'P02', 80, 120, 0);

-- 10. UNIQUE sobre clave foránea: segundo envío para el mismo pedido (cardinalidad máxima 1)
INSERT INTO envio (numeroGuia, folio, claveTransportista, numeroCliente, claveSucursal, costoFlete, dia, mes, anio)
VALUES ('G002', 100, 'T01', 1, 'S1', 500, 17, 10, 2026);

-- 11. RESTRICT: borrar un cliente que tiene pedidos
DELETE FROM cliente WHERE numeroCliente = 1;

