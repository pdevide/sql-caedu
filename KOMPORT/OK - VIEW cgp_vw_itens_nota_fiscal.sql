USE [CAEDU]
GO

/****** Object:  View [dbo].[cgp_vw_itens_nota_fiscal]    Script Date: 30/12/2024 15:29:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER view [dbo].[cgp_vw_itens_nota_fiscal] as (

select 
	 
	case 
		when /*eitem.nome_clifor = 'KOMPORT' */
		(eitem.nome_clifor LIKE 'HARPIA%' OR eitem.nome_clifor LIKE 'KOMPORT%')
		then 'EI' 
		else 'E' 
	end as tipo_nota_fiscal,
	
	eitem.nf_entrada							 as numero_nota,
	eitem.serie_nf_entrada						 as serie,
	eitem.nome_clifor							 as nome_clifor,
	eitem.codigo_item							 as codigo_produto,
	eitem.descricao_item						 as descricao_produto_servico,
	eitem.classif_fiscal						 as ncm,
	null										 as cst,
	eitem.codigo_fiscal_operacao                 as cfop,
	eitem.qtde_item                              as quantidade,
	eitem.preco_unitario_original                as valor_unit,
	eitem.valor_item                             as valor_total,
	
	isnull((case when eimp_icms.base_imposto     = 0 then eimp_icms.base_imposto_calc     else eimp_icms.base_imposto end),0.00)         as base_calculo_icms,
	isnull((case when eimp_icms_st.base_imposto  = 0 then eimp_icms_st.base_imposto_calc  else eimp_icms_st.base_imposto end),0.00)      as base_calculo_icms_st,
	isnull((case when eimp_ipi.base_imposto      = 0 then eimp_ipi.base_imposto_calc      else eimp_ipi.base_imposto end),0.00)          as base_calculo_ipi,
	isnull((case when eimp_pis.base_imposto      = 0 then eimp_pis.base_imposto_calc      else eimp_pis.base_imposto end),0.00)          as base_calculo_pis,
	isnull((case when eimp_cofins.base_imposto   = 0 then eimp_cofins.base_imposto_calc   else eimp_cofins.base_imposto end),0.00)       as base_calculo_cofins,
	
	isnull((case when eimp_icms.taxa_imposto     = 0 then eimp_icms.taxa_imposto_calc     else eimp_icms.taxa_imposto end),0.00)         as aliquota_icms,
	isnull((case when eimp_icms_st.taxa_imposto  = 0 then eimp_icms_st.taxa_imposto       else eimp_icms_st.taxa_imposto_calc end),0.00) as aliquota_icms_st,
	isnull((case when eimp_ipi.taxa_imposto      = 0 then eimp_ipi.taxa_imposto_calc      else eimp_ipi.taxa_imposto end),0.00)          as aliquota_ipi,
	isnull((case when eimp_pis.taxa_imposto      = 0 then eimp_pis.taxa_imposto_calc      else eimp_pis.taxa_imposto end),0.00)          as aliquota_pis,
	isnull((case when eimp_cofins.taxa_imposto   = 0 then eimp_cofins.taxa_imposto_calc   else eimp_cofins.taxa_imposto end),0.00)       as aliquota_cofins,
	
	isnull((case when eimp_icms.valor_imposto    = 0 then eimp_icms.valor_imposto_calc    else eimp_icms.valor_imposto end),0.00)        as valor_icms,
	isnull((case when eimp_icms_st.valor_imposto = 0 then eimp_icms_st.valor_imposto_calc else eimp_icms_st.valor_imposto end),0.00)     as valor_icms_st,
	isnull((case when eimp_ipi.valor_imposto     = 0 then eimp_ipi.valor_imposto_calc     else eimp_ipi.valor_imposto end),0.00)	     as valor_ipi,
	isnull((case when eimp_pis.valor_imposto     = 0 then eimp_pis.valor_imposto_calc     else eimp_pis.valor_imposto end),0.00)	     as valor_pis,	
	isnull((case when eimp_cofins.valor_imposto  = 0 then eimp_cofins.valor_imposto_calc  else eimp_cofins.valor_imposto end),0.00)      as valor_cofins,

	-- campos synchro -------------------------------------------------------------------------------

	ent.valor_total								 as synchro_valor_total,
	ent.chave_nfe								 as synchro_chave_nfe,
	emit.cod_clifor								 as synchro_codigo_emitente,
	eitem.item_impressao						 as synchro_item_impressao,
	ent.natureza								 as synchro_natureza,
	eitem.unidade								 as synchro_unidade,
	eitem.classif_fiscal						 as synchro_classificacao_fiscal,
	eitem.peso									 as synchro_peso,
	(eitem.valor_descontos * -1)				 as synchro_desconto_item,
	ent.emissao									 as synchro_emissao,

	-------------------------------------------------------------------------------------------------

	case when eitem.codigo_fiscal_operacao in (1406,1407,1409) then '60' else 
		case when eitem.codigo_fiscal_operacao in (1551,1556,1923,1949,2551,2556,2949) then '41' else  
			case when eitem.codigo_fiscal_operacao = 1102 then '00' else eitem.tribut_icms end 
	end
	end as synchro_cst_icms,

	null as synchro_origem_mercadoria,

	-------------------------------------------------------------------------------------------------

	case when eitem.codigo_fiscal_operacao in 
		(1551,1556,1923,1949,2551,2556,2949,1406,1407,1409,1102) 
	then '03' 
	else  
		eii_ipi.situacao_tributaria 
	end as synchro_cst_ipi,

	-------------------------------------------------------------------------------------------------

	eii_pis.situacao_tributaria                as synchro_cst_pis,
	eii_cofins.situacao_tributaria             as synchro_cst_cofins,
	dest.cgc_cpf							   as synchro_cnpj_emitente,
	emit.cgc_cpf							   as synchro_cnpj_destinatario,
	emit.ebs_id_cliente                        as synchro_dest_ebs_id_cliente,  
	emit.ebs_id_local_cliente                  as synchro_dest_ebs_id_local_cliente,
	replace(ces.desc_especie_serie,'-','')	   as synchro_desc_especie_serie,
	(eitem.valor_item - eitem.valor_descontos) as synchro_valor_liquido

from entradas_item eitem

inner join entradas ent (nolock)
        on eitem.nf_entrada = ent.nf_entrada
       and eitem.serie_nf_entrada = ent.serie_nf_entrada
       and eitem.nome_clifor = ent.nome_clifor

inner join cadastro_cli_for dest (nolock)
        on ent.filial = dest.nome_clifor

inner join cadastro_cli_for emit (nolock)
        on ent.nome_clifor = emit.nome_clifor

inner join ctb_especie_serie ces 
        on ent.especie_serie = ces.especie_serie

left join entradas_imposto eimp_icms (nolock)
       on eitem.nf_entrada = eimp_icms.nf_entrada
      and eitem.serie_nf_entrada = eimp_icms.serie_nf_entrada
      and eitem.nome_clifor = eimp_icms.nome_clifor
      and eitem.item_impressao = eimp_icms.item_impressao
      and eimp_icms.id_imposto = 1

left join entradas_imposto eimp_ipi (nolock)
       on eitem.nf_entrada = eimp_ipi.nf_entrada
      and eitem.serie_nf_entrada = eimp_ipi.serie_nf_entrada
      and eitem.nome_clifor = eimp_ipi.nome_clifor
      and eitem.item_impressao = eimp_ipi.item_impressao
      and eimp_ipi.id_imposto = 2

left join entradas_imposto eimp_pis (nolock)
       on eitem.nf_entrada = eimp_pis.nf_entrada
      and eitem.serie_nf_entrada = eimp_pis.serie_nf_entrada
      and eitem.nome_clifor = eimp_pis.nome_clifor
      and eitem.item_impressao = eimp_pis.item_impressao
      and eimp_pis.id_imposto = 5

left join entradas_imposto eimp_cofins (nolock)
       on eitem.nf_entrada = eimp_cofins.nf_entrada
      and eitem.serie_nf_entrada = eimp_cofins.serie_nf_entrada
      and eitem.nome_clifor = eimp_cofins.nome_clifor
      and eitem.item_impressao = eimp_cofins.item_impressao
      and eimp_cofins.id_imposto = 6

left join entradas_imposto eimp_icms_st (nolock)
       on eitem.nf_entrada = eimp_icms_st.nf_entrada
      and eitem.serie_nf_entrada = eimp_icms_st.serie_nf_entrada
      and eitem.nome_clifor = eimp_icms_st.nome_clifor
      and eitem.item_impressao = eimp_icms_st.item_impressao
      and eimp_icms_st.id_imposto = 12

left join ctb_excecao_imposto_item eii_ipi (nolock)
       on eii_ipi.id_excecao_imposto = eitem.id_excecao_imposto
      and eii_ipi.id_imposto = 2

left join ctb_excecao_imposto_item eii_pis (nolock)
       on eii_pis.id_excecao_imposto = eitem.id_excecao_imposto
      and eii_pis.id_imposto = 5

left join ctb_excecao_imposto_item eii_cofins (nolock)
       on eii_cofins.id_excecao_imposto = eitem.id_excecao_imposto
      and eii_cofins.id_imposto = 6

union all

select 

	'S'							    as tipo_nota_fiscal,
	fitem.nf_saida				    as numero_nota,
	fitem.serie_nf				    as serie,
	fitem.filial				    as nome_clifor,
	fitem.codigo_item			    as codigo_produto,
	fitem.descricao_item		    as descricao_produto_servico,
	fitem.classif_fiscal		    as ncm,
	null						    as cst,
	fitem.codigo_fiscal_operacao    as cfop,
	fitem.qtde_item				    as quantidade,
	fitem.preco_unitario_original   as valor_unit,
	fitem.valor_item			    as valor_total,

	isnull((case when fimp_icms.base_imposto     = 0   then fimp_icms.base_imposto_calc           else fimp_icms.base_imposto end),0.00)     as base_calculo_icms,
	isnull((case when fimp_icms_st.base_imposto  = 0   then fimp_icms_st.base_imposto_calc        else fimp_icms_st.base_imposto end),0.00)  as base_calculo_icms_st,
	isnull((case when fimp_ipi.base_imposto      = 0   then fimp_ipi.base_imposto_calc            else fimp_ipi.base_imposto end),0.00)      as base_calculo_ipi,
	isnull((case when fimp_pis.base_imposto      = 0   then fimp_pis.base_imposto_calc            else fimp_pis.base_imposto end),0.00)      as base_calculo_pis,
	isnull((case when fimp_cofins.base_imposto   = 0   then fimp_cofins.base_imposto_calc         else fimp_cofins.base_imposto end),0.00)   as base_calculo_cofins,
	
	isnull(fimp_icms.taxa_imposto,0.00)    as aliquota_icms,
	isnull(fimp_icms_st.taxa_imposto,0.00) as aliquota_icms_st,
	isnull(fimp_ipi.taxa_imposto,0.00)     as aliquota_ipi,
	isnull(fimp_pis.taxa_imposto,0.00)     as aliquota_pis,
	isnull(fimp_cofins.taxa_imposto,0.00)  as aliquota_cofins,

	isnull((case when fimp_icms.valor_imposto    = 0   then fimp_icms.valor_imposto_calculado     else fimp_icms.valor_imposto end),0.00)    as valor_icms,
	isnull((case when fimp_icms_st.valor_imposto = 0   then fimp_icms_st.valor_imposto_calculado  else fimp_icms_st.valor_imposto end),0.00) as valor_icms_st,
	isnull((case when fimp_ipi.valor_imposto     = 0   then fimp_ipi.valor_imposto_calculado      else fimp_ipi.valor_imposto end),0.00)     as valor_ipi,
	isnull((case when fimp_pis.valor_imposto     = 0   then fimp_pis.valor_imposto_calculado      else fimp_pis.valor_imposto end),0.00)     as valor_pis,
	isnull((case when fimp_cofins.valor_imposto  = 0   then fimp_cofins.valor_imposto_calculado   else fimp_cofins.valor_imposto end),0.00)  as valor_cofins,

	-- campos synchro -----------------------------------------------------

	fat.valor_total                as synchro_valor_total,
	fat.chave_nfe				   as synchro_chave_nfe,
	emit.clifor				       as synchro_codigo_emitente,
	fitem.item_impressao           as synchro_item_impressao,
	fat.natureza_saida			   as synchro_natureza,
	fitem.unidade				   as synchro_unidade,
	fitem.classif_fiscal		   as synchro_classificacao_fiscal,
	fitem.peso					   as synchro_peso,
	(fitem.desconto_item * -1)	   as synchro_desconto_item,
	fat.emissao					   as synchro_emissao,
	
	------------------------------------------------------------------------

	case when eii_icms.tribut_icms is null then p.tribut_icms 
		 else eii_icms.tribut_icms 
	end as synchro_cst_icms,

	------------------------------------------------------------------------

	case when ori_merc.situacao_tributaria is null then 0 
		 else ori_merc.situacao_tributaria 
	end as synchro_origem_mercadoria, 

	------------------------------------------------------------------------

	eii_ipi.situacao_tributaria              as synchro_cst_ipi,
	eii_pis.situacao_tributaria              as synchro_cst_pis,
	eii_cofins.situacao_tributaria           as synchro_cst_cofins,
	emit.cgc_cpf                             as synchro_cnpj_emitente,
	dest.cgc_cpf					         as synchro_cnpj_destinatario,
	dest.ebs_id_cliente                      as synchro_dest_ebs_id_cliente,  
	dest.ebs_id_local_cliente                as synchro_dest_ebs_id_local_cliente,
	replace(ces.desc_especie_serie,'-','')   as synchro_desc_especie_serie,
	(fitem.valor_item - fitem.desconto_item) as synchro_valor_liquido


from faturamento_item fitem (nolock)

inner join faturamento fat  (nolock)
        on fitem.nf_saida = fat.nf_saida 
	   and fitem.serie_nf = fat.serie_nf 
	   and fitem.filial = fat.filial

inner join cadastro_cli_for emit (nolock)
        on fat.filial = emit.nome_clifor

inner join cadastro_cli_for as dest (nolock) 
        on fat.nome_clifor = dest.nome_clifor

inner join series_nf se (nolock) 
        on se.serie_nf = fat.serie_nf  

inner join ctb_especie_serie ces (nolock) 
        on ces.especie_serie = se.especie_serie 

left join faturamento_imposto fimp_icms (nolock) 
       on fimp_icms.nf_saida = fitem.nf_saida 
	  and fimp_icms.serie_nf = fitem.serie_nf 
	  and fimp_icms.filial = fitem.filial 
	  and fimp_icms.id_imposto = 1 
	  and fitem.item_impressao = fimp_icms.item_impressao

left join faturamento_imposto fimp_ipi (nolock) 
       on fimp_ipi.nf_saida = fitem.nf_saida 
	  and fimp_ipi.serie_nf = fitem.serie_nf 
	  and fimp_ipi.filial = fitem.filial 
	  and fimp_ipi.id_imposto = 2 
	  and fitem.item_impressao = fimp_ipi.item_impressao

left join faturamento_imposto fimp_pis (nolock) 
       on fimp_pis.nf_saida = fitem.nf_saida 
	  and fimp_pis.serie_nf = fitem.serie_nf 
	  and fimp_pis.filial = fitem.filial 
	  and fimp_pis.id_imposto = 5 
	  and fitem.item_impressao = fimp_pis.item_impressao

left join faturamento_imposto fimp_cofins (nolock) 
	   on fimp_cofins.nf_saida = fitem.nf_saida 
	  and fimp_cofins.serie_nf = fitem.serie_nf 
	  and fimp_cofins.filial = fitem.filial 
	  and fimp_cofins.id_imposto = 6 
	  and fitem.item_impressao = fimp_cofins.item_impressao

left join faturamento_imposto fimp_icms_st (nolock) 
       on fimp_icms_st.nf_saida = fitem.nf_saida 
	  and fimp_icms_st.serie_nf = fitem.serie_nf 
	  and fimp_icms_st.filial = fitem.filial 
	  and fimp_icms_st.id_imposto = 12 
	  and fitem.item_impressao = fimp_icms_st.item_impressao

left join produtos p (nolock) 
	   on p.produto = fitem.codigo_item

left join ctb_excecao_imposto eii_icms (nolock) 
	   on eii_icms.id_excecao_imposto = fitem.id_excecao_imposto 

left join ctb_excecao_imposto_item eii_ipi (nolock) 
	   on eii_ipi.id_excecao_imposto = fitem.id_excecao_imposto 
	  and eii_ipi.id_imposto = '2'

left join ctb_excecao_imposto_item eii_pis (nolock) 
       on eii_pis.id_excecao_imposto = fitem.id_excecao_imposto 
	  and eii_pis.id_imposto ='5'

left join ctb_excecao_imposto_item eii_cofins (nolock) 
       on eii_cofins.id_excecao_imposto = fitem.id_excecao_imposto 
	  and eii_cofins.id_imposto = '6'

left join ctb_excecao_imposto_item ori_merc (nolock) 
	   on ori_merc.id_excecao_imposto = fitem.id_excecao_imposto 
	  and ori_merc.id_imposto = '12'

)



GO


