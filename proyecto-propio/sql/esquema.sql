CREATE TABLE cliente (
    numeroCliente   CHAR(7)        PRIMARY KEY,
    razonSocial     VARCHAR(100)   NOT NULL,
    correoCliente   VARCHAR(50)    NOT NULL,
    telefonoCliente VARCHAR(20)    NOT NULL
);

CREATE TABLE clienteNacional (
    numeroCliente   CHAR(7)       PRIMARY KEY REFERENCES cliente(numeroCliente),
    rfc             VARCHAR(13)   NOT NULL,
    regimenFiscal   VARCHAR(100)  NOT NULL,
    estadoOrigen    CHAR(7)       NOT NULL
);

CREATE TABLE clienteExportacion (
    numeroCliente   CHAR(7)       PRIMARY KEY REFERENCES cliente(numeroCliente),
    idFiscalGlobal  VARCHAR(100)  NOT NULL,
    paisReceptor    VARCHAR(80)   NOT NULL
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
);

CREATE TABLE transportistaInternacional (
    claveTransportista      CHAR(5)        PRIMARY KEY REFERENCES transportista(claveTransportista),
    codigoAduanal           VARCHAR(20)    NOT NULL,
    agenciaAduanal          VARCHAR(100)   NOT NULL
);

CREATE TABLE transportistaNacional (
    claveTransportista      CHAR(5)     PRIMARY KEY REFERENCES transportista(claveTransportista),
    rfc                     VARCHAR(13) NOT NULL
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
    costoUnitarioUSD    DECIMAL(12,3)   NOT NULL,
    precioUnitarioUSD   DECIMAL(12,3)   NOT NULL
);

CREATE TABLE onmigold (
    claveProducto       CHAR(6)     PRIMARY KEY REFERENCES producto(claveProducto)
);

CREATE TABLE hyvolt (
    claveProducto       CHAR(6)     PRIMARY KEY REFERENCES producto(claveProducto)
);

CREATE TABLE hyprene (
    claveProducto       CHAR(6)     PRIMARY KEY REFERENCES producto(claveProducto)
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