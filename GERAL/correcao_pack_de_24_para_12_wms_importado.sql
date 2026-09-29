select a.pedido, a.emissao, b.* 
from estoque_prod1_ent b 
inner join estoque_prod_ent a 
	on a.ROMANEIO_PRODUTO = b.ROMANEIO_PRODUTO and b.filial = a.FILIAL 
where b.produto in 
('M3020008'
,'M3020009'
,'M3020010'
,'M3020011'
,'M3020012')


select grade, * from produtos 
where produto in 
('M3020008'
,'M3020009'
,'M3020010'
,'M3020011'
,'M3020012')

select * from produtos_packs_permitidos
where produto in 
('M3020008'
,'M3020009'
,'M3020010'
,'M3020011'
,'M3020012')


select * from CAEDU_COMPRAS_PRODUTOS_PACKS where pedido in (
'219155E' 
,'219155' 
,'219156'  
,'219157'  
,'219157E' 
,'219158'  
,'219159')


select * from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL where pedido in (
'219155E' 
,'219155' 
,'219156'  
,'219157'  
,'219157E' 
,'219158'  
,'219159')


--update PRODUTOS_PACKS_PERMITIDOS
--set qtde=12, q2=1, q3=2, q4=3, q5=3, q6=2, q7=1
--where 
--produto in 
--('M3020008'
--,'M3020009'
--,'M3020010'
--,'M3020011'
--,'M3020012') 

--update produtos set ERP_QTD_PACK=12
--where produto in 
--('M3020008'
--,'M3020009'
--,'M3020010'
--,'M3020011'
--,'M3020012')

--update CAEDU_COMPRAS_PRODUTOS_PACKS
--set qtde=12, q2=1, q3=2, q4=3, q5=3, q6=2, q7=1
--where pedido in (
--'219155E' 
--,'219155' 
--,'219156'  
--,'219157'  
--,'219157E' 
--,'219158'  
--,'219159')

--update CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL
--set qtde=12, q2=1, q3=2, q4=3, q5=3, q6=2, q7=1
--where pedido in (
--'219155E' 
--,'219155' 
--,'219156'  
--,'219157'  
--,'219157E' 
--,'219158'  
--,'219159')

select pedido, TOT_QTDE_ORIGINAL, ERP_TOTAL_QTD_DISTRIB, ERP_TOTAL_CAIXAS_ORIGINAL from compras
where pedido in (
'219155E' 
,'219155' 
,'219156'  
,'219157'  
,'219157E' 
,'219158'  
,'219159')


update compras set ERP_TOTAL_QTD_DISTRIB = 654, ERP_TOTAL_CAIXAS_ORIGINAL = 654 where pedido = '219155';
update compras set ERP_TOTAL_QTD_DISTRIB = 12, ERP_TOTAL_CAIXAS_ORIGINAL = 12 where pedido = '219155E ';
update compras set ERP_TOTAL_QTD_DISTRIB = 670, ERP_TOTAL_CAIXAS_ORIGINAL = 670 where pedido = '219156';
update compras set ERP_TOTAL_QTD_DISTRIB = 664, ERP_TOTAL_CAIXAS_ORIGINAL = 664 where pedido = '219157';
update compras set ERP_TOTAL_QTD_DISTRIB = 12, ERP_TOTAL_CAIXAS_ORIGINAL = 12 where pedido = '219157E ';
update compras set ERP_TOTAL_QTD_DISTRIB = 660, ERP_TOTAL_CAIXAS_ORIGINAL = 660 where pedido = '219158';
update compras set ERP_TOTAL_QTD_DISTRIB = 674, ERP_TOTAL_CAIXAS_ORIGINAL = 674 where pedido = '219159';
