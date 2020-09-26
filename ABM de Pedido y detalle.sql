drop procedure if exists `automotriz`.`verificarParaPedido`;
drop procedure if exists `automotriz`.`altaPedido`;
drop procedure if exists `automotriz`.`agregarModeloAPedido`;
drop procedure if exists `automotriz`.`modificacionPedido`;
drop procedure if exists `automotriz`.`bajaPedido`;

delimiter $$
CREATE procedure verificarParaPedido(OUT existPedido int, OUT existModelo int, OUT existConcesionaria int, in nro_pedido_input int, in id_concesionaria_input int, in id_modelo_input int)
begin    
	set existPedido=0;   set existModelo=0;  set existConcesionaria = 0;
	if exists (select * from pedido where nro_pedido = nro_pedido_input) then 
       set existPedido = 1;
	end if;
	if exists (select * from modelo where codigo = id_modelo_input) then
		  set existModelo = 1;
	end if;
    if exists (select * from concesionaria where codigo = id_concesionaria_input) then
	  set existConcesionaria = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaPedido(in nro_pedido_input int, in id_concesionaria_input int, in fecha_input date, in id_modelo_input int, in cantidad_input int)
begin   
	declare existPedido int; declare existModelo int; declare existConcesionaria int;
    call verificarParaPedido(existPedido, existModelo, existConcesionaria, nro_pedido_input, id_concesionaria_input, id_modelo_input);
	if existPedido = 1 then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe uno con nro de pedido: ',nro_pedido_input) as causa_del_ERROR;
	elseif existModelo = 0 then
		select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe el modelo: ',id_modelo_input) as causa_del_ERROR;
	elseif existConcesionaria = 0 then	
		select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe la concesionaria: ',id_concesionaria_input) as causa_del_ERROR;
	else
        insert into pedido (nro_pedido, id_concesionaria, fecha,dado_de_alta) values(nro_pedido_input, id_concesionaria_input, fecha_input,true);
	    insert into modelo_x_pedido (id_pedido, id_modelo, cantidad) values(nro_pedido_input, id_modelo_input, cantidad_input);
        select 'Se agregó correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure agregarModeloAPedido(in nro_pedido_input int, in id_modelo_input int, in cantidad_input int)
begin   
		declare existPedido int; declare existModelo int; declare existConcesionaria int; declare id_concesionaria_input int;
    call verificarParaPedido(existPedido, existModelo, existConcesionaria, nro_pedido_input, id_concesionaria_input, id_modelo_input);
	if existPedido = 1 then
			if exists (select * from modelo_x_pedido where id_pedido = nro_pedido_input and id_modelo = id_modelo_input) then
				select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('El pedido ya tiene el modelo: ',id_modelo_input) as causa_del_ERROR;
			elseif existModelo = 1 then
			    insert into modelo_x_pedido (id_pedido, id_modelo, cantidad) values(nro_pedido_input, id_modelo_input, cantidad_input);
			    select 'Se agregó correctamente' as mensaje;
			else 
 			    select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe el modelo: ',id_modelo_input) as causa_del_ERROR;
			end if;
	else
	 select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('No existe el nro. pedido: ',nro_pedido_input) as causa_del_ERROR;
	end if;
END $$
delimiter ;


delimiter $$
CREATE procedure modificacionPedido(in nro_pedido_input int, in id_concesionaria_input int, in fecha_input date, in id_modelo_input int, in cantidad_input int)
begin   
	declare existPedido int; declare existModelo int; declare existConcesionaria int;
    call verificarParaPedido(existPedido, existModelo, existConcesionaria, nro_pedido_input, id_concesionaria_input, id_modelo_input);
	if existPedido = 1 then
			if exists (select * from modelo_x_pedido where id_pedido = nro_pedido_input and id_modelo = id_modelo_input) then
                if existConcesionaria = 0 then
					select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe la concesionaria: ',id_concesionaria_input) as causa_del_ERROR;
                else
				    update pedido set  id_concesionaria = id_concesionaria_input, fecha = fecha_input where nro_pedido = nro_pedido_input;
				    update modelo_x_pedido set cantidad = cantidad_input where id_pedido = nro_pedido_input and id_modelo = id_modelo_input;
				    select 'Modificado correctamente'  as mensaje;
                end if;
			else
				select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe pedido con modelo: ',id_modelo_input) as causa_del_ERROR;
			end if;
	else
       select 'No se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe nro. de pedido: ', nro_pedido_input) as causa_del_ERROR; 
        
	end if;
END $$
delimiter ;



delimiter $$
CREATE procedure bajaPedido(in nro_pedido_input int)
begin    
    if exists (select * from pedido where nro_pedido = nro_pedido_input) then
		if exists (select * from pedido where nro_pedido = nro_pedido_input and dado_de_alta = false) then
			select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('Está dado de baja el pedido nro ', nro_pedido_input) as causa_del_ERROR;
		else
		    update pedido set   dado_de_alta = false     where nro_pedido = nro_pedido_input;
			select 'Dado de baja correctamente'  as mensaje;
		end if;
	else
		select 'NO se puede dar de baja ' as mensaje_de_ERROR, CONCAT('NO existe el pedido nro: ', nro_pedido_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaPedido(4, 4, '2020-05-23', 1, 23);
call agregarModeloAPedido(4, 2, 13);
call bajaPedido(4);