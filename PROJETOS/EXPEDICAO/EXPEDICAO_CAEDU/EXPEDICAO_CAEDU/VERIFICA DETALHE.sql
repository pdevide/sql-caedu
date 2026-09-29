select ve.*
--a.caixa, a.DOCA, v.filial, v.FILIAL_DIGITACAO,  v.CLIENTE_ATACADO,fc.NOME_CLIFOR, ve.NOME_CLIFOR, ve.FILIAL
--,'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO
--update v set APROVACAO='A', FILIAL='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE'
--update ve set FILIAL='CD - SP - SAO ROQUE'
--UPDATE V SET APROVACAO='A', CLIENTE_ATACADO='SAO MATHEUS', 
--REPRESENTANTE='SAO MATHEUS', NOME_CLIFOR_ENTREGA='SAO MATHEUS', GERENTE='SAO MATHEUS'
--UPDATE VE SET NOME_CLIFOR='SAO MATHEUS',REPRESENTANTE='SAO MATHEUS'
--update fc SET NOME_CLIFOR='SAO MATHEUS', NOME_CLIFOR_ENTREGA='SAO MATHEUS'
--update a set FATURADO=0
from PDA_WMS_TB_EMBARQUE a
left join vendas v on v.pedido='CX-'+a.caixa
LEFT JOIN VENDAS_PRODUTO VP ON VP.PEDIDO='CX-'+a.caixa
left join VENDAS_PROD_EMBALADO ve on ve.caixa=a.caixa
left join faturamento_caixas fc on fc.caixa=a.CAIXA
where 1=1 and a.FATURADO=0 
--and a.caixa in ('33101275')
and a.caixa in ('31085785','31085921')
--and a.caixa in (select x.caixa from PDA_WMS_TB_EMBARQUE x 
--					left join vendas_prod_embalado b on b.caixa=x.caixa 
--					where x.FATURADO=0 and b.caixa is null)
--and a.doca like 'MG RUA UBERLANDIA CT PACK'
--and a.caixa in (select caixa from caedu_reserva_automatica where pedido='349195-1')
--and a.doca like 'sao matheus%' 

--and (v.filial  <> 'CD - SP - SAO ROQUE' or ve.FILIAL <> 'CD - SP - SAO ROQUE')
--and v.CLIENTE_ATACADO <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--AND VE.NOME_CLIFOR <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--and fc.NOME_CLIFOR  <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')


/* RETIRAR O QUE JA ESTA FATURADO
select * 
--update a set FATURADO=1
from PDA_WMS_TB_EMBARQUE a
left join vendas v on v.pedido='CX-'+a.caixa
LEFT JOIN VENDAS_PRODUTO VP ON VP.PEDIDO='CX-'+a.caixa
left join VENDAS_PROD_EMBALADO ve on ve.caixa=a.caixa
left join faturamento_caixas fc on fc.caixa=a.CAIXA
left join faturamento_prod fp on fp.caixa=a.caixa
where 1=1 and a.FATURADO=0 and fp.nf_saida is not null
*/