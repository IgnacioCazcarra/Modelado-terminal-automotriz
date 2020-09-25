drop procedure if exists `automotriz`.`verificarParaDarAltaPedido`;
drop procedure if exists `automotriz`.`altaPedido`;
drop procedure if exists `automotriz`.`modificacionPedido`;
drop procedure if exists `automotriz`.`bajaPedido`;
use automotriz;
delimiter $$
CREATE procedure verificarParaDarAltaPedido(OUT existNro_pedido int, in nro_pedido_input int)
begin    
	set existNro_pedido=0;
	if exists (select * from pedido where nro_pedido = nro_pedido_input) then
		set existNro_pedido = 1;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure altaPedido(in nro_pedido_input int, in id_concesionaria_input int)
begin   
    declare existNro_pedido int;
    call verificarParaDarAltaPedido(existNro_pedido, nro_pedido_input);
	if (existNro_pedido = 1) then
       select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe numero de pedido: ', nro_pedido_input) as causa_del_ERROR;
    else
		insert into pedido (nro_pedido, id_concesionaria, dado_de_alta) values(nro_pedido_input, id_concesionaria_input, true);
        select 'Pedido agregado correctamente' as mensaje;
	end if;
END $$
delimiter ;

delimiter $$
CREATE procedure modificacionPedido(in nro_pedido_input int, in id_concesionaria_input int)
begin    
    if exists (select * from pedido where nro_pedido = nro_pedido_input) then
       update pedido set nro_pedido = nro_pedido_input, id_concesionaria = id_concesionaria_input where nro_pedido = nro_pedido_input;
       select 'Pedido modificado correctamente'  as mensaje;
	else
       select 'No se puede modificar el pedido' as mensaje_de_ERROR, CONCAT('No existe uno con el nroPedido ', nro_pedido_input) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE procedure bajaPedido(in nro_pedido_input INT)
begin    
    if exists (select * from pedido where nro_pedido = nro_pedido_input) then
		SET SQL_SAFE_UPDATES = 0;
		delete from pedido where nro_pedido = nro_pedido_input;
        select 'Eliminado correctamente'  as mensaje;
	else
		select 'NO se puede eliminar el pedido ' as mensaje_de_ERROR, CONCAT('NO existe uno con el nroPedido ', nro_pedido_input) as causa_del_ERROR; 
    end if;
end $$
delimiter ;

call altaPedido(4,1);
call altaPedido(1,1);

call modificacionPedido(4,2);
call bajaPedido(4);

select * from pedido;

call altaVehiculo(1,1);
