declare @tabelas table (codigo char(2) not null, descricao varchar(70) null)
declare @i int = 1
declare @codigo char(2)
declare @desctabela varchar(70) 
while @i <= 99
begin 
		set @codigo = right('00' + convert(varchar,@i),2)
		select @desctabela = tabela
		from tabelas_preco where CODIGO_TAB_PRECO = @codigo
		if @@ROWCOUNT>0
		begin
			insert into @tabelas (codigo, descricao) values (@codigo, @desctabela)
		end
		else
		begin
			insert into @tabelas (codigo, descricao) values (@codigo, '<<<<<<<T A B E L A  D I S P O N I V E L>>>>>>>>>')
		end

		set @i = @i + 1
end


select * from @tabelas