/*
select t1.packs,pp.* 
--update pp set qtde = 5, q1=5
from produtos_packs_permitidos  pp
inner join (select distinct produto, cor_produto, PACKS 
			from compras_produto where pedido in ('220464','220470','220477','220474','220467','220475','220463')) as t1
			on t1.PRODUTO=pp.PRODUTO and t1.COR_PRODUTO=pp.COR_PRODUTO
where pack = 'A'


update produtos set erp_qtd_pack = 5 where produto = '55060253'
update produtos set erp_qtd_pack = 5 where produto = '55060254'
update produtos set erp_qtd_pack = 10 where produto = '55060255'
update produtos set erp_qtd_pack = 10 where produto = '55060256'
update produtos set erp_qtd_pack = 10 where produto = '55060257'
update produtos set erp_qtd_pack = 10 where produto = '55060258'
update produtos set erp_qtd_pack = 5 where produto = '55060259'

*/

select t1.qtde, cc.* 
--update cc set qtde = t1.qtde, q1 = t1.qtde
from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL cc
inner join (
select pedido,produto,sum(qtde) as qtde, sum(q1) as q1 from 
CAEDU_COMPRAS_PRODUTOS_PACKS
where 
pedido in
('220464'
,'220470'
,'220477'
,'220474'
,'220467'
,'220475'
,'220463')
group by pedido,produto) t1 on t1.PEDIDO = cc.PEDIDO and t1.PRODUTO = cc.PRODUTO


update CAEDU_COMPRAS_PRODUTOS_PACKS
set qtde=5,q1=5
where 
pedido in
('220464'
,'220470'
,'220477'
,'220474'
,'220467'
,'220475'
,'220463')

