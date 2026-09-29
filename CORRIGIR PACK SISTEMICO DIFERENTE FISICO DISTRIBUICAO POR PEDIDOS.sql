/*
Pedido	Pack
290045	60 - OK
290046	60 - NAO TEM BOX
290047	120 - NAO TEM BOX
290048	120 - NAO TEM BOX
290049	60 - NAO TEM BOX
290049E	60 - NAO TEM BOX
290050	100 - NAO TEM BOX
290051	20 - NAO DEU ENTRADA
297821	12 - NAO DEU ENTRADA
290052	48 - OK
290052E	48 - NAO DEU ENTRADA

select * from VENDAS_PROD_EMBALADO where caixa in (
select caixa from caedu_reserva_automatica 
where pedido in (
select pedido from COMPRAS_PRODUTO 
where pedido in (
'290045',
'290046',
'290047',
'290048',
'290049',
'290049E',
'290050',
'290051',
'297821',
'290052',
'290052E') and pedido in (select pedido from ESTOQUE_PROD_ENT)
))
*/
declare @pedido varchar(12) = '290045'
declare @qtd int = 60
declare @ok bit = 0

select CAST(b.TOT_QTDE_ORIGINAL AS INT) as TOT_QTDE_ORIGINAL, a.* 
from estoque_prod_ent a 
inner join compras b on b.pedido = a.pedido
where a.pedido = @pedido

select * from vendas_prod_embalado
where caixa in (
select caixa from caedu_reserva_automatica where pedido = @pedido
)

select *
from CAEDU_COMPRAS_PRODUTOS_PACKS a where pedido = @pedido

select *
from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL a where pedido = @pedido

if @ok = 1
begin
	update a set a.e1 = @qtd, a.VALOR_EMBALADO = a.preco1 * @qtd, a.QTDE_EMBALADA = @qtd
	from vendas_prod_embalado A
	where caixa in (
	select caixa from caedu_reserva_automatica where pedido = @pedido
	)

	update a set a.QTDE_CAIXA = @qtd
	from FATURAMENTO_CAIXAS a 
	where caixa in (
	select caixa from caedu_reserva_automatica where pedido = @pedido
	)

	update a set qtde=@qtd, q1 = @qtd
	from CAEDU_COMPRAS_PRODUTOS_PACKS a where pedido = @pedido

	update a set qtde=@qtd, q1 = @qtd
	from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL a where pedido = @pedido

end

select * 
from PRODUTOS_PACKS_PERMITIDOS
where produto in (select produto from COMPRAS_PRODUTO where pedido = @pedido)

