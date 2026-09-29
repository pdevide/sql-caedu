

--select * from produtos_barra where CODIGO_BARRA='34016207901'



--select * 
--update compras set STATUS_COMPRA='01'
--from compras where pedido = '308589V'

update produtos set DATA_PARA_TRANSFERENCIA = getdate() where produto in (

select t.PRODUTO
from (
select p.PRODUTO, p.DESC_PRODUTO, p01.preco1 'Original', p19.preco1 'Maua', pCC.PRECO1 'CC', 
isnull((select sum(estoque) from estoque_produtos where produto = p.produto),0) as estoque_geral
--update pcc set preco1 = p01.preco1
from produtos p
left join produtos_precos p01 on p01.PRODUTO=p.PRODUTO and p01.CODIGO_TAB_PRECO='01'
left join produtos_precos p19 on p19.PRODUTO=p.PRODUTO and p19.CODIGO_TAB_PRECO='19'
left join produtos_precos pCC on pCC.PRODUTO=p.PRODUTO and pCC.CODIGO_TAB_PRECO='CC'
) as t
where t.estoque_geral<>0)



select count(*) from produtos where DATA_PARA_TRANSFERENCIA>='2022-11-21 00:49'
--select * from _CONTROLE_CHAVE order by 5 desc

--select * from TABELAS_PRECO where tabela like '%maua%'


select * from update pda_wms_tb_embarque set faturado=1 where caixa = '22329094'