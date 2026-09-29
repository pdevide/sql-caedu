select * from caedu_reserva_automatica where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas)     

12050123


select * from VENDAS_PRODUTO 
where pedido in (
select venda from caedu_reserva_automatica where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas))

update VENDAS_PRODUTO set produto = '12050123', COR_PRODUTO='00121'
where pedido in (
select venda from caedu_reserva_automatica where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas))


select * from VENDAS_PROD_EMBALADO
where pedido in (
select venda from caedu_reserva_automatica where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas))

update VENDAS_PROD_EMBALADO set produto = '12050123', COR_PRODUTO='00121'
where pedido in (
select venda from caedu_reserva_automatica where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas))

UPDATE CAEDU_RESERVA_AUTOMATICA
SET PRODUTO = '12050123', cor_produto='00121'
where pedido = '216843E'
and caixa not in (select caixa from #caixasfaturadas)     


--select * from FATURAMENTO_CAIXAS
--where CAIXA in (
--select CAIXA from caedu_reserva_automatica where pedido = '216843E'
--and caixa not in (select caixa from #caixasfaturadas))


00121     
12050123    

select caixa into #caixasfaturadas from faturamento_prod 
where caixa in 
(select caixa from caedu_reserva_automatica where pedido = '216843E')


select * from produto_cores where produto = '12050123'

select * from compras_produto where produto = '12050123'