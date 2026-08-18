USE fotografia;

-- Tablas
SELECT * FROM pais;
SELECT * FROM ciudad;
SELECT * FROM tipousuario;
SELECT * FROM usuarios;
SELECT * FROM infousuarios;

SELECT * FROM tipocontenido;
SELECT * FROM albumes;
SELECT * FROM fotografias;
SELECT * FROM precioalbum;
SELECT * FROM comentarios;

SELECT * FROM compra;
SELECT * FROM itemscompra;

SELECT * FROM marcatarjeta;
SELECT * FROM estadopago;
SELECT * FROM tarjetas;
SELECT * FROM pagos;

-- Vistas
SELECT * FROM v_fact_fotos_comentadas;
SELECT * FROM v_fact_ordenes_compra; 
SELECT * FROM v_fact_ordenes_compra_detalles; 
SELECT * FROM v_fact_pagos_no_procesados;
SELECT * FROM v_tarjetas;
SELECT * FROM v_fact_usuarios_detalle;
SELECT * FROM v_fact_album_compra_venta; 

-- Funciones
SELECT f_max_comentarios_foto();
SELECT f_max_comentarios_usuario();
SELECT f_precio_album(1); 
SELECT f_total_orden_compra(1); 
SELECT f_cant_vendidos_album(114);
SELECT f_getUser_nombre(1);

-- Procedimientos
CALL p_crear_usuario('email.test@gamail.com', 'sdfj#"9sdd#d_xx', 'userOOO', '3');
CALL p_muestra_elimina_comentarios(151);
CALL p_elimina_comentarios(151);
CALL p_rellena_importe_ordenes();
CALL p_genera_tablas_analisis('2023-01-01', '2024-05-31');

-- Tabla auditoría Usuarios
SELECT * FROM usuarios_audit;

-- Tablas espejo para BI
SELECT * FROM z_esp_album_compra_venta;
SELECT * FROM z_esp_fotos_comentadas;
SELECT * FROM z_esp_ordenes_compra;
SELECT * FROM z_esp_ordenes_compra_detalles;
SELECT * FROM z_esp_usuarios_detalle;


