drop procedure if exists `automotriz`.`verificarParaDarAltaEstacion`;
drop procedure if exists `automotriz`.`altaEstacion`;
drop procedure if exists `automotriz`.`modificacionEstacion`;
drop procedure if exists `automotriz`.`bajaEstacion`;
use automotriz;


delimiter $$
CREATE procedure verificarParaDarAltaEstacion(OUT existCodigo int, in codigo_input int)
begin    
	set existCodigo=0;
	if exists (select * from estacion where codigo = codigo_input) then
		set existCodigo = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaEstacion(in codigo_input int, in nombre_input varchar(45), in orden_input int)
begin   
    declare existCodigo int;
    call verificarParaDarAltaEstacion(existCodigo, codigo_input);
	if (existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe una estacion con ese codigo: ', codigo_input) as causa_del_ERROR;
    else
		insert into estacion (codigo, nombre,orden, dado_de_alta) values(codigo_input, nombre_input, orden_input, true);
        select 'Estacion agregada correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionEstacion(in codigo_input int, in nombre_input varchar(45), in orden_input int)
begin    
    if exists (select * from estacion where codigo = codigo_input) then
       update estacion set codigo = codigo_input, nombre = nombre_input, orden = orden_input where codigo = codigo_input;
       select 'Estacion modificada correctamente'  as mensaje;
	else
       select 'No se puede modificar la estacion' as mensaje_de_ERROR, CONCAT('No existe una estacion con ese codigo ', codigo_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE procedure bajaEstacion(in codigo_input INT)
begin    
    if exists (select * from estacion where codigo = codigo_input) then
		update estacion set dado_de_alta=false where codigo = codigo_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar la estacion ' as mensaje_de_ERROR, CONCAT('NO existe una estacion con ese codigo ', codigo_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaEstacion(0, "A fabricar", 0);
call altaEstacion(1, "Chasis", 1);
call altaEstacion(2, "Pintura", 2);
call altaEstacion(3, "Tren delantero y trasero", 3);
call altaEstacion(4, "Electricidad", 4);
call altaEstacion(5, "Motorización y banco de prueba", 5);