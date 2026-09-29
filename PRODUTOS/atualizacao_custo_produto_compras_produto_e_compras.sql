SET NOCOUNT ON

declare @logpreco table (PEDIDO VARCHAR(10), PRODUTO VARCHAR(12), CUSTO_OLD NUMERIC(10,2), CUSTO_NEW NUMERIC(10,2))

declare @tabped table (ID INT IDENTITY(1,1), pedido VARCHAR(10), PRODUTO VARCHAR(12), CUSTO NUMERIC(10,2))

--INICIO BASE
insert into @tabped (pedido,produto,custo) values ('292425V','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292422V','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292429','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292427','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292429V','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292422','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292427V','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292431','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292431V','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292425','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292482','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292475','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292481','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292478','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292482V','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292478V','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292481V','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292484','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292484V','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292475V','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292492','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292488','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292493','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292488V','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292493V','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292486V','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292492V','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292496','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292486','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292496V','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292507','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292505','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292505V','S1020037',29.07);
insert into @tabped (pedido,produto,custo) values ('292507V','S1020038',29.07);
insert into @tabped (pedido,produto,custo) values ('292503','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('292509','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292498V','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292509V','S1020039',29.07);
insert into @tabped (pedido,produto,custo) values ('292498','S1020035',29.07);
insert into @tabped (pedido,produto,custo) values ('292503V','S1020036',29.07);
insert into @tabped (pedido,produto,custo) values ('284769V','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('284767V','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('284767','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('284766V','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('284768','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('284769','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('284768V','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('284766','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('282403V','Z6150003',39.17);
insert into @tabped (pedido,produto,custo) values ('282402','Z6150002',39.17);
insert into @tabped (pedido,produto,custo) values ('282402V','Z6150002',39.17);
insert into @tabped (pedido,produto,custo) values ('282401V','Z6150001',39.17);
insert into @tabped (pedido,produto,custo) values ('282401','Z6150001',39.17);
insert into @tabped (pedido,produto,custo) values ('282403','Z6150003',39.17);
insert into @tabped (pedido,produto,custo) values ('292143V','Z6150003',39.17);
insert into @tabped (pedido,produto,custo) values ('292142','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('292141V','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('292143','Z6150003',39.17);
insert into @tabped (pedido,produto,custo) values ('292142V','Z7100004',39.17);
insert into @tabped (pedido,produto,custo) values ('292140V','Z6150001',39.17);
insert into @tabped (pedido,produto,custo) values ('292136V','Z6150002',39.17);
insert into @tabped (pedido,produto,custo) values ('292140','Z6150001',39.17);
insert into @tabped (pedido,produto,custo) values ('292136','Z6150002',39.17);
insert into @tabped (pedido,produto,custo) values ('292141','Z7100003',39.17);
insert into @tabped (pedido,produto,custo) values ('294009V','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294011','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294011V','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294013','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294012','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294012V','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294009','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294010V','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294013V','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294010','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294018','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294015V','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294018V','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294017V','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294015','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294016V','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294014V','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294017','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294014','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294016','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294028','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294029V','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294023','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294029','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294019V','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294020','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294023V','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294019','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294020V','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294028V','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294021V','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294022','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294026V','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294022V','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294024V','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294024','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294027','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294027V','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294026','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294021','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294030V','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('294031V','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294033','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294033V','S6020027',37);
insert into @tabped (pedido,produto,custo) values ('294034','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294032','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294032V','S6020026',37);
insert into @tabped (pedido,produto,custo) values ('294031','S6020025',37);
insert into @tabped (pedido,produto,custo) values ('294034V','S6020028',37);
insert into @tabped (pedido,produto,custo) values ('294030','S6020029',37);
insert into @tabped (pedido,produto,custo) values ('293831','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293830V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293831V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293830','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293823','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293835','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293837V','S3020048',31);
insert into @tabped (pedido,produto,custo) values ('293837','S3020048',31);
insert into @tabped (pedido,produto,custo) values ('293835V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293823V','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293842V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293842','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293841V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293843V','S3020048',31);
insert into @tabped (pedido,produto,custo) values ('293839V','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293839','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293841','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293843','S3020048',31);
insert into @tabped (pedido,produto,custo) values ('293840V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293840','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293844','S3020050',31);
insert into @tabped (pedido,produto,custo) values ('293845V','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293850V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293847V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293848V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293847','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293850','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293848','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293844V','S3020050',31);
insert into @tabped (pedido,produto,custo) values ('293845','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293851V','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293851','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293853V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293853','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293854V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293852','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293855V','S3020050',31);
insert into @tabped (pedido,produto,custo) values ('293852V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293854','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293855','S3020050',31);
insert into @tabped (pedido,produto,custo) values ('293860V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293859V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293857V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293860','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293856','S3020049',31);
insert into @tabped (pedido,produto,custo) values ('293856V','S3020049',31);
insert into @tabped (pedido,produto,custo) values ('293859','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293857','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293864','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293870V','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293868','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293872','S3020049',31);
insert into @tabped (pedido,produto,custo) values ('293864V','S3020044',31);
insert into @tabped (pedido,produto,custo) values ('293872V','S3020049',31);
insert into @tabped (pedido,produto,custo) values ('293865V','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293870','S3020047',31);
insert into @tabped (pedido,produto,custo) values ('293865','S3020045',31);
insert into @tabped (pedido,produto,custo) values ('293868V','S3020046',31);
insert into @tabped (pedido,produto,custo) values ('293994V','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('293994','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('293993V','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('293993','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('293997','S5020039',33.6);
insert into @tabped (pedido,produto,custo) values ('293998','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('293998V','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('293997V','S5020039',33.6);
insert into @tabped (pedido,produto,custo) values ('294002','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('294001V','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('294001','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('294002V','S5020036',33.6);
insert into @tabped (pedido,produto,custo) values ('294006V','S5020042',33.6);
insert into @tabped (pedido,produto,custo) values ('294005V','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('294006','S5020042',33.6);
insert into @tabped (pedido,produto,custo) values ('294005','S5020035',33.6);
insert into @tabped (pedido,produto,custo) values ('292875','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292873','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292885V','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292879V','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292885','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292873V','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292875V','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292883','Z7090028',28);
insert into @tabped (pedido,produto,custo) values ('292879','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292883V','Z7090028',28);
insert into @tabped (pedido,produto,custo) values ('292887','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292899','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292889V','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292893V','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292889','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292893','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292899V','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292887V','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292900V','Z7090030',28);
insert into @tabped (pedido,produto,custo) values ('292900','Z7090030',28);
insert into @tabped (pedido,produto,custo) values ('292909V','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292921','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292905V','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292914V','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292905','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292917V','Z7090030',28);
insert into @tabped (pedido,produto,custo) values ('292917','Z7090030',28);
insert into @tabped (pedido,produto,custo) values ('292909','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292921V','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292914','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292936V','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292934','Z7090028',28);
insert into @tabped (pedido,produto,custo) values ('292924','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('292927V','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292936','Z7090029',28);
insert into @tabped (pedido,produto,custo) values ('292930','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292934V','Z7090028',28);
insert into @tabped (pedido,produto,custo) values ('292927','Z7090026',28);
insert into @tabped (pedido,produto,custo) values ('292930V','Z7090027',28);
insert into @tabped (pedido,produto,custo) values ('292924V','Z7090025',28);
insert into @tabped (pedido,produto,custo) values ('293996','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('293995V','S5020037',33.03);
insert into @tabped (pedido,produto,custo) values ('293995','S5020037',33.03);
insert into @tabped (pedido,produto,custo) values ('293996V','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('294000','S5020040',33.03);
insert into @tabped (pedido,produto,custo) values ('293999','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('293999V','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('294000V','S5020040',33.03);
insert into @tabped (pedido,produto,custo) values ('294004V','S5020037',33.03);
insert into @tabped (pedido,produto,custo) values ('294003','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('294004','S5020037',33.03);
insert into @tabped (pedido,produto,custo) values ('294003V','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('294008','S5020041',33.03);
insert into @tabped (pedido,produto,custo) values ('294007','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('294008V','S5020041',33.03);
insert into @tabped (pedido,produto,custo) values ('294007V','S5020038',33.03);
insert into @tabped (pedido,produto,custo) values ('290694','S5020032',41.8);
insert into @tabped (pedido,produto,custo) values ('290706V','S5020034',41.8);
insert into @tabped (pedido,produto,custo) values ('290691V','S5020031',41.8);
insert into @tabped (pedido,produto,custo) values ('290702V','S5020033',41.8);
insert into @tabped (pedido,produto,custo) values ('290691','S5020031',41.8);
insert into @tabped (pedido,produto,custo) values ('290702','S5020033',41.8);
insert into @tabped (pedido,produto,custo) values ('290694V','S5020032',41.8);
insert into @tabped (pedido,produto,custo) values ('290706','S5020034',41.8);

--FINAL BASE

SET NOCOUNT OFF

DECLARE @I INT 
DECLARE @TOT INT 

SELECT @I = MIN(ID), @TOT=MAX(ID)
FROM @tabped 

DECLARE @PEDIDO VARCHAR(10), @PRODUTO VARCHAR(12), @CUSTO NUMERIC(10,2)

WHILE @I<=@TOT
BEGIN
	
	PRINT @I

	SELECT @PEDIDO=PEDIDO, @PRODUTO = PRODUTO, @CUSTO=CUSTO
	FROM @tabped WHERE ID=@I
	
	INSERT INTO @logpreco
	SELECT 	PEDIDO, PRODUTO, CUSTO1 AS CUSTO_OLD, @CUSTO AS CUSTO_NEW 
	FROM COMPRAS_PRODUTO 
	WHERE pedido = @PEDIDO and produto = @PRODUTO

	update compras_produto 
	set		custo1 = @CUSTO, 
			VALOR_ORIGINAL = QTDE_ORIGINAL*@CUSTO, 
			VALOR_ENTREGAR=QTDE_ENTREGAR*@CUSTO, 
			ERP_VERBAS_EMPENHO=QTDE_ORIGINAL*@CUSTO 
	where pedido = @PEDIDO and produto = @PRODUTO

	update compras 
	set TOT_VALOR_ORIGINAL= TOT_QTDE_ORIGINAL * @CUSTO, 
		TOT_VALOR_ENTREGAR = TOT_QTDE_ENTREGAR * @CUSTO 
	WHERE PEDIDO = @PEDIDO;

	UPDATE PRODUTOS SET CUSTO_REPOSICAO1=@CUSTO
	WHERE PRODUTO = @PRODUTO

	SET @I=@I + 1
END

SELECT * FROM @logpreco