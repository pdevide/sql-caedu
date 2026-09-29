--00034725
--00034418
--00034020

select * from vendas_prod_embalado where caixa in (
select caixa
from caedu_reserva_automatica_pack_wms
where distribuicao = '00034725')