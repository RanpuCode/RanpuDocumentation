-- Table: public.usuarios

-- DROP TABLE IF EXISTS public.usuarios;

CREATE TABLE IF NOT EXISTS public.usuarios
(
    usuario_id integer NOT NULL DEFAULT nextval('usuarios_usuario_id_seq'::regclass),
    firebase_uid character varying(128) COLLATE pg_catalog."default",
    CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usuarios
    OWNER to ranpubackenddatabase_user;


-- Table: public.categorias_productos

-- DROP TABLE IF EXISTS public.categorias_productos;

CREATE TABLE IF NOT EXISTS public.categorias_productos
(
    categoria_producto_id integer NOT NULL DEFAULT nextval('categorias_productos_categoria_producto_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT categorias_productos_pkey PRIMARY KEY (categoria_producto_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categorias_productos
    OWNER to ranpubackenddatabase_user;


-- Table: public.productos

-- DROP TABLE IF EXISTS public.productos;

CREATE TABLE IF NOT EXISTS public.productos
(
    producto_id integer NOT NULL DEFAULT nextval('productos_producto_id_seq'::regclass),
    nombre character varying(100) COLLATE pg_catalog."default",
    descripcion character varying(1000) COLLATE pg_catalog."default",
    alto numeric(10,2),
    ancho numeric(10,2),
    largo numeric(10,2),
    gbl character varying(1000) COLLATE pg_catalog."default",
    precio numeric(10,2),
    categoria_producto_id integer,
    CONSTRAINT productos_pkey PRIMARY KEY (producto_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.productos
    OWNER to ranpubackenddatabase_user;


-- Table: public.detalles_catalogo

-- DROP TABLE IF EXISTS public.detalles_catalogo;

CREATE TABLE IF NOT EXISTS public.detalles_catalogo
(
    producto_id integer NOT NULL,
    detalles character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT detalles_catalogo_pkey PRIMARY KEY (producto_id),
    CONSTRAINT detalles_catalogo_producto_id_fkey FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.detalles_catalogo
    OWNER to ranpubackenddatabase_user;


-- Table: public.detalles_lamparas_ranpu

-- DROP TABLE IF EXISTS public.detalles_lamparas_ranpu;

CREATE TABLE IF NOT EXISTS public.detalles_lamparas_ranpu
(
    producto_id integer NOT NULL,
    detalles character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT detalles_lamparas_ranpu_pkey PRIMARY KEY (producto_id),
    CONSTRAINT detalles_lamparas_ranpu_producto_id_fkey FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.detalles_lamparas_ranpu
    OWNER to ranpubackenddatabase_user;


-- Table: public.detalles_productos_ia

-- DROP TABLE IF EXISTS public.detalles_productos_ia;

CREATE TABLE IF NOT EXISTS public.detalles_productos_ia
(
    producto_id integer NOT NULL,
    detalles character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT detalles_productos_ia_pkey PRIMARY KEY (producto_id),
    CONSTRAINT detalles_productos_ia_producto_id_fkey FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.detalles_productos_ia
    OWNER to ranpubackenddatabase_user;


-- Table: public.estado_impresora

-- DROP TABLE IF EXISTS public.estado_impresora;

CREATE TABLE IF NOT EXISTS public.estado_impresora
(
    estado_impresora_id integer NOT NULL DEFAULT nextval('estado_impresora_estado_impresora_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT estado_impresora_pkey PRIMARY KEY (estado_impresora_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_impresora
    OWNER to ranpubackenddatabase_user;
-- Index: ix_estado_impresora_estado_impresora_id

-- DROP INDEX IF EXISTS public.ix_estado_impresora_estado_impresora_id;

CREATE INDEX IF NOT EXISTS ix_estado_impresora_estado_impresora_id
    ON public.estado_impresora USING btree
    (estado_impresora_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.direcciones

-- DROP TABLE IF EXISTS public.direcciones;

CREATE TABLE IF NOT EXISTS public.direcciones
(
    direccion_id integer NOT NULL DEFAULT nextval('direccion_direccion_id_seq'::regclass),
    cedula character varying(10) COLLATE pg_catalog."default" NOT NULL,
    nombre_completo character varying(100) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(15) COLLATE pg_catalog."default" NOT NULL,
    calle_principal character varying(100) COLLATE pg_catalog."default" NOT NULL,
    calle_secundaria character varying(100) COLLATE pg_catalog."default",
    ciudad character varying(50) COLLATE pg_catalog."default" NOT NULL,
    provincia character varying(50) COLLATE pg_catalog."default" NOT NULL,
    numeracion character varying(10) COLLATE pg_catalog."default",
    referencia character varying(255) COLLATE pg_catalog."default",
    codigo_postal character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT direccion_pkey PRIMARY KEY (direccion_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.direcciones
    OWNER to ranpubackenddatabase_user;


-- Table: public.pedidos

-- DROP TABLE IF EXISTS public.pedidos;

CREATE TABLE IF NOT EXISTS public.pedidos
(
    pedido_id integer NOT NULL DEFAULT nextval('pedidos_pedido_id_seq'::regclass),
    fecha_envio timestamp without time zone,
    fecha_entrega timestamp without time zone,
    fecha_pago timestamp without time zone,
    estado_pedido_id integer,
    precio numeric(10,2),
    impuesto_id integer,
    precio_final numeric(10,2),
    pago_id character varying(1000) COLLATE pg_catalog."default",
    direccion_id integer,
    temporal_cart_id character varying(100) COLLATE pg_catalog."default",
    detalles_pago json,
    ingreso_neto numeric(10,2),
    fecha_creacion timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pedidos_pkey PRIMARY KEY (pedido_id),
    CONSTRAINT pedidos_direccion_id_fkey FOREIGN KEY (direccion_id)
        REFERENCES public.direcciones (direccion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pedidos
    OWNER to ranpubackenddatabase_user;


-- Table: public.pedidos_usuario

-- DROP TABLE IF EXISTS public.pedidos_usuario;

CREATE TABLE IF NOT EXISTS public.pedidos_usuario
(
    pedido_id integer NOT NULL,
    usuario_id integer NOT NULL,
    CONSTRAINT pedidos_usuario_pkey PRIMARY KEY (pedido_id, usuario_id),
    CONSTRAINT pedidos_usuario_pedido_id_fkey FOREIGN KEY (pedido_id)
        REFERENCES public.pedidos (pedido_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pedidos_usuario_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES public.usuarios (usuario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pedidos_usuario
    OWNER to ranpubackenddatabase_user;

-- Table: public.productos_pedidos

-- DROP TABLE IF EXISTS public.productos_pedidos;

CREATE TABLE IF NOT EXISTS public.productos_pedidos
(
    pedido_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer,
    producto_pedido_id integer NOT NULL DEFAULT nextval('pedidos_productos_id_seq'::regclass),
    CONSTRAINT productos_pedidos_pk PRIMARY KEY (producto_pedido_id),
    CONSTRAINT productos_pedidos_pedido_id_fkey FOREIGN KEY (pedido_id)
        REFERENCES public.pedidos (pedido_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT productos_pedidos_producto_id_fkey FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.productos_pedidos
    OWNER to ranpubackenddatabase_user;

-- Table: public.impresoras

-- DROP TABLE IF EXISTS public.impresoras;

CREATE TABLE IF NOT EXISTS public.impresoras
(
    impresora_id integer NOT NULL DEFAULT nextval('impresoras_impresora_id_seq'::regclass),
    marca character varying(50) COLLATE pg_catalog."default",
    estado_impresora_id integer,
    alto_area numeric(10,2),
    ancho_area numeric(10,2),
    largo_area character varying(1000) COLLATE pg_catalog."default",
    max_temp_cama numeric(10,2),
    max_temp_extrusor numeric(10,2),
    diametro_extrusor integer,
    consumo_electrico numeric(10,2),
    filamento_id integer,
    CONSTRAINT impresoras_pkey PRIMARY KEY (impresora_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.impresoras
    OWNER to ranpubackenddatabase_user;


-- Table: public.estados_impresoras

-- DROP TABLE IF EXISTS public.estados_impresoras;

CREATE TABLE IF NOT EXISTS public.estados_impresoras
(
    estado_impresora_id integer NOT NULL DEFAULT nextval('estados_impresoras_estado_impresora_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT estados_impresoras_pkey PRIMARY KEY (estado_impresora_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estados_impresoras
    OWNER to ranpubackenddatabase_user;


-- Table: public.estados_pedidos

-- DROP TABLE IF EXISTS public.estados_pedidos;

CREATE TABLE IF NOT EXISTS public.estados_pedidos
(
    estado_pedido_id integer NOT NULL DEFAULT nextval('estados_pedidos_estado_pedido_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default",
    nombre_ingles character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT estados_pedidos_pkey PRIMARY KEY (estado_pedido_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estados_pedidos
    OWNER to ranpubackenddatabase_user;


-- Table: public.imagenes_productos

-- DROP TABLE IF EXISTS public.imagenes_productos;

CREATE TABLE IF NOT EXISTS public.imagenes_productos
(
    imagen_producto_id integer NOT NULL DEFAULT nextval('imagenes_productos_imagen_producto_id_seq'::regclass),
    descripcion character varying(1000) COLLATE pg_catalog."default",
    ubicacion character varying(1000) COLLATE pg_catalog."default",
    producto_id integer,
    is_thumbnail boolean NOT NULL DEFAULT false,
    CONSTRAINT imagenes_productos_pkey PRIMARY KEY (imagen_producto_id),
    CONSTRAINT imagenes_productos_producto_id_fkey FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.imagenes_productos
    OWNER to ranpubackenddatabase_user;
-- Index: unique_main_thumbnail_per_product

-- DROP INDEX IF EXISTS public.unique_main_thumbnail_per_product;

CREATE UNIQUE INDEX IF NOT EXISTS unique_main_thumbnail_per_product
    ON public.imagenes_productos USING btree
    (producto_id ASC NULLS LAST)
    TABLESPACE pg_default
    WHERE is_thumbnail = true;

-- Table: public.filamentos

-- DROP TABLE IF EXISTS public.filamentos;

CREATE TABLE IF NOT EXISTS public.filamentos
(
    filamento_id integer NOT NULL DEFAULT nextval('filamentos_filamento_id_seq'::regclass),
    color character varying(50) COLLATE pg_catalog."default",
    marca character varying(50) COLLATE pg_catalog."default",
    peso_inicial numeric(10,2),
    peso_actual numeric(10,2),
    longitud_inicial numeric(10,2),
    longitud_actual numeric(10,2),
    precio_compra numeric(10,2),
    fecha_compra timestamp without time zone,
    categoria_filamento_id integer,
    CONSTRAINT filamentos_pkey PRIMARY KEY (filamento_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.filamentos
    OWNER to ranpubackenddatabase_user;


-- Table: public.categorias_filamentos

-- DROP TABLE IF EXISTS public.categorias_filamentos;

CREATE TABLE IF NOT EXISTS public.categorias_filamentos
(
    categoria_filamento_id integer NOT NULL DEFAULT nextval('categorias_filamentos_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default",
    descripcion character varying(1000) COLLATE pg_catalog."default",
    diametro numeric(10,2),
    temp_extrusion numeric(10,2),
    temp_cama numeric(10,2),
    resistencia numeric(10,2),
    flexibilidad numeric(10,2),
    material_base character varying(50) COLLATE pg_catalog."default",
    precio_kg numeric(10,2),
    CONSTRAINT categorias_filamentos_pkey PRIMARY KEY (categoria_filamento_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categorias_filamentos
    OWNER to ranpubackenddatabase_user;


-- Table: public.filamentos_compatibles

-- DROP TABLE IF EXISTS public.filamentos_compatibles;

CREATE TABLE IF NOT EXISTS public.filamentos_compatibles
(
    impresora_id integer NOT NULL,
    categoria_filamento_id integer NOT NULL,
    CONSTRAINT filamentos_compatibles_pkey PRIMARY KEY (impresora_id, categoria_filamento_id),
    CONSTRAINT filamentos_compatibles_categoria_filamento_id_fkey FOREIGN KEY (categoria_filamento_id)
        REFERENCES public.categorias_filamentos (categoria_filamento_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT filamentos_compatibles_impresora_id_fkey FOREIGN KEY (impresora_id)
        REFERENCES public.impresoras (impresora_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.filamentos_compatibles
    OWNER to ranpubackenddatabase_user;

-- Table: public.impresion

-- DROP TABLE IF EXISTS public.impresion;

CREATE TABLE IF NOT EXISTS public.impresion
(
    impresion_id integer NOT NULL,
    fecha_inicio timestamp without time zone,
    fecha_fin timestamp without time zone,
    cantidad_filamento numeric(10,2),
    tiempo_impresion time without time zone,
    peso numeric(10,2),
    impresora_id integer,
    filamento_id integer,
    CONSTRAINT impresion_pkey PRIMARY KEY (impresion_id),
    CONSTRAINT impresion_filamento_id_fkey FOREIGN KEY (filamento_id)
        REFERENCES public.filamentos (filamento_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT impresion_impresora_id_fkey FOREIGN KEY (impresora_id)
        REFERENCES public.impresoras (impresora_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.impresion
    OWNER to ranpubackenddatabase_user;

-- Table: public.modelos

-- DROP TABLE IF EXISTS public.modelos;

CREATE TABLE IF NOT EXISTS public.modelos
(
    modelo_id integer NOT NULL DEFAULT nextval('modelos_modelo_id_seq'::regclass),
    tiempo_estimado time without time zone,
    alto numeric(10,2),
    ancho numeric(10,2),
    largo numeric(10,2),
    stl character varying(1000) COLLATE pg_catalog."default",
    stock integer,
    producto_id integer NOT NULL DEFAULT 1,
    CONSTRAINT modelo_pkey PRIMARY KEY (modelo_id),
    CONSTRAINT fk_productos FOREIGN KEY (producto_id)
        REFERENCES public.productos (producto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.modelos
    OWNER to ranpubackenddatabase_user;


-- Table: public.modelos_impresion

-- DROP TABLE IF EXISTS public.modelos_impresion;

CREATE TABLE IF NOT EXISTS public.modelos_impresion
(
    impresion_id integer NOT NULL,
    modelo_id integer NOT NULL,
    CONSTRAINT modelos_impresion_pkey PRIMARY KEY (impresion_id, modelo_id),
    CONSTRAINT modelos_impresion_impresion_id_fkey FOREIGN KEY (impresion_id)
        REFERENCES public.impresion (impresion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT modelos_impresion_modelo_id_fkey FOREIGN KEY (modelo_id)
        REFERENCES public.modelos (modelo_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.modelos_impresion
    OWNER to ranpubackenddatabase_user;


-- Table: public.impuestos

-- DROP TABLE IF EXISTS public.impuestos;

CREATE TABLE IF NOT EXISTS public.impuestos
(
    impuesto_id integer NOT NULL DEFAULT nextval('impuestos_impuesto_id_seq'::regclass),
    nombre character varying(50) COLLATE pg_catalog."default",
    porcentaje numeric(5,2),
    activo boolean,
    CONSTRAINT impuestos_pkey PRIMARY KEY (impuesto_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.impuestos
    OWNER to ranpubackenddatabase_user;


-- Table: public.imagenes_ranpulamps

-- DROP TABLE IF EXISTS public.imagenes_ranpulamps;

CREATE TABLE IF NOT EXISTS public.imagenes_ranpulamps
(
    imagenes_ranpulamps_id integer NOT NULL DEFAULT nextval('imagenes_ranpulamps_id_seq'::regclass),
    imagen_url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    producto_pedido_id integer NOT NULL,
    CONSTRAINT imagenes_ranpulamps_pkey PRIMARY KEY (imagenes_ranpulamps_id),
    CONSTRAINT imagenes_ranpulamps_producto_pedido_id_fkey FOREIGN KEY (producto_pedido_id)
        REFERENCES public.productos_pedidos (producto_pedido_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.imagenes_ranpulamps
    OWNER to ranpubackenddatabase_user;

-- Trigger: limit_images_trigger

-- DROP TRIGGER IF EXISTS limit_images_trigger ON public.imagenes_ranpulamps;

CREATE OR REPLACE TRIGGER limit_images_trigger
    BEFORE INSERT
    ON public.imagenes_ranpulamps
    FOR EACH ROW
    EXECUTE FUNCTION public.check_max_images_per_producto_pedido();