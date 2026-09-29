--287504 e 287504V. 274177/273916/276939

select a.* 
from recebimento_pedido a 
inner join recebimento_produto b on b.id = a.recebimento_produto_id
where pedido = '276939'
--a.recebimento_produto_id = 127205
go

select * from recebimento_produto where id = 127205
go

delete from recebimento_produto where id = 127205
go

select * from recebimento_pedido where pedido = '273916'
go

delete from recebimento_pedido where pedido = '273916'
go

select a.QUANTIDADE_AGENDAMENTO,* 
from caedu.dbo.compras  a
where a.PEDIDO = '273916'
go

select a.QUANTIDADE_AGENDAMENTO,* 
from caedu.dbo.COMPRAS_PRODUTO  a
where a.PEDIDO = '273916'
go
