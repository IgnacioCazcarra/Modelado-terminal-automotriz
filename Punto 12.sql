drop procedure if exists `automotriz`.`listarCantidadInsumosPorPedido`;

delimiter $$
CREATE procedure listarCantidadInsumosPorPedido(in nro_pedido_input int)
begin

	select id_pedido, id_modelo, mxp.cantidad, m.nombre as modelo, lm.codigo as linea_montaje, e.nombre, ixe.id_insumo, ixe.cantidad_insumo, (ixe.cantidad_insumo * mxp.cantidad) as cant_insumos_total  from modelo_x_pedido mxp
	inner join modelo m on mxp.id_pedido = m.codigo
	inner join linea_de_montaje lm on m.codigo = lm.id_modelo_prod
	inner join estaciones_x_linea exl on lm.codigo = exl.id_linea_de_montaje
	inner join estacion e on e.codigo = exl.id_estacion
	inner join insumo_x_estacion ixe on ixe.id_estacion = e.codigo
	where mxp.id_pedido = nro_pedido_input;

END $$
delimiter ;

call listarCantidadInsumosPorPedido(1);

select * from vehiculo_x_estacion vxe where vxe.id_estacion = 5;

select * from linea_de_montaje;