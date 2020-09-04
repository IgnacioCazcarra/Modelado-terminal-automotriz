create schema if not exists automotriz;
use automotriz;

create table if not exists vehiculo (
nro_chasis varchar(45) primary key,
id_modelo int,
id_pedido int
);

create table if not exists modelo (
codigo int primary key,
nombre varchar(45)
);

create table if not exists concesionaria(
codigo int primary key,
razon_social varchar(100),
reporte_de_ventas int
);

create table if not exists vehiculo_x_estacion(
id_vehiculo varchar(45),
id_estacion int,   -- solo cambié el nombre del atributo (y en todos los lugares donde aparecía)
fecha_hora_entrada datetime,
fecha_hora_salida datetime,
primary key(id_vehiculo,id_estacion)
);

create table if not exists estacion(
codigo int primary key,
nombre varchar(100),
orden int
);

create table if not exists estaciones_x_linea(
id_linea_de_montaje int,
id_estacion int,
primary key(id_linea_de_montaje,id_estacion)
);

create table if not exists linea_de_montaje(
codigo int primary key,
id_modelo_prod int,
produccion_promedio_mensual int
);

create table if not exists insumo(
codigo int primary key,
nombre varchar(45) -- saqué el atributo "idproveedor int", porque lo tenemos en la tabla "insumo_por_proveedor"
);

create table if not exists insumo_por_proveedor(
id_proveedor varchar(45), -- cambié el tipo
id_insumo int,
precio int,
primary key(id_insumo,id_proveedor)
);

create table if not exists proveedor(
cuit varchar(45) primary key, -- cambié el tipo
razon_social varchar(100) -- saqué el atributo "idinsumo_fabricado int" , porque lo tenemos en la tabla "insumo_por_proveedor"
);

create table if not exists insumo_x_estacion(
id_estacion int,
id_insumo int,
cantidad_insumo int,
unidad_medida_ins varchar(45),
primary key(id_insumo,id_estacion)
);

create table if not exists pedido(
nro_pedido int primary key,
id_concesionaria int,
fecha date
);

create table if not exists modelo_x_pedido(
id_pedido int,
id_modelo int,
cantidad int,
primary key(id_modelo,id_pedido)
);

alter table modelo_x_pedido add foreign key(id_modelo) references modelo(codigo);
alter table modelo_x_pedido add foreign key(id_pedido) references pedido(nro_pedido);
alter table pedido add foreign key(id_concesionaria) references concesionaria(codigo); -- lo cambié
alter table insumo_por_proveedor add foreign key(id_proveedor) references proveedor(cuit);
alter table insumo_por_proveedor add foreign key(id_insumo) references insumo(codigo);
alter table insumo_x_estacion add foreign key(id_insumo) references insumo(codigo);
alter table linea_de_montaje add foreign key(id_modelo_prod) references modelo(codigo);
alter table vehiculo add foreign key(id_modelo) references modelo(codigo);
alter table vehiculo add foreign key(id_pedido) references pedido(nro_pedido);
alter table vehiculo_x_estacion add foreign key(id_vehiculo) references vehiculo(nro_chasis);
alter table vehiculo_x_estacion add foreign key(id_estacion) references estacion(codigo);
alter table insumo_x_estacion add foreign key(id_estacion) references estacion(codigo);
alter table estaciones_x_linea add foreign key(id_linea_de_montaje) references linea_de_montaje(codigo);
alter table estaciones_x_linea add foreign key(id_estacion) references estacion(codigo);


