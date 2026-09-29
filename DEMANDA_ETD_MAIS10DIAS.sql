/*
Objetivo: Criar um procedimento (proc) que aceite a data ETA como entrada e preencha automaticamente ambos os campos.

Como usuário do sistema de compras de produtos importados da Linx
Eu quero  que os dados da data ETA sejam integrados ao campo "Entrega" e que, além disso, sejam somados mais 10 dias a esse valor
Para preencher o campo "Limite de Entrega", somar mais 4 dias

Regra:
Campo "Entrega" = Data ETA + 10 dias*
*Caso a data ocorra em um dos seguintes dias da semana: terça, quarta, quinta, sexta ou sábado, deve ser ajustada para segunda-feira anterior\da mesma semana.
*Se a data cair em um domingo, ela deverá ser ajustada para a próxima segunda-feira, ou seja, para o dia seguinte.

Origem: Importsys
Destino: SQL Linx
ERP_CUPS_CHEGADA_PORTO

declare @ret varchar(max)
exec CGP_PRC_CALCULA_DATA_ENTREGA_IMPORTADO '20231001', @ret output
select @ret

*/



create or alter procedure CGP_PRC_CALCULA_DATA_ENTREGA_IMPORTADO

 @ERP_CUPS_CHEGADA_PORTO datetime, 
 @retproc nvarchar(MAX) output

AS
declare @entrega datetime, @limite_entrega datetime, @data1 datetime, @dweek int, @numdias int
set @numdias = case 
				when datepart(dw,@ERP_CUPS_CHEGADA_PORTO) = 1 then 8 
				when datepart(dw,@ERP_CUPS_CHEGADA_PORTO) = 2 then 7
				else 10
				end

set @data1 = dateadd(dd, @numdias, @ERP_CUPS_CHEGADA_PORTO)
set @dweek=datepart(DW,@data1) 

if @dweek <= 2
begin
	if @dweek = 1 --domingo
	begin
		set @data1 = dateadd(dd, 1, @data1)
	end
	else
	begin
		set @data1 = @data1
	end
end
else
begin
	while @dweek>2
	begin
		set @data1 = dateadd(dd, -1, @data1)
		set @dweek = datepart(DW,@data1) 
	end


end

set @entrega = @data1
set @limite_entrega = dateadd(dd, 4, @entrega)

declare @result table
(chegada_porto Datetime, 
 dweek Int, 
 original_chegada_porto_mais_10d Datetime, 
 dweek2 Int,
 entrega Datetime,
 limite_entrega Datetime,
 diferenca Int)

 insert into @result
 select	@ERP_CUPS_CHEGADA_PORTO as CHEGADA_PORTO, 
		DATEPART(DW,@ERP_CUPS_CHEGADA_PORTO) dweek, 
		dateadd(dd, 10, @ERP_CUPS_CHEGADA_PORTO) as original_chegada_porto_mais_10d,
		DATEPART(DW,dateadd(dd, 10, @ERP_CUPS_CHEGADA_PORTO)) dweek2,
		@entrega entrega, 
		@limite_entrega limite_entrega,
		DATEDIFF(DD,@ERP_CUPS_CHEGADA_PORTO,@entrega) AS DIFERENCA

SELECT @retproc = 
(
select	* from @result
		for json auto
)
GO






