drop procedure if exists `automotriz`.`verificarOcupacionEnEstacion`;
drop procedure if exists `automotriz`.`pasarASiguienteEstacion`;

delimiter $$
CREATE procedure verificarOcupacionEnEstacion(OUT id_modeloAux int, OUT chasisOcupante varchar(45), in nro_chasis_input varchar(45), in nro_estacion_input varchar(45))
begin   
		set id_modeloAux = 0;    set chasisOcupante = null;
		select id_modelo from vehiculo where nro_chasis = nro_chasis_input into id_modeloAux; 
		
        if exists (select vxe.id_vehiculo from  vehiculo_x_estacion vxe inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
		inner join modelo m on m.codigo=v.id_modelo where vxe.id_estacion=nro_estacion_input and m.codigo=id_modeloAux 
		and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null)  then -- si existe
			
            select vxe.id_vehiculo from vehiculo_x_estacion vxe inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
			inner join modelo m on m.codigo=v.id_modelo where vxe.id_estacion=nro_chasis_input and m.codigo=id_modeloAux 
			and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null into chasisOcupante; -- si existe, recién guardo el contenido (es para que no me cambie el null por vacio cuando no encontraba y al preguntar si era null daba falso pero porque está vacio)
		
        end if;
END $$
delimiter ;

delimiter $$
create procedure pasarASiguienteEstacion(OUT nResultado INT, OUT cMensaje VARCHAR(500), in nro_chasis_input varchar(45)) 
	begin
        
        declare id_modeloAux INT DEFAULT 0;
        declare chasisOcupante varchar(45) default null;
        declare nro_estacion_input INT DEFAULT 6; -- si con el select de debajo no cambia, significa que el nro de chasis corresponde a un vehiculo que ya salio de la ultima estacion
		
        select vxe.id_estacion from vehiculo_x_estacion vxe -- retorna mas de uno
			inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
			where vxe.id_vehiculo = nro_chasis_input and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null
			into nro_estacion_input;
        
        call verificarOcupacionEnEstacion(id_modeloAux, chasisOcupante, nro_chasis_input, nro_estacion_input+1);-- le sumas 1 a la estacion para chequear si hay un automovil en la siguiente estacion
        
        if(nro_estacion_input < 5) then -- si esta en una estacion que no es la ultima, le sumamos uno para chequear despues que no haya un auto del mismo modelo en esa.
				
			if id_modeloAux>0 then
				if chasisOcupante is not null then
					select -1 INTO nResultado;	
					select CONCAT('La estacion esta ocupada por el vehículo ', chasisOcupante) INTO cMensaje;
				else
					update vehiculo_x_estacion set fecha_hora_salida = current_time() where id_vehiculo = nro_chasis_input and id_estacion = nro_estacion_input;
					update vehiculo_x_estacion set fecha_hora_entrada = current_time() where id_vehiculo = nro_chasis_input and id_estacion = (nro_estacion_input+1); -- and id_estacion = nro_estacion_input;
					
                    select 0 INTO nResultado;	
					select ' ' INTO cMensaje;
				end if;
			else
				select -1 INTO nResultado;	
				select CONCAT('El nro. de chasis ',nro_chasis_input,' no está asignado a ningún vehículo') INTO cMensaje;
			
            end if;
		elseif(nro_estacion_input = 5) then -- si esta en la ultima estacion, lo hacemos salir (le asignamos fecha de salida).
			update vehiculo_x_estacion set fecha_hora_salida = current_time() where id_estacion = nro_estacion_input and id_vehiculo = nro_chasis_input; 
            select 0 into nResultado;
            select ' ' INTO cMensaje;
         else
			select -1 into nResultado;
            select CONCAT('El nro de chasis ',nro_chasis_input,' corresponde a un vehiculo que ya salio de la ultima estacion.') INTO cMensaje;
        end if;
            
            
	end $$
delimiter ;




-- ***** PRUEBAS *****

-- ***************************************************************************
set @cResultado = 0;        
set @cMensaje = ' ';
call pasarASiguienteEstacion(@cResultado,@cMensaje,'4CPDW57A2G2855244');
select @cResultado, @cMensaje; 
-- update vehiculo_x_estacion set fecha_hora_salida = null, fecha_hora_entrada = null where id_vehiculo = '4CPDW57A2G2855244' and id_estacion > 2;
-- select * from vehiculo_x_estacion where id_vehiculo = '4CPDW57A2G2855244' ;
