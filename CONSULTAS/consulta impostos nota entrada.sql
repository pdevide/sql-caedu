SET NOCOUNT ON
DECLARE @TABIMPOSTO2 TABLE 
(codigo_item varchar(12) null,
desc_produto varchar(40) null,
erp_desc_licenciado  varchar(50) null,
erp_tema_licenciado varchar(50) null,
nome_clifor VARCHAR(50) NULL,
nf_entrada VARCHAR(15) NULL,      
serie_nf_entrada VARCHAR(6) NULL, 
item_impressao varchar(4) null,
sub_item_tamanho int null,
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

DECLARE @NOTAS TABLE (
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
,nome_clifor varchar(25)
,nf_entrada varchar(9)
,serie_nf_entrada varchar(6)
,recebimento datetime)

INSERT INTO @NOTAS
SELECT nome_clifor,nf_entrada,serie_nf_entrada,recebimento
FROM ENTRADAS 
WHERE NATUREZA='200.01' 
AND RECEBIMENTO>'20231231' AND RECEBIMENTO<getdate()+1
ORDER BY RECEBIMENTO


declare		@nome_clifor varchar(25)
			,@nf_entrada varchar(9)
			,@serie_nf_entrada varchar(6)
			,@i int
			,@tot int

select @i=min(id), @tot=max(id)
from @notas

while @i <= @tot
begin

	--PRINT @i
	select 
		@nome_clifor=n.nome_clifor,
		@nf_entrada=n.nf_entrada,
		@serie_nf_entrada=n.serie_nf_entrada
	from @notas n
	where id=@i

	;WITH baseimposto (codigo_item,desc_produto,erp_desc_licenciado,erp_tema_licenciado,nome_clifor, nf_entrada, serie_nf_entrada,
						item_impressao, sub_item_tamanho, id_imposto, imposto, taxa_imposto, valor_imposto, base_imposto,
						taxa_imposto_calc, valor_imposto_calc, base_imposto_calc)
	as
	(
	SELECT		   entradas_item.CODIGO_ITEM,
				   p.desc_produto,
				   p.ERP_DESC_LICENCIADO,
				   p.ERP_TEMA_LICENCIADO,
				   entradas_imposto.nome_clifor,
				   entradas_imposto.nf_entrada,
				   entradas_imposto.serie_nf_entrada,
				   entradas_imposto.item_impressao,
				   entradas_imposto.sub_item_tamanho,
				   entradas_imposto.id_imposto,
				   ctb_lx_imposto_tipo.imposto,
				   entradas_imposto.taxa_imposto,
				   entradas_imposto.valor_imposto,
				   entradas_imposto.base_imposto,
				   entradas_imposto.taxa_imposto_calc,
				   entradas_imposto.valor_imposto_calc,
				   entradas_imposto.base_imposto_calc
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
		INNER JOIN PRODUTOS P ON P.PRODUTO=ENTRADAS_ITEM.CODIGO_ITEM
		WHERE 
		entradas_imposto.nome_clifor = @nome_clifor
		AND        entradas_imposto.nf_entrada = @nf_entrada
		AND        entradas_imposto.serie_nf_entrada = @serie_nf_entrada)


	insert into @TABIMPOSTO2
	(codigo_item,desc_produto,erp_desc_licenciado,erp_tema_licenciado,nome_clifor,nf_entrada,      
	serie_nf_entrada, item_impressao,sub_item_tamanho,TAXA_ICMS,BASE_ICMS,                            
	VALOR_ICMS,BASE_ICMS_CALC,VALOR_ICMS_CALC,TAXA_IPI,BASE_IPI,VALOR_IPI,BASE_IPI_CALC,                       
	VALOR_IPI_CALC,TAXA_PIS,BASE_PIS,VALOR_PIS,BASE_PIS_CALC,VALOR_PIS_CALC,TAXA_COFINS,                            
	BASE_COFINS,VALOR_COFINS,BASE_COFINS_CALC,VALOR_COFINS_CALC)
	select	codigo_item,
			desc_produto,
			erp_desc_licenciado,
			erp_tema_licenciado,
			nome_clifor, 
			nf_entrada, 
			serie_nf_entrada,
			item_impressao, 
			sub_item_tamanho, 
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
	from baseimposto
	group by codigo_item,
			desc_produto,
			erp_desc_licenciado,
			erp_tema_licenciado,
			nome_clifor, 
			nf_entrada, 
			serie_nf_entrada,
			item_impressao, 
			sub_item_tamanho 
	order by 
			item_impressao, 
			sub_item_tamanho 

	set @i += 1
end

SELECT  
	STUFF((
		SELECT DISTINCT ';' + RTRIM(CAST(A.PEDIDO AS VARCHAR))
		FROM estoque_prod_ent a
		INNER JOIN estoque_prod1_ent b 
			ON b.romaneio_produto = a.romaneio_produto 
			AND b.filial = a.FILIAL
		WHERE a.nome_clifor = IMP.nome_clifor
			AND a.nf_entrada = IMP.nf_entrada
			AND a.serie_nf_entrada = IMP.serie_nf_entrada
			AND b.PRODUTO = IMP.codigo_item
		FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS PEDIDOS,
		P.GRIFFE, P.LINHA, P.GRUPO_PRODUTO,	P.SUBGRUPO_PRODUTO, P.GRADE,
imp.*, E.RECEBIMENTO, E.DATA_DIGITACAO, E.EMISSAO, E.CHAVE_NFE, E.FILIAL AS FILIAL_ENTRADA,
E.DESCONTO AS DESCONTO_NOTA, E.VALOR_SUB_ITENS AS VALOR_BRUTO
FROM @TABIMPOSTO2 IMP
INNER JOIN ENTRADAS E ON E.NF_ENTRADA=IMP.NF_ENTRADA 
							AND E.SERIE_NF_ENTRADA=IMP.serie_nf_entrada
							AND E.NOME_CLIFOR=IMP.nome_clifor
INNER JOIN PRODUTOS P ON P.PRODUTO = IMP.codigo_item



SET NOCOUNT OFF
