--select * from INFO_LOJAS
--90 91 92  95 94  A1 A0   



DECLARE @TABELA VARCHAR(2) = 'A0'
insert into 
PRODUTOS_PRECOS	(CODIGO_TAB_PRECO, PRODUTO, PRECO1, PRECO2,PRECO3,PRECO4, ULT_ATUALIZACAO, DATA_PARA_TRANSFERENCIA) 

select @TABELA as CODIGO_TAB_PRECO, t1.PRODUTO, PRECO1, PRECO2,PRECO3,PRECO4, 
ULT_ATUALIZACAO, GETDATE()  AS DATA_PARA_TRANSFERENCIA
from produtos_precos t1
inner join 
(
select  PRODUTO
from compras a
inner join compras_produto b on b.PEDIDO=a.PEDIDO
where a.EMISSAO > '20220501' and 
b.produto not in(select produto from produtos_precos where CODIGO_TAB_PRECO=@TABELA)
group by PRODUTO ) as tab1 on tab1.PRODUTO = t1.PRODUTO and t1.CODIGO_TAB_PRECO='11'



