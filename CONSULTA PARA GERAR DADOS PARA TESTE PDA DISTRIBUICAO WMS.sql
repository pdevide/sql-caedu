with basewms (distribuicao,qtdlinhas,caixas_faturadas,qtd_em_box)
as (
select a.DISTRIBUICAO, 
count(distinct a.caixa) as qtdlinhas,
count(f.caixa) as caixas_faturadas,
count(v.caixa) as qtd_em_box
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
left join faturamento_prod f on f.caixa=a.caixa
left join vendas_prod_embalado v on v.caixa=a.caixa
where a.data>'20250403' and a.data<'20250416'
group by a.DISTRIBUICAO
having count(f.caixa)=0)

select a.*,
(select top 1 convert(varchar,data,103) 
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao=a.distribuicao) as data_distribuicao
from basewms a
order by 1,2

update caedu_reserva_automatica set data='20250701'
where pedido in 
('335706'  
,'339213'  
,'340554'  
,'346298'  
,'346387'  
,'347540')  


update caedu_reserva_automatica_pack_wms set data='20250701'
where distribuicao in
('00033705'
,'00033706'
,'00033707'
,'00033709'
,'00033710'
,'00033713'
,'00033715'
,'00033716'
,'00033717')
		  