drop procedure if exists `automotriz`.`promedioConstruccionVehiculosXLinea`;
drop function if exists `automotriz`.`verificarSiEstaTerminadoElVehiculo`;

delimiter $$
CREATE procedure promedioConstruccionVehiculosXLinea(in id_linea_de_montaje_input int)
begin
	
    -- Trae la el tiempo promedio en minutos por estacion por vehiculo que ya salio de la estacion 5 (esta finalizado su construcción) por linea de montaje
	
    select avg(timestampdiff(MINUTE,vxe.fecha_hora_entrada,fecha_hora_salida)) as `promedio_construccion_vehiculos(minutos)` from estaciones_x_linea exl 
	inner join estacion on estacion.codigo = exl.id_estacion
	inner join vehiculo_x_estacion vxe on vxe.id_estacion = estacion.codigo
	where exl.id_linea_de_montaje = id_linea_de_montaje_input and verificarSiEstaTerminadoElVehiculo(vxe.id_vehiculo) = true order by vxe.id_vehiculo,vxe.id_estacion; 
	
    -- Traer el tiempo promedio en minutos agrupado estacion de trabajo de una linea de montaje
    
    /*select avg(timestampdiff(MINUTE,vxe.fecha_hora_entrada,fecha_hora_salida)) as minutos, vxe.id_estacion, vxe.id_vehiculo from estaciones_x_linea exl 
	inner join estacion on estacion.codigo = exl.id_estacion
	inner join vehiculo_x_estacion vxe on vxe.id_estacion = estacion.codigo
	where exl.id_linea_de_montaje = id_linea_de_montaje_input and verificarSiEstaTerminadoElVehiculo(vxe.id_vehiculo) = true group by vxe.id_estacion order by vxe.id_vehiculo,vxe.id_estacion; 
    */
END $$
delimiter ;

delimiter $$
CREATE function verificarSiEstaTerminadoElVehiculo(id_vehiculo_input varchar(45))
returns bool
DETERMINISTIC
begin
	declare finalizado bool;
    
    if exists(select vxe.fecha_hora_salida from vehiculo_x_estacion vxe where vxe.id_vehiculo = id_vehiculo_input and vxe.fecha_hora_salida is not null and vxe.id_estacion = 5) then
		set finalizado = true;
	else
		set finalizado = false;
    end if;
    
    return finalizado;
END $$
delimiter ;

call promedioConstruccionVehiculosXLinea(2);

