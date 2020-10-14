drop procedure if exists `automotriz`.`listarVehiculosConEstado`;

delimiter $$
CREATE procedure listarVehiculosConEstado(in nro_pedido_input int)
begin

	select vxe.id_vehiculo, 'Finalizado' as Estado, vxe.id_estacion  from vehiculo_x_estacion vxe
		inner join vehiculo v on vxe.id_vehiculo = v.nro_chasis
        inner join pedido p on v.id_pedido = p.nro_pedido
        where p.nro_pedido = nro_pedido_input and vxe.id_estacion = 5 and vxe.fecha_hora_salida is not null
        
	UNION
    
    select vxe.id_vehiculo, 'No finalizado' as Estado, vxe.id_estacion  from vehiculo_x_estacion vxe
		inner join vehiculo v on vxe.id_vehiculo = v.nro_chasis
        inner join pedido p on v.id_pedido = p.nro_pedido
        where p.nro_pedido = nro_pedido_input and vxe.id_estacion != 5 and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null;

END $$
delimiter ;


call listarVehiculosConEstado(2);