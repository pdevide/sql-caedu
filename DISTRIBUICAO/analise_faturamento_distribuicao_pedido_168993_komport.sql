select * from compras_produto where pedido in ( '168993', '168993E')


select * from estoque_prod_ent a 
inner join estoque_prod1_ent b on b.romaneio_produto = a.romaneio_produto and b.filial = a.filial
where a.pedido in ('168993', '168993E')

select * from vendas_prod_embalado where caixa in (
select caixa from caedu_reserva_automatica where pedido in ('168993', '168993E') )


select b.* from entradas a 
INNER JOIN ENTRADAS_PRODUTO b on 
	b.nf_entrada = a.nf_entrada and b.serie_nf_entrada = a.SERIE_NF_ENTRADA and b.NOME_CLIFOR = a.NOME_CLIFOR
where a.nf_entrada = '000226417' and a.serie_nf_entrada = '001' and a.NOME_CLIFOR = 'KOMPORT' and b.pedido in ( '168993', '168993E')

select * from FATURAMENTO_CAIXAS where caixa in (
select caixa from caedu_reserva_automatica where pedido in ('168993', '168993E'))

select * from faturamento_prod where caixa in (
select caixa from FATURAMENTO_CAIXAS where caixa in (
select caixa from caedu_reserva_automatica where pedido in ('168993', '168993E'))
)


select * from cadastro_cli_for where nome_clifor like '%plano serv%'



select * from prop_produtos where propriedade in ('00098','00099')


select * from propriedade where propriedade = '00098'

produtos
inner join prop_produtos on prop_produtos.produto = produtos.produto and prop_produtos.propriedade = '00098' as xuxa