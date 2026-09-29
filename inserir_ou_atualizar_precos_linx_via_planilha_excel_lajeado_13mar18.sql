declare @lajeado table (id int, codigo char(2), produto char(8), preco numeric(10,2))

/*
registros a serem inseridos ou atualizados
*/
------------
insert into @lajeado (id,codigo,produto,preco) values (1,'99', 'D6040122' ,34.99)
insert into @lajeado (id,codigo,produto,preco) values (2,'99', 'D6040150' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (3,'99', 'D6040151' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (4,'99', 'D6040120' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (5,'99', 'D6040148' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (6,'99', 'D6040070' ,27.99)
insert into @lajeado (id,codigo,produto,preco) values (7,'99', 'D6040119' ,27.99)
insert into @lajeado (id,codigo,produto,preco) values (8,'99', 'D6040080' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (9,'99', 'D6030010' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (10,'99', 'D6030011' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (11,'99', 'D6030005' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (12,'99', 'D6040071' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (13,'99', 'D6040043' ,44.99)
insert into @lajeado (id,codigo,produto,preco) values (14,'99', 'D6040124' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (15,'99', 'D6040121' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (16,'99', 'D6040153' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (17,'99', 'D6040140' ,34.99)
insert into @lajeado (id,codigo,produto,preco) values (18,'99', 'D6040141' ,34.99)
insert into @lajeado (id,codigo,produto,preco) values (19,'99', 'D6040117' ,79.99)
insert into @lajeado (id,codigo,produto,preco) values (20,'99', 'D6040116' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (21,'99', 'D6040115' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (22,'99', 'D6040118' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (23,'99', 'D6040075' ,79.99)
insert into @lajeado (id,codigo,produto,preco) values (24,'99', 'D6040076' ,79.99)
insert into @lajeado (id,codigo,produto,preco) values (25,'99', 'D6040045' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (26,'99', 'D6040142' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (27,'99', 'D6040143' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (28,'99', 'D8030092' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (29,'99', 'D8020046' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (30,'99', 'D8030066' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (31,'99', 'D8020048' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (32,'99', 'D8030065' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (33,'99', 'D8030096' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (34,'99', 'D8030095' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (35,'99', 'D8030064' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (36,'99', 'D8030080' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (37,'99', 'D8030073' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (38,'99', 'D8030072' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (39,'99', 'D8030097' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (40,'99', 'D8030099' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (41,'99', 'D8030098' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (42,'99', 'D9020052' ,34.99)
insert into @lajeado (id,codigo,produto,preco) values (43,'99', 'D9020064' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (44,'99', 'D9020065' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (45,'99', 'D9020042' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (46,'99', 'D9020062' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (47,'99', 'D9020063' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (48,'99', 'D9020078' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (49,'99', 'D9020075' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (50,'99', 'D9020076' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (51,'99', 'D9020057' ,79.99)
insert into @lajeado (id,codigo,produto,preco) values (52,'99', 'D6040094' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (53,'99', 'D6040093' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (54,'99', 'D6040127' ,22.99)
insert into @lajeado (id,codigo,produto,preco) values (55,'99', '12100105' ,7.99)
insert into @lajeado (id,codigo,produto,preco) values (56,'99', '12100109' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (57,'99', '13090019' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (58,'99', '13090020' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (59,'99', '13090075' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (60,'99', '13090014' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (61,'99', '13090016' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (62,'99', '13090018' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (63,'99', '13090023' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (64,'99', '13090087' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (65,'99', '13090077' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (66,'99', '13060158' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (67,'99', '13060160' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (68,'99', '13060152' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (69,'99', '13060137' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (70,'99', '13060150' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (71,'99', '13060153' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (72,'99', '13060159' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (73,'99', '13060154' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (74,'99', '13060155' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (75,'99', '70054939' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (76,'99', '70054759' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (77,'99', '70055072' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (78,'99', '70055069' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (79,'99', '70055073' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (80,'99', '70055265' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (81,'99', '70041886' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (82,'99', '70041900' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (83,'99', '70041911' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (84,'99', '70041917' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (85,'99', '70041924' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (86,'99', '70041907' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (87,'99', '70041945' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (88,'99', '70041943' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (89,'99', '70041955' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (90,'99', '70041957' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (91,'99', '70041891' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (92,'99', 'D3010085' ,89.99)
insert into @lajeado (id,codigo,produto,preco) values (93,'99', 'D3010086' ,89.99)
insert into @lajeado (id,codigo,produto,preco) values (94,'99', 'D3010068' ,89.99)
insert into @lajeado (id,codigo,produto,preco) values (95,'99', 'D3010087' ,99.99)
insert into @lajeado (id,codigo,produto,preco) values (96,'99', 'D3010047' ,119.99)
insert into @lajeado (id,codigo,produto,preco) values (97,'99', 'D3010076' ,119.99)
insert into @lajeado (id,codigo,produto,preco) values (98,'99', '45120432' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (99,'99', '45120434' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (100,'99', '45120438' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (101,'99', '45120425' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (102,'99', '45100196' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (103,'99', '45100204' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (104,'99', '45100207' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (105,'99', '45100198' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (106,'99', '45100182' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (107,'99', '45100200' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (108,'99', '70054884' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (109,'99', '70054886' ,29.99)
insert into @lajeado (id,codigo,produto,preco) values (110,'99', '70054809' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (111,'99', '70054805' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (112,'99', '70055075' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (113,'99', '70055179' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (114,'99', '70025084' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (115,'99', '70025010' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (116,'99', '70025008' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (117,'99', '70025082' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (118,'99', '70024821' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (119,'99', '70024751' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (120,'99', '70025087' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (121,'99', '70024904' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (122,'99', '13090056' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (123,'99', '13090057' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (124,'99', '13090058' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (125,'99', '13090059' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (126,'99', '13090055' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (127,'99', '13090065' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (128,'99', '13090066' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (129,'99', '13090067' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (130,'99', '13090068' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (131,'99', '13090069' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (132,'99', '13090060' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (133,'99', '13090061' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (134,'99', '13090062' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (135,'99', '13090063' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (136,'99', '13090064' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (137,'99', '13090072' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (138,'99', '13090074' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (139,'99', '13060145' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (140,'99', '13060146' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (141,'99', '13060147' ,24.99)
insert into @lajeado (id,codigo,produto,preco) values (142,'99', '70070573' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (143,'99', '70054625' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (144,'99', '70070574' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (145,'99', '70070575' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (146,'99', '70070576' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (147,'99', '70041864' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (148,'99', '70041865' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (149,'99', '70041866' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (150,'99', '70041867' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (151,'99', '70041868' ,39.99)
insert into @lajeado (id,codigo,produto,preco) values (152,'99', '01225107' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (153,'99', '01225112' ,49.99)
insert into @lajeado (id,codigo,produto,preco) values (154,'99', '01225141' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (155,'99', '01225016' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (156,'99', '01225019' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (157,'99', 'D3010056' ,79.99)
insert into @lajeado (id,codigo,produto,preco) values (158,'99', '01225117' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (159,'99', '01225118' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (160,'99', '01225120' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (161,'99', '01225144' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (162,'99', '01225142' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (163,'99', '01225039' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (164,'99', '01225041' ,59.99)
insert into @lajeado (id,codigo,produto,preco) values (165,'99', '01225146' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (166,'99', '01225145' ,69.99)

------------
declare @tot int, @i int, @ins int, @upd int
select  @tot = count(*) from @lajeado

declare	@codigo char(2),
		@produto char(8),
		@preco numeric(10,2)

set @i = 1
set @ins = 0
set @upd = 0
while @i <= @tot
begin
	
	select	@codigo = a.codigo,
			@produto = a.produto,
			@preco = a.preco
	from @lajeado a
	where a.id = @i

	if not exists(select 1 from produtos_precos where CODIGO_TAB_PRECO=@codigo and PRODUTO=@produto)
	--INSERT
	BEGIN

		insert into produtos_precos (CODIGO_TAB_PRECO,PRODUTO,PRECO1,LX_STATUS_REGISTRO,DATA_PARA_TRANSFERENCIA,DATA_CARGA_PRECOS)
		values (@codigo, @produto, @preco, 0, '20180308','20180308')

		set @ins = @ins + 1

	END
	--UPDATE
	ELSE
	BEGIN

		update produtos_precos 
		set CODIGO_TAB_PRECO =@codigo,
		PRODUTO = @produto,
		PRECO1 = @preco,
		DATA_PARA_TRANSFERENCIA='20180308',
		DATA_CARGA_PRECOS='20180308'
		where CODIGO_TAB_PRECO = @codigo and PRODUTO = @produto

		set @upd = @upd + 1
	
	END

	set @i = @i + 1
end

select @ins as inseridos, @upd as atualizados
