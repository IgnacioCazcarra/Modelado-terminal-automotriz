call altaPedido(1, 1, '2020-10-12', 1, 5);
drop trigger vehiculoParaPedido
DELIMITER $$
Create trigger vehiculoParaPedido after insert on pedido
for each row
begin
    declare modeloNuevo int;
    declare pedido integer;
	declare pedidoNuevo int;

    set pedido=new.nro_pedido;
    set modeloNuevo = (select id_modelo from modelo_x_pedido m where m.id_pedido = pedido); -- A SOLUCIONAR, EL WHERE NO RECONOCE
    -- LA VARIABLE PEDIDO
    
    insert into vehiculo (nro_chasis, id_modelo,id_pedido, dado_de_alta) values(uuid(), modeloNuevo, pedido, true);
    

end;
$$

DELIMITER ;