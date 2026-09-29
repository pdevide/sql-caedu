/*
SELECT caixa, f.filial
into [ccp\paulo.devide].TB_CAIXAS_NAO_FATURADAS_PDA_5
FROM PDA_WMS_TB_EMBARQUE X

--INNER JOIN 

--(select	'P' AS ORIGEM,
--		pedido as distribuicao,
--		produto,
--		cor_produto,
--		filial,
--		filial_origem,
--		qtde_total,
--		1 as qtde_pack,
--		caixa,
--		venda
--from caedu_reserva_automatica 

--union 

--select  'W' AS ORIGEM,
--		distribuicao,
--		produto,
--		null as cor_produto,
--		filial,
--		filial_origem,
--		qtde_total,
--		qtde_pack,
--		caixa,
--		venda
--from caedu_reserva_automatica_pack_wms  ) A 
	
--	ON A.caixa = X.CAIXA
inner join filiais f on f.cod_filial = x.codigo_filial

WHERE X.DATA>'20250101' AND X.DATA<CONVERT(VARCHAR,GETDATE(),112)
AND NOT EXISTS (SELECT CAIXA FROM FATURAMENTO_PROD WHERE CAIXA = X.CAIXA)
order by 2,1
*/


select	a.caixa, a.filial, b.origem, b.distribuicao, 
		b.produto, b.cor_produto, b.filial_origem, b.qtde_total, 
		b.qtde_total, b.venda, 
(select count(*) from PRODUTOS_PACKS_PERMITIDOS pp where pp.produto=b.produto) as qtd_linhas,
b.filial as lojadestino, p.grade, p.erp_qtd_pack, pp.preco1 as CUSTO_1
from [ccp\paulo.devide].TB_CAIXAS_NAO_FATURADAS_PDA_5 a
left join 
(select	'P' AS ORIGEM,
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
from caedu_reserva_automatica_pack_wms  ) B on b.caixa = a.caixa
left join 
			produtos p on p.produto = b.produto
left join 
			produtos_precos pp on pp.produto = b.produto and pp.CODIGO_TAB_PRECO = '02'


 --select * from [ccp\paulo.devide].[VW_CAIXAS_NAO_FATURADAS_PDA_4]