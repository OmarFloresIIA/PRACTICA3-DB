# Inventario del Model Entidad Relación Extendido
## Entidades Fuertes
+ CLIENTE:
    + Clave primaria: **numeroCliente**
    + Atributos:
        + telefonoCliente
        + correoCliente
        + razonSocial
+ PEDIDO:
    + Clave primaria: **folio**
    + Atributos:
        + estatus
        + utilidadTotalUSD
        + montoTotalUSD
        + fecha
+ PRODUCTO:
    + Clave primaria: **claveProducto**
    + Atributos:
        + costoUnitarioUSD
        + precioUnitarioUSD
+ TRANSPORTISTA:
    + Clave primaria: **claveTransportista**
    + Atributos:
        + nombreEmpresa
        + telefonoAtencion
        + email
## Entidades Débiles
+ SUCURSAL: depende de CLIENTE, ya que un CLIENTE **tiene** una Sucursal, y una Sucursal pertenece a un solo CLIENTE
    + Clave primaria: **claveSucursal**
    + Atributos:
        + nombrePlanta
        + telefonoEncargado
        + direccion
+ DETALLE: depende de PEDIDO, ya que un pedido **registra** muchos detalles, y un detalle pertenece a un solo PEDIDO
    + Clave primaria: **claveParcial**
    + Atributos:
        + subtotal
        + costoProduccion
        + precioAplicado
        + cantidad
## Relaciones
+ Realiza:
+ Aparece:
+ Registra: 
+ Tiene:

## Jerarquías
### PRODUCTO
Se hizo una especialización disjunta y total, de los cuáles surgieron: 
+ Hyvolt
+ Omnigold
+ Hyprene
### CLIENTE
Se hizo una especialización disjunta y total, de los cuales surgieron:
+ clienteNacional:
+ clienteExportacion: 
### TRANSPORTISTA
Se hizo una especialización solapada y total, de los cuales surgieron:
+ transportistaNacional:
+ transportistaInternacional:
## Atributos Multivaluados
+ fecha(compuesto):
+ dirección(compuesto): 
+ utilidadTotalUSD(derivado):
+ montoTotalUSD(derivado):
+ subtotal(derivado):

## Relaciones Ternarias
+ Envío:
    + Atributos:

## ¿Qué elementos van a requerir una tabla adicional?
## ¿Qué atributos se convertiran en una clave foránea?
## ¿Qué decisión tendrá que tomar en cada jerarquía?