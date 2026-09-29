CREATE OR ALTER VIEW DBO.CGP_VW_WMS_STATUS_QUALIDADE
AS
select	a.distribuicao, 
		data, 
		p.GRIFFE, 
		p.LINHA, 
		p.GRUPO_PRODUTO, 
		p.SUBGRUPO_PRODUTO, 
		p.GRADE, 
		p.produto, 
		p.DESC_PRODUTO,
		P.ERP_ST_QUALIDADE
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
inner join produtos p on p.PRODUTO = a.PRODUTO
where not exists (select caixa from FATURAMENTO_CAIXAS where caixa = a.caixa)
and FILIAL_ORIGEM = (SELECT VALOR_ATUAL 
						FROM PARAMETROS WHERE PARAMETRO = 'PALMA_CD_ORIGEM_DISTRIB')
group by 
		a.distribuicao,
		cast(a.data as date),
		p.GRIFFE, 
		p.LINHA, 
		p.GRUPO_PRODUTO, 
		p.SUBGRUPO_PRODUTO, 
		p.GRADE, 
		p.produto, 
		p.DESC_PRODUTO,
		P.ERP_ST_QUALIDADE



