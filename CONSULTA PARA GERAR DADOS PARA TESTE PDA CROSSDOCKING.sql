with basepedido (filial_a_entregar,pedido,qtdlinhas,caixas_faturadas,qtd_em_box)
as (
select c.FILIAL_A_ENTREGAR, c.pedido, 
count(distinct a.caixa) as qtdlinhas,
count(f.caixa) as caixas_faturadas,
count(v.caixa) as qtd_em_box
from compras c
inner join caedu_reserva_automatica a
	on a.pedido=c.pedido
left join faturamento_prod f on f.caixa=a.caixa
left join vendas_prod_embalado v on v.caixa=a.caixa
where a.data>'20250403' and a.data<'20250416'
and c.TOT_QTDE_ENTREGAR=0
group by c.FILIAL_A_ENTREGAR, c.pedido
having count(f.caixa)=0)

select a.*,
(select top 1 convert(varchar,data,103) 
from caedu_reserva_automatica 
where pedido=a.pedido) as data_distribuicao
from basepedido a
order by 1,2
