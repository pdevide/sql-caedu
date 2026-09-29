select V.*
from pda_wms_tb_embarque a
left join vendas v on v.pedido='CX-'+a.caixa
left join vendas_produto vp on vp.pedido='CX-'+a.caixa
left join vendas_prod_embalado ve on ve.caixa=a.caixa
left join faturamento_caixas fc on fc.caixa=a.caixa
left join faturamento_prod fp on fp.caixa = a.caixa
where 1=1
and faturado=0
and fp.nf_saida is null
and doca like 'limeira pack'


