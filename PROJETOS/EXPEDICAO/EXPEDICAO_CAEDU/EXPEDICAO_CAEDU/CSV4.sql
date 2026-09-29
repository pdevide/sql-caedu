--Z2010276 00042908
select 
v.pedido, vp.pedido, ve.pedido, a.gerado, fp.nf_saida,
'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO,
a.* 
from caedu_reserva_automatica a
left join vendas v on v.pedido=a.venda
left join vendas_produto vp on vp.pedido=a.venda
left join vendas_prod_embalado ve on ve.pedido=a.venda
left join faturamento_prod fp on fp.caixa = a.caixa
where a.pedido = '367212' and ve.pedido is null and fp.caixa is null
--and vp.pedido is not null

--SP - SANTO AMARO
SELECT 
1 AS rownum	
,a.caixa	
,f.filial doca	
,f.clifor as codigo_filial	
,a.filial	
,'W' origem	
,a.DISTRIBUICAO as distribuicao	
,a.produto	
,a.filial as lojadestino	
,filial_origem	
,a.qtde_total	
,1 qtde_pack	
,venda	
,ppp.pack	
,preco1 as custo_1	
,grade	
,erp_qtd_pack	
,1 qtde_packs	
,'00076' cor_produto	
,ppp.qtde	
,ppp.q1	
,ppp.q2	
,ppp.q3	
,ppp.q4	
,ppp.q5	
,ppp.q6	
,ppp.q7	
,ppp.q8	
,ppp.q9	
,ppp.q10	
,ppp.q11	
,ppp.q12	
,ppp.q13	
,ppp.q14	
,ppp.q15	
,ppp.q16	
,1 qtde_total_valor
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
--inner join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
left join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
left join PRODUTOS P ON P.PRODUTO = a.PRODUTO
left join PRODUTOS_PACKS_PERMITIDOS ppp 
			on ppp.produto = a.produto and ppp.pack=a.PACK /*and ppp.cor_produto=a.COR_PRODUTO */
inner join filiais f on f.filial=a.filial
where a.distribuicao = '00042908' and f.clifor='000027'
--a.caixa in  ('31085785','31085921')
--('34546498','34546503','34546506','34546514','34546523')
--(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)
--(select a.caixa
--from caedu_reserva_automatica a
--left join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
--where a.pedido='355770' and b.caixa is null)

(
 '34474090'
,'34474002'
,'34474003'
,'34474004'
,'34474005'
,'34474006'
,'34474007'
,'34474008'
,'34474009'
,'34474010'
,'34474011'
,'34474012'
,'34474013'
,'34474113'
,'34474016'
,'34474017'
,'34474021'
,'34474022'
,'34474023'
,'34474024'
,'34474025'
,'34474026'
,'34474027'
,'34474028'
,'34474029'
,'34474030'
,'34474031'
,'34474032'
,'34474033'
,'34474034'
,'34474035'
,'34474036'
,'34474037'
,'34474101'
,'34474118'
,'34474119'
,'34474114'
,'34474111'
,'34474112'
,'34474047'
,'34474048'
,'34474049'
,'34474050'
,'34474051'
,'34474052'
,'34474105'
,'34474106'
,'34474053'
,'34474054'
,'34474063'
,'34474066'
,'34474070'
,'34474071'
,'34474091'
,'34474092'
,'34474095'
,'34474096'
,'34474099'
,'34474100'
,'34474122'
,'34474123'
,'34474124'
,'34474130'
,'34474127'
,'34474128'
,'34474129'
,'34474125'
,'34474126'
,'34474116'
,'34474117'
,'34474107'
,'34474108'
,'34474109'
,'34474110'
,'34474081'
,'34474082'
,'34474083'
,'34474084'
,'34474088' 
)

--select cor_produto,* from produtos_packs_permitidos where produto = 'Z6020427'

--select * from compras_produto where produto = 'Z6020427'

--select * from faturamento_prod where caixa in ('34201710','34201691','34201714')
--('34201710','CX-34201710'),
--('34201691','CX-34201691'),
--('34201714','CX-34201714')


--delete from VENDAS_PROD_EMBALADO
--where caixa in ('34201710','34201691','34201714')