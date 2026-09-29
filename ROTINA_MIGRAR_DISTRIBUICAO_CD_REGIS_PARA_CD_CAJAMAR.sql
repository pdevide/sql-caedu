--select * from vendas_prod_embalado where caixa = '12724105'
--select * from faturamento_caixas where caixa = '12724105'
--update vendas set filial = 'CD CAJAMAR' WHERE PEDIDO = 'CX-12724105'
--update vendas_prod_embalado set FILIAL = 'CD CAJAMAR' where CAIXA = '12724105'
--select * from vendas where pedido = 'CX-12724105'

set nocount on
declare @tab01 table (id int identity(1,1), caixa varchar(8), pedido varchar(12))

insert into @tab01 (caixa, pedido) 
select caixa, 'CX-'+caixa as pedido 
from vendas_prod_embalado where filial='CD REGIS'


declare @i int = 1
declare @tot int
select @tot = max(id) from @tab01
declare @caixa varchar(8), @pedido varchar(12)

print @tot

while @i <= @tot
begin

	select @caixa = caixa, @pedido = pedido 
	from @tab01 where id = @i

	print @i

	update vendas 
	set filial = 'CD CAJAMAR' 
	WHERE PEDIDO = @pedido

	if @@ERROR=0
	begin
		update vendas_prod_embalado 
		set FILIAL = 'CD CAJAMAR' 
		where CAIXA = @caixa
	end

	set @i = @i + 1
end

set nocount off

