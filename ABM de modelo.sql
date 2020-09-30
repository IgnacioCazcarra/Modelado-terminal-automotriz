drop procedure if exists `automotriz`.`verificarParaDarAltaModelo`;
drop procedure if exists `automotriz`.`altaModelo`;
drop procedure if exists `automotriz`.`modificacionModelo`;
drop procedure if exists `automotriz`.`bajaModelo`;

delimiter $$
CREATE procedure verificarParaDarAltaModelo(OUT existCodigo int, OUT existNombre int, OUT ambosJuntos int,in codigo_input int, in nombre_input varchar(45))
begin    
	set existCodigo=0;   set existNombre=0;  set ambosJuntos = 0;
	if exists (select * from modelo where codigo = codigo_input and nombre = nombre_input) then
       set ambosJuntos = 1;
	else
		if exists (select * from modelo where codigo = codigo_input) then
		  set existCodigo = 1;
		end if;
		if exists (select * from modelo where nombre = nombre_input) then
		  set existNombre = 1;
		end if;
		
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaModelo(in codigo_input int, in nombre_input varchar(45))
begin   
    declare existCodigo int; declare existNombre int; declare ambosJuntos int;
    call verificarParaDarAltaModelo(existCodigo,existNombre,ambosJuntos, codigo_input, nombre_input);
	if ambosJuntos = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_input,' y nombre: ',nombre_input) as causa_del_ERROR, 'Están en el mismo registro' as detalle;
    elseif (existNombre = 1 and existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_input,' y nombre: ',nombre_input) as causa_del_ERROR, 'Están en registros separados' as detalle;
	elseif existCodigo = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con código: ',codigo_input) as causa_del_ERROR;
	elseif existNombre = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con nombre: ',nombre_input) as causa_del_ERROR;
    else
		insert into modelo (codigo, nombre,dado_de_alta) values(codigo_input, nombre_input,true);
        select 'Se agregó correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionModelo(in codigo_input int, in nombre_input varchar(45))
begin    
    if exists (select * from modelo where codigo = codigo_input) then
       update modelo set nombre= nombre_input where codigo=codigo_input;
       select 'Modificado correctamente'  as mensaje;
	else
       select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el código ', codigo_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;-- si hubiese más campos que modifica, solo es pone coma (,) despues de "nombre= nonbre_input" y agregarlo

delimiter $$
CREATE procedure bajaModelo(in codigo_input int)
begin    
    if exists (select * from modelo where codigo = codigo_input) then
		if exists (select * from modelo where codigo = codigo_input and dado_de_alta = false) then
			select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('Está dado de baja el modelo con id: ', codigo_input) as causa_del_ERROR;
		else
		    update modelo set   dado_de_alta = false     where codigo = codigo_input;
			select 'Dado de baja correctamente'  as mensaje;
		end if;
	else
		select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('NO existe el modelo con id: ', codigo_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaModelo(8,'6067');
call modificacionModelo(8,'600');
call bajaModelo(8);

 select * from modelo;
 
