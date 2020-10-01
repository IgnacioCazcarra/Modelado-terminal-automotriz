drop procedure if exists `automotriz`.`verificarParaDarAltaConcesionaria`;
drop procedure if exists `automotriz`.`altaConcesionaria`;
drop procedure if exists `automotriz`.`modificacionConcesionaria`;
drop procedure if exists `automotriz`.`bajaConcesionaria`;

delimiter $$
CREATE procedure verificarParaDarAltaConcesionaria(OUT existCodigo int, OUT existRazonSocial int, OUT ambosJuntos int, in codigo_input int, in razon_social_input varchar(45))
begin    
	set existCodigo=0;   set existRazonSocial=0;  set ambosJuntos = 0;
	if exists (select * from concesionaria where codigo = codigo_input and razon_social = razon_social_input) then
       set ambosJuntos = 1;
	else
		if exists (select * from concesionaria where codigo = codigo_input) then
		  set existCodigo = 1;
		end if;
		if exists (select * from concesionaria where razon_social = razon_social_input) then
		  set existRazonSocial = 1;
		end if;
		
	end if;
END $$
delimiter ;


delimiter $$
CREATE procedure altaConcesionaria(in codigo_input int, in razon_social_input varchar(45), in reporte_de_ventas_input int)
begin   
    declare existCodigo int; declare existRazonSocial int; declare ambosJuntos int;
    call verificarParaDarAltaConcesionaria(existCodigo, existRazonSocial, ambosJuntos, codigo_input, razon_social_input);
	if ambosJuntos = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_input,' y razon social: ',razon_social_input) as causa_del_ERROR, 'Están en el mismo registro' as detalle;
    elseif (existRazonSocial = 1 and existCodigo = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',codigo_input,' y razon social: ',razon_social_input) as causa_del_ERROR, 'Están en registros separados' as detalle;
	elseif existCodigo = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con código: ',codigo_input) as causa_del_ERROR;
	elseif existRazonSocial = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con razon social: ',codigo_input) as causa_del_ERROR;
    else
		insert into concesionaria (codigo, razon_social, reporte_de_ventas, dado_de_alta) values(codigo_input, razon_social_input, reporte_de_ventas_input,true);
        select 'Se agregó correctamente' as mensaje;
	end if;
END $$
delimiter ;


delimiter $$
CREATE procedure modificacionConcesionaria(in codigo_input int, in razon_social_input varchar(45), in reporte_de_ventas_input int)
begin    
    if exists (select * from concesionaria where codigo = codigo_input) then
       update concesionaria set razon_social = razon_social_input, reporte_de_ventas = reporte_de_ventas_input where codigo = codigo_input;
       select 'Modificado correctamente'  as mensaje;
	else
       select 'No se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el código ', codigo_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;


delimiter $$
CREATE procedure bajaConcesionaria(in codigo_input int)
begin    
    if exists (select * from concesionaria where codigo = codigo_input) then
		update concesionaria set dado_de_alta=false where codigo = codigo_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar la concesionaria ' as mensaje_de_ERROR, CONCAT('NO existe una concesionaria con el código ', codigo_input) as causa_del_ERROR; 
    end if;
end $$


delimiter ;

call altaConcesionaria(5,'Concesionaria de prueba',120);
call modificacionConcesionaria(5,'Probando modificacion', 120);
call bajaConcesionaria(5);

 select * from concesionaria;