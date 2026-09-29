ALTER view [ccp\paulo.devide].vw_union_distribuicoes

as
select	'P' AS ORIGEM,
		pedido as distribuicao,
		produto,
		cor_produto,
		filial,
		filial_origem,
		qtde_total,
		1 as qtde_pack,
		caixa,
		venda
from caedu_reserva_automatica 

union 

select  'W' AS ORIGEM,
		distribuicao,
		produto,
		null as cor_produto,
		filial,
		filial_origem,
		qtde_total,
		qtde_pack,
		caixa,
		venda
from caedu_reserva_automatica_pack_wms 
GO


