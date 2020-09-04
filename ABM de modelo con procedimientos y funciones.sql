drop procedure if exists `automotriz`.`verificarParaDarAltaModelo`;
drop procedure if exists `automotriz`.`altaModelo`;
drop procedure if exists `automotriz`.`modificacionModelo`;
drop procedure if exists `automotriz`.`bajaModelo`;

delimiter $$
CREATE procedure verificarParaDarAltaModelo(OUT existCodigo int, OUT existNombre int, OUT ambosJuntos int,in codigo_imput int, in nombre_imput varchar(45))
begin    
	set existCodigo=0;   set existNombre=0;  set ambosJuntos = 0;
	if exists (select * from modelo where codigo = codigo_imput and nombre = nombre_imput) then
       set ambosJuntos = 1;
	else
		if exists (select * from modelo where codigo = codigo_imput) then
		  set existCodigo = 1;
		end if;
		if exists (select * from modelo where nombre = nombre_imput) then
		  set existNombre = 1;
		end if;
		
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaModelo(in codigo_imput int, in nombre_imput varchar(45))
begin   
    declare existCodigo int; declare existNombre int; declare ambosJuntos int;
    call verificarParaDarAltaModelo(existCodigo,existNombre,ambosJuntos, codigo_imput, nombre_imput);
	if ambosJuntos = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_imput,' y nombre: ',nombre_imput) as causa_del_ERROR, 'Están en el mismo registro' as detalle;
    elseif (existNombre = 1 and existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_imput,' y nombre: ',nombre_imput) as causa_del_ERROR, 'Están en registros separados' as detalle;
	elseif existCodigo = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con código: ',codigo_imput) as causa_del_ERROR;
	elseif existNombre = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con nombre: ',nombre_imput) as causa_del_ERROR;
    else
		insert into modelo (codigo, nombre) values(codigo_imput, nombre_imput);
        select 'Se agregó correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionModelo(in codigo_imput int, in nombre_imput varchar(45))
begin    
    if exists (select * from modelo where codigo = codigo_imput) then
       update modelo set nombre= nombre_imput where codigo=codigo_imput;
       select 'Modificado correctamente'  as mensaje;
	else
       select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el código ', codigo_imput) as causa_del_ERROR;
    end if;
end $$
delimiter ;-- si hubiese más campos que modifica, solo es pone coma (,) despues de "nombre= nonbre_imput" y agregarlo

delimiter $$
CREATE procedure bajaModelo(in codigo_imput int)
begin    
    if exists (select * from modelo where codigo = codigo_imput) then
		SET SQL_SAFE_UPDATES = 0;
		delete from modelo where codigo = codigo_imput;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el registro ' as mensaje_de_ERROR, CONCAT('NO existe uno con el código ', codigo_imput) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaModelo(8,'6067');
call modificacionModelo(8,'600');
call bajaModelo(8);

 select * from modelo;
 
