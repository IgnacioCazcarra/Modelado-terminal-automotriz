
delimiter $$
CREATE procedure altaPedido(in nro_pedido_input int, in id_concesionaria_input int, in fecha_input date, in id_modelo_input int, in cantidad_input int)
begin   
	declare existPedido int; declare existModelo int; declare existConcesionaria int; 	DECLARE idPedidoParametro INTEGER DEFAULT 0;
	DECLARE idChasis INTEGER DEFAULT 0;
	DECLARE dFechaIngreso DATETIME;
	DECLARE idModeloParametro INTEGER;
	DECLARE nCantidadDetalle INT; 
    	DECLARE nInsertados INT;
    DECLARE finished int DEFAULT 0; 
    DECLARE curDetallePedido
        CURSOR FOR
            SELECT id_modelo, cantidad FROM modelo_x_pedido WHERE id_pedido = nro_pedido_input;
	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET finished = 1;

    
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
		set idPedidoParametro = nro_pedido_input;
        OPEN curDetallePedido;
        getDetalle: LOOP
        FETCH curDetallePedido INTO idModeloParametro, nCantidadDetalle;
		IF finished = 1 THEN
            LEAVE getDetalle;
        END IF;
		SET nInsertados = 0;
        WHILE nInsertados < nCantidadDetalle DO
        call altaVehiculo(uuid(), idModeloParametro, idPedidoParametro);		
        SET nInsertados = nInsertados  +1;

		END WHILE;

		END LOOP getDetalle;
        CLOSE curDetallePedido;
        
        select 'Se agregó correctamente el pedido' as mensaje;
	end if;
END $$
delimiter ;


call altaPedido(1, 1, '2020-10-12', 1, 5);