
select d.chave_nfe, a.pedido_transferencia, b.pedido as pedido_compra, e.* 
from csm_transito_notas a
inner join (
select nf_entrada, nome_clifor, pedido from estoque_prod_ent where pedido in 
('353050-1'
,'353050-2'
,'353050-3'
,'352948')
) b on b.nome_clifor = a.nome_clifor and b.nf_entrada=a.nf_entrada
inner join faturamento_prod c on c.pedido = a.pedido_transferencia
inner join faturamento d 
	on d.nf_saida=c.nf_saida and 
		d.serie_nf=c.serie_nf and d.filial=c.filial
inner join LOJA_ENTRADAS e on e.chave_nfe = d.chave_nfe