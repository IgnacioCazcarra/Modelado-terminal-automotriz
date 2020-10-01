drop procedure if exists `automotriz`.`verificarParaDarAltaVehiculo`;
drop procedure if exists `automotriz`.`altaVehiculo`;
drop procedure if exists `automotriz`.`modificacionVehiculo`;
drop procedure if exists `automotriz`.`bajaVehiculo`;
use automotriz;
delimiter $$
CREATE procedure verificarParaDarAltaVehiculo(OUT existNro_chasis int, in nro_chasis_input varchar(45))
begin    
	set existNro_chasis=0;
	if exists (select * from vehiculo where nro_chasis = nro_chasis_input) then
		set existNro_chasis = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaVehiculo(in nro_chasis_input varchar(45), in id_modelo_input int,in id_pedido_input int)
begin   
    declare existNro_chasis int;
    call verificarParaDarAltaVehiculo(existNro_chasis, nro_chasis_input);
	if (existNro_chasis = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe numero de chasis: ', nro_chasis_input) as causa_del_ERROR;
    else
		insert into vehiculo (nro_chasis, id_modelo,id_pedido, dado_de_alta) values(nro_chasis_input, id_modelo_input, id_pedido_input, true);
        select 'Vehiculo agregado correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionVehiculo(in nro_chasis_input varchar(45), in id_modelo_input int)
begin    
    if exists (select * from vehiculo where nro_chasis = nro_chasis_input) then
       update vehiculo set nro_chasis = nro_chasis_input, id_modelo = id_modelo_input where nro_chasis = nro_chasis_input;
       select 'Vehiculo modificado correctamente'  as mensaje;
	else
       select 'No se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el chasis ', nro_chasis_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;


delimiter $$
CREATE procedure bajaVehiculo(in nro_chasis_input varchar(45))
begin    
    if exists (select * from vehiculo where nro_chasis = nro_chasis_input) then
		update vehiculo set dado_de_alta=false where nro_chasis = nro_chasis_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el vehiculo ' as mensaje_de_ERROR, CONCAT('NO existe un vehiculo con el numero de chasis ', nro_chasis_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaVehiculo("1ANCS13Z6M0246591",8,1); -- pedido 1 (con modelo cargado)
call modificacionVehiculo("1ANCS13Z6M0246591",'8');
call bajaVehiculo("1ANCS13Z6M0246591");

select * from vehiculo;

call altaVehiculo("1ANCS13Z6M0246591",8,2);

