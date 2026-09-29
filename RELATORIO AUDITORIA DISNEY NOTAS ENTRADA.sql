set nocount on

DECLARE @PEDIDOS TABLE (ID INT IDENTITY(1,1) PRIMARY KEY,ERP_DESC_LICENCIADO VARCHAR(50),PEDIDO VARCHAR(12),ENTREGA DATETIME)
INSERT INTO @PEDIDOS (ERP_DESC_LICENCIADO,PEDIDO,ENTREGA)
select B.ERP_DESC_LICENCIADO,A.PEDIDO, A.ENTREGA 
from COMPRAS_PRODUTO a
inner join produtos b on b.produto=a.PRODUTO
where 1=1
--isnull(b.ERP_DESC_LICENCIADO,'') <> '' 
AND a.ENTREGA>'20211231' 
and a.PEDIDO in (select pedido 
from estoque_prod_ent epe 
inner join entradas e on e.NOME_CLIFOR=epe.NOME_CLIFOR and e.NF_ENTRADA=epe.NF_ENTRADA and e.SERIE_NF_ENTRADA=epe.SERIE_NF_ENTRADA
where e.NATUREZA='200.01' and epe.pedido = a.PEDIDO)
order by ENTREGA

declare @pedido varchar(12) 

DECLARE @TABIMPOSTO TABLE 
(PEDIDO VARCHAR(12) NULL,
nome_clifor VARCHAR(40) NULL,
nf_entrada VARCHAR(9) NULL,      
serie_nf_entrada VARCHAR(6) NULL, 
DESCONTO NUMERIC(14,5) NULL,
VALOR_SUB_ITENS  NUMERIC(14,2) NULL,
ID_IMPOSTO INT NULL, 
IMPOSTO VARCHAR(20) NULL,                   
TAXA_IMPOSTO NUMERIC(14,5) NULL,                            
BASE_IMPOSTO NUMERIC(14,2) NULL,                            
VALOR_IMPOSTO NUMERIC(14,2) NULL,                           
BASE_IMPOSTO_CALC NUMERIC(14,2) NULL,                       
VALOR_IMPOSTO_CALC NUMERIC(14,2) NULL
)

DECLARE @TABIMPOSTO2 TABLE 
(PEDIDO VARCHAR(12) NULL,
nome_clifor VARCHAR(40) NULL,
nf_entrada VARCHAR(9) NULL,      
serie_nf_entrada VARCHAR(6) NULL, 
DESCONTO NUMERIC(14,5) NULL,
VALOR_BRUTO  NUMERIC(14,2) NULL,
TAXA_ICMS NUMERIC(14,5) NULL,                            
BASE_ICMS NUMERIC(14,2) NULL,                            
VALOR_ICMS NUMERIC(14,2) NULL,                           
BASE_ICMS_CALC NUMERIC(14,2) NULL,                       
VALOR_ICMS_CALC NUMERIC(14,2) NULL,
TAXA_IPI NUMERIC(14,5) NULL,                            
BASE_IPI NUMERIC(14,2) NULL,                            
VALOR_IPI NUMERIC(14,2) NULL,                           
BASE_IPI_CALC NUMERIC(14,2) NULL,                       
VALOR_IPI_CALC NUMERIC(14,2) NULL,
TAXA_PIS NUMERIC(14,5) NULL,                            
BASE_PIS NUMERIC(14,2) NULL,                            
VALOR_PIS NUMERIC(14,2) NULL,                           
BASE_PIS_CALC NUMERIC(14,2) NULL,                       
VALOR_PIS_CALC NUMERIC(14,2) NULL,
TAXA_COFINS NUMERIC(14,5) NULL,                            
BASE_COFINS NUMERIC(14,2) NULL,                            
VALOR_COFINS NUMERIC(14,2) NULL,                           
BASE_COFINS_CALC NUMERIC(14,2) NULL,                       
VALOR_COFINS_CALC NUMERIC(14,2) NULL)

declare @nome_clifor varchar(25), @nf_entrada varchar(9), @serie_nf_entrada varchar(6)

declare @i int, @tot int

select	@i = min(id), 
		@tot = max(id) 
from @PEDIDOS

while @i <= @tot
begin

	select	@pedido = pedido 
	from @PEDIDOS 
	where id = @i

	select	@nome_clifor = epe.NOME_CLIFOR, 
			@nf_entrada = epe.NF_ENTRADA, 
			@serie_nf_entrada = epe.serie_nf_entrada
	from estoque_prod_ent epe
	inner join entradas e 
		on e.NF_ENTRADA=epe.NF_ENTRADA and e.SERIE_NF_ENTRADA=epe.SERIE_NF_ENTRADA and e.nome_clifor=epe.NOME_CLIFOR
	where pedido = @pedido and e.NATUREZA='200.01'

	; with V_ENTRADAS_00_IMPOSTO (nome_clifor,nf_entrada,serie_nf_entrada,item_impressao,sub_item_tamanho,agrega_apos_desconto,
								taxa_imposto,valor_imposto,base_imposto,taxa_imposto_espelho,valor_imposto_espelho,base_imposto_espelho,
								agrega_apos_encargo,id_imposto,imposto,incidencia,taxa_imposto_calc,valor_imposto_calc,base_imposto_calc,
								codigo_item,descricao_item,valor_min_arrecadacao,valor_max_arrecadacao,valida_valor_parcela,codigo_fiscal_operacao,
								valor_imposto_parcela,porc_recuperacao,codigo_classe_tributacao,porcent_reducao_de_base,base_imposto_sred,taxa_imposto_xml,
								valor_imposto_xml,base_imposto_xml)
	as(
	SELECT     entradas_imposto.nome_clifor,
			   entradas_imposto.nf_entrada,
			   entradas_imposto.serie_nf_entrada,
			   entradas_imposto.item_impressao,
			   entradas_imposto.sub_item_tamanho,
			   entradas_imposto.agrega_apos_desconto,
			   entradas_imposto.taxa_imposto,
			   entradas_imposto.valor_imposto,
			   entradas_imposto.base_imposto,
			   entradas_imposto.taxa_imposto_espelho,
			   entradas_imposto.valor_imposto_espelho,
			   entradas_imposto.base_imposto_espelho,
			   entradas_imposto.agrega_apos_encargo,
			   entradas_imposto.id_imposto,
			   ctb_lx_imposto_tipo.imposto,
			   entradas_imposto.incidencia,
			   entradas_imposto.taxa_imposto_calc,
			   entradas_imposto.valor_imposto_calc,
			   entradas_imposto.base_imposto_calc,
			   entradas_item.codigo_item,
			   entradas_item.descricao_item,
			   Isnull(ctb_excecao_imposto_item.valor_min_arrecadacao, ctb_lx_imposto_tipo.valor_min_arrecadacao) AS valor_min_arrecadacao,
			   Isnull(ctb_excecao_imposto_item.valor_max_arrecadacao, ctb_lx_imposto_tipo.valor_max_arrecadacao) AS valor_max_arrecadacao,
			   Isnull(ctb_excecao_imposto_item.valida_valor_parcela, ctb_lx_imposto_tipo.valida_valor_parcela)   AS valida_valor_parcela,
			   entradas_item.codigo_fiscal_operacao,
			   entradas_imposto.valor_imposto_parcela,
			   Cast(Isnull(ctb_excecao_imposto_item.porc_recuperacao, 100) AS NUMERIC(13,10)) AS porc_recuperacao,
			   ctb_excecao_imposto.codigo_classe_tributacao,
			   Cast(Isnull(ctb_excecao_imposto_item.porcent_reducao_de_base, 0) AS NUMERIC(13,10)) AS porcent_reducao_de_base,
			   Cast(0 AS                                                           NUMERIC(15,2))  AS base_imposto_sred,
			   entradas_imposto.taxa_imposto_xml,
			   entradas_imposto.valor_imposto_xml,
			   entradas_imposto.base_imposto_xml
	FROM       ctb_lx_imposto_tipo
	INNER JOIN entradas_imposto
	ON         ctb_lx_imposto_tipo.id_imposto = entradas_imposto.id_imposto
	INNER JOIN entradas_item
	ON         entradas_imposto.item_impressao = entradas_item.item_impressao
	AND        entradas_imposto.sub_item_tamanho = entradas_item.sub_item_tamanho
	AND        entradas_imposto.nf_entrada = entradas_item.nf_entrada
	AND        entradas_imposto.nome_clifor = entradas_item.nome_clifor
	AND        entradas_imposto.serie_nf_entrada = entradas_item.serie_nf_entrada
	LEFT JOIN  ctb_excecao_imposto_item
	ON         entradas_item.id_excecao_imposto = ctb_excecao_imposto_item.id_excecao_imposto
	AND        entradas_imposto.id_imposto = ctb_excecao_imposto_item.id_imposto
	LEFT JOIN  ctb_excecao_imposto
	ON         entradas_item.id_excecao_imposto = ctb_excecao_imposto.id_excecao_imposto
	WHERE      entradas_imposto.nome_clifor = @nome_clifor
	AND        entradas_imposto.nf_entrada = @nf_entrada
	AND        entradas_imposto.serie_nf_entrada = @serie_nf_entrada)

	INSERT INTO @TABIMPOSTO
	SELECT  @pedido as PEDIDO,
			V_ENTRADAS_00_IMPOSTO.nome_clifor,
			V_ENTRADAS_00_IMPOSTO.nf_entrada,
			V_ENTRADAS_00_IMPOSTO.serie_nf_entrada,
			E.DESCONTO,
			E.VALOR_SUB_ITENS,
			V_ENTRADAS_00_IMPOSTO.ID_IMPOSTO,
			V_ENTRADAS_00_IMPOSTO.IMPOSTO,
			max(taxa_imposto) as TAXA_IMPOSTO,
		   SUM(V_ENTRADAS_00_IMPOSTO.BASE_IMPOSTO) AS BASE_IMPOSTO,
		   SUM(V_ENTRADAS_00_IMPOSTO.VALOR_IMPOSTO) AS VALOR_IMPOSTO,
		   SUM(V_ENTRADAS_00_IMPOSTO.BASE_IMPOSTO_CALC) AS BASE_IMPOSTO_CALC,
		   SUM(V_ENTRADAS_00_IMPOSTO.VALOR_IMPOSTO_CALC) AS VALOR_IMPOSTO_CALC
	FROM V_ENTRADAS_00_IMPOSTO
	INNER JOIN ENTRADAS E 
		ON  E.NF_ENTRADA=V_ENTRADAS_00_IMPOSTO.nf_entrada 
			AND E.SERIE_NF_ENTRADA=V_ENTRADAS_00_IMPOSTO.serie_nf_entrada 
			AND E.NOME_CLIFOR=V_ENTRADAS_00_IMPOSTO.nome_clifor
	WHERE E.NATUREZA='200.01'
	GROUP BY	V_ENTRADAS_00_IMPOSTO.nome_clifor,
				V_ENTRADAS_00_IMPOSTO.nf_entrada,
				V_ENTRADAS_00_IMPOSTO.serie_nf_entrada,
				E.DESCONTO,
				E.VALOR_SUB_ITENS,
				V_ENTRADAS_00_IMPOSTO.ID_IMPOSTO,
				V_ENTRADAS_00_IMPOSTO.IMPOSTO

	INSERT INTO @TABIMPOSTO2
	SELECT	MAX(PEDIDO) AS PEDIDO,
			MAX(NOME_CLIFOR) AS NOME_CLIFOR,
			MAX(nf_entrada) AS NF_ENTRADA,
			MAX(SERIE_NF_ENTRADA) AS SERIE_NF_ENTRADA,
			MAX(DESCONTO) AS DESCONTO,
			MAX(VALOR_SUB_ITENS) AS VALOR_BRUTO,
			max(case WHEN id_imposto=1 then TAXA_IMPOSTO else 0 end) as TAXA_ICMS,	
			SUM(case WHEN id_imposto=1 then BASE_IMPOSTO else 0 end) as BASE_ICMS,	
			SUM(case WHEN id_imposto=1 then VALOR_IMPOSTO else 0 end) as VALOR_ICMS,	
			SUM(case WHEN id_imposto=1 then BASE_IMPOSTO_CALC else 0 end) as BASE_ICMS_CALC,	
			SUM(case WHEN id_imposto=1 then VALOR_IMPOSTO_CALC else 0 end) as VALOR_ICMS_CALC,	
			max(case WHEN id_imposto=2 then TAXA_IMPOSTO else 0 end) as TAXA_IPI,	
			SUM(case WHEN id_imposto=2 then BASE_IMPOSTO else 0 end) as BASE_IPI,	
			SUM(case WHEN id_imposto=2 then VALOR_IMPOSTO else 0 end) as VALOR_IPI,	
			SUM(case WHEN id_imposto=2 then BASE_IMPOSTO_CALC else 0 end) as BASE_IPI_CALC,	
			SUM(case WHEN id_imposto=2 then VALOR_IMPOSTO_CALC else 0 end) as VALOR_IPI_CALC,	
			max(case WHEN id_imposto=5 then TAXA_IMPOSTO else 0 end) as TAXA_PIS,	
			SUM(case WHEN id_imposto=5 then BASE_IMPOSTO else 0 end) as BASE_PIS,	
			SUM(case WHEN id_imposto=5 then VALOR_IMPOSTO else 0 end) as VALOR_PIS,	
			SUM(case WHEN id_imposto=5 then BASE_IMPOSTO_CALC else 0 end) as BASE_PIS_CALC,	
			SUM(case WHEN id_imposto=5 then VALOR_IMPOSTO_CALC else 0 end) as VALOR_PIS_CALC,	
			max(case WHEN id_imposto=6 then TAXA_IMPOSTO else 0 end) as TAXA_COFINS,	
			SUM(case WHEN id_imposto=6 then BASE_IMPOSTO else 0 end) as BASE_COFINS,	
			SUM(case WHEN id_imposto=6 then VALOR_IMPOSTO else 0 end) as VALOR_COFINS,	
			SUM(case WHEN id_imposto=6 then BASE_IMPOSTO_CALC else 0 end) as BASE_COFINS_CALC,	
			SUM(case WHEN id_imposto=6 then VALOR_IMPOSTO_CALC else 0 end) as VALOR_COFINS_CALC	
	FROM @TABIMPOSTO
	WHERE PEDIDO=@pedido
	set @i += 1

end

SELECT A.*, 
	CONVERT(VARCHAR(10),B.RECEBIMENTO,103) as recebimento, 
	CONVERT(VARCHAR(10),B.EMISSAO,103) as emissao, 
	CONVERT(VARCHAR(10),B.DATA_DIGITACAO,103) as data_digitacao, 
	B.CHAVE_NFE, 
	B.FILIAL as filial_entrada
FROM @TABIMPOSTO2 A
inner join ENTRADAS B ON B.NOME_CLIFOR=A.nome_clifor AND B.NF_ENTRADA=A.nf_entrada AND B.SERIE_NF_ENTRADA=A.serie_nf_entrada 
where pedido is not null

set nocount off
