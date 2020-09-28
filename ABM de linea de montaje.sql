drop procedure if exists `automotriz`.`verificarParaDarAltaLineaDeMontaje`;
drop procedure if exists `automotriz`.`altaLineaDeMontaje`;
drop procedure if exists `automotriz`.`modificacionLineaDeMontaje`;
drop procedure if exists `automotriz`.`bajaLineaDeMontaje`;
use automotriz;


delimiter $$
CREATE procedure verificarParaDarAltaLineaDeMontaje(OUT existCodigo int, in codigo_input int)
begin    
	set existCodigo=0;
	if exists (select * from linea_de_montaje where codigo = codigo_input) then
		set existCodigo = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaLineaDeMontaje(in codigo_input int, in id_modelo_prod_input int, in produccion_promedio_mensual_input int)
begin   
    declare existCodigo int;
    call verificarParaDarAltaLineaDeMontaje(existCodigo, codigo_input);
	if (existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe una linea de montaje con ese codigo: ', codigo_input) as causa_del_ERROR;
    else
		insert into linea_de_montaje (codigo, id_modelo_prod, produccion_promedio_mensual, dado_de_alta) values(codigo_input, id_modelo_prod_input, produccion_promedio_mensual_input, true);
        select 'Linea de montaje agregada correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionLineaDeMontaje(in codigo_input int, in id_modelo_prod_input int, in produccion_promedio_mensual_input int)
begin    
    if exists (select * from linea_de_montaje where codigo = codigo_input) then
       update linea_de_montaje set codigo = codigo_input, id_modelo_prod = id_modelo_prod_input, produccion_promedio_mensual = produccion_promedio_mensual_input where codigo = codigo_input;
       select 'Linea de montaje modificada correctamente'  as mensaje;
	else
       select 'No se puede modificar la linea de montaje' as mensaje_de_ERROR, CONCAT('No existe una estacion con ese codigo ', codigo_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE procedure bajaLineaDeMontaje(in codigo_input INT)
begin    
    if exists (select * from linea_de_montaje where codigo = codigo_input) then
		update linea_de_montaje set dado_de_alta=false where codigo = codigo_input;
        select 'Eliminada correctamente'  as mensaje;
	else
		select 'NO se puede eliminar la linea de montaje ' as mensaje_de_ERROR, CONCAT('NO existe una linea de montaje con ese codigo ', codigo_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaLineaDeMontaje(5, 1, 4);
call altaLineaDeMontaje(3, 2, 5);
call altaLineaDeMontaje(4, 1, 7);
call modificacionLineaDeMontaje(3, 1, 100);
call bajaLineaDeMontaje(5);

select * from linea_de_montaje;