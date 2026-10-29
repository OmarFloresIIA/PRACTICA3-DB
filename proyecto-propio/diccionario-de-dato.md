# Diccionario de Datos

## cliente

Jerarquía disjunta y total (Nacional / Exportación). Discriminador: `tipoCliente`.

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **cliente** | numeroCliente | INTEGER | PK (pk_cliente), NOT NULL | Identificador único del cliente. |
| **cliente** | razonSocial | VARCHAR(150) | NOT NULL | Razón social o nombre comercial del cliente. |
| **cliente** | correoCliente | VARCHAR(100) | NULL | Correo electrónico de contacto del cliente. |
| **cliente** | telefonoCliente | VARCHAR(20) | NULL | Número telefónico de contacto del cliente. |
| **cliente** | tipoCliente | VARCHAR(15) | NOT NULL, CHECK (ck_tipo_cliente): NACIONAL o EXPORTACION | Discriminador de subtipo. NOT NULL implementa la totalidad y un solo valor por fila implementa la disyunción. |
| **cliente** | RFC | VARCHAR(13) | UNIQUE (uq_cliente_rfc), CHECK (ck_subtipo_cliente) | Registro Federal de Contribuyentes. Obligatorio si es NACIONAL; nulo si es EXPORTACION. |
| **cliente** | regimenFiscal | VARCHAR(100) | CHECK (ck_subtipo_cliente) | Régimen fiscal ante el SAT. Obligatorio si es NACIONAL; nulo si es EXPORTACION. |
| **cliente** | estadoOrigen | VARCHAR(50) | CHECK (ck_subtipo_cliente) | Estado de origen del cliente. Obligatorio si es NACIONAL; nulo si es EXPORTACION. |
| **cliente** | idFiscalGlobal | VARCHAR(30) | UNIQUE (uq_cliente_idfiscal), CHECK (ck_subtipo_cliente) | Identificador fiscal global para operaciones internacionales. Obligatorio si es EXPORTACION; nulo si es NACIONAL. |
| **cliente** | paisReceptor | VARCHAR(50) | CHECK (ck_subtipo_cliente) | País receptor del cliente. Obligatorio si es EXPORTACION; nulo si es NACIONAL. |

## transportista

Jerarquía solapada y total (Nacional / Internacional). Discriminadores: las banderas `esNacional` y `esInternacional`.

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **transportista** | claveTransportista | VARCHAR(10) | PK (pk_transportista), NOT NULL | Identificador único de la empresa transportista. |
| **transportista** | nombreEmpresa | VARCHAR(100) | NOT NULL | Nombre comercial de la empresa transportista. |
| **transportista** | telefonoAtencion | VARCHAR(20) | NULL | Teléfono de atención a clientes o soporte. |
| **transportista** | email | VARCHAR(100) | NULL | Correo electrónico general del transportista. |
| **transportista** | esNacional | BOOLEAN | NOT NULL, DEFAULT FALSE, CHECK (ck_transp_total) | Bandera de subtipo: verdadera si opera a nivel nacional. |
| **transportista** | esInternacional | BOOLEAN | NOT NULL, DEFAULT FALSE, CHECK (ck_transp_total) | Bandera de subtipo: verdadera si opera a nivel internacional. Con la anterior, al menos una debe ser verdadera (totalidad) y ambas pueden serlo (solapamiento). |
| **transportista** | RFC | VARCHAR(13) | CHECK (ck_transp_nacional) | RFC del transportista. Obligatorio si esNacional; nulo en caso contrario. |
| **transportista** | codigoAduanal | VARCHAR(20) | CHECK (ck_transp_internacional) | Código aduanal para cruces internacionales. Obligatorio si esInternacional; nulo en caso contrario. |
| **transportista** | agenciaAduanal | VARCHAR(100) | CHECK (ck_transp_internacional) | Agencia aduanal asociada. Obligatoria si esInternacional; nula en caso contrario. |

## producto

Jerarquía disjunta y total (Omnigold / Hyvolt / Hyprene). Discriminador: `tipoProducto`.

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **producto** | claveProducto | VARCHAR(10) | PK (pk_producto), NOT NULL | Identificador único del producto. |
| **producto** | costoUnitarioUSD | NUMERIC(12,2) | NOT NULL, CHECK (ck_producto_costo): >= 0 | Costo unitario estándar de producción en dólares. |
| **producto** | precioUnitarioUSD | NUMERIC(12,2) | NOT NULL, CHECK (ck_producto_precio): >= 0 | Precio unitario estándar de venta en dólares. |
| **producto** | tipoProducto | VARCHAR(10) | NOT NULL, CHECK (ck_tipo_producto): OMNIGOLD, HYVOLT o HYPRENE | Discriminador de subtipo. NOT NULL implementa la totalidad y un solo valor por fila implementa la disyunción. |
| **producto** | provMaquinaria | VARCHAR(100) | CHECK (ck_subtipo_producto) | Proveedor de maquinaria. Obligatorio si es OMNIGOLD; nulo en los demás. |
| **producto** | provTransformador | VARCHAR(100) | CHECK (ck_subtipo_producto) | Proveedor de transformador. Obligatorio si es HYVOLT; nulo en los demás. |
| **producto** | provTransporte | VARCHAR(100) | CHECK (ck_subtipo_producto) | Proveedor de transporte. Obligatorio si es HYPRENE; nulo en los demás. |

## sucursal

Entidad débil de `cliente` (dependencia de identificación).

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **sucursal** | numeroCliente | INTEGER | PK compuesta (pk_sucursal), FK (fk_sucursal_cliente) → cliente, NOT NULL, ON DELETE CASCADE, ON UPDATE CASCADE | Cliente al que pertenece la sucursal. |
| **sucursal** | claveSucursal | VARCHAR(10) | PK compuesta (pk_sucursal), NOT NULL | Clave parcial (discriminador de la entidad débil): identifica la sucursal dentro de su cliente. |
| **sucursal** | nombrePlanta | VARCHAR(100) | NOT NULL | Nombre descriptivo de la planta o sucursal. |
| **sucursal** | telefonoEncargado | VARCHAR(20) | NULL | Teléfono del responsable de la sucursal. |
| **sucursal** | calle | VARCHAR(100) | NULL | Calle de la ubicación (componente del atributo compuesto dirección). |
| **sucursal** | numero | VARCHAR(10) | NULL | Número exterior/interior (componente de dirección). |
| **sucursal** | ciudad | VARCHAR(60) | NULL | Ciudad o municipio (componente de dirección). |
| **sucursal** | estado | VARCHAR(60) | NULL | Estado o provincia (componente de dirección). |
| **sucursal** | pais | VARCHAR(60) | NULL | País de la ubicación (componente de dirección). |
| **sucursal** | CP | VARCHAR(10) | NULL | Código postal de la ubicación (componente de dirección). |

## pedido

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **pedido** | folio | INTEGER | PK (pk_pedido), NOT NULL | Folio o identificador único del pedido. |
| **pedido** | numeroCliente | INTEGER | FK (fk_pedido_cliente) → cliente, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Cliente que realizó el pedido. |
| **pedido** | estatus | VARCHAR(20) | NOT NULL | Estado actual del pedido. |
| **pedido** | dia | SMALLINT | NOT NULL, CHECK (ck_pedido_dia): 1 a 31 | Día de registro del pedido (componente del atributo compuesto fecha). |
| **pedido** | mes | SMALLINT | NOT NULL, CHECK (ck_pedido_mes): 1 a 12 | Mes de registro del pedido (componente de fecha). |
| **pedido** | anio | SMALLINT | NOT NULL, CHECK (ck_pedido_anio): >= 2000 | Año de registro del pedido (componente de fecha). |

## detalle

Entidad débil de `pedido` (dependencia de identificación y de existencia).

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **detalle** | folio | INTEGER | PK compuesta (pk_detalle), FK (fk_detalle_pedido) → pedido, NOT NULL, ON DELETE CASCADE, ON UPDATE CASCADE | Pedido al que pertenece la línea de detalle. |
| **detalle** | claveParcial | INTEGER | PK compuesta (pk_detalle), NOT NULL | Clave parcial (discriminador de la entidad débil): consecutivo del renglón dentro del pedido. |
| **detalle** | claveProducto | VARCHAR(10) | FK (fk_detalle_producto) → producto, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Producto del renglón. |
| **detalle** | costoProduccion | NUMERIC(12,2) | NOT NULL, CHECK (ck_detalle_costo): >= 0 | Costo de producción unitario al momento de la venta. |
| **detalle** | precioAplicado | NUMERIC(12,2) | NOT NULL, CHECK (ck_detalle_precio): >= 0 | Precio de venta unitario aplicado al renglón. |
| **detalle** | cantidad | INTEGER | NOT NULL, CHECK (ck_detalle_cantidad): > 0 | Unidades del producto en el renglón. |

## envio

Relación de orden superior entre sucursal, transportista y pedido.

| Tabla | Columna | Tipo | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **envio** | numeroGuia | VARCHAR(20) | PK (pk_envio), NOT NULL | Número de guía único para el rastreo del envío. |
| **envio** | folio | INTEGER | UNIQUE (uq_envio_folio), FK (fk_envio_pedido) → pedido, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Pedido asociado. UNIQUE limita a un envío por pedido. |
| **envio** | claveTransportista | VARCHAR(10) | FK (fk_envio_transportista) → transportista, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Transportista que ejecuta el envío. |
| **envio** | numeroCliente | INTEGER | FK compuesta (fk_envio_sucursal) → sucursal, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Parte de la clave foránea hacia la sucursal receptora (cliente dueño). |
| **envio** | claveSucursal | VARCHAR(10) | FK compuesta (fk_envio_sucursal) → sucursal, NOT NULL, ON DELETE RESTRICT, ON UPDATE CASCADE | Parte de la clave foránea hacia la sucursal receptora. |
| **envio** | costoFlete | NUMERIC(12,2) | NOT NULL, CHECK (ck_envio_flete): >= 0 | Costo del flete del servicio de envío. |
| **envio** | dia | SMALLINT | NOT NULL, CHECK (ck_envio_dia): 1 a 31 | Día en que se ejecuta el envío (componente de fecha). |
| **envio** | mes | SMALLINT | NOT NULL, CHECK (ck_envio_mes): 1 a 12 | Mes en que se ejecuta el envío (componente de fecha). |
| **envio** | anio | SMALLINT | NOT NULL, CHECK (ck_envio_anio): >= 2000 | Año en que se ejecuta el envío (componente de fecha). |

