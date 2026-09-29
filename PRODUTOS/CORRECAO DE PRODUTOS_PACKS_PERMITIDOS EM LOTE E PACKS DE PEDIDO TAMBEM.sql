declare @tabela table (id int identity(1,1),pedido varchar(12), qtde int)

insert into @tabela values 
('290045',60),
('290046',	60),
('290047',	120),
('290048',	120),
('290049',	60),
('290049E',	60),
('290050',	100),
('290051',	20),
('297821',	12),
('290052',	48),
('290052E',	48)


declare @min int, @max int, @pedido varchar(12), @qtde int, @produto varchar(12)

select @min = min(id), @max = max(id)
from @tabela

--select * from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL a
--inner join @tabela b on b.pedido=a.PEDIDO

select * 
from PRODUTOS_PACKS_PERMITIDOS a
inner join COMPRAS_PRODUTO b on b.PRODUTO=a.PRODUTO
inner join @tabela c on c.pedido = b.PEDIDO

select * 
update a set STATUS_NFE=3, LOG_STATUS_NFE=0
from faturamento a where CHAVE_NFE = '42220946377727001670550020000600001151631065'

/*
while @min <= @max
begin
	
	select @pedido = a.pedido, @qtde = a.qtde, @produto = b.PRODUTO
	from @tabela a
	inner join compras_produto b on b.PEDIDO = a.pedido
	where a.id = @min

	--select @min as min, @pedido as pedido, @qtde as qtde, @produto as PRODUTO

	update PRODUTOS_PACKS_PERMITIDOS set qtde = @qtde, q1=@qtde
	where produto = @produto

	update a set qtde=@qtde, q1 = @qtde
	from CAEDU_COMPRAS_PRODUTOS_PACKS a where pedido = @pedido

	update a set qtde=@qtde, q1 = @qtde
	from CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL a where pedido = @pedido


	set @min = @min + 1

end
*/