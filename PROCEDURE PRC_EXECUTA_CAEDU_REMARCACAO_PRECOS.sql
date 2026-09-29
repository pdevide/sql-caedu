--select * from dbo.CAEDU_REMARCACAO_PRECOS where PROCESS_ID='00000031'
--select * from dbo.CAEDU_REMARCACAO_PRECOS_ITENS where PROCESS_ID='00000031'

CREATE OR ALTER PROCEDURE PRC_EXECUTA_CAEDU_REMARCACAO_PRECOS
/**
** PROCEDURE PRC_EXECUTA_CAEDU_REMARCACAO_PRECOS
** AUTOR....: PAULO EDUARDO DEVIDE
** CRIADO EM: 30/08/2024
** OBJETIVO.: PEGAR OS PROCESSOS DE AGENDAMENTO DE REMARCAÇÃO DE PREÇOS E EFETIVAR A ATUALIZAÇÃO 
**				DOS PREÇOS NA TABELA PRODUTOS_PRECOS DO LINX CONFORME A PARAMETRIZAÇÃO DO USUÁRIO
**/
AS
BEGIN
	set nocount on

	declare @data date, @hora int, @ativo bit, @PROCESS_ID CHAR(8), @min int, @max int, @data_exec datetime 
	/*pega a hora do sistema getdate()*/
	select @hora = DATEPART(hh,getdate()), @data = CONVERT(varchar,getdate(),112)

	/*verifica se este horario está ativo para processamento*/
	select @ativo = ativo from dbo.CAEDU_REMARCACAO_PRECOS_HORARIOS
	WHERE HORA = @hora

	if @ativo=0
	begin
		return /*Não executa o processamento, horário não está ativo */
	end

	declare @tab_chaves table (ID INT IDENTITY(1,1), PROCESS_ID CHAR(8))
	INSERT INTO @tab_chaves (PROCESS_ID)
	select PROCESS_ID
	from dbo.CAEDU_REMARCACAO_PRECOS a
	where (cast(CONVERT(varchar,scheduling_date,23)+' '+SCHEDULING_TIME+':00.000' as datetime)  <= GETDATE())
	and ISNULL(EXECUTION_DATE_TIME,'')=''

	select @min=MIN(id), @max=MAX(id)
	from @tab_chaves

	while @min <= @max
	begin
		select @PROCESS_ID = PROCESS_ID
		from @tab_chaves
		where ID = @min

		select @data_exec = GETDATE()
		/*descarrega os preços da tabela CAEDU_REMARCACAO_PRECOS_ITENS 
			na PRODUTOS_PRECOS nos produto e codigo de tabela correspondentes 
			para o PROCESS_ID lido
		*/
		UPDATE a SET PRECO1_ANTERIOR = a.PRECO1, DATA_CARGA_PRECOS=@data_exec, PRECO1 = b.PRECO1
		from dbo.PRODUTOS_PRECOS a
		inner join dbo.CAEDU_REMARCACAO_PRECOS_ITENS b
			on b.PRODUTO=a.PRODUTO and b.CODIGO_TAB_PRECO=a.CODIGO_TAB_PRECO
		where b.PROCESS_ID=@PROCESS_ID

		/*atualiza a tabela pai CAEDU_REMARCACAO_PRECOS com data/hora da execução e encerra o processo*/
		UPDATE dbo.CAEDU_REMARCACAO_PRECOS
		SET EXECUTION_DATE_TIME = @data_exec 
		WHERE PROCESS_ID = @PROCESS_ID
		
		print @PROCESS_ID + ' executado com sucesso! as '+ cast(@data_exec as varchar)
		set @min = @min + 1
	end
	set nocount off

END
