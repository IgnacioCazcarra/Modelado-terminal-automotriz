call altaModelo(1,'CAMARO');
call altaModelo(2,'MUSTANG');

call altaLineaDeMontaje(1,1,60);
call altaLineaDeMontaje(2,2,50);

call altaEstacion(0, "A fabricar", 0);
call altaEstacion(1, "Chasis", 1);
call altaEstacion(2, "Pintura", 2);
call altaEstacion(3, "Tren delantero y trasero", 3);
call altaEstacion(4, "Electricidad", 4);
call altaEstacion(5, "Motorización y banco de prueba", 5);


call agregarLineaAEstacion(1,1);
call agregarLineaAEstacion(1,2);
call agregarLineaAEstacion(1,3);
call agregarLineaAEstacion(1,4);
call agregarLineaAEstacion(1,5);
call agregarLineaAEstacion(2,1);
call agregarLineaAEstacion(2,2);
call agregarLineaAEstacion(2,3);
call agregarLineaAEstacion(2,4);
call agregarLineaAEstacion(2,5);

call altaInsumo(1, "Capot");
call altaInsumo(2, "Optica");
call altaInsumo(3, "Puerta");
call altaInsumo(4, "Ventanilla");
call altaInsumo(5, "Pintura");
call altaInsumo(6, "Masilla");
call altaInsumo(7, "Lija");
call altaInsumo(8, "Diluyente");
call altaInsumo(9, "Llanta");
call altaInsumo(10, "Cubierta");
call altaInsumo(11, "Suspensión");
call altaInsumo(12, "Transmisión");
call altaInsumo(13, "Cableado");
call altaInsumo(14, "Encendido");
call altaInsumo(15, "Batería");
call altaInsumo(16, "Motor");
call altaInsumo(17, "Escape");
call altaInsumo(18, "Burro de arranque");

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

call altaConcesionaria(1,'General Motors',180);
call altaConcesionaria(2,"The Vanguard Group",100);
call altaConcesionaria(3,"Daimler AG",150);
call altaConcesionaria(4,"BD Group",10); -- una que no hace pedidos

call altaPedido(1, 1, '2019-01-01', 1, 3); -- pedido 1 va a estar completo poorque ya tengo la cantidad de vehiculos los terminados en vehiculo_x_estacion
call agregarModeloAPedido(1, 2, 5); -- carga a "modelo_x_pedido" 
call altaPedido(2, 2, '2019-01-07', 1, 4); -- pedido 2 va a estar a medio completar poorque tengo la cantidad de vehiculos empezados pero falta terminar algunos en vehiculo_x_estacion
call agregarModeloAPedido(2, 2, 6); -- carga a "modelo_x_pedido"
call altaPedido(3, 3, '2019-01-11', 1, 5); -- pedido 3 va a estar pendiente poorque no igresaron a la estacion 1 en vehiculo_x_estacion
call agregarModeloAPedido(3, 2, 4); -- carga a "modelo_x_pedido"

-- teniendo en cuenta los pedidos 1, 2 y 3 , tenemos 12 vehiculos modelos 1 
--  y 15 vehiculos modelos 2... si quisieramos tener todos serian 27,  18 pasan por las 5 estaciones o alguna de ellas y 9 quedan en la estación 0

call altaVehiculo("1ANCS13Z6M0246591",1,1); -- para el pedido 1
call altaVehiculo("2APDW57A2G2855222",1,1);
call altaVehiculo("3AGSG97W6G6262333",1,1);
call altaVehiculo("1BSHC52U9L2354111",2,1);
call altaVehiculo("2BPDW57A2G2855222",2,1);
call altaVehiculo("3BSHC52U9L2354323",2,1);
call altaVehiculo("4BUCS13G6M0246244",2,1);
call altaVehiculo("5BSHC52U9L2354525",2,1); 
call altaVehiculo("1CECS13G6M0246551",1,2); -- para el pedido 2
call altaVehiculo("2CPDW57A2G2855242",1,2);
call altaVehiculo("3CGSG97W6G6262393",1,2);
call altaVehiculo("4CPDW57A2G2855244",1,2);
call altaVehiculo("1DHJF13G6M0241111",2,2);
call altaVehiculo("2DKDS57A2G2852222",2,2);
call altaVehiculo("3DRUP97W6G6263333",2,2);
call altaVehiculo("4DLHA57A2G2854444",2,2);
call altaVehiculo("5DTDK13G6M0245555",2,2);
call altaVehiculo("6DMDR57A2G2855466",2,2);
call altaVehiculo("1EECS13G6M0246111",1,3);-- para el pedido 3
call altaVehiculo("2EECS13G6M0246222",1,3);
call altaVehiculo("3EPDW57A2G2855233",1,3);
call altaVehiculo("4EGSG97W6G6262444",1,3);
call altaVehiculo("5EPDW57A2G2855555",1,3);
call altaVehiculo("1FHJF13G6M0244511",2,3);
call altaVehiculo("2FKDS57A2G2855622",2,3);
call altaVehiculo("3FRUP97W6G6267833",2,3);
call altaVehiculo("4FLHA57A2G2858944",2,3); 


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