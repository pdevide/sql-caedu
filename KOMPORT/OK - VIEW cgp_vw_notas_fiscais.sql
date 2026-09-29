USE [CAEDU]
GO

/****** Object:  View [dbo].[cgp_vw_notas_fiscais]    Script Date: 30/12/2024 15:46:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE OR ALTER view [dbo].[cgp_vw_notas_fiscais] as (

select 
	 
	'S' as tipo_nota_fiscal,
	fat.filial as identificacao_emitente,
	fat.nf_saida as numero_nota,
	fat.serie_nf as serie,
	fat.chave_nfe as chave_de_acesso,
	'S' + '@@' + fat.chave_nfe as chave_de_acesso_por_tipo_nota,
	nat.desc_natureza as natureza_operacao,
	fat.protocolo_autorizacao_nfe  + ' - ' + convert(varchar,fat.data_autorizacao_nfe,120) as protocolo_autorizacao_uso,
	replace(emit.rg_ie,'.','') as inscricao_estadual_emitente,
	null as inscricao_estadual_subst_tribut,
	emit.cgc_cpf as cnpj_cpf_emitente,
	ccf.razao_social,
	cast(ccf.cgc_cpf as varchar) as cnpj_cpf_destinatario,
	fat.emissao as data_emissao,
	ltrim(rtrim(ccf.endereco)) + ',' + ccf.numero + ' ' + ccf.entrega_complemento as endereco,
	ccf.bairro as bairro_distrito,
	ccf.cep,
	fat.data_saida as data_saida_entrada,
	ccf.cobranca_cidade as municipio,
	ccf.uf as uf_destinatario,
	ltrim(rtrim(cast(ccf.ddd1 as int)))+''+ltrim(rtrim(replace(ccf.telefone1,'-',''))) as fone_fax,
	replace(ccf.rg_ie,'.','') as inscricao_estadual_destinatario,
	ltrim(rtrim(convert(varchar, fat.data_hora_emissao, 108))) as hora_saida_entrada,


		(select t.codigo_fiscal_operacao from (

	(select 
		top 1 count(1) as qtd, 
		f1.codigo_fiscal_operacao 
	  from 
		faturamento_item f1 (nolock)
	  where f1.filial = fat.filial
	    and f1.serie_nf = fat.serie_nf
		and f1.nf_saida = fat.nf_saida 
	  group by f1.codigo_fiscal_operacao 
	  order by 1 desc)

	) t ) as cfop,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		sum(base_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 1),0.00) as base_calculo_icms,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 1),0.00 ) as valor_icms,

	-----------------------------------------------------------------------------------------------
	  
	isnull((select 
		sum(base_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 12 and incidencia = 1),0.00) as base_calculo_icms_st,

	-----------------------------------------------------------------------------------------------
	  
	isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 12 and incidencia = 1),0.00) as valor_icms_st,
	  
	-------------------------------------------------------------------------------------------

	  0.00 as valor_imp_importacao,
	  0.00 as valor_icms_uf_remetetnte,
	  
	-----------------------------------------------------------------------------------------------

	 isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 42),0.00) as valor_fcp,
	  
	-----------------------------------------------------------------------------------------------

	  isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 5),0.00) as valor_pis,

	-----------------------------------------------------------------------------------------------

	  fat.mpadrao_valor_sub_itens as valor_total_produtos,
	  fat.frete as valor_frete,
	  fat.seguro as valor_seguro,
	  fat.desconto as valor_desconto,
	  fat.valor_imposto_incidencia as outras_despesas,
	  	
	-----------------------------------------------------------------------------------------------		
		  
	 isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 2),0.00) as valor_total_ipi,

	-----------------------------------------------------------------------------------------------

	  0.00 as valor_icms_uf_dest,
	  0.00 as valor_total_trib,
	  
	-----------------------------------------------------------------------------------------------

	isnull((select 
		sum(valor_imposto) 
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 6),0.00) as valor_confins,

	-----------------------------------------------------------------------------------------------

	  fat.valor_total,
	  transp.transportadora as nome_razao_social_transportadora,
	  cast(tfrete.frete_pago as varchar) as frete_por_conta,
	  null as codigo_antt,
	  null as placa_veiculo,
	  null as uf_1,
	  transp.cgc as cnpj_cpf_transportadora,
	  transp.endereco as endereco_transportadora,
	  transp.cidade as municipio_transportadora ,
	  transp.uf as uf_2,
	  replace(transp.inscricao,'.','') as inscricao_estadual,
	  fat.volumes as quantidade,
	  fat.tipo_volume as especie,
	  null as marca,
	  null as numeracao,
	  fat.peso_bruto,
	  fat.peso_liquido,
	  ccf.ebs_id_fornecedor as ebs_id_fornecedor,
	  ccf.ebs_id_local_fornecedor as ebs_id_local_fornecedor,
	  null as recebimento,
	  fat.condicao_pgto,
	  cepg.ebs_id_cond_pagamento as ebs_id_cond_pagamento,
	  isnull(cpgmov.desconto_obtido,0.00) as desconto_no_show,

	  -- campos synchro ------------------------------------------------

	  emit.clifor				  as synchro_codigo_emitente,
	  ccf.clifor				  as synchro_codigo_destinatario,
	  fat.natureza_saida		  as synchro_natureza,
	  fat.mpadrao_valor_sub_itens as synchro_valor_total_m,

	 --------------------------------------------------------------------

	 isnull((select sum(mpadrao_desconto_item * -1) from  
		faturamento_item (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf
	    and filial = fat.filial),0.00000) as synchro_valor_total_ajuste_m,
	  
	  --------------------------------------------------------------------

	  emit.uf								 as synchro_uf_emitente,
	  replace(ces.desc_especie_serie,'-','') as synchro_desc_especie_serie,
	  emit_estabelc.cod_filial				 as synchro_ind_filial_emitente,
	  clie_estabelc.cod_filial				 as synchro_ind_filial_cliente,
	  fat.encargo							 as synchro_encargo,
	  fat.filial							 as synchro_filial,
	  fat.desconto							 as synchro_desconto,
	  fat.ctb_lancamento					 as synchro_ctb_lancamento,

	  --------------------------------------------------------------------

	  case when fat.status_nfe = '5' then 'N'  
		   when (select top 1 status_nfe from faturamento a (nolock) 
				inner join cadastro_cli_for b (nolock) 
						on a.nome_clifor = b.nome_clifor 
					 where b.cgc_cpf not like '4637772%') = 1 
									  then 'N'
		   when fat.status_nfe = '49' then 'S'  
		   when fat.status_nfe = '59' then 'I'  
	  end	as synchro_status_nfe,

	  --------------------------------------------------------------------

	  isnull((select 
		sum(taxa_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 5),0.00) as synchro_aliquota_pis,

	  --------------------------------------------------------------------

	  isnull((select 
		sum(base_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 5),0.00) as synchro_base_pis,

	  --------------------------------------------------------------------

	  isnull((select 
		sum(taxa_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 6),0.00) as synchro_aliquota_cofins,

	  --------------------------------------------------------------------

	  isnull((select 
		 sum(base_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 6),0.00) as synchro_base_cofins,

	  --------------------------------------------------------------------

	  isnull((select 
		sum(taxa_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 1),0.00) as synchro_aliquota_icms,

	--------------------------------------------------------------------	   

	isnull((select 
		sum(taxa_imposto)
	 from 
		faturamento_imposto (nolock)
	where nf_saida = fat.nf_saida 
	  and serie_nf = fat.serie_nf 
	  and filial = fat.filial 
	  and id_imposto = 12 and incidencia = 1),0.00) as synchro_aliquota_st,

	 --------------------------------------------------------------------

	  isnull((select 
		sum(base_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 1),0.00) as synchro_base_icms,

	 --------------------------------------------------------------------

	  isnull((select 
		sum(taxa_imposto)
	   from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 2),0.00) as synchro_aliquota_ipi,

	--------------------------------------------------------------------

	  isnull((select 
		sum(base_imposto)
	  from 
		faturamento_imposto (nolock)
	  where nf_saida = fat.nf_saida 
	    and serie_nf = fat.serie_nf 
	    and filial = fat.filial 
	    and id_imposto = 2),0.00) as synchro_base_ipi,

	--------------------------------------------------------------------

	  ccf.uf					  as synchro_uf_destinatario,
	  ccf.nome_clifor			  as synchro_nome_destinatario,
	  ccf.ebs_id_cliente		  as synchro_ebs_id_cliente,
	  ccf.ebs_id_local_cliente    as synchro_ebs_id_local_cliente,
	   
	--------------------------------------------------------------------
	
	fat.data_para_transferencia

from faturamento fat (nolock)

inner join naturezas_saidas (nolock) nat on fat.natureza_saida = nat.natureza_saida
inner join cadastro_cli_for (nolock) ccf on fat.nome_clifor = ccf.nome_clifor
inner join cadastro_cli_for (nolock) emit on fat.filial = emit.nome_clifor
inner join transportadoras (nolock) transp on fat.transportadora = transp.transportadora
inner join cond_ent_pgtos cepg (nolock) on fat.condicao_pgto = cepg.condicao_pgto
inner join series_nf se (nolock) on se.serie_nf = fat.serie_nf  
inner join ctb_especie_serie ces with (nolock) on  ces.especie_serie = se.especie_serie
left join tipo_frete tfrete (nolock) on fat.tipo_frete = tfrete.tipo_frete
left join ctb_a_pagar_fatura cpgfat (nolock) on fat.nf_saida = cpgfat.fatura and fat.ctb_lancamento = cpgfat.lancamento
left join ctb_a_pagar_mov cpgmov (nolock) on cpgfat.lancamento = cpgmov.lancamento_mov
left join filiais emit_estabelc (nolock) on emit.clifor = emit_estabelc.cod_filial  
left join filiais clie_estabelc (nolock) on ccf.clifor = clie_estabelc.cod_filial

union all

select

	case when (ent.nome_clifor = 'KOMPORT' OR ent.nome_clifor LIKE 'HARPIA%')
		then 'EI' else 'E' end as tipo_nota_fiscal,
	ent.nome_clifor as identificacao_emitente,
	ent.nf_entrada as numero_nota,
	ent.serie_nf_entrada as serie,
	ent.chave_nfe as chave_de_acesso,
	case when (ent.nome_clifor = 'KOMPORT' OR ent.nome_clifor LIKE 'HARPIA%') 
		then 'EI' else 'E' end + '@@' + ent.chave_nfe as chave_de_acesso_por_tipo_nota,
	nat.desc_natureza as natureza_operacao,
	ent.protocolo_autorizacao_nfe + ' - ' + convert(varchar,ent.data_autorizacao_nfe,120) as protocolo_autorizacao_uso,
	replace(ccf.rg_ie,'.','') as inscricao_estadual_emitente,
	null as inscricao_estadual_subst_tribut,
	ccf.cgc_cpf as cnpj_cpf_emitente,
	fil.razao_social,
	fil.cgc_cpf as cnpj_cpf_destinatario,
	ent.emissao as data_emissao,
	ltrim(rtrim(fil.endereco)) + ',' + fil.numero + ' ' + fil.entrega_complemento as endereco,
	fil.bairro as bairro_distrito,
	fil.cep,
	ent.emissao as data_saida_entrada,
	fil.cidade as municipio,
	fil.uf as uf_destinatario,
	ltrim(rtrim(cast(fil.ddd1 as int)))+''+ltrim(rtrim(replace(fil.telefone1,'-',''))) as fone_fax,
	replace(fil.rg_ie,'.','') as inscricao_estadual_destinatario,
	convert(varchar, ent.data_hora_emissao, 108) as hora_saida_entrada,

	-----------------------------------------------------------------------------------------------

	(select t.codigo_fiscal_operacao from (

	(select 
		top 1 count(1) as qtd, 
		e1.codigo_fiscal_operacao 
	  from 
		entradas_item e1 (nolock)
	  where e1.nome_clifor = ent.nome_clifor 
	    and e1.serie_nf_entrada = ent.serie_nf_entrada 
		and e1.nf_entrada = ent.nf_entrada 
	  group by e1.codigo_fiscal_operacao 
	  order by 1 desc)

	) t ) as cfop,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_calc) else sum(base_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 1),0.00) as base_calculo_icms,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 1),0.00) as valor_icms,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_calc) else sum(base_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 12),0.00) as base_calculo_icms_st,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 12),0.00) as valor_icms_st,
	
	-----------------------------------------------------------------------------------------------

	 isnull(ent.importacao_imposto,0.00) as valor_imp_importacao,
	 0.00 as valor_icms_uf_remetetnte,
	 
	-----------------------------------------------------------------------------------------------	 
	  	  
	 isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end
	 from 
		entradas_imposto (nolock)
	 where nf_entrada = ent.nf_entrada 
	   and serie_nf_entrada = ent.serie_nf_entrada
	   and nome_clifor = ent.nome_clifor
	   and id_imposto = 42),0.00) as valor_fcp,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end 
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 5),0.00) as valor_pis,
	  
	-----------------------------------------------------------------------------------------------

	  ent.valor_sub_itens as valor_total_produtos,
	  ent.frete as valor_frete,
	  ent.seguro as valor_seguro,
	  ent.desconto as valor_desconto,
	  0.00 as outras_despesas,

	-----------------------------------------------------------------------------------------------

	isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end
	 from 
		entradas_imposto (nolock)
	 where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 2),0.00) as valor_total_ipi,

	-----------------------------------------------------------------------------------------------

	  0.00 as valor_icms_uf_dest,
	  0.00 as valor_total_trib,          

	-----------------------------------------------------------------------------------------------

	 isnull((select 
		case when sum(valor_imposto) = 0 then sum(valor_imposto_calc) else sum(valor_imposto) end 
	 from 
		entradas_imposto (nolock)
	 where nf_entrada = ent.nf_entrada 
	   and serie_nf_entrada = ent.serie_nf_entrada
	   and nome_clifor = ent.nome_clifor
	   and id_imposto = 6),0.00) as valor_confins,

	-----------------------------------------------------------------------------------------------

	ent.valor_total,
	ent.transportadora_a_pagar as nome_razao_social_transportadora,
	cast(ent.transportadora_a_pagar as varchar) as frete_por_conta,
	null as codigo_antt,
	null as placa_veiculo,
	null as uf_1,
	null as cnpj_cpf_transportadora,
	null as endereco_transportadora,
	null as municipio_transportadora,
	null as uf_2,
	null as inscricao_estadual,
	ent.embalagens as quantidade,
	ent.tipo_volume as especie,
	null as marca,
	null as numeracao,
	ent.peso_bruto,
	ent.peso as peso_liquido,
	ccf.ebs_id_fornecedor,
	ccf.ebs_id_local_fornecedor,
	ent.recebimento,
	ent.condicao_pgto,
	cepg.ebs_id_cond_pagamento,
	isnull(cpgmov.desconto_obtido,0.00) as desconto_no_show,

	-- campos synchro ------------------------------------------------

	ccf.clifor                as synchro_codigo_emitente,
	fil.clifor                as synchro_codigo_destinatario,
	ent.natureza              as synchro_natureza,
	ent.valor_sub_itens       as synchro_valor_total_m,

	--------------------------------------------------------------------

	(select sum(valor_descontos * -1) from  
		entradas_item (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor) as synchro_valor_total_ajuste_m,

	--------------------------------------------------------------------

	ccf.uf								   as synchro_uf_emitente,
	replace(ces.desc_especie_serie,'-','') as synchro_desc_especie_serie,
	emit_estabelc.cod_filial			   as synchro_ind_filial_emitente, 
	dest_estabelc.cod_filial			   as synchro_ind_filial_cliente,
	ent.encargo							   as synchro_encargo,
	ent.filial							   as synchro_filial,
	ent.desconto						   as synchro_desconto,
	ent.ctb_lancamento					   as synchro_ctb_lancamento,
	
	--------------------------------------------------------------------

	case 

		when ent.status_nfe = '5'  then 'N' 
		when (select top 1 status_nfe 
		        from entradas a (nolock)
		  inner join cadastro_cli_for as b (nolock)
		          on a.nome_clifor = b.nome_clifor 
			   where b.cgc_cpf not like '4637772%') = 1 
				                   then 'N' 
		
		when ent.status_nfe = '49' then 'S' 
		when ent.status_nfe = '59' then 'I'
	
	end as synchro_status_nfe,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(taxa_imposto) = 0 then sum(taxa_imposto_espelho) else sum(taxa_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 5),0.00) as synchro_aliquota_pis,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_espelho) else sum(base_imposto) end 
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 5),0.00) as synchro_base_pis,	

	--------------------------------------------------------------------

	isnull((select 
		case when sum(taxa_imposto) = 0 then sum(taxa_imposto_espelho) else sum(taxa_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 6),0.00) as synchro_aliquota_cofins,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_espelho) else sum(base_imposto) end 
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 6),0.00) as synchro_base_cofins,		

	--------------------------------------------------------------------

	isnull((select 
		case when sum(taxa_imposto) = 0 then sum(taxa_imposto_espelho) else sum(taxa_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 1),0.00) as synchro_aliquota_icms,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(taxa_imposto) = 0 then sum(taxa_imposto_espelho) else sum(taxa_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 12),0.00) as synchro_aliquota_st,

	---------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_espelho) else sum(base_imposto) end 
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 1),0.00) as synchro_base_icms,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(taxa_imposto) = 0 then sum(taxa_imposto_espelho) else sum(taxa_imposto) end
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 2),0.00) as synchro_aliquota_ipi,

	--------------------------------------------------------------------

	isnull((select 
		case when sum(base_imposto) = 0 then sum(base_imposto_espelho) else sum(base_imposto) end 
	 from 
		entradas_imposto (nolock)
	where nf_entrada = ent.nf_entrada 
	  and serie_nf_entrada = ent.serie_nf_entrada
	  and nome_clifor = ent.nome_clifor
	  and id_imposto = 2),0.00) as synchro_base_ipi,
	--------------------------------------------------------------------

	ccf.uf					  as synchro_uf_destinatario,
	ccf.nome_clifor			  as synchro_nome_destinatario,
	ccf.ebs_id_cliente		  as synchro_ebs_id_cliente,
	ccf.ebs_id_local_cliente  as synchro_ebs_id_local_cliente,

	--------------------------------------------------------------------

	ent.data_para_transferencia as data_para_transferencia

from entradas ent (nolock)
inner join naturezas_entradas nat (nolock) on ent.natureza = nat.natureza
inner join cadastro_cli_for ccf (nolock) on ent.nome_clifor = ccf.nome_clifor
inner join cadastro_cli_for fil (nolock) on ent.filial = fil.nome_clifor
inner join cond_ent_pgtos cepg (nolock) on ent.condicao_pgto = cepg.condicao_pgto
inner join ctb_especie_serie ces (nolock) on ent.especie_serie = ces.especie_serie
left join ctb_a_pagar_fatura cpgfat (nolock) on ent.nf_entrada = cpgfat.fatura and ent.ctb_lancamento = cpgfat.lancamento
left join ctb_a_pagar_mov cpgmov (nolock) on cpgfat.lancamento = cpgmov.lancamento_mov
left join filiais emit_estabelc (nolock) on emit_estabelc.cod_filial = ccf.cod_clifor 
left join filiais dest_estabelc (nolock) on dest_estabelc.cod_filial = fil.cod_clifor

)





GO


