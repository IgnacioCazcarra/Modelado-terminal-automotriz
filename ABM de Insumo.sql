drop procedure if exists `automotriz`.`verificarParaDarAltaInsumo`;
drop procedure if exists `automotriz`.`altaInsumo`;
drop procedure if exists `automotriz`.`modificacionInsumo`;
drop procedure if exists `automotriz`.`bajaInsumo`;
use automotriz;


delimiter $$
CREATE procedure verificarParaDarAltaInsumo(OUT existCodigo int, in codigo_input int)
begin    
	set existCodigo=0;
	if exists (select * from insumo where codigo = codigo_input) then
		set existCodigo = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaInsumo(in codigo_input int, in nombre_input varchar(45))
begin   
    declare existCodigo int;
    call verificarParaDarAltaInsumo(existCodigo, codigo_input);
	if (existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe un insumo con ese codigo: ', codigo_input) as causa_del_ERROR;
    else
		insert into insumo (codigo, nombre,dado_de_alta) values(codigo_input, nombre_input, true);
        select 'Insumo agregado correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionInsumo(in codigo_input int, in nombre_input varchar(45))
begin    
    if exists (select * from insumo where codigo = codigo_input) then
       update insumo set codigo = codigo_input, nombre = nombre_input where codigo = codigo_input;
       select 'Insumo modificado correctamente'  as mensaje;
	else
       select 'No se puede modificar el insumo' as mensaje_de_ERROR, CONCAT('No existe un insumo con ese codigo ', codigo_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE procedure bajaInsumo(in codigo_input INT)
begin    
    if exists (select * from insumo where codigo = codigo_input) then
		update insumo set dado_de_alta=false where codigo = codigo_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el insumo ' as mensaje_de_ERROR, CONCAT('NO existe un insumo con ese codigo ', codigo_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;


call altaInsumo(1, "Capot");
call altaInsumo(2, "Optica");
call altaInsumo(3, "Puerta");
call altaInsumo(4, "Ventanilla");
call altaInsumo(5, "Pintura");
call altaInsumo(6, "Masilla");
call altaInsumo(7, "Lija");
call altaInsumo(8, "Diluyente");
call altaInsumo(9, "Llanta");
call altaInsumo(10, "Cubierta");
call altaInsumo(11, "Suspensión");
call altaInsumo(12, "Transmisión");
call altaInsumo(13, "Cableado");
call altaInsumo(14, "Encendido");
call altaInsumo(15, "Batería");
call altaInsumo(16, "Motor");
call altaInsumo(17, "Escape");
call altaInsumo(18, "Burro de arranque");