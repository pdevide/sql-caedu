

select *
--update a set QTDE_TOTAL=12
from caedu_reserva_automatica_pack_wms a
where distribuicao = '00005738'

select * from VENDAS_PRODUTO where produto = '44020147'
and pedido in 
(select venda from caedu_reserva_automatica_pack_wms a where distribuicao = '00005738')

select count(*) 
--delete b
from caedu_reserva_automatica_pack_wms a (nolock) 
inner join vendas b (nolock) on b.PEDIDO=a.VENDA
where distribuicao = '00005738'

update caedu_reserva_automatica_pack_wms set GERADO=0
where distribuicao = '00005738'

exec lx_gera_vendas_wms '00005738'

select b.*
--into #faturamento_caixas_bkp

from faturamento_caixas b 
inner join caedu_reserva_automatica_pack_wms a
on b.CAIXA = a.CAIXA
where a.distribuicao = '00005738'

SELECT SUM(QTDE_TOTAL) from caedu_reserva_automatica_pack_wms where distribuicao = '00005738'

select * from faturamento_prod where caixa in (
select caixa from caedu_reserva_automatica_pack_wms where distribuicao = '00005738')

select 2110*12