CREATE TABLE cliente (
    numeroCliente   CHAR(7)        PRIMARY KEY,
    razonSocial     VARCHAR(100)   NOT NULL,
    correoCliente   VARCHAR(50)    NOT NULL,
    telefonoCliente VARCHAR(20)    NOT NULL
    tipoCliente
    RFC
    regimenFiscal
    estadoOrigen
    idFiscalGlobal
    paisReceptor
);


CREATE TABLE pedido (
    folio           CHAR(8)     PRIMARY KEY,
    numeroCliente   CHAR(7)     NOT NULL REFERENCES cliente(numeroCliente), 
    estatus         VARCHAR(20) NOT NULL,       
    dia             SMALLINT,
    mes             SMALLINT,            
    anio            SMALLINT   
);

CREATE TABLE transportista (
    claveTransportista      CHAR(5)        PRIMARY KEY,
    nombreEmpresa           VARCHAR(100)   NOT NULL,
    telefonoAtencion        VARCHAR(20),    
    email                   VARCHAR(50)   
    esNacional
    esInternacional
    RFC
    codigoAduanal
    agenciaAduanal 
);


CREATE TABLE sucursal (
    numeroCliente       CHAR(7)         NOT NULL REFERENCES cliente(numeroCliente),
    claveSucursal       CHAR(5)         NOT NULL,
    nombrePlanta        VARCHAR(100)    NOT NULL,
    telefonoEncargado   VARCHAR(20)     NOT NULL,
    codigoPostal        CHAR(5),
    calle               VARCHAR(50),
    pais                VARCHAR(50),
    estado              VARCHAR(40),
    numero              VARCHAR(10),
    ciudad              VARCHAR(50),
    PRIMARY KEY (numeroCliente, claveSucursal)
);

CREATE TABLE producto (
    claveProducto       CHAR(6)         PRIMARY KEY,
    tipoProducto
    costoUnitarioUSD    DECIMAL(12,3)   NOT NULL,
    precioUnitarioUSD   DECIMAL(12,3)   NOT NULL
    provMaquinaria      
    provTransformador
    provTransporte
);


CREATE TABLE detalle (
    folio               CHAR(8)         NOT NULL REFERENCES pedido(folio),
    claveParcial        SMALLINT,
    claveProducto       CHAR(6)         NOT NULL REFERENCES producto(claveProducto),
    costoProduccion     DECIMAL(12,2)   NOT NULL,
    precioAplicado      DECIMAL(12,2)   NOT NULL,
    cantidad            INT             NOT NULL,
    PRIMARY KEY (folio, claveParcial)
);

CREATE TABLE envio (
    numeroGuia          CHAR(10)        PRIMARY KEY,
    folio               CHAR(8)         NOT NULL REFERENCES pedido(folio),
    claveTransportista  CHAR(5)         NOT NULL REFERENCES transportista(claveTransportista),
    numeroCliente       CHAR(7)         NOT NULL,
    claveSucursal       CHAR(5)         NOT NULL,
    costo               DECIMAL(12,2)   NOT NULL,
    dia                 SMALLINT,
    mes                 SMALLINT,
    anio                SMALLINT,
    FOREIGN KEY (numeroCliente, claveSucursal)
        REFERENCES sucursal(numeroCliente, claveSucursal)
);