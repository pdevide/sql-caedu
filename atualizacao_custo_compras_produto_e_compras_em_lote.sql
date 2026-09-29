SET NOCOUNT ON

declare @tabped table (ID INT IDENTITY(1,1), pedido VARCHAR(10), CUSTO NUMERIC(10,2))

insert into @tabped (pedido,custo) values ('221924',3.52);
insert into @tabped (pedido,custo) values ('221964',3.52);
insert into @tabped (pedido,custo) values ('221802',3.52);
insert into @tabped (pedido,custo) values ('221914',3.52);
insert into @tabped (pedido,custo) values ('222564',4.3);
insert into @tabped (pedido,custo) values ('222570',4.3);
insert into @tabped (pedido,custo) values ('222557',4.3);
insert into @tabped (pedido,custo) values ('222553',4.3);
insert into @tabped (pedido,custo) values ('221956',3.52);
insert into @tabped (pedido,custo) values ('221819',3.52);
insert into @tabped (pedido,custo) values ('221845',3.52);
insert into @tabped (pedido,custo) values ('222018',3.52);
insert into @tabped (pedido,custo) values ('221898',3.52);
insert into @tabped (pedido,custo) values ('221830',3.52);
insert into @tabped (pedido,custo) values ('221862',3.52);
insert into @tabped (pedido,custo) values ('222033',3.52);
insert into @tabped (pedido,custo) values ('222000',3.52);
insert into @tabped (pedido,custo) values ('221971',3.52);
insert into @tabped (pedido,custo) values ('221942',3.52);
insert into @tabped (pedido,custo) values ('221811',3.52);
insert into @tabped (pedido,custo) values ('222044',3.52);
insert into @tabped (pedido,custo) values ('222025',3.52);
insert into @tabped (pedido,custo) values ('221990',3.52);
insert into @tabped (pedido,custo) values ('221885',3.52);
insert into @tabped (pedido,custo) values ('222106',8.7);
insert into @tabped (pedido,custo) values ('222054',7);
insert into @tabped (pedido,custo) values ('222067',7);
insert into @tabped (pedido,custo) values ('222187',11.25);
insert into @tabped (pedido,custo) values ('222151',8.7);
insert into @tabped (pedido,custo) values ('222134',8.7);
insert into @tabped (pedido,custo) values ('222059',7);
insert into @tabped (pedido,custo) values ('222196',11.25);
insert into @tabped (pedido,custo) values ('222170',11.25);
insert into @tabped (pedido,custo) values ('222161',8.7);
insert into @tabped (pedido,custo) values ('222074',7);
insert into @tabped (pedido,custo) values ('222178',11.25);

SET NOCOUNT OFF

DECLARE @I INT 
DECLARE @TOT INT 

SELECT @I = MIN(ID), @TOT=MAX(ID)
FROM @tabped 

DECLARE @PEDIDO VARCHAR(10), @CUSTO NUMERIC(10,2)

WHILE @I<=@TOT
BEGIN
	
	PRINT @I

	SELECT @PEDIDO=PEDIDO, @CUSTO=CUSTO
	FROM @tabped WHERE ID=@I
		
	update compras_produto 
	set		custo1 = @CUSTO, 
			VALOR_ORIGINAL = QTDE_ORIGINAL*@CUSTO, 
			VALOR_ENTREGAR=QTDE_ENTREGAR*@CUSTO, 
			ERP_VERBAS_EMPENHO=QTDE_ORIGINAL*@CUSTO 
	where pedido = @PEDIDO /*and produto = '23100011'*/

	update compras 
	set TOT_VALOR_ORIGINAL= TOT_QTDE_ORIGINAL * @CUSTO, 
		TOT_VALOR_ENTREGAR = TOT_QTDE_ENTREGAR * @CUSTO 
	WHERE PEDIDO = @PEDIDO;

	SET @I=@I + 1
END

