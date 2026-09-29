select b.doca, a.* 
--update v set TOT_QTDE_ORIGINAL=ve.qtde_embalada, TOT_VALOR_ORIGINAL=ve.VALOR_EMBALADO,
--TOT_QTDE_ENTREGAR=ve.qtde_embalada, TOT_VALOR_ENTREGAR=ve.VALOR_EMBALADO
update b set FATURADO=0
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a 
--left join faturamento_prod b on b.caixa=a.caixa
left join PDA_WMS_TB_EMBARQUE b on b.caixa = a.caixa
--left join vendas_prod_embalado b on b.caixa = a.caixa
--left join vendas v on v.pedido=a.venda
--left join VENDAS_PROD_EMBALADO ve on ve.caixa=a.caixa
left join faturamento_prod fp on fp.caixa=a.caixa
where distribuicao='00042908'
and fp.caixa is null and b.doca is not null


select right(b.caixa,8) as caixa2, b.caixa, a.* 
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a 
left join PDA_WMS_TB_DISTRIBUICAO_COLETA b on right(b.caixa,8) = a.caixa
where a.distribuicao='00042908'


select doca, count(*) as qtd 
from PDA_WMS_TB_EMBARQUE 
where faturado=0
group by doca

select * 
update a set FATURADO=0
from PDA_WMS_TB_EMBARQUE a 
where caixa in ('34702386','34702387')


select v.* 
update v set TOT_QTDE_ORIGINAL=ve.qtde_embalada, TOT_VALOR_ORIGINAL=ve.VALOR_EMBALADO,
TOT_QTDE_ENTREGAR=ve.qtde_embalada, TOT_VALOR_ENTREGAR=ve.VALOR_EMBALADO
from vendas v
inner join vendas_produto vp on vp.pedido=v.pedido
inner join vendas_prod_embalado ve on ve.pedido=v.pedido
where v.pedido in ('cx-34702386','cx-34702387')



