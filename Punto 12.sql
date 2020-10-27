drop procedure if exists `automotriz`.`listarCantidadInsumosPorPedido`;

delimiter $$
CREATE procedure listarCantidadInsumosPorPedido(in nro_pedido_input int)
begin

	select ixe.id_insumo, sum(ixe.cantidad_insumo) * sum(mxp.cantidad)  as cantidad_total from modelo_x_pedido mxp
	inner join modelo m on mxp.id_pedido = m.codigo
	inner join linea_de_montaje lm on m.codigo = lm.id_modelo_prod
	inner join estaciones_x_linea exl on lm.codigo = exl.id_linea_de_montaje
	inner join estacion e on e.codigo = exl.id_estacion
	inner join insumo_x_estacion ixe on ixe.id_estacion = e.codigo
	where mxp.id_pedido = nro_pedido_input
    group by ixe.id_insumo;

END $$

delimiter ;

call listarCantidadInsumosPorPedido(1);

select * from vehiculo_x_estacion vxe where vxe.id_estacion = 5;

select * from linea_de_montaje;