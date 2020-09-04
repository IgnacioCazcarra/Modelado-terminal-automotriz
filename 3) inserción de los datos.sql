use automotriz;
-- 	CARGA DE DATOS
insert into modelo values
(1,"CAMARO"),
(2,"MUSTANG");

insert into linea_de_montaje values
(1,1,60),
(2,2,50);

insert into estacion values
(0,'A fabricar',0),
(1,"Chasis",1),
(2,"Pintura",2),
(3,"Tren delantero y trasero",3),
(4,"Electricidad",4),
(5,"Motorización y banco de prueba",5);

insert into estaciones_x_linea values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5);

insert into insumo values
(1,"Capot"),(2,"Optica"),(3,"Puerta"),(4,"Ventanilla"),(5,"Pintura"),
(6,"Masilla"),(7,"Lija"),(8,"Diluyente"),(9,"Llanta"),(10,"Cubierta"),
(11,"Suspensión"),(12,"Transmisión"),(13,"Cableado"),(14,"Encendido"),
(15,"Bateria"),(16,"Motor"),(17,"Escape"),(18,"Burro de Arranque");

insert into insumo_x_estacion values
(1,1,1,"unidades"),     -- estación "Chasis", capot 1 u
(1,2,2,"unidades"),     -- estación "Chasis", opticas 2 u
(1,3,5,"unidades"),     -- estación "Chasis", puerta 5 u
(1,4,4,"unidades"),     -- estación "Chasis", ventanilla 4 u
(2,5,6,"Litros"),       -- estación "Pintura", pintura 6 l
(2,6,3,"Kilos"),        -- estación "Pintura", masilla 3 k
(2,7,12,"unidades"),    -- estación "Pintura", lija 12 u
(2,8,5,"litros"),       -- estación "Pintura", diluyente 5 l
(3,9,4,"unidades"),     -- estación "Tren delantero y trasero", llanta 4 u
(3,10,4,"unidades"),    -- estación "Tren delantero y trasero", cubierta 4 u
(3,11,1,"unidades"),    -- estación "Tren delantero y trasero", suspensión 1 u
(3,12,1,"unidades"),    -- estación "Tren delantero y trasero", transmisón 1 u 
(4,2,2,"unidades"),     -- estación "Electricidad", opticas 4 u 
(4,13,1,"unidades"),    -- estación "Electricidad", cableado 1 u 
(4,14,1,"unidades"),    -- estación "Electricidad", encendido 1 u 
(4,15,1,"unidades"),    -- estación "Electricidad", bateria 1 u 
(5,16,1,"unidades"),    -- estación "Motorización y banco de prueba", motor 1 u  
(5,17,1,"unidades"),    -- estación "Motorización y banco de prueba", escape 1 u 
(5,18,1,"unidades"),    -- estación "Motorización y banco de prueba", burro de arranque 1 u 
(5,12,1,"unidades");    -- estación "Motorización y banco de prueba", transmisón 1 u 


insert into proveedor values
("30-71031609-7","Autopartes SOL"),
("30-47639864-2","Accesorios JDT"),
("33-12639451-4","Danlay SRL"),
("33-95735649-1","PoliAuto"),
("30-17264593-5","Accesorios FA-MA"),
("30-36275873-2","ABC Accesorios"),
("33-45636234-5","Daimler AG"),
("30-15678234-9","KIT Accesorios"),
("30-45678123-4","El Fierrero"),
("33-98651235-2","Todo Partes");


insert into insumo_por_proveedor values
("30-71031609-7",1,4500),
("30-71031609-7",2,3000),
("30-71031609-7",11,12000), 
("30-47639864-2",3,5600),   
("30-47639864-2",12,20000),
("33-12639451-4",4,2000),
("33-12639451-4",13,2400),
("33-95735649-1",5,300),
("33-95735649-1",6,260),
("33-95735649-1",7,30),
("33-95735649-1",8,200),
("30-17264593-5",14,15000),
("30-17264593-5",18,8700),
("30-36275873-2",15,7000),  
("30-36275873-2",3,5700),   -- repite articulo
("33-45636234-5",16,68500),
("33-45636234-5",18,8500),   -- repite articulo  
("30-15678234-9",9,3680),
("30-15678234-9",17,2700),
("30-45678123-4",10,3870),
("30-45678123-4",12,20500),  -- repite articulo 
("33-98651235-2",11,12200),  -- repite articulo 
("33-98651235-2",15,6800);   -- repite articulo


insert into concesionaria values
(1,"General Motors",180),
(2,"The Vanguard Group",100),
(3,"Daimler AG",150),
(4,"BD Group",10); -- una que no hace pedidos

insert into pedido values
(1,1,'2019-01-01'), -- completo poorque ya tengo la cantidad de vehiculos los terminados en vehiculo_x_estacion
(2,2,'2019-01-07'), -- a medio completar poorque tengo la cantidad de vehiculos empezados pero falta terminar algunos en vehiculo_x_estacion
(3,3,'2019-01-11');  -- pendiente poorque no igresaron a la estacion 1 en vehiculo_x_estacion

insert into modelo_x_pedido values
(1,1,3),
(1,2,5), 
(2,1,4),
(2,2,6),
(3,1,5),
(3,2,4); 
-- teniendo en cuenta los pedidos 1, 2 y 3 , tenemos 12 vehiculos modelos 1 
--  y 15 vehiculos modelos 2... si quisieramos tener todos serian 27,  18 pasan por las 5 estaciones o alguna de ellas y 9 quedan en la estación 0

insert into vehiculo values
("1ANCS13Z6M0246591",1,1), -- pedido 1
("2APDW57A2G2855222",1,1),
("3AGSG97W6G6262333",1,1),
("1BSHC52U9L2354111",2,1),
("2BPDW57A2G2855222",2,1),
("3BSHC52U9L2354323",2,1),
("4BUCS13G6M0246244",2,1),
("5BSHC52U9L2354525",2,1), 
("1CECS13G6M0246551",1,2), -- pedido 2
("2CPDW57A2G2855242",1,2),
("3CGSG97W6G6262393",1,2),
("4CPDW57A2G2855244",1,2),
("1DHJF13G6M0241111",2,2),
("2DKDS57A2G2852222",2,2),
("3DRUP97W6G6263333",2,2),
("4DLHA57A2G2854444",2,2),
("5DTDK13G6M0245555",2,2),
("6DMDR57A2G2855466",2,2),
("1EECS13G6M0246111",1,3),-- pedido 3
("2EECS13G6M0246222",1,3),
("3EPDW57A2G2855233",1,3),
("4EGSG97W6G6262444",1,3),
("5EPDW57A2G2855555",1,3),
("1FHJF13G6M0244511",2,3),
("2FKDS57A2G2855622",2,3),
("3FRUP97W6G6267833",2,3),
("4FLHA57A2G2858944",2,3); 


insert into vehiculo_x_estacion values
-- ---- representa el PEDIDO 1 MODELO 1 completo
("1ANCS13Z6M0246591",1,'2019-01-03 08:20','2019-01-03 17:55'), -- mod 1
("1ANCS13Z6M0246591",2,'2019-01-04 08:15','2019-01-04 17:30'), -- mod 1
("1ANCS13Z6M0246591",3,'2019-01-05 08:20','2019-01-05 16:55'), -- mod 1
("1ANCS13Z6M0246591",4,'2019-01-06 08:15','2019-01-06 17:30'), -- mod 1
("1ANCS13Z6M0246591",5,'2019-01-07 10:20','2019-01-07 17:38'), -- mod 1
("2APDW57A2G2855222",1,'2019-01-04 10:20','2019-01-04 17:38'), -- mod 1
("2APDW57A2G2855222",2,'2019-01-05 10:20','2019-01-05 17:38'), -- mod 1
("2APDW57A2G2855222",3,'2019-01-06 10:20','2019-01-06 17:38'), -- mod 1
("2APDW57A2G2855222",4,'2019-01-07 10:20','2019-01-07 17:38'), -- mod 1
("2APDW57A2G2855222",5,'2019-01-08 10:20','2019-01-08 17:38'), -- mod 1
("3AGSG97W6G6262333",1,'2019-01-05 10:20','2019-01-05 17:38'), -- mod 1
("3AGSG97W6G6262333",2,'2019-01-06 10:20','2019-01-06 17:38'), -- mod 1
("3AGSG97W6G6262333",3,'2019-01-07 10:20','2019-01-07 17:38'), -- mod 1
("3AGSG97W6G6262333",4,'2019-01-08 10:20','2019-01-08 17:38'), -- mod 1
("3AGSG97W6G6262333",5,'2019-01-09 10:20','2019-01-09 17:38'), -- mod 1
-- ---- representa el PEDIDO 1 MODELO 2 completo
("1BSHC52U9L2354111",1,'2019-01-06 08:15','2019-01-06 17:47'), -- mod 2
("1BSHC52U9L2354111",2,'2019-01-07 14:25','2019-01-07 17:40'), -- mod 2
("1BSHC52U9L2354111",3,'2019-01-08 08:15','2019-01-08 17:30'), -- mod 2
("1BSHC52U9L2354111",4,'2019-01-09 14:25','2019-01-09 17:50'), -- mod 2
("1BSHC52U9L2354111",5,'2019-01-10 08:15','2019-01-10 17:47'), -- mod 2
("2BPDW57A2G2855222",1,'2019-01-07 10:20','2019-01-07 17:38'), -- mod 2
("2BPDW57A2G2855222",2,'2019-01-08 10:20','2019-01-08 17:38'), -- mod 2
("2BPDW57A2G2855222",3,'2019-01-09 10:20','2019-01-09 17:38'), -- mod 2
("2BPDW57A2G2855222",4,'2019-01-10 10:20','2019-01-10 17:38'), -- mod 2
("2BPDW57A2G2855222",5,'2019-01-11 10:20','2019-01-11 17:38'), -- mod 2
("3BSHC52U9L2354323",1,'2019-01-08 10:20','2019-01-08 17:38'), -- mod 2 
("3BSHC52U9L2354323",2,'2019-01-09 10:20','2019-01-09 17:38'), -- mod 2
("3BSHC52U9L2354323",3,'2019-01-10 10:20','2019-01-10 17:38'), -- mod 2
("3BSHC52U9L2354323",4,'2019-01-11 10:20','2019-01-11 17:38'), -- mod 2
("3BSHC52U9L2354323",5,'2019-01-12 10:20','2019-01-12 17:38'), -- mod 2
("4BUCS13G6M0246244",1,'2019-01-09 10:20','2019-01-09 17:38'), -- mod 2
("4BUCS13G6M0246244",2,'2019-01-10 10:20','2019-01-10 17:38'), -- mod 2
("4BUCS13G6M0246244",3,'2019-01-11 10:20','2019-01-11 17:38'), -- mod 2
("4BUCS13G6M0246244",4,'2019-01-12 10:20','2019-01-12 17:38'), -- mod 2
("4BUCS13G6M0246244",5,'2019-01-13 10:20','2019-01-13 17:38'), -- mod 2
("5BSHC52U9L2354525",1,'2019-01-10 10:20','2019-01-10 17:38'), -- mod 2
("5BSHC52U9L2354525",2,'2019-01-11 10:20','2019-01-11 17:38'), -- mod 2
("5BSHC52U9L2354525",3,'2019-01-12 10:20','2019-01-12 17:38'), -- mod 2
("5BSHC52U9L2354525",4,'2019-01-13 10:20','2019-01-13 17:38'), -- mod 2
("5BSHC52U9L2354525",5,'2019-01-14 10:20','2019-01-14 17:38'), -- mod 2
-- ---- representa parte del PEDIDO 2 MODELO 1 TERMINADOS
("1CECS13G6M0246551",1,'2019-01-11 10:20','2019-01-11 17:38'), -- mod 1
("1CECS13G6M0246551",2,'2019-01-12 10:20','2019-01-12 17:38'), -- mod 1
("1CECS13G6M0246551",3,'2019-01-13 10:20','2019-01-13 17:38'), -- mod 1 
("1CECS13G6M0246551",4,'2019-01-14 10:20','2019-01-14 17:38'), -- mod 1
("1CECS13G6M0246551",5,'2019-01-15 10:20','2019-01-15 17:38'), -- mod 1
("2CPDW57A2G2855242",1,'2019-01-12 10:20','2019-01-12 17:38'), -- mod 1
("2CPDW57A2G2855242",2,'2019-01-13 10:20','2019-01-13 17:38'), -- mod 1
("2CPDW57A2G2855242",3,'2019-01-14 10:20','2019-01-14 17:38'), -- mod 1
("2CPDW57A2G2855242",4,'2019-01-15 10:20','2019-01-15 17:38'), -- mod 1
("2CPDW57A2G2855242",5,'2019-01-16 10:20','2019-01-16 17:38'), -- mod 1
-- ---- representa parte del PEDIDO 2 MODELO 2 TERMINADOS
("1DHJF13G6M0241111",1,'2019-01-13 10:20','2019-01-13 17:38'), -- mod 2
("1DHJF13G6M0241111",2,'2019-01-14 10:20','2019-01-14 17:38'), -- mod 2
("1DHJF13G6M0241111",3,'2019-01-15 10:20','2019-01-15 17:38'), -- mod 2
("1DHJF13G6M0241111",4,'2019-01-16 10:20','2019-01-16 17:38'), -- mod 2
("1DHJF13G6M0241111",5,'2019-01-17 10:20','2019-01-17 17:38'), -- mod 2 
("2DKDS57A2G2852222",1,'2019-01-14 10:20','2019-01-14 17:38'), -- mod 2 
("2DKDS57A2G2852222",2,'2019-01-15 10:20','2019-01-15 17:38'), -- mod 2
("2DKDS57A2G2852222",3,'2019-01-16 10:20','2019-01-16 17:38'), -- mod 2
("2DKDS57A2G2852222",4,'2019-01-17 10:20','2019-01-17 17:38'), -- mod 2
("2DKDS57A2G2852222",5,'2019-01-18 10:20','2019-01-18 17:38'), -- mod 2
("3DRUP97W6G6263333",1,'2019-01-15 10:20','2019-01-15 17:38'), -- mod 2
("3DRUP97W6G6263333",2,'2019-01-16 10:20','2019-01-16 17:38'), -- mod 2
("3DRUP97W6G6263333",3,'2019-01-17 10:20','2019-01-17 17:38'), -- mod 2
("3DRUP97W6G6263333",4,'2019-01-18 10:20','2019-01-18 17:38'), -- mod 2
("3DRUP97W6G6263333",5,'2019-01-19 10:20','2019-01-19 17:38'), -- mod 2
("4DLHA57A2G2854444",1,'2019-01-16 10:20','2019-01-16 17:38'), -- mod 2
("4DLHA57A2G2854444",2,'2019-01-17 10:20','2019-01-17 17:38'), -- mod 2
("4DLHA57A2G2854444",3,'2019-01-18 10:20','2019-01-18 17:38'), -- mod 2
("4DLHA57A2G2854444",4,'2019-01-19 10:20','2019-01-19 17:38'), -- mod 2
("4DLHA57A2G2854444",5,'2019-01-20 10:20','2019-01-20 17:38'), -- mod 2
-- ---- representa parte del PEDIDO 2 MODELO 2 A TERMINAR
("6DMDR57A2G2855466",1,'2019-01-17 08:15','2019-01-17 17:26'), -- mod 2
("6DMDR57A2G2855466",2,'2019-01-18 08:20','2019-01-18 16:59'), -- mod 2
("6DMDR57A2G2855466",3,'2019-01-19 08:15','2019-01-19 16:59'), -- mod 2
("6DMDR57A2G2855466",4,'2019-01-20 16:59',null), -- mod 2
("6DMDR57A2G2855466",5,null,null), -- mod 2
("5DTDK13G6M0245555",1,'2019-01-18 10:20','2019-01-18 17:38'), -- mod 2
("5DTDK13G6M0245555",2,'2019-01-19 10:20','2019-01-19 16:59'), -- mod 2
("5DTDK13G6M0245555",3,'2019-01-20 16:59',null), -- mod 2
("5DTDK13G6M0245555",4,null,null), -- mod 2
("5DTDK13G6M0245555",5,null,null), -- mod 2
-- ---- representa parte del PEDIDO 2 MODELO 1  A TERMINAR
("4CPDW57A2G2855244",1,'2019-01-19 08:00','2019-01-19 17:21'), -- mod 1
("4CPDW57A2G2855244",2,'2019-01-20 08:20',null), -- mod 1
("4CPDW57A2G2855244",3,null,null), -- mod 1
("4CPDW57A2G2855244",4,null,null), -- mod 1
("4CPDW57A2G2855244",5,null,null), -- mod 1
("3CGSG97W6G6262393",1,'2019-01-20 10:20',null), -- mod 1
("3CGSG97W6G6262393",2,null,null), -- mod 1
("3CGSG97W6G6262393",3,null,null), -- mod 1
("3CGSG97W6G6262393",4,null,null), -- mod 1
("3CGSG97W6G6262393",5,null,null), -- mod 1
-- pedido 3
("1EECS13G6M0246111",0,null,null), -- mod 1
("2EECS13G6M0246222",0,null,null), -- mod 1
("3EPDW57A2G2855233",0,null,null), -- mod 1
("4EGSG97W6G6262444",0,null,null), -- mod 1
("5EPDW57A2G2855555",0,null,null), -- mod 1
("1FHJF13G6M0244511",0,null,null), -- mod 2
("2FKDS57A2G2855622",0,null,null), -- mod 2
("3FRUP97W6G6267833",0,null,null), -- mod 2
("4FLHA57A2G2858944",0,null,null); -- mod 2