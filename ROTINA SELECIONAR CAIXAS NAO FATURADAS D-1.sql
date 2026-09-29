
set nocount on 

declare @caixas table (rownum int not null identity (1,1) primary key, 
						caixa varchar(8), doca varchar(35), codigo_filial varchar(6), data datetime)
insert into @caixas (caixa, doca, codigo_filial, data)
select a.caixa, a.doca, a.CODIGO_FILIAL, data
from pda_wms_tb_embarque a
left join faturamento_prod b on b.caixa = a.caixa 
where 1=1
and b.caixa is null
and a.data>'20250101' and a.data<convert(varchar,getdate()+1,112)
and a.FATURADO=1

declare @tb_romaneios table 
(
rownum int ,
caixa varchar(8) not null primary key, 
doca varchar(35), 
codigo_filial varchar(6),
filial varchar(25),
origem char(1),
distribuicao varchar(8),	
produto	varchar(8),
lojadestino	varchar(25), 
filial_origem varchar(25),	
qtde_total	int,
qtde_pack int,	
venda varchar(12),	
pack char(1),	
CUSTO_1	numeric(14,2),
GRADE varchar(25),	
ERP_QTD_PACK int,	
qtde_packs int, 	
COR_PRODUTO	varchar(5),
QTDE int,	
Q1	 int,
Q2	 int,
Q3	 int,
Q4	 int,
Q5	int,
Q6	int,
Q7	int,
Q8	int,
Q9	int,
Q10	int,
Q11	int,
Q12	int,
Q13	int,
Q14	int,
Q15	int,
Q16	int
)

declare
		@caixa varchar(8), @doca varchar(35), @codigo_filial varchar(6),@filial varchar(25),@origem char(1),
		@distribuicao varchar(8), @produto	varchar(8), @lojadestino	varchar(25), @filial_origem varchar(25),	
		@qtde_total	int,@qtde_pack int,	@venda varchar(12),	@pack char(1),	@CUSTO_1	numeric(14,2),
		@GRADE varchar(25),	@ERP_QTD_PACK int,	@qtde_packs int, 	@COR_PRODUTO	varchar(5),
		@QTDE int,	@Q1	 int,@Q2	 int,@Q3	 int,@Q4	 int,@Q5	int,@Q6	int,@Q7	int,@Q8	int,
		@Q9	int,@Q10	int,@Q11	int,@Q12	int,@Q13	int,@Q14	int,@Q15	int,@Q16	int

declare @i int, @tot int

select @i=min(rownum), @tot=max(rownum) 
from @caixas

while @i<=@tot
begin
	
	select	@caixa = caixa, 
			@doca = doca,	
			@filial = F.filial,
			@filial_origem = 'CD - SP - SAO ROQUE',
			@lojadestino = F.filial
	from @caixas a
	inner join filiais f on f.cod_filial = a.codigo_filial
	where rownum = @i

	insert into @tb_romaneios (rownum, caixa,doca,filial,filial_origem,lojadestino)
	values (@i,@caixa,@doca,@filial,@filial_origem,@lojadestino)

	if exists(select 1 from caedu_reserva_automatica where caixa = @caixa)
	begin

		update a 
		set origem = 'P',
			produto = b.produto, 
			COR_PRODUTO=b.cor_produto,
			qtde_total=b.qtde_total, 
			qtde_pack=b.qtde_pack,
			venda=b.VENDA,
			distribuicao=b.pedido,
			erp_qtd_pack=p.erp_qtd_pack,
			grade=p.grade,
			CUSTO_1=pp.preco1
		from @tb_romaneios a
		inner join caedu_reserva_automatica b on b.caixa = a.caixa
		inner join produtos p on p.produto = b.produto
		inner join produtos_precos pp on pp.produto = b.produto and pp.CODIGO_TAB_PRECO='02'
		
	end

	if exists(select 1 from CAEDU_RESERVA_AUTOMATICA_PACK_WMS where caixa = @caixa)
	begin

		update a 
		set origem = 'W',
			produto = b.produto, 
			qtde_total=b.qtde_total, 
			qtde_pack=b.qtde_pack,
			venda=b.VENDA, 
			pack=b.PACK,
			distribuicao=b.DISTRIBUICAO,
			erp_qtd_pack=p.erp_qtd_pack,
			grade=p.grade,
			CUSTO_1=pp.preco1
		from @tb_romaneios a
		inner join CAEDU_RESERVA_AUTOMATICA_PACK_WMS b on b.caixa = a.caixa
		inner join produtos p on p.produto = b.produto
		inner join produtos_precos pp on pp.produto = b.produto and pp.CODIGO_TAB_PRECO='02'
	end

	if exists(select 1 from [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] WHERE CAIXA = @caixa)
	begin

		update a 
		set origem = 'Z',
			produto = b.produto, 
			qtde_total=b.QUANTIDADE, 
			qtde_pack=1,
			venda='CX-'+@caixa, 
			pack=b.PACK,
			distribuicao=b.DISTRIBUICAO,
			erp_qtd_pack=p.erp_qtd_pack,
			grade=p.grade,
			CUSTO_1=pp.preco1
		from @tb_romaneios a
		inner join [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] b on b.caixa = a.caixa
		inner join produtos p on p.produto = b.produto
		inner join produtos_precos pp on pp.produto = b.produto and pp.CODIGO_TAB_PRECO='02'
	end

	set @i=@i+1
end

--insert into [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250609
select b.data,a.*, cast(0 as bit) as FATURADO 
--into [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250609
from @tb_romaneios a
inner join @caixas b on b.caixa=a.caixa
where origem is not null
and a.caixa not in (select caixa from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250609)
order by origem, doca

set nocount off
