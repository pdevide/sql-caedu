with base (distribuicao, qtd_caixas)

as
(
select cra.pedido as distribuicao, count(cra.caixa) as qtd_caixas 
from caedu_reserva_automatica cra
where cra.caixa in (
select a.caixa
from pda_wms_tb_embarque a
where a.faturado=0 )
and isnull(cra.gerado,0) = 0
group by cra.pedido

UNION ALL

select crw.distribuicao as distribuicao, count(crw.caixa) as qtd_caixas 
from caedu_reserva_automatica_pack_wms crw
where crw.caixa in (
select a.caixa
from pda_wms_tb_embarque a
where a.faturado=0 )
and isnull(crw.gerado,0) = 0
group by crw.distribuicao
)

select *, 
(select count(*) from caedu_reserva_automatica where pedido = base.distribuicao) as qtd_total_pedido,
(select count(*) from caedu_reserva_automatica_pack_wms where distribuicao = base.distribuicao) as qtd_total_wms
from base
