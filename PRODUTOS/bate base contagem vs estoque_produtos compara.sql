--select SUM(estoque) 
--from ESTOQUE_PRODUTOS 
--where FILIAL='ITAQUERA'
declare @tabela table (rownumber int identity (1,1) primary key, 
						filial varchar(25), produto varchar(8))

--;with base (produto, cor_produto, estoque, saldo_contagem, compara)
--as (
--select a.produto, a.cor_produto, b.ESTOQUE, a.SALDO_CONTAGEM, (b.ESTOQUE - a.saldo_contagem) as compara
--from ESTOQUE_PROD_CTG_ITENS A 
--INNER JOIN ESTOQUE_PRODUTOS B ON B.FILIAL='ITAQUERA' 
--AND B.PRODUTO=A.PRODUTO AND B.COR_PRODUTO=A.COR_PRODUTO
--where NOME_CONTAGEM='ITAQUERA_2025-08-25')
----insert into @tabela (filial, produto)
--select * from base 
--where 1=1
----AND produto='13090177'
--AND compara<>0

;with base (produto, cor_produto, estoque, saldo_contagem, compara)
as (
select a.produto, a.cor_produto, b.ESTOQUE, a.SALDO_CONTAGEM, (b.ESTOQUE - a.saldo_contagem) as compara
from ESTOQUE_PROD_CTG_ITENS A 
INNER JOIN ESTOQUE_PRODUTOS B ON B.FILIAL='SP - ARICANDUVA' 
AND B.PRODUTO=A.PRODUTO AND B.COR_PRODUTO=A.COR_PRODUTO
where NOME_CONTAGEM='ITAQUERA_2025-08-25')
--insert into @tabela (filial, produto)
select * from base 
where 1=1
--AND produto='13090177'
AND compara<>0

/*
SELECT * FROM @tabela

DECLARE @LINHA INT, @TOTLINHA INT, @FILIAL VARCHAR(25), @PRODUTO VARCHAR(8)
SELECT @LINHA=MIN(ROWNUMBER), @TOTLINHA=MAX(ROWNUMBER)
FROM @tabela

WHILE @LINHA <= @TOTLINHA
BEGIN

	SELECT @FILIAL= FILIAL, @PRODUTO=PRODUTO 
	FROM @tabela
	WHERE rownumber = @LINHA
	exec Lx_ver1_estoque_pa @produto= @PRODUTO, @filial= @FILIAL, @corrige='S';

	exec Lx_ver2_estoque_pa @produto= @PRODUTO, @filial= @FILIAL, @corrige='S';

	exec LX_PROCESSOS;

	SET @LINHA += 1
END
*/

/*
Lx_ver1_estoque_pa @produto= '13090177', @filial= 'ITAQUERA', @corrige='S'
go

Lx_ver2_estoque_pa @produto= '13090177', @filial= 'ITAQUERA', @corrige='S'
go

LX_PROCESSOS
GO


select *
from ESTOQUE_PROD_CTG_ITENS A 
--INNER JOIN ESTOQUE_PRODUTOS B ON B.FILIAL='ITAQUERA' 
WHERE PRODUTO = '13090177'    AND COR_PRODUTO='00158'
AND NOME_CONTAGEM='ITAQUERA_2025-08-25'

*/ 

--select * from sku

