select a.romaneio_produto, a.filial, a.FILIAL_DESTINO, a.EMISSAO, a.TIPO_ROMANEIO,
 a.CM_OPERACAO, b.PRODUTO, b.COR_PRODUTO, b.QTDE,
 b.SA_1, b.SA_2, b.SA_3, b.SA_4, b.SA_5, b.SA_6, b.SA_7, b.SA_8, b.SA_9, b.SA_10, 
 b.SA_11, b.SA_12, b.SA_13, b.SA_14, b.SA_15, b.SA_16, b.CUSTO1, p.classif_fiscal, p.INDICADOR_CFOP
from estoque_prod_sai a 
inner join estoque_prod1_sai b 
	on b.romaneio_produto = a.romaneio_produto and b.filial = a.filial
inner join produtos p 
	on p.produto = b.produto
where 
	a.emissao>'20171120' 
	and a.FILIAL = 'ITU' 
	and a.FILIAL_DESTINO='SOROCABA'