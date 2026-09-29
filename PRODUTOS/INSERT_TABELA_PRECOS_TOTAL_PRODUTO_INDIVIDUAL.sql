   

declare @lajeado table (id int, codigo char(2), produto char(8), preco numeric(10,2))

/*
registros a serem inseridos ou atualizados
*/
------------
insert into @lajeado (id,codigo,produto,preco) values (1,'00', '24050061' ,26.34)
insert into @lajeado (id,codigo,produto,preco) values (2,'01', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (3,'02', '24050061' ,26.34)
insert into @lajeado (id,codigo,produto,preco) values (7,'06', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (8,'07', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (9,'08', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (10,'09', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (11,'10', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (12,'11', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (13,'12', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (14,'13', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (15,'14', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (16,'15', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (17,'16', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (18,'17', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (19,'18', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (20,'19', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (21,'20', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (22,'21', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (23,'22', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (24,'23', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (25,'24', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (26,'25', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (27,'26', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (28,'27', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (29,'28', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (30,'29', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (31,'30', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (32,'31', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (33,'32', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (34,'33', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (35,'34', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (38,'38', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (39,'39', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (40,'40', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (41,'41', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (42,'42', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (43,'43', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (44,'44', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (45,'45', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (46,'46', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (47,'47', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (48,'48', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (49,'56', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (50,'62', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (51,'63', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (52,'64', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (53,'65', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (54,'68', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (55,'70', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (56,'71', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (57,'72', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (58,'74', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (59,'75', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (60,'76', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (61,'79', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (62,'80', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (63,'81', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (64,'82', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (65,'84', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (67,'97', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (68,'98', '24050061' ,69.99)
insert into @lajeado (id,codigo,produto,preco) values (69,'99', '24050061' ,69.99)

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
		values (@codigo, @produto, @preco, 0, '20180412','20180412')

		set @ins = @ins + 1

	END
	--UPDATE
	ELSE
	BEGIN

		update produtos_precos 
		set CODIGO_TAB_PRECO =@codigo,
		PRODUTO = @produto,
		PRECO1 = @preco,
		DATA_PARA_TRANSFERENCIA='20180412',
		DATA_CARGA_PRECOS='20180412'
		where CODIGO_TAB_PRECO = @codigo and PRODUTO = @produto

		set @upd = @upd + 1
	
	END

	set @i = @i + 1
end

select @ins as inseridos, @upd as atualizados
