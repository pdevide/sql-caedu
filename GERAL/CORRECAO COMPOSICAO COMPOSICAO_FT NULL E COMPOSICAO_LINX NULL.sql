declare @nEmpresa int, @NOVO_CODIGO_1 varchar(6), @NOVO_CODIGO_3 varchar(6), @codigo char(6)

declare @tabmatriz table (
rownum int identity(1,1) not null primary key,
codigo char(6) not null,
descricao varchar(50) not null,
id_dominio char(3) not null,
desc_dominio varchar(20) not null,
ERP_CUPS_DESCRICAO_IMPORTACAO varchar(50) null,
COMPOSICAO_LINX char(6) null,
COMPOSICAO_FT char(6) null
)
insert into @tabmatriz (codigo,descricao,id_dominio,desc_dominio,ERP_CUPS_DESCRICAO_IMPORTACAO,
						COMPOSICAO_LINX,COMPOSICAO_FT)
select codigo,
descricao,
id_dominio,
desc_dominio,
ERP_CUPS_DESCRICAO_IMPORTACAO,
COMPOSICAO_LINX,
COMPOSICAO_FT
from CAEDU_LISTA_COMBO a
where a.id_dominio='005' and a.COMPOSICAO_LINX is null and a.COMPOSICAO_FT is null

declare @linha int, @totlinha int, @descricao varchar(50)

select @linha=min(rownum), @totlinha=max(rownum) from @tabmatriz

while @linha <= @totlinha
begin
	
	select @codigo=codigo, @descricao=descricao
	from @tabmatriz
	where rownum = @linha

	set @nEmpresa = 1
	SET @NOVO_CODIGO_1 = '' /* sequencial materiais_composicao*/
	EXEC LX_SEQUENCIAL 'MATERIAIS_COMPOSICAO.COMPOSICAO', @nEmpresa, @NOVO_CODIGO_1 OUTPUT  

	/* sequencial para novo item na ficha tecnica */
	select @NOVO_CODIGO_3 = right('000000' + convert(varchar,MAX(cast(codigo as int)) + 1),6)
	from CGP_FICHA_TECNICA_ITENS 

	insert into MATERIAIS_COMPOSICAO 
	(COMPOSICAO, DESC_COMPOSICAO, DATA_PARA_TRANSFERENCIA, INATIVA)
	values (@NOVO_CODIGO_1, @descricao, GETDATE(), 0)

	INSERT INTO CGP_FICHA_TECNICA_ITENS (CODIGO, DESCRICAO, CODIGO_FT, INATIVO)
	values (@NOVO_CODIGO_3, @descricao, '0005', 0)

	UPDATE CAEDU_LISTA_COMBO 
	SET COMPOSICAO_LINX = @NOVO_CODIGO_1, COMPOSICAO_FT = @NOVO_CODIGO_3
	WHERE CODIGO = @codigo

	set @linha = @linha + 1
end


