delimiter $$
CREATE procedure agregarLineaAEstacion(in codigo_linea_input int,in codigo_estacion_input int)
begin   
		declare existEstacion int; declare existLinea int;
		call verificarParaDarAltaEstacion(existEstacion, codigo_estacion_input);
		call verificarParaDarAltaLineaDeMontaje(existLinea ,codigo_linea_input);
    
    if existEstacion=1 and existLinea=1 then
		if exists (select * from estaciones_x_linea where id_linea_de_montaje = codigo_linea_input and id_estacion = codigo_estacion_input)then
		select 'NO se puede agregar el registro' as mensaje_de_ERROR, CONCAT('Ya existe una linea para esa estacion: ')as CAUSA_ERROR;
		ELSE
        insert into estaciones_x_linea (id_linea_de_montaje,id_estacion) values(codigo_linea_input,codigo_estacion_input);
		select 'Se agregó correctamente' as mensaje;
        end if;
    else
    select 'No se puede agregar'as mensaje_de_ERROR,CONCAT("al menos uno no existe")as CAUSA_ERROR;
    end if;

END $$
delimiter ;