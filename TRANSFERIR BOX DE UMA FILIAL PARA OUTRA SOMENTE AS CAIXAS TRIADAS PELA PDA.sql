set nocount on

-- Cria dataset temporario
declare @caixas table 
(id int identity(1,1) not null, 
caixa varchar(8) not null, 
filial varchar(25) not null)

-- Popula o dataset com os caixas e destinos 

--insert into @caixas (CAIXA, FILIAL) values ('11651356', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL)
select VE.CAIXA, 'SAO MATHEUS' AS FILIAL
from vendas_prod_embalado ve
inner join (
select EMB.NOME_CLIFOR, EMB.CAIXA,PR.GRIFFE, EMB.PRODUTO, EMB.QTDE_EMBALADA     
 from (    
 SELECT VOLUME FROM PDA_WMS_TB_TRIAGEM M    
    WHERE NOT EXISTS (SELECT 1 FROM PDA_WMS_TB_EMBARQUE PE WHERE M.VOLUME = PE.CAIXA) GROUP BY VOLUME) TR     
  INNER JOIN VENDAS_PROD_EMBALADO EMB ON TR.VOLUME = EMB.CAIXA    
  INNER JOIN PRODUTOS PR ON EMB.PRODUTO = PR.PRODUTO    where EMB.NOME_CLIFOR = 'RS - PORTO ALEGRE CENTRO'
  ) as PDA on PDA.CAIXA = ve.CAIXA



--select distinct filial from @caixas --where filial not in (select filial from filiais)


-- variaveis de controle de loop
declare @i int = 1
declare @tot int

select @tot = max(id) from @caixas

-- declare variaveis de trabalho
declare @caixa varchar(8) 
declare @filial varchar(25) 

-- inicio do loop
while @i <= @tot
begin

	select @caixa = CAIXA, @filial = FILIAL 
	FROM @caixas 
	WHERE ID = @i

	UPDATE VENDAS_PROD_EMBALADO 
		SET NOME_CLIFOR=@filial , 
			representante = @filial 
	WHERE CAIXA=@caixa

	-- se atualizou, atualiza as demais tabelas tambem
	IF @@ROWCOUNT > 0  
	begin
		UPDATE FATURAMENTO_CAIXAS 
		SET NOME_CLIFOR=@filial, 
		NOME_CLIFOR_ENTREGA = @filial
		WHERE CAIXA=@caixa
      
		UPDATE B 
		SET CLIENTE_ATACADO=@filial, 
			nome_clifor_entrega  = @filial, 
			representante = @filial, 
			gerente= @filial   
		FROM VENDAS_PROD_EMBALADO A 
		INNER JOIN VENDAS B 
			ON A.PEDIDO=B.PEDIDO 
					WHERE CAIXA =@caixa
	end

	-- passa para o proximo registro do dataset
	set @i = @i + 1
end

set nocount off


