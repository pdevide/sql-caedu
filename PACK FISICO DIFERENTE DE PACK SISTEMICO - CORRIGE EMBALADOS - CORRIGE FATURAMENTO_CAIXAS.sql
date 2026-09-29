
select * from VENDAS_PROD_EMBALADO where caixa in (
select CAIXA from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao in ('00010539','00010541'))


select * from FATURAMENTO_CAIXAS where caixa in (
select CAIXA from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao in ('00010539','00010541'))




update a set a.e1 = 20, a.VALOR_EMBALADO = a.preco1 * 20, a.QTDE_EMBALADA = 20
from VENDAS_PROD_EMBALADO a where a.caixa in (
select CAIXA from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao in ('00010539','00010541'))



update a set a.QTDE_CAIXA = 20
from FATURAMENTO_CAIXAS a 
where caixa in (
select CAIXA from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao in ('00010539','00010541'))


select p.ERP_QTD_PACK, pp.* 
from produtos p 
inner join PRODUTOS_PACKS_PERMITIDOS pp 
	on pp.PRODUTO = p.PRODUTO
where p.PRODUTO in ('Z4010173','Z4010168') 


