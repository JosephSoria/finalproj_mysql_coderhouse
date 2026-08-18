/*
----------------------------------------------
----------------------------------------------
ENTREGA PROYECTO FINAL
curso: 		MySQL
profesor:	Santiago Luis Acosta Rapoani

alumno:		JOSE, SORIA DIAZ
comision:	53185
temática:	Fotografía
entrega:	mayo 2024
----------------------------------------------
----------------------------------------------
*/


DROP DATABASE IF EXISTS fotografia;
DROP DATABASE IF EXISTS fotografia;
CREATE DATABASE  IF NOT EXISTS fotografia;
USE fotografia;



-- ------------------------------------------------------
-- CREACION DE TABLAS -----------------------------------
-- ------------------------------------------------------



DROP TABLE IF EXISTS tipousuario;
CREATE TABLE tipousuario (
  id_tipoUsuario int NOT NULL AUTO_INCREMENT,
  tipoUsuario varchar(45) NOT NULL,
  puedeCargarTarjeta tinyint NOT NULL,
  puedeComprar tinyint NOT NULL,
  puedeDescargar tinyint NOT NULL,
  puedeVerPreview tinyint NOT NULL,
  puedeCompartirLink tinyint NOT NULL,
  puedeInteractuar tinyint NOT NULL,
  puedeCrearAlbum tinyint NOT NULL,
  puedeSuspender tinyint NOT NULL,
  puedeModerar tinyint NOT NULL,
  PRIMARY KEY (id_tipoUsuario)
);


DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id_usuario int NOT NULL AUTO_INCREMENT,
  email varchar(80) NOT NULL,
  contraseña varchar(50) NOT NULL,
  nombreUsuario varchar(30) NOT NULL,
  id_tipoUsuario int NOT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY nombreUsuario (nombreUsuario),
  UNIQUE KEY email (email),
  KEY id_tipoUsuario_ix (id_tipoUsuario),
  CONSTRAINT usuarios_fk_1 FOREIGN KEY (id_tipoUsuario) REFERENCES tipousuario (id_tipoUsuario)
);


DROP TABLE IF EXISTS pais;
CREATE TABLE pais (
  id_pais int NOT NULL AUTO_INCREMENT,
  pais varchar(45) NOT NULL,
  PRIMARY KEY (id_pais),
  UNIQUE KEY pais (pais)
);


DROP TABLE IF EXISTS ciudad;
CREATE TABLE ciudad (
  id_ciudad int NOT NULL AUTO_INCREMENT,
  ciudad varchar(45) NOT NULL,
  id_pais int NOT NULL,
  lat decimal(10,7) DEFAULT NULL,
  lon decimal(10,7) DEFAULT NULL,  
  PRIMARY KEY (id_ciudad),
  KEY ciudad_ix (id_pais),
  CONSTRAINT ciudad_fk FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);


DROP TABLE IF EXISTS infousuarios;
CREATE TABLE infousuarios (
  id_infoUsuarios int NOT NULL AUTO_INCREMENT,
  id_usuario int NOT NULL,
  nombre varchar(30) NOT NULL,
  apellido varchar(30) NOT NULL,
  fechaCreacion date NOT NULL,
  fechaNac date NOT NULL,
  telefono varchar(20) NOT NULL,
  id_ciudad int NOT NULL,
  PRIMARY KEY (id_infoUsuarios),
  KEY id_usuario_ix (id_usuario),
  KEY id_ciudad_ix (id_ciudad),
  CONSTRAINT infousuarios_fk_1 FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
  CONSTRAINT infousuarios_fk_2 FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad)
);


DROP TABLE IF EXISTS marcatarjeta;
CREATE TABLE marcatarjeta (
  id_marcaTarjeta int NOT NULL AUTO_INCREMENT,
  marca varchar(40) NOT NULL,
  PRIMARY KEY (id_marcaTarjeta),
  UNIQUE KEY marca (marca)
);


DROP TABLE IF EXISTS tarjetas;
CREATE TABLE tarjetas (
  id_tarjeta int NOT NULL AUTO_INCREMENT,
  numero varchar(20) NOT NULL,
  vencimiento int NOT NULL,
  cvv smallint NOT NULL,
  titular varchar(50) NOT NULL,
  documentoTitular varchar(15) NOT NULL,
  id_marcaTarjeta int NOT NULL,
  PRIMARY KEY (id_tarjeta),
  KEY id_marcaTarjeta_ix (id_marcaTarjeta),
  CONSTRAINT tarjetas_fk_1 FOREIGN KEY (id_marcaTarjeta) REFERENCES marcatarjeta (id_marcaTarjeta)
);


DROP TABLE IF EXISTS tipocontenido;
CREATE TABLE tipocontenido (
  id_tipoContenido int NOT NULL,
  tipoContenido varchar(30) NOT NULL,
  PRIMARY KEY (id_tipoContenido)
);


DROP TABLE IF EXISTS albumes;
CREATE TABLE albumes (
  id_album int NOT NULL,
  nombre varchar(50) NOT NULL,
  aptoMenores tinyint NOT NULL,
  id_usuario int NOT NULL,
  id_tipoContenido int NOT NULL,
  PRIMARY KEY (id_album),
  KEY id_usuario_ix (id_usuario),
  KEY id_tipoContenido_ix (id_tipoContenido),
  CONSTRAINT albumes_fk_1 FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
  CONSTRAINT albumes_fk_2 FOREIGN KEY (id_tipoContenido) REFERENCES tipocontenido (id_tipoContenido)
);


DROP TABLE IF EXISTS fotografias;
CREATE TABLE fotografias (
  id_foto int NOT NULL,
  nombreArchivo varchar(256) NOT NULL,
  fechaCarga date NOT NULL,
  tituloFoto varchar(90) DEFAULT NULL,
  id_album int NOT NULL,
  id_usuario int NOT NULL,
  PRIMARY KEY (id_foto),
  KEY id_album_ix (id_album),
  KEY id_usuario_ix (id_usuario),
  CONSTRAINT fotografias_fk_1 FOREIGN KEY (id_album) REFERENCES albumes (id_album),
  CONSTRAINT fotografias_fk_2 FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);


DROP TABLE IF EXISTS comentarios;
CREATE TABLE comentarios (
  id_comentario int NOT NULL,
  fecha date DEFAULT NULL,
  comentario text,
  id_usuario int NOT NULL,
  id_foto int NOT NULL,
  PRIMARY KEY (id_comentario),
  KEY id_usuario_ix (id_usuario),
  KEY id_foto_ix (id_foto),
  CONSTRAINT comentarios_fk_1 FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
  CONSTRAINT comentarios_fk_2 FOREIGN KEY (id_foto) REFERENCES fotografias (id_foto)
);


DROP TABLE IF EXISTS estadopago;
CREATE TABLE estadopago (
  id_estadoPago int NOT NULL,
  estado varchar(30) NOT NULL,
  PRIMARY KEY (id_estadoPago)
);


DROP TABLE IF EXISTS compra;
CREATE TABLE compra (
  id_compra int NOT NULL,
  id_usuario_comprador int NOT NULL,
  fechaCompra date DEFAULT NULL,
  totalU$D int DEFAULT NULL,
  PRIMARY KEY (id_compra),
  KEY id_usuario_ix (id_usuario_comprador),
  CONSTRAINT compra_fk_1 FOREIGN KEY (id_usuario_comprador) REFERENCES usuarios (id_usuario)
);


DROP TABLE IF EXISTS pagos;
CREATE TABLE pagos (
  id_pago int NOT NULL,
  fechaHora timestamp NOT NULL,
  id_estadoPago int NOT NULL,
  id_tarjeta int NOT NULL,
  id_compra int NOT NULL,
  PRIMARY KEY (id_pago),
  KEY id_estadoPago_ix (id_estadoPago),
  KEY id_tarjeta_ix (id_tarjeta),
  KEY id_compra_ix (id_compra),
  CONSTRAINT pagos_fk_1 FOREIGN KEY (id_estadoPago) REFERENCES estadopago (id_estadoPago),
  CONSTRAINT pagos_fk_2 FOREIGN KEY (id_tarjeta) REFERENCES tarjetas (id_tarjeta),
  CONSTRAINT pagos_fk_3 FOREIGN KEY (id_compra) REFERENCES compra (id_compra)
);


DROP TABLE IF EXISTS itemscompra;
CREATE TABLE itemscompra (
  id_item int NOT NULL,
  id_compra int NOT NULL,
  id_album int NOT NULL,
  PRIMARY KEY (id_item),
  KEY id_album_ix (id_album),
  KEY id_compra_ix (id_compra),
  CONSTRAINT itemscompra_fk_1 FOREIGN KEY (id_compra) REFERENCES compra (id_compra),
  CONSTRAINT itemscompra_fk_2 FOREIGN KEY (id_album) REFERENCES albumes (id_album)
);


DROP TABLE IF EXISTS precioalbum;
CREATE TABLE precioalbum (
  id_precio int NOT NULL,
  id_album int NOT NULL,
  fechaAltaPrecio date NOT NULL,
  importeU$D int NOT NULL,
  PRIMARY KEY (id_precio),
  KEY id_album_ix (id_album),
  CONSTRAINT precioalbum_fk_1 FOREIGN KEY (id_album) REFERENCES albumes (id_album)
);



-- Creacion de tabla de auditoria para utilzar con triggers. 
-- auditoria sobre la tabla 'usuarios'

CREATE TABLE usuarios_audit (
	id_audit INT NOT NULL AUTO_INCREMENT,
	tipo VARCHAR(15),
	fecha DATETIME,
	id_usuario int NOT NULL,
	email varchar(80) NOT NULL,
	contraseña varchar(50) NOT NULL,
	nombreUsuario varchar(30) NOT NULL,
	id_tipoUsuario int NOT NULL,
	PRIMARY KEY(id_audit)
);







-- ------------------------------------------------------
-- CREACION DE FUNCIONES---------------------------------
-- ------------------------------------------------------


-- funcion que devuelve el precio más reciente de un álbum dado
DELIMITER $$
DROP FUNCTION IF EXISTS f_precio_album $$

CREATE FUNCTION f_precio_album (p_id_album INT) RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cantidad INT default 0;
    DECLARE precio INT DEFAULT 0;
	
    SELECT COUNT(*) INTO cantidad
	FROM precioalbum
	WHERE id_album=(p_id_album)
	GROUP BY id_album;
    
    IF cantidad>0 THEN
		SELECT importeU$D INTO precio 
		FROM precioAlbum 
		WHERE id_album IN (p_id_album) 
		ORDER BY fechaAltaPrecio DESC
		LIMIT 1;
    END IF;
    
    RETURN precio;
END$$
DELIMITER ;


-- funcion que suma el importe de venta vigente de todos los elementos que conforman una orden de compra
-- usado para calcular el importe total de las ordenes de compra
DELIMITER $$
DROP FUNCTION IF EXISTS f_total_orden_compra $$

CREATE FUNCTION f_total_orden_compra (p_id_orden_compra INT) returns INT
READS SQL DATA
BEGIN
	DECLARE total INT DEFAULT 0;

	SELECT SUM( f_precio_album(id_album) ) INTO total
	FROM itemscompra
	WHERE id_compra = p_id_orden_compra;
    
    RETURN total;
END$$
DELIMITER ;


-- funcion que devuelve la máxima cantidad de comentarios que existe en una misma foto
DELIMITER $$
DROP FUNCTION IF EXISTS f_max_comentarios_foto $$

CREATE FUNCTION f_max_comentarios_foto() RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cantidad INT;
    
	SELECT count(*) AS max_comentarios_foto
	INTO cantidad
	FROM comentarios
	GROUP BY id_foto
	ORDER BY 1 DESC
	LIMIT 1;

	RETURN cantidad;
END $$
DELIMITER ;


-- función que devuelve la cantidad máxima de comentarios realizados por un mismo usuario
DELIMITER $$
DROP FUNCTION IF EXISTS f_max_comentarios_usuario $$

CREATE FUNCTION f_max_comentarios_usuario() RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cantidad INT;
    
	select count(*) as max_comentarios_usuario
    INTO cantidad
	from comentarios
	group by id_usuario
	order by 1 desc
	limit 1;

	RETURN cantidad;
END $$
DELIMITER ;


-- función que devuelve la cantidad de veces que se vendió un album dado su id_album
DELIMITER $$
DROP FUNCTION IF EXISTS f_cant_vendidos_album $$

CREATE FUNCTION f_cant_vendidos_album(p_id_album INT) RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cant INT;

	SELECT count(*)
	INTO cant
	FROM albumes AS a
	INNER JOIN itemscompra AS ic ON a.id_album = ic.id_album
	WHERE a.id_album = p_id_album;
    
    RETURN cant;

END $$
DELIMITER ;


-- función que devuelve el nombre y apellido de un usuario dado su id_usuario
-- esta función se utiliza en la vista v_album_compra_venta, para evitar relacionar 2 tablas (una de comprador y otra de vendedor)
-- a la misma tabla 'infousuarios' mediante 2 joins a la misma tabla.
DELIMITER $$
DROP FUNCTION IF EXISTS f_getUser_nombre $$

CREATE FUNCTION f_getUser_nombre(p_id_usuario INT) RETURNS VARCHAR(60)
READS SQL DATA
BEGIN 
	
    RETURN (
			SELECT concat(iu.nombre, " ", iu.apellido)
			FROM infousuarios AS iu
			WHERE iu.id_usuario = p_id_usuario
			);

END $$
DELIMITER ;


-- ------------------------------------------------------
-- CREACION DE VISTAS------------------------------------
-- ------------------------------------------------------


-- Info detallada de usuarios (no se muestra campo 'contraseña')
CREATE OR REPLACE VIEW v_fact_usuarios_detalle AS
SELECT 
        u.id_usuario,
        tu.tipoUsuario,
        u.nombreUsuario,
        u.email,
        iu.nombre,
        iu.apellido,
        iu.fechaCreacion,
        iu.fechaNac,
        iu.telefono,
        c.ciudad,
        p.pais,
        iu.id_infoUsuarios,
        tu.id_tipoUsuario,
        c.id_ciudad,
        p.id_pais
FROM infousuarios AS iu
INNER JOIN usuarios AS u ON iu.id_usuario = u.id_usuario
INNER JOIN tipousuario AS tu ON u.id_tipoUsuario = tu.id_tipoUsuario
INNER JOIN ciudad AS c ON iu.id_ciudad = c.id_ciudad
INNER JOIN pais AS p ON p.id_pais = c.id_pais
;



-- detalles de items comprados 
CREATE OR REPLACE VIEW v_fact_ordenes_compra_detalles AS
SELECT  
		ic.id_compra,
        c.fechaCompra,
        a.nombre AS nombreAlbum,
        f_precio_album(ic.id_album) AS importeU$D,
        a.aptoMenores,
        tc.tipoContenido,
        (SELECT fo.fechaCarga
			FROM fotografias AS fo
			WHERE fo.id_album = ic.id_album
			GROUP BY fo.fechacarga, fo.id_album
			LIMIT 1) AS fechaCreacionAlbum,
		concat(iu.nombre, " ", iu.apellido) AS nombreFotografo,
        -- iu.nombre AS nombreFotografo,
        -- iu.apellido AS apellidoFotografo,
        p.pais AS paisFotografo,
        u.nombreUsuario AS nombreUsuarioFotografo,
        
		ic.id_item,
        ic.id_album,
        a.id_usuario AS id_usuario_fotografo,
        iu.id_infoUsuarios as id_infoUsuario,
        a.id_tipoContenido,
        p.id_pais AS id_pais_fotografo
        
from itemscompra as ic
inner join albumes as a on ic.id_album = a.id_album
inner join usuarios as u on a.id_usuario = u.id_usuario
inner join infousuarios as iu on iu.id_usuario = u.id_usuario
inner join tipocontenido as tc on tc.id_tipoContenido = a.id_tipoContenido
inner join ciudad as ciu on ciu.id_ciudad = iu.id_ciudad
inner join pais as p on p.id_pais = ciu.id_pais
inner join compra as c on c.id_compra = ic.id_compra
order by id_compra asc, a.id_album asc
;



-- detalle de ordenes de compra
CREATE OR REPLACE VIEW v_fact_ordenes_compra AS
select
	c.id_compra,
    c.id_usuario_comprador,
    c.fechaCompra,
    c.totalU$D,
    concat(iu.nombre, " " , iu.apellido) as nombreComprador,
    u.nombreUsuario as nombreUsuario,
    u.email,
    tu.tipoUsuario,
    iu.telefono,
    ciu.ciudad,
    p.pais,
    ciu.lat,
    ciu.lon,
    u.id_tipoUsuario,
    ciu.id_ciudad,
    p.id_pais
from compra as c
inner join usuarios as u on c.id_usuario_comprador = u.id_usuario
inner join infousuarios as iu on iu.id_usuario = c.id_usuario_comprador
inner join tipousuario as tu on tu.id_tipoUsuario = u.id_tipoUsuario
inner join ciudad as ciu on ciu.id_ciudad = iu.id_ciudad
inner join pais as p on p.id_pais = ciu.id_pais
order by c.id_compra ASC
;



-- Muestra información privada de tarjestas de crédito almacenadas
CREATE OR REPLACE VIEW v_tarjetas AS
select 
		tarj.id_tarjeta,
        marca.marca,
		concat(left(tarj.numero,3), " *** *** ", right(tarj.numero,3) ) as numero, 
		tarj.vencimiento,
		-- tarj.cvv,
        "***" as cvv,
		tarj.titular,
		tarj.documentoTitular,
		tarj.id_marcaTarjeta
from tarjetas as tarj
inner join marcaTarjeta as marca on tarj.id_marcaTarjeta = marca.id_marcaTarjeta
order by id_tarjeta
;



-- Vista que muestra las fotografías con comentarios
CREATE OR REPLACE VIEW v_fact_fotos_comentadas AS
SELECT 
    f.id_foto AS id_fotografia,
    alb.nombre AS nombreAlbum,
    com.comentario,
    us.nombreUsuario AS usuarioComentador,
    f.fechaCarga AS fechaCargaFoto,
    com.fecha AS fechaComentario,
    com.id_usuario AS id_usuario_comentador,
    f.id_album
FROM fotografias AS f
INNER JOIN comentarios AS com ON f.id_foto = com.id_foto
INNER JOIN usuarios AS us ON us.id_usuario = com.id_usuario
INNER JOIN albumes AS alb ON alb.id_album = f.id_album
WHERE EXISTS( 
			SELECT DISTINCT(id_foto)
			FROM comentarios AS c
			WHERE c.id_foto = f.id_foto
            )
ORDER BY fechaComentario ASC;



-- vista que muestra aquellos registros de pagos que no han sido aprobados, o con errores
-- cuyas órdenes de compra no tiene un importe asociado
-- por lo general son registros de pagos que tienen un estado no correcto
CREATE OR REPLACE VIEW v_fact_pagos_no_procesados AS
SELECT
	p.id_pago,
    p.fechaHora,
    p.id_compra,
    c.fechaCompra,
    c.totalU$D,     
    mt.marca AS tarjeta,
    u.nombreUsuario AS usuarioComprador,
    e.estado as estadoPago,
    p.id_estadoPago,
    p.id_tarjeta,
    c.id_usuario_comprador
FROM pagos AS p 
INNER JOIN compra AS c ON p.id_compra = c.id_compra
INNER JOIN estadopago AS e ON e.id_estadoPago = p.id_estadoPago
INNER JOIN tarjetas AS t ON p.id_tarjeta = t.id_tarjeta
INNER JOIN marcatarjeta AS mt ON mt.id_marcaTarjeta = t.id_marcaTarjeta
INNER JOIN usuarios AS u ON u.id_usuario = c.id_usuario_comprador
WHERE e.id_estadoPago != 1
ORDER BY p.id_pago
;



-- vista que muestra información relacionada a los albumes, sus vendedores (fotografos) y sus usuarios compradores
-- así como la fecha de la operación de compra/venta
CREATE OR REPLACE VIEW v_fact_album_compra_venta AS
SELECT
	a.id_album,
    a.nombre AS nombreAlbum,
    a.id_usuario AS id_usuario_fotografo,
    c.id_usuario_comprador,
    f_getUser_nombre(a.id_usuario) AS nombreFotografo,
    f_getUser_nombre(c.id_usuario_comprador) AS nombreUsuarioComprador,
    f_precio_album(a.id_album) AS importeU$D,
    c.fechaCompra AS fecha_Compra_Venta
FROM albumes AS a
INNER JOIN itemscompra AS ic ON ic.id_album = a.id_album
INNER JOIN compra AS c ON c.id_compra = ic.id_compra
;



-- ------------------------------------------------------
-- CREACION DE STORED PROCEDURES ------------------------
-- ------------------------------------------------------


-- procedimiento que elimina todos los comentarios para todas las fotografias incluidas en un album
DELIMITER $$
DROP PROCEDURE IF EXISTS p_elimina_comentarios $$

CREATE PROCEDURE p_elimina_comentarios(IN p_id_album INT)
BEGIN
	
    DELETE FROM comentarios 
    WHERE id_foto IN 	(
						SELECT id_foto from fotografias 
                        WHERE id_album = p_id_album
						);
END $$
DELIMITER ;


-- procedimiento que muestra los registros a elminar si se utilizara el 
-- procedimiento p_elimina_comentarios, antes de proceder a su ejecucion
DELIMITER $$
DROP PROCEDURE IF EXISTS p_muestra_elimina_comentarios $$

CREATE PROCEDURE p_muestra_elimina_comentarios(IN p_id_album INT)
BEGIN
	
    SELECT * FROM comentarios 
    WHERE id_foto IN 	(
						SELECT id_foto from fotografias 
                        WHERE id_album = p_id_album
						);
END $$
DELIMITER ;


-- procedimiento para la creacion de un usuario nuevo con sus detalles
DELIMITER $$ 
DROP PROCEDURE IF EXISTS p_crear_usuario $$

CREATE PROCEDURE p_crear_usuario(
	IN x_email VARCHAR(80), 
	IN x_contraseña VARCHAR(50),
	IN x_nombreUsuario VARCHAR(30),
	IN x_id_tipoUsuario INT
    )
BEGIN
	INSERT INTO usuarios (email, contraseña, nombreUsuario, id_tipoUsuario)
    VALUES (x_email, x_contraseña, x_nombreUsuario, x_id_tipoUsuario);
END $$
DELIMITER ;


-- Procedimiento que rellena los valores de la columna 'totalU$D' de la trabla 'compra'.
-- Dicho campo almacena los importes totales de una orden de compra, se suman los importes de
-- cada elemento que conforma la órden de compra. 
-- Se hace uso de la función: f_total_orden_compra
DELIMITER $$
DROP PROCEDURE IF EXISTS p_rellena_importe_ordenes $$

CREATE PROCEDURE p_rellena_importe_ordenes()
BEGIN
	UPDATE compra
	SET totalU$D = f_total_orden_compra(compra.id_compra)
    WHERE totalU$D IS NULL;
END $$
DELIMITER ;


-- Procedimiento que genera tablas espejo, que provienen de las vistas ya creadas, para que funcionen en 
-- herramientas de BI y no afectar el funcionamiento de las tablas de producción
-- Estas tablas espejo se eliminan y se crean en cada llamado al procedimiento, y se guardarán con datos 
-- entre las fechas indicadas en parámetros, para poder restringir el volumen del análisis si la base de datos
-- cuenta con mucha info que no sea necesario analizar.
DELIMITER $$
DROP PROCEDURE IF EXISTS p_genera_tablas_analisis $$

CREATE PROCEDURE p_genera_tablas_analisis(IN fechaDesde DATE, IN fechaHasta DATE)
BEGIN
DROP TABLE IF EXISTS z_esp_album_compra_venta;
CREATE TABLE z_esp_album_compra_venta AS  SELECT * FROM v_fact_album_compra_venta WHERE fecha_Compra_Venta BETWEEN fechaDesde AND fechaHasta;
DROP TABLE IF EXISTS z_esp_fotos_comentadas;
CREATE TABLE z_esp_fotos_comentadas AS SELECT * FROM v_fact_fotos_comentadas WHERE fechaComentario BETWEEN fechaDesde AND fechaHasta;
DROP TABLE IF EXISTS z_esp_ordenes_compra;
CREATE TABLE z_esp_ordenes_compra AS SELECT * FROM v_fact_ordenes_compra WHERE fechaCompra BETWEEN fechaDesde AND fechaHasta; 
DROP TABLE IF EXISTS z_esp_ordenes_compra_detalles;
CREATE TABLE z_esp_ordenes_compra_detalles AS SELECT * FROM v_fact_ordenes_compra_detalles WHERE fechaCompra BETWEEN fechaDesde AND fechaHasta; 
DROP TABLE IF EXISTS z_esp_usuarios_detalle;
CREATE TABLE z_esp_usuarios_detalle AS SELECT * FROM v_fact_usuarios_detalle WHERE fechaCreacion BETWEEN fechaDesde AND fechaHasta;
END $$
DELIMITER ;





-- ------------------------------------------------------
-- CREACION DE TRIGGERS ---------------------------------
-- ------------------------------------------------------


-- Triggers de auditoria de la tabla 'usuarios', escribe información en la tabla 'usuarios_audit'

DELIMITER $$
DROP TRIGGER IF EXISTS t_audit_usuarios_insert  $$

CREATE TRIGGER t_audit_usuarios_insert AFTER INSERT ON usuarios FOR EACH ROW
BEGIN
	INSERT INTO usuarios_audit(tipo, fecha, id_usuario, email, contraseña, nombreUsuario, id_tipoUsuario)
    VALUES('INSERT_NEW', SYSDATE(), NEW.id_usuario, NEW.email, NEW.contraseña, NEW.nombreUsuario, NEW.id_tipoUsuario);
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS t_audit_usuarios_update  $$

CREATE TRIGGER t_audit_usuarios_update AFTER UPDATE ON usuarios FOR EACH ROW
BEGIN
	INSERT INTO usuarios_audit(tipo, fecha, id_usuario, email, contraseña, nombreUsuario, id_tipoUsuario)
    VALUES('UPDATE_OLD', SYSDATE(), OLD.id_usuario, OLD.email, OLD.contraseña, OLD.nombreUsuario, OLD.id_tipoUsuario);
    
    INSERT INTO usuarios_audit(tipo, fecha, id_usuario, email, contraseña, nombreUsuario, id_tipoUsuario)
    VALUES('UPDATE_NEW', SYSDATE(), NEW.id_usuario, NEW.email, NEW.contraseña, NEW.nombreUsuario, NEW.id_tipoUsuario);
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS t_audit_usuarios_delete  $$

CREATE TRIGGER t_audit_usuarios_delete AFTER DELETE ON usuarios FOR EACH ROW
BEGIN
	INSERT INTO usuarios_audit(tipo, fecha, id_usuario, email, contraseña, nombreUsuario, id_tipoUsuario)
    VALUES('DELETE_OLD', SYSDATE(), OLD.id_usuario, OLD.email, OLD.contraseña, OLD.nombreUsuario, OLD.id_tipoUsuario);
END $$
DELIMITER ;
