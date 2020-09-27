drop procedure if exists `automotriz`.`verificarParaInsumo`;
drop procedure if exists `automotriz`.`altaInsumo`;
drop procedure if exists `automotriz`.`agregarInsumoAProveedor`;
drop procedure if exists `automotriz`.`modificacionInsumo`;
drop procedure if exists `automotriz`.`bajaInsumo`;

delimiter $$
CREATE procedure verificarParaInsumo(OUT existInsumo int, OUT existProveedor int, in codigo_input int, in cuit_input varchar(45))
begin    
	set existInsumo=0;   set existProveedor=0;
	if exists (select * from insumo where codigo = codigo_input) then 
       set existInsumo = 1;
	end if;
	if exists (select * from proveedor where cuit = cuit_input) then
		  set existProveedor = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaInsumo(in codigo_input int, in nombre_input varchar(45), in id_proveedor_input varchar(45), in precio_input int)
begin   
	declare existInsumo int; declare existProveedor int;
    call verificarParaInsumo(existInsumo, existProveedor, codigo_input, id_proveedor_input);
	if existInsumo = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe un insumo con ese codigo: ',codigo_input) as causa_del_ERROR;
	elseif existProveedor = 0 then
		select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe un proveedor: ',id_proveedor_input) as causa_del_ERROR;
	else
        insert into insumo (codigo, nombre,dado_de_alta) values(codigo_input, nombre_input, true);
	    insert into insumo_por_proveedor (id_proveedor, id_insumo, precio) values(id_proveedor_input, codigo_input, precio_input);
        select 'Se agregó correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure agregarInsumoAProveedor(in id_proveedor_input varchar(45), in codigo_input int, in precio int)
begin   
		declare existInsumo int; declare existProveedor int;
    call verificarParaInsumo(existInsumo, existProveedor, codigo_input, cuit_input);
	if existInsumo = 1 then
			if exists (select * from insumo_por_proveedor where id_proveedor = id_proveedor_input and id_insumo = codigo_input) then
				select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('El insumo ya tiene el proveedor: ',id_proveedor_input) as causa_del_ERROR;
			elseif existProveedor = 1 then
			    insert into insumo_por_proveedor (id_proveedor, id_insumo, precio) values(id_proveedor_input, codigo_input, precio);
			    select 'Se agregó correctamente' as mensaje;
			else 
 			    select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe el proveedor: ',id_proveedor_input) as causa_del_ERROR;
			end if;
	else
	 select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe el insumo: ',codigo_input) as causa_del_ERROR;
	end if;
END $$
delimiter ;


delimiter $$
CREATE procedure modificacionPedido(in codigo_input int, in nombre_input varchar(45), in id_proveedor_input varchar(45), in precio_input int)
begin   
	declare existInsumo int; declare existProveedor int;
    call verificarParaInsumo(existInsumo, existProveedor, codigo_input, id_proveedor_input);
	if existInsumo = 1 then
			if exists (select * from insumo_por_proveedor where id_insumo = codigo_input and id_proveedor = id_proveedor_input) then
                if existProveedor = 0 then
					select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe el proveedor: ',id_proveedor_input) as causa_del_ERROR;
                else
				    update insumo set  codigo = codigo_input, nombre = nombre_input where codigo = codigo_input;
				    update insumo_por_proveedor set precio = precio_input where id_insumo = codigo_input and id_proveedor = id_proveedor_input;
				    select 'Modificado correctamente'  as mensaje;
                end if;
			else
				select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe un insumo con el proveedor: ',id_proveedor_input) as causa_del_ERROR;
			end if;
	else
       select 'No se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe el insumo: ', codigo_input) as causa_del_ERROR; 
        
	end if;
END $$
delimiter ;



delimiter $$
CREATE procedure bajaInsumo(in codigo_input int)
begin    
    if exists (select * from insumo where codigo = codigo_input) then
		if exists (select * from insumo where codigo = codigo_input and dado_de_alta = false) then
			select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('Está dado de baja el insumo nro ', codigo_input) as causa_del_ERROR;
		else
		    update insumo set   dado_de_alta = false     where codigo = codigo_input;
			select 'Dado de baja correctamente'  as mensaje;
		end if;
	else
		select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('NO existe el insumo nro: ', codigo_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaInsumo(1, "Capot", "30-71031609-7", 4500);
call altaInsumo(2, "Optica", "30-71031609-7", 3000);
call altaInsumo(11, "Suspensión", "30-71031609-7", 12000);
call altaInsumo(3, "Puerta", "30-47639864-2", 5600);
call altaInsumo(12, "Transmisión", "30-47639864-2", 20000);
call altaInsumo(4, "Ventanilla", "33-12639451-4", 2000);
call altaInsumo(13, "Cableado", "33-12639451-4", 2400);
call altaInsumo(5, "Pintura", "33-95735649-1", 300);
call altaInsumo(6, "Masilla", "33-95735649-1", 260);
call altaInsumo(7, "Lija", "33-95735649-1", 30);
call altaInsumo(8, "Diluyente", "33-95735649-1", 200);
call altaInsumo(14, "Encendido", "30-17264593-5", 15000);
call altaInsumo(18, "Burro de Arranque", "30-17264593-5", 8700);
call altaInsumo(15, "Bateria", "30-36275873-2", 7000);
call altaInsumo(3, "Puerta", "30-36275873-2", 5700); -- repite articulo
call altaInsumo(5, "Pintura", "33-45636234-5", 68500); -- repite articulo
call altaInsumo(18, "Burro de Arranque", "33-45636234-5", 8500); -- repite articulo
call altaInsumo(9, "Llanta", "30-15678234-9", 3680);
call altaInsumo(17, "Escape", "30-15678234-9", 2700);
call altaInsumo(10, "Cubierta", "30-45678123-4", 3870);
call altaInsumo(12, "Transmisión", "30-45678123-4", 20500); -- repite articulo
call altaInsumo(11, "Suspensión", "33-98651235-2", 12200); -- repite articulo
call altaInsumo(15, "Bateria", "33-98651235-2", 6800); -- repite articulo