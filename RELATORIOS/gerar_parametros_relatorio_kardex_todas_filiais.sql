declare @saida table (FILIAL VARCHAR(25), PRODUTO CHAR(12), COR_PRODUTO CHAR(10))

declare @produtos table (regn int identity(1,1) not null, produto char(12), cor_produto char(10))

declare @filiais table (regn int identity(1,1) not null, filial varchar(25))

insert into @produtos
select distinct produto, cor_produto from produto_cores 
where produto in (
'06100941'
,'13080883'
,'18050178'
,'45072059'
,'62080176'
,'70055324'
,'70055331'
,'75012180'
)

insert into @filiais
select filial from filiais order by filial

declare @i int = 1
declare @totfilial int
declare @filial varchar(25)

declare @ii int = 1
declare @totprodutos int 
declare @produto char(12)
declare @cor_produto char(10)

select @totprodutos = max(regn) from @produtos

select @totfilial = max(regn) from @filiais

while @i <= @totfilial
begin
	select @filial = filial from @filiais where regn = @i

	set @ii = 1
	while @ii <= @totprodutos
	begin
		
		select @produto = produto, @cor_produto = cor_produto 
		from @produtos where regn = @ii
		insert into @saida (FILIAL, PRODUTO, COR_PRODUTO) values (@filial, @produto, @cor_produto)
		set @ii = @ii + 1
	end

	set @i = @i + 1
end

select * from @saida
