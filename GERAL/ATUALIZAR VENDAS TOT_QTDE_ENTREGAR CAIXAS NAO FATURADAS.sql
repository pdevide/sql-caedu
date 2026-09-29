select A.FILIAL, B.APROVACAO, B.TOT_QTDE_ENTREGAR, B.TIPO_RATEIO, 
(select sum(QTDE_EMBALADA) from VENDAS_PROD_EMBALADO where pedido=b.pedido) as qty,
B.* 
--update a set faturado=1 
--update b set tot_qtde_entregar=(select sum(QTDE_EMBALADA) from VENDAS_PROD_EMBALADO where pedido=b.pedido)
FROM [ccp\paulo.devide].[TB_CAIXAS_A_FATURAR_20250519] A
inner join vendas B ON B.pedido = 'CX-'+RTRIM(A.CAIXA)
left join faturamento_prod c on c.caixa = a.caixa
WHERE 1=1 
and c.caixa is null
and A.faturado=0
--and isnull(b.tot_qtde_entregar,0)=0
