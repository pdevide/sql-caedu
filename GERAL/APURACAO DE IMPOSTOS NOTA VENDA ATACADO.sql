declare @filial varchar(25), @nf_saida varchar(9), @serie_nf varchar(6) 
SELECT 
@filial = 'VENDA ATACADO SAO ROQUE',
@nf_saida = '000000016',
@serie_nf = '4'

; WITH baseimposto  (filial, nf_saida, serie_nf, item_impressao, sub_item_tamanho, id_imposto,
						agrega_apos_desconto, taxa_imposto, incidencia, valor_imposto, valor_imposto_calculado,
						base_imposto, agrega_apos_encargo, lancamento_ctb_item, imposto, codigo_item,
						descricao_item, porc_recuperacao, calculo_decimal, codigo_fiscal_operacao,
						valor_min_arrecadacao,valor_max_arrecadacao,valida_valor_parcela,valor_item,
						porcent_reducao_de_base,base_imposto_calc)
	as
	(SELECT faturamento_imposto.filial,
			  faturamento_imposto.nf_saida,
			  faturamento_imposto.serie_nf,
			  faturamento_imposto.item_impressao,
			  faturamento_imposto.sub_item_tamanho,
			  faturamento_imposto.id_imposto,
			  faturamento_imposto.agrega_apos_desconto,
			  faturamento_imposto.taxa_imposto,
			  faturamento_imposto.incidencia,
			  faturamento_imposto.valor_imposto,
			  faturamento_imposto.valor_imposto_calculado,
			  faturamento_imposto.base_imposto,
			  faturamento_imposto.agrega_apos_encargo,
			  faturamento_imposto.lancamento_ctb_item,
			  ctb_lx_imposto_tipo.imposto,
			  faturamento_item.codigo_item,
			  faturamento_item.descricao_item,
			  ctb_excecao_imposto_item.porc_recuperacao,
			  ctb_lx_imposto_tipo.calculo_decimal,
			  faturamento_item.codigo_fiscal_operacao,
			  CASE
						WHEN Isnull(ctb_excecao_imposto_item.valor_min_arrecadacao,0)=0 THEN Isnull(ctb_lx_imposto_tipo.valor_min_arrecadacao,0)
						ELSE ctb_excecao_imposto_item.valor_min_arrecadacao
			  END AS valor_min_arrecadacao,
			  CASE
						WHEN Isnull(ctb_excecao_imposto_item.valor_max_arrecadacao,0)=0 THEN Isnull(ctb_lx_imposto_tipo.valor_max_arrecadacao,0)
						ELSE ctb_excecao_imposto_item.valor_max_arrecadacao
			  END       AS valor_max_arrecadacao,
			  Isnull(ctb_excecao_imposto_item.valida_valor_parcela,Isnull(ctb_lx_imposto_tipo.valida_valor_parcela,0)) AS valida_valor_parcela,
			  faturamento_item.valor_item,
			  Isnull(ctb_excecao_imposto_item.porcent_reducao_de_base,0) porcent_reducao_de_base,
			  faturamento_imposto.base_imposto_calc
	FROM      faturamento_imposto
	LEFT JOIN faturamento_item
	ON        faturamento_imposto.filial = faturamento_item.filial
	AND       faturamento_imposto.nf_saida = faturamento_item.nf_saida
	AND       faturamento_imposto.serie_nf = faturamento_item.serie_nf
	AND       faturamento_imposto.item_impressao = faturamento_item.item_impressao
	AND       faturamento_imposto.sub_item_tamanho = faturamento_item.sub_item_tamanho
	JOIN      ctb_lx_imposto_tipo
	ON        faturamento_imposto.id_imposto = ctb_lx_imposto_tipo.id_imposto
	LEFT JOIN ctb_excecao_imposto_item
	ON        faturamento_item.id_excecao_imposto=ctb_excecao_imposto_item.id_excecao_imposto
	AND       faturamento_imposto.id_imposto=ctb_excecao_imposto_item.id_imposto
	WHERE     faturamento_imposto.filial = @filial
	AND       faturamento_imposto.nf_saida = @nf_saida
	AND       faturamento_imposto.serie_nf = @serie_nf)

--select * from baseimposto


select  
		a.filial,
		a.nf_saida,
		a.serie_nf, 
		f.NOME_CLIFOR,
		f.EMISSAO,
		a.item_impressao,
		a.sub_item_tamanho,
		a.codigo_item as produto,
		a.descricao_item as desc_produto,
		p.griffe,
		p.linha,
		p.grupo_produto,
		p.subgrupo_produto,
		p.erp_desc_licenciado,
		p.erp_tema_licenciado,
--		
		max(valor_item) as VALOR_ITEM,	
		max(case WHEN id_imposto=1 then TAXA_IMPOSTO else 0 end) as TAXA_ICMS,
		max(case WHEN id_imposto=1 then agrega_apos_desconto else 0 end) as AGREGA_APOS_DESCONTO_ICMS,
		SUM(case WHEN id_imposto=1 then BASE_IMPOSTO else 0 end) as BASE_ICMS,	
		SUM(case WHEN id_imposto=1 then VALOR_IMPOSTO else 0 end) as VALOR_ICMS,	
		SUM(case WHEN id_imposto=1 then BASE_IMPOSTO_CALC else 0 end) as BASE_ICMS_CALC,	
--
		max(case WHEN id_imposto=2 then TAXA_IMPOSTO else 0 end) as TAXA_IPI,
		max(case WHEN id_imposto=2 then agrega_apos_desconto else 0 end) as AGREGA_APOS_DESCONTO_IPI,
		SUM(case WHEN id_imposto=2 then BASE_IMPOSTO else 0 end) as BASE_IPI,	
		SUM(case WHEN id_imposto=2 then VALOR_IMPOSTO else 0 end) as VALOR_IPI,	
		SUM(case WHEN id_imposto=2 then BASE_IMPOSTO_CALC else 0 end) as BASE_IPI_CALC,	
--
		max(case WHEN id_imposto=5 then TAXA_IMPOSTO else 0 end) as TAXA_PIS,
		max(case WHEN id_imposto=5 then agrega_apos_desconto else 0 end) as AGREGA_APOS_DESCONTO_PIS,
		SUM(case WHEN id_imposto=5 then BASE_IMPOSTO else 0 end) as BASE_PIS,	
		SUM(case WHEN id_imposto=5 then VALOR_IMPOSTO else 0 end) as VALOR_PIS,	
		SUM(case WHEN id_imposto=5 then BASE_IMPOSTO_CALC else 0 end) as BASE_PIS_CALC,	
--
		max(case WHEN id_imposto=6 then TAXA_IMPOSTO else 0 end) as TAXA_COFINS,
		max(case WHEN id_imposto=6 then agrega_apos_desconto else 0 end) as AGREGA_APOS_DESCONTO_COFINS,
		SUM(case WHEN id_imposto=6 then BASE_IMPOSTO else 0 end) as BASE_COFINS,	
		SUM(case WHEN id_imposto=6 then VALOR_IMPOSTO else 0 end) as VALOR_COFINS,	
		SUM(case WHEN id_imposto=6 then BASE_IMPOSTO_CALC else 0 end) as BASE_COFINS_CALC,	
--
		max(case WHEN id_imposto=12 then TAXA_IMPOSTO else 0 end) as TAXA_ICMS_ST,
		max(case WHEN id_imposto=12 then agrega_apos_desconto else 0 end) as AGREGA_APOS_DESCONTO_ICMS_ST,
		SUM(case WHEN id_imposto=12 then BASE_IMPOSTO else 0 end) as BASE_ICMS_ST,	
		SUM(case WHEN id_imposto=12 then VALOR_IMPOSTO else 0 end) as VALOR_ICMS_ST,	
		SUM(case WHEN id_imposto=12 then BASE_IMPOSTO_CALC else 0 end) as BASE_ICMS_ST_CALC,

		(select top 1 pedido 
		from faturamento_prod fp 
		where fp.nf_saida=a.nf_saida and fp.filial=a.filial and fp.serie_nf=a.serie_nf
		and fp.produto = a.codigo_item) as pedido_venda,

		(select top 1 fi.QTDE_ITEM 
		from faturamento_item fi
		where fi.filial = a.filial 
		and fi.nf_saida = a.nf_saida
		and fi.serie_nf = a.serie_nf
		and fi.item_impressao = a.item_impressao
		and fi.sub_item_tamanho = a.sub_item_tamanho
		and fi.codigo_item = a.codigo_item) as qtde_item,

		(select top 1 VALOR_TOTAL
		from faturamento f 
		where f.nf_saida=a.nf_saida and f.filial=a.filial and f.serie_nf=a.serie_nf) as VALOR_TOTAL_NF


from baseimposto a
inner join produtos p on p.produto = a.codigo_item
inner join faturamento f on f.FILIAL=a.filial and f.NF_SAIDA = a.nf_saida and f.SERIE_NF=a.serie_nf 
group by 	a.filial,
			a.nf_saida,
			a.serie_nf, 
			f.NOME_CLIFOR,
			f.EMISSAO,
			a.item_impressao,
			a.sub_item_tamanho,
			a.codigo_item,
			a.descricao_item,
			p.griffe,
			p.linha,
			p.grupo_produto,
			p.subgrupo_produto,
			p.erp_desc_licenciado,
			p.erp_tema_licenciado




