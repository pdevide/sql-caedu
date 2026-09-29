--Z2010276 00042908
--367363E1 e 367485E1
select 
v.pedido, vp.pedido, ve.pedido, a.gerado, fp.nf_saida,
'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO,
a.* 
from caedu_reserva_automatica a
left join vendas v on v.pedido=a.venda
left join vendas_produto vp on vp.pedido=a.venda
left join vendas_prod_embalado ve on ve.pedido=a.venda
left join faturamento_prod fp on fp.caixa = a.caixa
where a.pedido = '367485E1' and ve.pedido is null and fp.caixa is null
--and vp.pedido is not null

--SP - SANTO AMARO
SELECT 
1 AS rownum	
,a.caixa	
,f.filial doca	
,f.clifor as codigo_filial	
,a.filial	
,'P' origem	
,a.pedido as distribuicao	
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
,a.cor_produto	
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
from CAEDU_RESERVA_AUTOMATICA a
--inner join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
--left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
left join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
left join PRODUTOS P ON P.PRODUTO = a.PRODUTO
left join PRODUTOS_PACKS_PERMITIDOS ppp on ppp.produto = a.produto and ppp.cor_produto=a.COR_PRODUTO 
inner join filiais f on f.filial=a.filial
where a.pedido = '367485E1' and f.clifor = '000027'

and a.caixa in 
(
 '36053357'
,'36053358'
,'36053359'
,'36053360'
,'36053361'
,'36053362'
,'36053363'
,'36053364'
,'36053365'
,'36053366'
,'36053367'
,'36053368'
,'36053369'
,'36053370'
,'36053371'
,'36053372'
,'36053373'
,'36053538'
,'36053551'
,'36053560'
,'36053561'
,'36053566'
,'36053341'
,'36053342'
,'36053343'
,'36053344'
,'36053345'
,'36053346'
,'36053347'
,'36053348'
,'36053349'
,'36053350'
,'36053351'
,'36053352'
,'36053353'
,'36053354'
,'36053355'
,'36053356'
,'36053374'
,'36053375'
,'36053376'
,'36053377'
,'36053378'
,'36053379'
,'36053380'
,'36053381'
,'36053511'
,'36053512'
,'36053513'
,'36053514'
,'36053515'
,'36053553'
,'36053554'
,'36053555'
,'36053382'
,'36053383'
,'36053384'
,'36053385'
,'36053386'
,'36053387'
,'36053388'
,'36053389'
,'36053390'
,'36053391'
,'36053392'
,'36053393'
,'36053394'
,'36053395'
,'36053396'
,'36053397'
,'36053398'
,'36053399'
,'36053400'
,'36053401'
,'36053402'
,'36053403'
,'36053404'
,'36053405'
,'36053406'
,'36053407'
,'36053408'
,'36053409'
,'36053410'
,'36053411'
,'36053412'
,'36053413'
,'36053414'
,'36053501'
,'36053502'
,'36053503'
,'36053504'
,'36053505'
,'36053506'
,'36053507'
,'36053508'
,'36053509'
,'36053510'
,'36053532'
,'36053533'
,'36053534'
,'36053557'
,'36053558'
,'36053559'
,'36053571'
,'36053572'
,'36053573'
,'36053574'
,'36053587'
,'36053588'
,'36053589'
,'36053590'
,'36053591'
,'36053592'
,'36053593'
,'36053415'
,'36053416'
,'36053417'
,'36053419'
,'36053420'
,'36053421'
,'36053422'
,'36053423'
,'36053424'
,'36053425'
,'36053426'
,'36053427'
,'36053428'
,'36053429'
,'36053430'
,'36053431'
,'36053432'
,'36053433'
,'36053434'
,'36053435'
,'36053436'
,'36053437'
,'36053438'
,'36053439'
,'36053440'
,'36053441'
,'36053442'
,'36053443'
,'36053444'
,'36053445'
,'36053446'
,'36053447'
,'36053448'
,'36053449'
,'36053450'
,'36053451'
,'36053452'
,'36053453'
,'36053454'
,'36053455'
,'36053456'
,'36053457'
,'36053458'
,'36053459'
,'36053460'
,'36053461'
,'36053462'
,'36053463'
,'36053464'
,'36053465'
,'36053466'
,'36053467'
,'36053468'
,'36053469'
,'36053470'
,'36053471'
,'36053472'
,'36053473'
,'36053474'
,'36053475'
,'36053476'
,'36053477'
,'36053478'
,'36053479'
,'36053480'
,'36053481'
,'36053482'
,'36053483'
,'36053484'
,'36053485'
,'36053486'
,'36053487'
,'36053488'
,'36053489'
,'36053490'
,'36053491'
,'36053492'
,'36053493'
,'36053516'
,'36053517'
,'36053518'
,'36053519'
,'36053520'
,'36053521'
,'36053522'
,'36053523'
,'36053524'
,'36053525'
,'36053526'
,'36053527'
,'36053528'
,'36053529'
,'36053530'
,'36053531'
,'36053535'
,'36053536'
,'36053537'
,'36053539'
,'36053540'
,'36053541'
,'36053542'
,'36053552'
,'36053562'
,'36053563'
,'36053564'
,'36053565'
,'36053567'
,'36053568'
,'36053569'
,'36053570'
,'36053575'
,'36053576'
,'36053577'
,'36053578'
,'36053579'
,'36053580'
,'36053581'
,'36053582'
,'36053583'
,'36053584'
,'36053585'
,'36053586'
,'36053594'
,'36053595'
,'36053596'
,'36053600'
,'36053601'
,'36053494'
,'36053495'
,'36053496'
,'36053497'
,'36053498'
,'36053499'
,'36053500')


--a.caixa in  ('31085785','31085921')
--('34546498','34546503','34546506','34546514','34546523')
--(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)
--(select a.caixa
--from caedu_reserva_automatica a
--left join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
--where a.pedido='355770' and b.caixa is null)


--select cor_produto,* from produtos_packs_permitidos where produto = 'Z6020427'

--select * from compras_produto where produto = 'Z6020427'

--select * from faturamento_prod where caixa in ('34201710','34201691','34201714')
--('34201710','CX-34201710'),
--('34201691','CX-34201691'),
--('34201714','CX-34201714')


--delete from VENDAS_PROD_EMBALADO
--where caixa in ('34201710','34201691','34201714')