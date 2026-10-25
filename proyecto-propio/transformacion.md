# Transformacion de Relaciones 

## Relaciones UNO a MUCHOS 

"Regla 4. Relaciones uno a muchos. La clave primaria del lado uno se propaga como clave foránea a la tabla
del lado muchos. Si la cardinalidad mínima del lado muchos es 1, la clave foránea es NOT NULL; si es 0, admite
nulos."

+ producto (1:1) - detalle (0:N) 

|       | **Producto**            |   |
|-------|-------------------|---------|
| PK    | claveProducto     |  |
|       | costoUnitarioUSD  |  |
|       | precioUnitarioUSD | |


|       | **Detalle**            |   |
|-------|-------------------|---------|
| PK    | folio    |  |
| PK      | claveParcial  |  |
| FK    | claveProducto | 

---

+ pedido (1:1) - detalle (1:N)

|       | **Pedido**            |   |
|-------|-------------------|---------|
| PK    | folio   |  |
| FK      | numeroCliente |  |
|       | estatus| |
| | dia
| | mes
| | año

---

+ cliente (1:1) - pedido (0:N)

|       | **Cliente**            |   |
|-------|-------------------|---------|
| PK    | numeroCliente     |  |
|       | razonSocial  |  |
|       | correoCliente | |
| | telefonoCliente

--- 

+ cliente (1:1) - sucursal (1:N)

|       | **Sucursal**            |   |
|-------|-------------------|---------|
| PK, FK   | numeroCliente     |  |
| PK      | claveSucursal  |  |
|       | nombrePlanta| |
| |telefonoEncargado|
| |CP|
| | calle
| |pais|
|| estado
||numero
||ciudad

---

+ sucursal (1:1) - envio (0:N)


|       | **Envio**            |   |
|-------|-------------------|---------|
| PK    | numeroGuia    |  |
| FK1,UK| folio   |  |
| FK2   | claveTransportista | |
|FK3| numeroCliente
||costoFlete
||dia
||mes
||año
---

+ envio (0:M) - transportista (1:1)

|       | **Transportista**            |   |
|-------|-------------------|---------|
| PK    | claveTransportista    |  |
|       | nombreEmpresa  |  |
|       | telefonoAtencion | |
|| email



## Relaciones UNO a UNO

"Regla 6. Relaciones uno a uno. Elija entre tres estrategias y justifique la elección:
1. Si una entidad tiene cardinalidad mínima 0 y la otra 1, propague la clave de la obligatoria a la opcional
como clave foránea con restricción UNIQUE.
2. Si ambas son obligatorias, propague la clave de cualquiera de las dos como clave foránea UNIQUE y
NOT NULL.
3. Fusione ambas entidades en una sola tabla, solo si tiene sentido desde el significado del problema."

+ cliente (1:1) - clienteNacional (0:1)

|       | **ClienteNacional**            |   |
|-------|-------------------|---------|
| PK, FK    | numeroCliente     |  |
|       | RFC  |  |
|       | regimenFiscal | |
| | estadoOrigen

---

+ cliente (1:1) - clienteExportacion (0:1)

|       | **ClienteExportacion**            |   |
|-------|-------------------|---------|
| PK, FK    | numeroCliente     |  |
|       | idFiscalGlobal |  |
|       | paisReceptor | |

---



+ transportista (1:1) - transportistaNacional (0:1)

|       | **TransportistaNacional**            |   |
|-------|-------------------|---------|
| PK, FK    | claveTransportista   |  |
|       | RFC  |  |


---


+ transportista (1:1) - transportistaInternacional(0:1)

|       | **TransportistaInternacional**            |   |
|-------|-------------------|---------|
| PK, FK    | claveTransportista     |  |
|       | codigoAduanal|  |
|       | agenciaAduanal | |

---

+ producto (1:1) - omnigold (0:1)

|       | **Omnigold**            |   |
|-------|-------------------|---------|
| PK, FK    | claveProducto     |  |
|       | provMaquinaria |  |
|       | 

----

+ producto (1:1) - hyvolt (0:1)

|       | **Hyvolt**            |   |
|-------|-------------------|---------|
| PK, FK    | claveProducto     |  |
|       | provTransformador  |  |
|       | 

---

+ prodcuto (1:1) - hyprene (0:1)

|       | **Hyprene**            |   |
|-------|-------------------|---------|
| PK, FK    | claveProducto     |  |
|       | provTransporte   |  |
|       | 


## Relaciones de ORDEN SUPERIOR

"Regla 7. Relaciones de orden superior. Las relaciones ternarias o mayores se transforman en una tabla propia
que incluye las claves primarias de todas las entidades participantes, más los atributos propios de la relación."

+ sucursal (0:N) - transportista (0:N) - pedido (0:1)


|       | **Envio**            |   |
|-------|-------------------|---------|
| PK    | numeroGuia    |  |
| FK1,UK| folio   |  |
| FK2   | claveTransportista | |
|FK3| numeroCliente
||costoFlete
||dia
||mes
||año






