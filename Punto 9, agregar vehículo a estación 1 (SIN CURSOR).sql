delimiter $$
create procedure iniciarFabricacionDelVehiculo(OUT nResultado INT, OUT cMensaje VARCHAR(500), in nro_chasis_imput varchar(45)) -- en vehiculo x estacion   estacion 0 de en la linea de su modelo
	begin
        declare id_modeloAux INT DEFAULT 0;
        declare chasisOcupante varchar(45) default null;
		 select id_modelo from vehiculo where nro_chasis = nro_chasis_imput into id_modeloAux; 
         select vxe.id_vehiculo from  vehiculo_x_estacion vxe inner join vehiculo v on vxe.id_vehiculo=v.nro_chasis 
         inner join modelo m on m.codigo=v.id_modelo where vxe.id_estacion=1 and m.codigo=id_modeloAux 
         and vxe.fecha_hora_entrada is not null and vxe.fecha_hora_salida is null into chasisOcupante;
        if id_modeloAux>0 then
			if chasisOcupante is not null then
				select -1 INTO nResultado;	
				select CONCAT('La estacion esta ocupada por el vehículo ',chasisOcupante) INTO cMensaje;
			else
				update vehiculo_x_estacion set fecha_hora_entrada = current_time(), id_estacion = 1 
				where id_estacion = 0 and id_vehiculo = nro_chasis_imput;
				select 0 INTO nResultado;	
				select ' ' INTO cMensaje;
			end if;
        else
			select -1 INTO nResultado;	
			select CONCAT('El nro. de chasis ',nro_chasis_imput,' no está asignado a ningún vehículo') INTO cMensaje;
        end if;
	end $$
delimiter ;

-- ***** PRUEBAS *****
-- ***************************************************************************
set @cResultado =0;        
call iniciarFabricacionDelVehiculo(@cResultado,@cMensaje,'3EPDW57A2G2855233');
select @cResultado, @cMensaje;-- con los datos originalmente cargados  esto en cResultado "-1" y en cMensaje "La estacion esta ocupada por el vehiculo 3CGSG97W6G6262393" 

select * from vehiculo_x_estacion where id_estacion = 1 and id_vehiculo ='3CGSG97W6G6262393';-- este es el vehiculo que encuentra en la estación 1 de linea_de_montaje, que le corresponde por modelo, al vehículo '3EPDW57A2G2855233' que pasé como parametro en el "call iniciarFabricacionDelVehiculo(...);"
-- ***************************************************************************
-- para que anda el cResultado "0" ejecuto este código
 update vehiculo_x_estacion set fecha_hora_salida = current_time() 
 where id_estacion = 1 and id_vehiculo ='3CGSG97W6G6262393';
 
set @cResultado =0;        
call iniciarFabricacionDelVehiculo(@cResultado,@cMensaje,'3EPDW57A2G2855233');
select @cResultado, @cMensaje;-- ahora en cResultado "0" y en cMensaje ' '

 select * from vehiculo_x_estacion where id_estacion = 1 and id_vehiculo ='3EPDW57A2G2855233';-- El vehículo '3EPDW57A2G2855233' que pasé como parametro en el "call iniciarFabricacionDelVehiculo(...) con fecha_hora_entrada de momento del update y fecha_hora_salida en null
-- ***************************************************************************
-- para dejar todo en estado inicial (dos pasos)
-- 1) saco el vehículo (3EPDW57A2G2855233) que ingresé en la estación 1
 update vehiculo_x_estacion set fecha_hora_entrada = null, id_estacion=0
 where id_estacion = 1 and id_vehiculo ='3EPDW57A2G2855233';
-- 2) regreso el vehículo (3CGSG97W6G6262393) que saqué de la estación 1 
  update vehiculo_x_estacion set fecha_hora_salida = null 
 where id_estacion = 1 and id_vehiculo ='3CGSG97W6G6262393';
 -- ***************************************************************************
 -- si se ingresa un chasis que no fue asingado a ningún vehículo
 set @cResultado =0;        
call iniciarFabricacionDelVehiculo(@cResultado,@cMensaje,'x.x_x-x');
select @cResultado, @cMensaje;-- ahora en cResultado "-1" y en cMensaje "El nro. de chasis x.x_x-x no está asignado a ningún vehículo"