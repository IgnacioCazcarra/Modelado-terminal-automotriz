drop procedure if exists `automotriz`.`verificarParaDarAltaProveedor`;
drop procedure if exists `automotriz`.`altaProveedor`;
drop procedure if exists `automotriz`.`modificacionProveedor`;
drop procedure if exists `automotriz`.`bajaProveedor`;

delimiter $$
CREATE procedure verificarParaDarAltaProveedor(OUT existCuit int, OUT existRazonSocial int, OUT ambosJuntos int, in cuit_input varchar(45), in razon_social_input varchar(100))
begin    
	set existCuit=0;   set existRazonSocial=0;  set ambosJuntos = 0;
	if exists (select * from proveedor where cuit = cuit_input and razon_social = razon_social_input) then
       set ambosJuntos = 1;
	else
		if exists (select * from proveedor where cuit = cuit_input) then
		  set existCuit = 1;
		end if;
		if exists (select * from proveedor where razon_social = razon_social_input) then
		  set existRazonSocial = 1;
		end if;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaProveedor(in cuit_input varchar(45), in razon_social_input varchar(100))
begin   
    declare existCuit int; declare existRazonSocial int; declare ambosJuntos int;
    call verificarParaDarAltaProveedor(existCuit, existRazonSocial, ambosJuntos, cuit_input, razon_social_input);
	if ambosJuntos = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe cuit: ',cuit_input,' y razon social: ',razon_social_input) as causa_del_ERROR, 'Están en el mismo registro' as detalle;
    elseif (existRazonSocial = 1 and existCuit = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe código: ',cuit_input,' y razon social: ',razon_social_input) as causa_del_ERROR, 'Están en registros separados' as detalle;
	elseif existCuit = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con código: ',cuit_input) as causa_del_ERROR;
	elseif existRazonSocial = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con razon social: ',razon_social_input) as causa_del_ERROR;
    else
		insert into proveedor (cuit, razon_social, dado_de_alta) values(cuit_input, razon_social_input, true);
        select 'Proveedor agregado correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionProveedor(in cuit_input varchar(45), in razon_social_input varchar(100))
begin    
    if exists (select * from proveedor where cuit = cuit_input) then
       update proveedor set razon_social = razon_social_input, cuit = cuit_input where cuit = cuit_input;
       select 'Proveedor modificado correctamente'  as mensaje;
	else
       select 'No se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el cuit ', cuit_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE procedure bajaProveedor(in cuit_input varchar(45))
begin    
    if exists (select * from proveedor where cuit = cuit_input) then
		SET SQL_SAFE_UPDATES = 0;
        update proveedor set dado_de_alta=false where cuit = cuit_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el registro ' as mensaje_de_ERROR, CONCAT('NO existe uno con el código ', cuit_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaProveedor("1-111111-1116",'Proveedor de prueba');
call modificacionProveedor("1-111111-1116",'Probando modificación');
call bajaProveedor("1-111111-1116");

SELECT * FROM proveedor p where p.dado_de_alta = 1; /* Debido a que se realiza baja logica  */ 

call altaProveedor("30-71031609-7","Autopartes SOL");
call altaProveedor("30-47639864-2","Accesorios JDT");
call altaProveedor("33-12639451-4","Danlay SRL");
call altaProveedor("33-95735649-1","PoliAuto");
call altaProveedor("30-17264593-5","Accesorios FA-MA");
call altaProveedor("30-36275873-2","ABC Accesorios");
call altaProveedor("33-45636234-5","Daimler AG");
call altaProveedor("30-15678234-9","KIT Accesorios");
call altaProveedor("30-45678123-4","El Fierrero");
call altaProveedor("33-98651235-2","Todo Partes");
