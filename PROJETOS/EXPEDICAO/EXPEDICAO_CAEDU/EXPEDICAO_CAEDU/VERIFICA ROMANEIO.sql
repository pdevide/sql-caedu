/*
with base (pedido,produto,cor_produto, gerado)
as (
	Select pedido, produto, cor_produto, gerado
	from caedu_reserva_automatica a
	where a.caixa in (
 '34625104'
,'34625105'
,'34625153'
,'34625154'
,'34625250'
,'34625251'
,'34625257'
,'34625258'
,'34625308'                                      
        
	)
)

select a.gerado, v.pedido, v.CLIENTE_ATACADO, v.filial, fp.nf_saida, a.* 
from caedu_reserva_automatica a
left join base b on b.pedido=a.pedido
left join vendas v on v.pedido=a.venda
left join faturamento_prod fp on fp.caixa=a.caixa
where a.pedido = b.pedido and v.cliente_atacado is null
*/

with base (distribuicao,produto, gerado)
as (
	Select distribuicao, produto,gerado
	from caedu_reserva_automatica_pack_wms a
	where a.caixa in (
	'34657072','34747956'
	)
)

select a.gerado, v.pedido, v.CLIENTE_ATACADO, v.filial, fp.nf_saida, a.* 
from caedu_reserva_automatica_pack_wms a
left join base b on b.distribuicao=a.distribuicao
left join vendas v on v.pedido=a.venda
left join faturamento_prod fp on fp.caixa=a.caixa
where a.distribuicao = b.distribuicao

