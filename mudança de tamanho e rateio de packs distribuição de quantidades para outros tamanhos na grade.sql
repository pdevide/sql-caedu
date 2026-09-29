--23030724
/*
Pedido:23030725
Tamanho	10	12	14	16
Físico 	0	4	4	2     ====> ok ajustado

Pedido:18030318
Tamanho	4	6	8	10
Físico 	2	4	4	0

Pedido:18030317
Tamanho	4	6	8	10
Físico 	2	4	4	0

1) Descreva abaixo sua Requisição ou Incidente:
Bom dia poderia por gentileza corrigir a distribuição do pedido 275709, 275710 ambas o pack fisico é com 10.
grade 2-4, 4-6, 4-8
2) Anexe o "Print do Incidente" ou "Formulário de Requisição".

*/


select * 
from caedu_reserva_automatica a 
--inner join faturamento_prod b on b.caixa = a.caixa
where a.produto = '18030318'



select p.grade,pp.* 
--UPDATE P SET ERP_QTD_PACK=10
--UPDATE PP SET Q7=0,Q6=4,Q5=4,Q4=2, QTDE=10
from produtos p 
inner join PRODUTOS_PACKS_PERMITIDOS pp 
	on pp.PRODUTO=p.PRODUTO 
where p.PRODUTO in ('63020711')

select A.PEDIDO, CP.* 
from estoque_prod_ent A 
INNER JOIN estoque_prod1_ent B 
	ON B.ROMANEIO_PRODUTO=A.ROMANEIO_PRODUTO AND B.FILIAL=A.FILIAL
INNER JOIN COMPRAS_PRODUTO CP ON CP.PEDIDO = A.PEDIDO AND CP.PRODUTO=B.PRODUTO AND CP.COR_PRODUTO=B.COR_PRODUTO
where A.nf_entrada = '000034105' and A.filial = 'CD NAVEGANTES'


SELECT B.* 
--update b set en_4=9, en_5=9,en_6=9,en_7=9, en_8=0, en_9=0, en_10=0
FROM ESTOQUE_PROD_ENT A
INNER JOIN ESTOQUE_PROD1_ENT B 
	ON B.ROMANEIO_PRODUTO=A.ROMANEIO_PRODUTO AND B.FILIAL=A.FILIAL
WHERE NF_ENTRADA = '000034105' 
	AND A.FILIAL IN ('CD NAVEGANTES','VENDA ATACADO SC') 


--select b.* 
----update b set co7=0, co8=648,co9=648,co10=324
--from estoque_prod1_ent b 
--inner join estoque_prod_ent a 
--	on a.ROMANEIO_PRODUTO=b.ROMANEIO_PRODUTO and a.FILIAL=b.FILIAL
--where produto = '23030725'

select * 
--update cp set co7=0, co6=706,co5=706,co4=352
from compras_produto cp
inner join compras c on c.pedido = cp.PEDIDO 
where cp.produto  and cp.pedido in  ('275709', '275710')


select filial, count(*) as qtd  
from faturamento 
where status_nfe = 1 and emissao = '20220420'
group by filial



select * 
--UPDATE A SET Q7=0,Q6=4,Q5=4,Q4=2, QTDE=10
from CAEDU_COMPRAS_PRODUTOS_PACKS A
where pedido in ('275709','275710')




SELECT B.*
--update b set en_7=0, en_6=200,en_5=200,en_4=200
FROM ESTOQUE_PROD_ENT A
INNER JOIN ESTOQUE_PROD1_ENT B 
	ON B.ROMANEIO_PRODUTO=A.ROMANEIO_PRODUTO AND B.FILIAL=A.FILIAL
WHERE NF_ENTRADA = '000053340' 
	AND A.FILIAL IN ('CD BARRA VELHA') 


SELECT B.* 
update b set en7=0, en6=12,en5=12,en4=12
FROM LOJA_ENTRADAS A
INNER JOIN LOJA_ENTRADAS_PRODUTO B ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO AND B.FILIAL=A.FILIAL
WHERE A.ROMANEIO_NF_SAIDA='000053341' AND A.FILIAL='CD BARRA VELHA'



select * 
update f set status_nfe=3, LOG_STATUS_NFE=0
from faturamento f where nf_saida = '000054976' and status_nfe=2


select * 
--UPDATE A SET es4=9, es5=9,es6=9,es7=9, es8=0, es9=0, es10=0
UPDATE A SET es4=0, es5=0,es6=0,es7=9, es8=9, es9=9, es10=9
from estoque_produtos A 
where filial='CD BARRA VELHA' AND PRODUTO = '63020711'

select b.* 

update b set en4=9, en5=9,en6=9,en7=9, en8=0, en9=0, en10=0
from LOJA_ENTRADAS a
inner join LOJA_ENTRADAS_PRODUTO b on b.ROMANEIO_PRODUTO=a.ROMANEIO_PRODUTO and b.FILIAL=a.FILIAL
where NUMERO_NF_TRANSFERENCIA='000055712' and a.ROMANEIO_PRODUTO='A0564212'

select * from CSM_TRANSITO_NOTAS where NF_ENTRADA='000034105' 

