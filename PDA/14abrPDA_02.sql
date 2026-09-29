SELECT *
from vendas_prod_embalado where caixa  in
 (
select a.CAIXA
from [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a
left join faturamento_prod fp on fp.caixa = a.caixa
where a.lojadestino is not null and fp.caixa is null and a.lojadestino not like 'POS%') 

/*vendas_prod_embalado*/
--37085 trazendo tudo
--34958 tirando lojadestino nula

/*faturadas 33766*/
/*nao faturadas diferente de POS% 20655 */
/* 19670 de 20655 já tem box */


delete from vendas where pedido = 'CX-31169625' 