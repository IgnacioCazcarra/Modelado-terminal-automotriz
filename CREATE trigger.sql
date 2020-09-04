/* TRIGER HECHO PARA PROBAR
  creo un trigger en insumo_por_roveedor para que si al actualizar se ingresa como precio un némero negativo el precio será 0 y no el número negativo
  Aunque no hace falta primmero creo una función con validaciónes para modificar la tabla
 */
delimiter $$
CREATE procedure modificacionInsumoPorProveedor(in id_proveedor_imput varchar(45), in id_insumo_imput int, in precio_imput int)
begin    
    if exists (select * from insumo_por_proveedor where id_proveedor = id_proveedor_imput and id_insumo = id_insumo_imput) then
       update insumo_por_proveedor set precio = precio_imput where id_proveedor = id_proveedor_imput and id_insumo = id_insumo_imput;
       select 'Modificado correctamente'  as mensaje;
	else
       select 'NO se puede modificar el registro' as mensaje_de_ERROR, CONCAT('No existe uno con el código ', codigo_imput) as causa_del_ERROR;
    end if;
end $$
delimiter ;

delimiter $$
CREATE trigger insumo_por_proveedor_BU before update on insumo_por_proveedor for each row -- BU es por Before Update
begin    
    if NEW.precio<0 then
       set NEW.precio = 0;
    end if;
end $$
delimiter ;