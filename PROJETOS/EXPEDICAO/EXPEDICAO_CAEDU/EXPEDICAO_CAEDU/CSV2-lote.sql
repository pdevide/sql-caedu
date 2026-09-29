--use CAEDU
-- Tabela temporária global para acumular todos os resultados
set nocount on

IF OBJECT_ID('tempdb..#result') IS NOT NULL
    DROP TABLE #result

declare @result table (
	rownum	int 
	,caixa	varchar(8)
	,doca	varchar(35)
	,codigo_filial	varchar(6)
	,filial	varchar(25)
	,origem	char(1)
	,distribuicao varchar(12)
	,produto varchar(8)	
	,lojadestino	varchar(25)
	,filial_origem	varchar(25)
	,qtde_total	int
	,qtde_pack	int
	,venda varchar(12)	
	,pack	char(1)
	,custo_1	numeric(14,2)
	,grade	varchar(25)
	,erp_qtd_pack int	
	,qtde_packs	int
	,cor_produto	varchar(6)
	,qtde	int
	,q1	int
	,q2	int
	,q3	int
	,q4	int
	,q5	int
	,q6	int
	,q7	int
	,q8	int
	,q9	int
	,q10 int	
	,q11 int	
	,q12 int	
	,q13 int	
	,q14 int	
	,q15 int	
	,q16 int	
	,qtde_total_valor int
)


declare @tabpedido table (
id int identity(1,1) not null primary key,
pedido varchar(12) null
)

insert into @tabpedido (pedido) values ('375786')
insert into @tabpedido (pedido) values ('375786')
insert into @tabpedido (pedido) values ('375788E') 
insert into @tabpedido (pedido) values ('376873')

declare @i int, @tot int, @pedido varchar(12)

select @i = min(id), @tot = max(id) 
from @tabpedido 

while @i <= @tot
begin


	select @pedido = pedido 
	from @tabpedido 
	where id = @i

	INSERT INTO @result
	SELECT 
1 AS rownum	
,a.caixa	
,F.FILIAL AS doca	
,F.COD_FILIAL AS codigo_filial	
,F.filial	
,'P' origem	
,a.pedido as distribuicao	
,a.produto	
,F.filial as lojadestino	
,filial_origem	
,a.qtde_total	
,1 qtde_pack	
,venda	
,ppp.pack	
,preco1 as custo_1	
,grade	
,erp_qtd_pack	
,1 qtde_packs	
,a.cor_produto	
,ppp.qtde	
,ppp.q1	
,ppp.q2	
,ppp.q3	
,ppp.q4	
,ppp.q5	
,ppp.q6	
,ppp.q7	
,ppp.q8	
,ppp.q9	
,ppp.q10	
,ppp.q11	
,ppp.q12	
,ppp.q13	
,ppp.q14	
,ppp.q15	
,ppp.q16	
,1 qtde_total_valor
--update cp set packs='B'
--UPDATE A SET FILIAL = 'SP SH JARDIM ORIENTE'
from caedu_reserva_automatica a
left join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
left join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
left join PRODUTOS P ON P.PRODUTO = a.PRODUTO
left join PRODUTOS_PACKS_PERMITIDOS ppp 
			on ppp.produto = a.produto and ppp.cor_produto=a.COR_PRODUTO and ppp.pack=cp.PACKS
left join FILIAIS F ON F.FILIAL = A.filial
where a.caixa in  

(select a.caixa
from caedu_reserva_automatica a
left join faturamento_prod b on b.caixa = a.caixa
left join vendas_prod_embalado c on c.caixa = a.CAIXA
where a.pedido = @pedido
and b.nf_saida is null and c.pedido is null)

	set @i += 1

end

set nocount off

select * from @result


