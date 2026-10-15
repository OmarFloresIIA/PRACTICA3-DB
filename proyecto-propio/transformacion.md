# Transformacion de Relaciones 

## Relaciones UNO a MUCHOS 

"Regla 4. Relaciones uno a muchos. La clave primaria del lado uno se propaga como clave foránea a la tabla
del lado muchos. Si la cardinalidad mínima del lado muchos es 1, la clave foránea es NOT NULL; si es 0, admite
nulos."

+ producto (1:1) - detalle (0:N) 

+ pedido (1:1) - detalle (1:N)

+ cliente (1:1) - pedido (0:N)

+ cliente (1:1) - sucursal (1:N)

+ sucursal (1:1) - envio (0:N)

+ envio (0:M) - transportista (1:1)



## Relaciones UNO a UNO

"Regla 6. Relaciones uno a uno. Elija entre tres estrategias y justifique la elección:
1. Si una entidad tiene cardinalidad mínima 0 y la otra 1, propague la clave de la obligatoria a la opcional
como clave foránea con restricción UNIQUE.
2. Si ambas son obligatorias, propague la clave de cualquiera de las dos como clave foránea UNIQUE y
NOT NULL.
3. Fusione ambas entidades en una sola tabla, solo si tiene sentido desde el significado del problema."

+ cliente (1:1) - clienteNacional (0:1)

+ cliente (1:1) - clienteExportacion (0:1)

+ transportista (1:1) - transportistaNacional (0:1)

+ transportista (1:1) - transportistaInternacional(0:1)

+ producto (1:1) - omnigold (0:1)

+ producto (1:1) - hyvolt (0:1)

+ prodcuto (1:1) - hyprene (0:1)

## Relaciones de ORDEN SUPERIOR

"Regla 7. Relaciones de orden superior. Las relaciones ternarias o mayores se transforman en una tabla propia
que incluye las claves primarias de todas las entidades participantes, más los atributos propios de la relación."

+ envio () - sucursal () - pedido ()







