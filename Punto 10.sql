drop procedure if exists `automotriz`.`verificarOcupacionEnEstacion`;
drop procedure if exists `automotriz`.`pasarASiguienteEstacion`;

delimiter $$
CREATE procedure verificarOcupacionEnEstacion(OUT id_modeloAux int, OUT chasisOcupante varchar(45), in nro_chasis_input varchar(45), in id_estacion_input varchar(45))
begin   
		set id_modeloAux = 0;    set chasisOcupante = null;
		select id_modelo from vehiculo where nro_chasis = nro_chasis_input into id_modeloAux; 
		
        if exists (select vxe.id_vehiculo from  vehiculo_x_estacion vxe inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
		inner join modelo m on m.codigo=v.id_modelo where vxe.id_estacion=id_estacion_input and m.codigo=id_modeloAux 
		and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null)  then -- si existe
			
            select vxe.id_vehiculo from vehiculo_x_estacion vxe inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
			inner join modelo m on m.codigo=v.id_modelo where vxe.id_estacion=id_estacion_input and m.codigo=id_modeloAux 
			and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null into chasisOcupante; -- si existe, recién guardo el contenido (es para que no me cambie el null por vacio cuando no encontraba y al preguntar si era null daba falso pero porque está vacio)
		
        end if;
END $$
delimiter ;

delimiter $$
create procedure pasarASiguienteEstacion(OUT nResultado INT, OUT cMensaje VARCHAR(500), in nro_chasis_input varchar(45)) 
	begin
        
        declare id_modeloAux INT DEFAULT 0;
        declare chasisOcupante varchar(45) default null;
        declare id_estacion_input INT DEFAULT 6; -- si con el select de debajo no cambia el 6, significa que el nro de chasis corresponde a un vehiculo que ya salio de la ultima estacion

        select vxe.id_estacion from vehiculo_x_estacion vxe
			inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
			where vxe.id_vehiculo = nro_chasis_input and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null
			into id_estacion_input;
        
        call verificarOcupacionEnEstacion(id_modeloAux, chasisOcupante, nro_chasis_input, id_estacion_input+1);-- le sumas 1 a la estacion para chequear si hay un automovil en la siguiente estacion
        
		if id_modeloAux>0 then
			if chasisOcupante is not null then
				select -1 INTO nResultado;	
				select CONCAT('La estacion esta ocupada por el vehículo ', chasisOcupante) INTO cMensaje;
			else
				if(id_estacion_input = 0) then
					select -1 INTO nResultado;	
					select CONCAT('El nro. de chasis ',nro_chasis_input,' corresponde a un vehiculo que no está en ninguna estacion.') INTO cMensaje;
				
                elseif(id_estacion_input < 5 and id_estacion_input != 0 ) then 
					update vehiculo_x_estacion set fecha_hora_salida = current_time() where id_estacion = id_estacion_input and id_vehiculo = nro_chasis_input;
					call agregarVehiculoAEstacion(nro_chasis_input, id_estacion_input+1, current_time());
					select 0 INTO nResultado;	
					select ' ' INTO cMensaje;
                    
				elseif(id_estacion_input = 5) then -- si esta en la ultima estacion, lo hacemos salir (le asignamos fecha de salida).
					update vehiculo_x_estacion set fecha_hora_salida = current_time() where id_estacion = id_estacion_input and id_vehiculo = nro_chasis_input;
					select 0 INTO nResultado;
					select ' ' INTO cMensaje;
                    
				 else
					select -1 into nResultado;
					select CONCAT('El nro de chasis ',nro_chasis_input,' corresponde a un vehiculo que ya salio de la ultima estacion.') INTO cMensaje;
				end if;
			end if;
		else
			select -1 INTO nResultado;	
			select CONCAT('El nro. de chasis ',nro_chasis_input,' no está asignado a ningún vehículo') INTO cMensaje;
        end if;
            
	end $$
delimiter ;




-- ***** PRUEBAS *****

-- ***************************************************************************
set @cResultado = 0;        
set @cMensaje = ' ';
call pasarASiguienteEstacion(@cResultado,@cMensaje,' ');
select @cResultado, @cMensaje; 
