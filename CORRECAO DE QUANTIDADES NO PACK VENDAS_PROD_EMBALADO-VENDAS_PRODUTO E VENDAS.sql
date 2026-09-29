
select VE.* 
--UPDATE v SET TOT_QTDE_ORIGINAL = 50, TOT_QTDE_ENTREGAR = 50, TOT_VALOR_ORIGINAL = 50*3.44, TOT_VALOR_ENTREGAR = 50*3.44
--UPDATE Ve SET QTDE_EMBALADA = 50, E1 = 50, VALOR_EMBALADO = 50*3.44
--UPDATE VP SET QTDE_ORIGINAL = 50, QTDE_ENTREGAR=50, VALOR_ORIGINAL = 3.44*50, VALOR_ENTREGAR=3.44*50, VO1=50,VE1=50
from vendas_prod_embalado ve
inner join vendas_produto vp on vp.pedido = ve.PEDIDO
inner join vendas v on v.pedido = ve.PEDIDO
where ve.produto in 
('Z3010073',
'Z3010070',
'Z3010069',
'Z3010066',
'Z3010071',
'Z3010065',
'Z3010065',
'Z3010073')


--vp TOT_QTDE_ORIGINAL = 50, TOT_QTDE_ENTREGAR = 50, TOT_VALOR_ORIGINAL = 50*3.44, TOT_VALOR_ENTREGAR = 50*3.44
--Ve QTDE_EMBALADA = 50, E1 = 50, VALOR_EMBALADO = 50*3.44
--VP QTDE_ORIGINAL = 50, QTDE_ENTREGAR=50, VALOR_ORIGINAL = PRECO1*50, VALOR_ENTREGAR=PRECO1*50, VO1=50,VE1=50, QTDE_LIQUIDA=50,VALOR_LIQUIDO=PRECO1*50

select pp.* 
--update p set ERP_QTD_PACK=50
--update pp set QTDE=50, q1=50
from produtos p 
inner join produtos_packs_permitidos pp 
	on pp.produto = p.produto 
where p.produto in 
('Z3010073',
'Z3010070',
'Z3010069',
'Z3010066',
'Z3010071',
'Z3010065',
'Z3010065',
'Z3010073')

select ccp.* 
--update ccp set qtde=50, q1=50
from compras_produto cp 
inner join compras c 
	on c.pedido = cp.pedido
inner join CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL ccp on ccp.pedido = cp.pedido and ccp.produto = cp.PRODUTO
where cp.produto in 
('Z3010073',
'Z3010070',
'Z3010069',
'Z3010066',
'Z3010071',
'Z3010065',
'Z3010065',
'Z3010073')

