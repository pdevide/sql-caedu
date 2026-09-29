declare @tabnotas table (id int identity(1,1), nome_clifor varchar(25), pedido varchar(8), nf_entrada varchar(9), desconto numeric(10,2))
insert into @tabnotas values('ACIL TEXTIL','293669','000064975',142.8)
insert into @tabnotas values('ACIL TEXTIL','294909','000064992',153.6)
insert into @tabnotas values('ACIL TEXTIL','294915','000064979',153.6)
insert into @tabnotas values('ACIL TEXTIL','294921','000064996',153.6)
insert into @tabnotas values('ACIL TEXTIL','294928','000064990',153.6)
insert into @tabnotas values('ACIL TEXTIL','295724','000064994',131.4)
insert into @tabnotas values('ACIL TEXTIL','295729','000064972',131.4)
insert into @tabnotas values('ACIL TEXTIL','295735','000064987',131.4)
insert into @tabnotas values('ACIL TEXTIL','295739','000064977',131.4)
insert into @tabnotas values('ACIL TEXTIL','295744','000064981',131.4)
insert into @tabnotas values('ACIL TEXTIL','295758','000064984',131.4)
insert into @tabnotas values('MKR','292347','000030928',572.4)
insert into @tabnotas values('MKR','292842','000030924',162)
insert into @tabnotas values('MKR','292366','000030921',653.4)
insert into @tabnotas values('MKR','294505','000030926',261)
insert into @tabnotas values('ACIL TEXTIL','293775','000065048',192)
insert into @tabnotas values('ACIL TEXTIL','295750','000065036',131.4)
insert into @tabnotas values('MKR','292473','000030948',594)
insert into @tabnotas values('ACIL TEXTIL','294932','000065128',153.6)
insert into @tabnotas values('ACIL TEXTIL','294937','000065125',153.6)
insert into @tabnotas values('CONFECCOES RUMO CERTO LTD','294596','000024414',370.8)
insert into @tabnotas values('MKR','292607','000030963',198)
insert into @tabnotas values('MKR','292464','000030977',648)
insert into @tabnotas values('MKR','295206','000030972',788.4)
insert into @tabnotas values('MKR','292838','000030984',531)
insert into @tabnotas values('MKR','299944','000030989',135.6)
insert into @tabnotas values('MKR','292871','000030982',496.8)
insert into @tabnotas values('ACIL TEXTIL','293901','000065178',192)
insert into @tabnotas values('MKR','292603','000031023',207.6)
insert into @tabnotas values('MKR','292439','000030980',270)
insert into @tabnotas values('MKR','292370','000031017',572.4)
insert into @tabnotas values('MKR','293604','000031031',428.4)
insert into @tabnotas values('MKR','293806','000031020',324)
insert into @tabnotas values('MKR','299951','000031012',207.6)
insert into @tabnotas values('PAXA','299371','000075244',432)

declare @min int, @max int
declare @nome_clifor varchar(25), @pedido varchar(8), @nf_entrada varchar(9), @desconto numeric(10,2), @SERIE_NF_ENTRADA varchar(3)
declare @CTB_LANCAMENTO int, @CTB_ITEM smallint

declare @fazer bit
set @fazer = 0

select @min = min(id), @max = max(id) 
from @tabnotas


while @min <= @max
begin
	
	select 
	@nome_clifor = a.nome_clifor, @pedido = a.pedido, @nf_entrada = a.nf_entrada, @desconto = a.desconto,
	@serie_nf_entrada = e.SERIE_NF_ENTRADA, @ctb_lancamento = e.CTB_LANCAMENTO, @ctb_item = e.CTB_ITEM 
	from @tabnotas a
	inner join entradas e 
		on e.NOME_CLIFOR = a.nome_clifor and e.NF_ENTRADA=a.nf_entrada
	where a.id = @min

	if @fazer = 1
	begin
		/*atualiza o pedido de compras*/
		update compras set desconto = @desconto, TOT_VALOR_ORIGINAL = (TOT_VALOR_ORIGINAL - @desconto) WHERE PEDIDO = @pedido

		/*zera o lancamento contabil na nota fiscal pra poder excluir o lançamento contabil posteriormente */
		UPDATE A SET A.CTB_ITEM=NULL, CTB_LANCAMENTO =NULL, 
				ERP_EBS_AP_DATA_ENVIO=NULL, ERP_EBS_GL_DATA_ENVIO=NULL, ERP_EBS_SYNCHRO_DATA_ENVIO=NULL
		from entradas A where NF_ENTRADA = @nf_entrada and NOME_CLIFOR=@nome_clifor

		/*exclui o lançamento contabil referente a nota fiscal de entrada */
		delete from ctb_lancamento where LANCAMENTO = @CTB_LANCAMENTO 
	end
	
	/*Integrar as notas de entrada pra gerar o novo lançamento contabil*/
	exec LX_CTB_INTEGRAR_ENTRADA @nome_clifor, @nf_entrada, @SERIE_NF_ENTRADA

	set @min = @min + 1
end


