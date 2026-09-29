declare @pedidos table (pedido varchar(12))

--insert into @pedidos (pedido) values ('353806V')
--insert into @pedidos (pedido) values ('353835')  
--insert into @pedidos (pedido) values ('359389E') 
--insert into @pedidos (pedido) values ('359959V')
--insert into @pedidos (pedido) values ('360842')  
--insert into @pedidos (pedido) values ('361850')  
--insert into @pedidos (pedido) values ('361858')  
--insert into @pedidos (pedido) values ('361862')  
--insert into @pedidos (pedido) values ('361871')  
--insert into @pedidos (pedido) values ('366951')  
--insert into @pedidos (pedido) values ('367952')  
insert into @pedidos (pedido) values ('359027')  

	select 
	v.pedido, vp.pedido, ve.pedido, a.gerado, fp.nf_saida,
	'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO,
	a.* 
	from caedu_reserva_automatica a
	left join vendas v on v.pedido=a.venda
	left join vendas_produto vp on vp.pedido=a.venda
	left join vendas_prod_embalado ve on ve.pedido=a.venda
	left join faturamento_prod fp on fp.caixa = a.caixa
	where a.pedido in (select pedido from @pedidos)
	and ve.pedido is null 
	and fp.caixa is null
	--and vp.pedido is not null
	order by a.filial

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
	from caedu_reserva_automatica a
	inner join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
	left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
	inner join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
	inner join PRODUTOS P ON P.PRODUTO = a.PRODUTO
	inner join PRODUTOS_PACKS_PERMITIDOS ppp 
				on ppp.produto = a.produto and ppp.cor_produto=a.COR_PRODUTO and ppp.pack=cp.PACKS
	inner join filiais f on f.filial=a.filial
	where a.caixa in ('34657045','34657073')
	--('34214649','34214650','34242770','34242771','34242772','34242773','34255785','34264571','34264572','34276026','34276027')
	--(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)
	--(select a.caixa
	--from caedu_reserva_automatica a
	--left join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
	--where a.pedido='355770' and b.caixa is null)
	(
	select a.caixa
	from caedu_reserva_automatica a
	left join vendas v on v.pedido=a.venda
	left join vendas_produto vp on vp.pedido=a.venda
	left join vendas_prod_embalado ve on ve.pedido=a.venda
	left join faturamento_prod fp on fp.caixa = a.caixa
	where a.pedido in (select pedido from @pedidos)
	and ve.pedido is null 
	and fp.caixa is null)
	order by a.filial

--and a. caixa in ('34426808','34426809','34426810')

--select cor_produto,* from produtos_packs_permitidos where produto = 'Z6020427'

--select * from compras_produto where produto = 'Z6020427'

--select * from faturamento_prod where caixa in ('34201710','34201691','34201714')
--('34201710','CX-34201710'),
--('34201691','CX-34201691'),
--('34201714','CX-34201714')


--delete from VENDAS_PROD_EMBALADO
--where caixa in ('34201710','34201691','34201714')