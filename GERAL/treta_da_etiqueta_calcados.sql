--select * from compras where pedido = '185820'


--update compras set ERP_PERCENT_DISTRIB=0, ERP_TOTAL_QTD_DISTRIB=0 where pedido = '185820'


select * from produtos_barra where 
--produto = 'D9020224'
 produto in ( 
'D9020249'
,'D9020250'
,'D9020251'
,'D9020252'
)

update produtos_barra set codigo_barra_padrao = 0 where right(rtrim(ltrim(codigo_barra)),1)='D' 
--and produto = 'D9020224'
and produto in ( 
'D9020249'
,'D9020250'
,'D9020251'
,'D9020252'
)

select ','+char(39)+rtrim(produto)+char(39) as produto2,produto,pedido from compras_produto 
--where pedido = '190843'
where pedido in (
'192550-2'
,'192552-2'
,'192552-1'
,'192550-1'
)

INSERT INTO PRODUTOS_BARRA (
CODIGO_BARRA, PRODUTO, COR_PRODUTO, TAMANHO, GRADE, DATA_PARA_TRANSFERENCIA, NOME_CLIFOR, CODIGO_BARRA_PADRAO, 
INATIVO, TIPO_COD_BAR, LX_STATUS_REGISTRO)
select  
RTRIM(CODIGO_BARRA)+'D' AS CODIGO_BARRA, PRODUTO, COR_PRODUTO, TAMANHO, GRADE, DATA_PARA_TRANSFERENCIA, NOME_CLIFOR, 0 as CODIGO_BARRA_PADRAO, INATIVO, TIPO_COD_BAR, LX_STATUS_REGISTRO
from produtos_barra where produto = 'D6040326'

select * from produtos_barra where produto = 'D6040326'

SELECT prod.produto, pb.CODIGO_BARRA
  FROM [CAEDU].[dbo].[PRODUTOS_BARRA] pb
  INNER JOIN produtos prod on(prod.produto=pb.produto)
   where prod.GRIFFE = 'CALCADOS'
   and pb.codigo_barra like '%E' 
  order by pb.DATA_PARA_TRANSFERENCIA DESC;
