declare @lajeado table (id int, codigo char(2), produto char(8), preco numeric(10,2))

/*
registros a serem inseridos ou atualizados
*/
------------
insert into @lajeado (id,codigo,produto,preco) values (1,'99', 'Z2010045' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (2,'99', 'Z1020018' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (3,'99', 'Z4010026' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (4,'99', 'Z4010022' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (5,'99', 'Z4010042' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (6,'99', 'Z4010043' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (7,'99', 'Z4010044' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (8,'99', 'Z4010045' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (9,'99', 'Z4010048' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (10,'99', 'Z4010049' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (11,'99', 'Z4010038' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (12,'99', 'Z1010009' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (13,'99', 'Z1010007' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (14,'99', 'Z1010010' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (15,'99', 'Z2010040' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (16,'99', 'B0030006' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (17,'99', 'Z1020014' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (18,'99', 'B0010006' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (19,'99', 'B0020011' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (20,'99', 'Z4010055' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (21,'99', 'B0030007' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (22,'99', 'Z5030002' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (23,'99', 'B0030004' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (24,'99', 'Z4010064' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (25,'99', 'Z3010010' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (26,'99', 'Z1020005' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (27,'99', 'B0010005' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (28,'99', 'B0020012' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (29,'99', 'B0030005' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (30,'99', 'Z4010037' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (31,'99', 'Z4010058' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (32,'99', 'Z4010060' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (33,'99', 'Z4010061' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (34,'99', 'Z2010041' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (35,'99', 'Z1020017' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (36,'99', 'Z2010047' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (37,'99', 'B0020013' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (38,'99', 'Z4010063' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (39,'99', 'Z3010012' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (40,'99', 'Z1020006' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (41,'99', 'Z4010035' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (42,'99', 'Z4010054' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (43,'99', 'Z4010056' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (44,'99', 'Z4010057' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (45,'99', 'Z1020002' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (46,'99', 'Z5010009' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (47,'99', 'Z1010006' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (48,'99', 'Z2010050' ,15.99)
insert into @lajeado (id,codigo,produto,preco) values (49,'99', 'Z5010006' ,19.99)
insert into @lajeado (id,codigo,produto,preco) values (50,'99', 'Z1020015' ,9.99)
insert into @lajeado (id,codigo,produto,preco) values (51,'99', 'Z5010004' ,5.99)
insert into @lajeado (id,codigo,produto,preco) values (52,'99', 'Z3010006' ,5.99)

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
