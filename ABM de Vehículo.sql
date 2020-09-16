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
CREATE procedure altaVehiculo(in nro_chasis_input varchar(45), in id_modelo_input int)
begin   
    declare existNro_chasis int;
    call verificarParaDarAltaVehiculo(existNro_chasis, nro_chasis_input);
	if (existNro_chasis = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe numero de chasis: ', nro_chasis_input) as causa_del_ERROR;
    else
		insert into vehiculo (nro_chasis, id_modelo, dado_de_alta) values(nro_chasis_input, id_modelo_input, true);
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
		SET SQL_SAFE_UPDATES = 0;
		delete from vehiculo where nro_chasis = nro_chasis_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el registro ' as mensaje_de_ERROR, CONCAT('NO existe uno con el chasis ', nro_chasis_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaVehiculo("1ANCS13Z6M0246591",8); -- pedido 1 (con modelo cargado)
call modificacionVehiculo("1ANCS13Z6M0246591",'8');
call bajaVehiculo("1ANCS13Z6M0246591");

select * from vehiculo;

call altaVehiculo("1ANCS13Z6M0246591",8);


-- (FALTA AGREGAR PARA CADA UN EL NUMERO DE PEDIDO)
-- (UNA VEZ QUE SE AGREGUEN LOS RESPECTIVOS MODELOS, SE PUEDE DESCOMENTAR EL SIGUIENTE CÓDIGO)
-- pedido 1
-- call altaVehiculo("2APDW57A2G2855222",1);
-- call altaVehiculo("3AGSG97W6G6262333",1);
-- call altaVehiculo("1BSHC52U9L2354111",2);
-- call altaVehiculo("2BPDW57A2G2855222",2);
-- call altaVehiculo("3BSHC52U9L2354323",2);
-- call altaVehiculo("4BUCS13G6M0246244",2);
-- call altaVehiculo("5BSHC52U9L2354525",2);

-- pedido 2
-- call altaVehiculo("1CECS13G6M0246551",1);
-- call altaVehiculo("2CPDW57A2G2855242",1);
-- call altaVehiculo("3CGSG97W6G6262393",1);
-- call altaVehiculo("4CPDW57A2G2855244",1);
-- call altaVehiculo("1DHJF13G6M0241111",2);
-- call altaVehiculo("2DKDS57A2G2852222",2);
-- call altaVehiculo("3DRUP97W6G6263333",2);
-- call altaVehiculo("4DLHA57A2G2854444",2);
-- call altaVehiculo("5DTDK13G6M0245555",2);
-- call altaVehiculo("6DMDR57A2G2855466",2);

-- pedido 3
-- call altaVehiculo("1EECS13G6M0246111",1);
-- call altaVehiculo("2EECS13G6M0246222",1);
-- call altaVehiculo("3EPDW57A2G2855233",1);
-- call altaVehiculo("4EGSG97W6G6262444",1);
-- call altaVehiculo("5EPDW57A2G2855555",1);
-- call altaVehiculo("1FHJF13G6M0244511",2);
-- call altaVehiculo("2FKDS57A2G2855622",2);
-- call altaVehiculo("3FRUP97W6G6267833",2);
-- call altaVehiculo("4FLHA57A2G2858944",2);

