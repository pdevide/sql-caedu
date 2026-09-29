CREATE PROCEDURE LX_DUPLICA_PEDIDO_BONIFICADO
(
	@PEDIDO_ORIGEM VARCHAR(8),
	@ENTREGA DATETIME,
	@LIMITE_ENTREGA DATETIME,
	@QTD_DEBITO_PACKS_ORIGEM INT,
	@QTD_CREDITO_PACKS_DESTINO INT
)
AS
BEGIN
	declare @newpedido varchar(8)
	declare @erro int = 0
	declare @msg varchar(200) = ''
	set @newpedido = LTRIM(RTRIM(@PEDIDO_ORIGEM))+'-5'


	if EXISTS(SELECT 1 FROM COMPRAS WHERE PEDIDO = @newpedido)
	begin
		set @erro= -1
		set @msg = 'Erro: Pedido '+@newpedido+' ja cadastrado no Linx!'
		RAISERROR (@msg,16,1); 
		return @erro
	end

	if EXISTS(SELECT 1 FROM COMPRAS_PROD_CANCELADA WHERE PEDIDO = @PEDIDO_ORIGEM)
	begin
		set @erro= -1
		set @msg = 'Erro: Pedido '+@PEDIDO_ORIGEM+' esta CANCELADO no Linx!'
		RAISERROR (@msg,16,1); 
		return @erro
	end

	IF EXISTS(select 1 from compras where (TOT_QTDE_ORIGINAL<>TOT_QTDE_ENTREGAR) AND PEDIDO = @PEDIDO_ORIGEM) 	
	BEGIN
		set @erro= -1
		set @msg = 'Erro: Pedido '+@PEDIDO_ORIGEM+' ja deu entrada no Linx! Duplicação não permitida!'
		RAISERROR (@msg,16,1); 
		return @erro
	END

	insert into compras
		  (pedido, 
		   fornecedor, 
		   filial_a_entregar, 
		   filial_cobranca, 
		   filial_a_faturar, 
		   condicao_pgto, 
		   transportadora, 
		   moeda, 
		   cod_transacao, 
		   emissao, 
		   cadastramento, 
		   aprovado_por, 
		   pedido_fornecedor, 
		   desconto, 
		   encargo, 
		   valor_ipi, 
		   frete_a_pagar, 
		   tot_qtde_original, 
		   tot_qtde_entregar, 
		   tot_valor_original, 
		   tot_valor_entregar, 
		   ctrl_mult_entregas, 
		   tabela_filha, 
		   entrega_aceitavel, 
		   obs, 
		   requerido_por, 
		   tipo_compra, 
		   programacao, 
		   status_aprovacao, 
		   data_aprovacao, 
		   origem_da_compra, 
		   status_compra, 
		   pedido_venda, 
		   comprimento_de_rolos, 
		   tot_valor_despesa, 
		   marca_volumes, 
		   aprovador_por, 
		   rateio_centro_custo, 
		   rateio_filial, 
		   data_faturamento_relativo, 
		   natureza_entrada, 
		   natureza, 
		   id_assinatura_documento, 
		   data_para_transferencia, 
		   pedido_compra_origem, 
		   caedu_data_entrega_original, 
		   lx_status_compra, 
		   quantidade_agendamento, 
		   quantidade_cancelamento, 
		   caedu_data_otb, 
		   status_cq, 
		   motivo_cq, 
		   erp_conferencia_packs, 
		   erp_cab_cod_cabide, 
		   erp_cab_cd_entrega, 
		   erp_cab_encabidado, 
		   erp_cab_status, 
		   erp_cab_localizacao, 
		   erp_cab_qtdpecas, 
		   erp_cab_tipo_pedido, 
		   erp_cab_data_envio, 
		   erp_follow_up_margem, 
		   objeto_id, 
		   erp_cups_tipo_pedido, 
		   erp_cups_segmento, 
		   erp_cups_data_acordada, 
		   erp_cups_peca_mostruario, 
		   erp_cups_embarque_atual, 
		   erp_cups_embarque_real, 
		   erp_cups_contrato, 
		   erp_cups_chegada_porto, 
		   erp_cups_chegada_cd, 
		   erp_cups_processo_ccf_cca, 
		   erp_cups_embarque_liberado, 
		   erp_cups_seq_produto, 
		   erp_cups_incoterm, 
		   erp_cups_id_contrato, 
		   erp_imp_num_fatura, 
		   erp_imp_cod_processo, 
		   erp_imp_tipo_importacao, 
		   erp_percent_verbas, 
		   bloq_embarque, 
		   erp_ebs_ctrl_pagto_parcela, 
		   erp_ebs_vlr_siscomex, 
		   erp_ebs_vlr_custo_fob_di, 
		   erp_ebs_vlr_taxa_di, 
		   erp_ebs_vlr_taxa_bl, 
		   erp_importado, 
		   erp_moeda, 
		   erp_total_qtd_distrib, 
		   erp_percent_distrib, 
		   erp_total_caixas_original, 
		   erp_pack_resto, 
		   ctb_tipo_operacao, 
		   desc_tipo_operacao, 
		   gerar_wf, 
		   chave_processo_se, 
		   erp_distribuicao, 
		   erp_manual, 
		   erp_liberado_cq, 
		   erp_faturado, 
		   erp_cab_opcao, 
		   erp_cab_cod_bolacha) 
	SELECT @newpedido, 
		   fornecedor, 
		   filial_a_entregar, 
		   filial_cobranca, 
		   filial_a_faturar, 
		   condicao_pgto, 
		   transportadora, 
		   moeda, 
		   cod_transacao, 
		   emissao, 
		   cadastramento, 
		   aprovado_por, 
		   pedido_fornecedor, 
		   desconto, 
		   encargo, 
		   valor_ipi, 
		   frete_a_pagar, 
		   tot_qtde_original, 
		   tot_qtde_entregar, 
		   tot_valor_original, 
		   tot_valor_entregar, 
		   ctrl_mult_entregas, 
		   tabela_filha, 
		   entrega_aceitavel, 
		   obs, 
		   requerido_por, 
		   tipo_compra, 
		   programacao, 
		   status_aprovacao, 
		   data_aprovacao, 
		   origem_da_compra, 
		   status_compra, 
		   pedido_venda, 
		   comprimento_de_rolos, 
		   tot_valor_despesa, 
		   marca_volumes, 
		   aprovador_por, 
		   rateio_centro_custo, 
		   rateio_filial, 
		   data_faturamento_relativo, 
		   natureza_entrada, 
		   '228.01' as natureza, /* Natureza de Operação de Bonificação */
		   id_assinatura_documento, 
		   data_para_transferencia, 
		   pedido_compra_origem, 
		   caedu_data_entrega_original, 
		   lx_status_compra, 
		   quantidade_agendamento, 
		   quantidade_cancelamento, 
		   caedu_data_otb, 
		   status_cq, 
		   motivo_cq, 
		   erp_conferencia_packs, 
		   erp_cab_cod_cabide, 
		   erp_cab_cd_entrega, 
		   erp_cab_encabidado, 
		   erp_cab_status, 
		   erp_cab_localizacao, 
		   erp_cab_qtdpecas, 
		   erp_cab_tipo_pedido, 
		   erp_cab_data_envio, 
		   erp_follow_up_margem, 
		   objeto_id, 
		   erp_cups_tipo_pedido, 
		   erp_cups_segmento, 
		   erp_cups_data_acordada, 
		   erp_cups_peca_mostruario, 
		   erp_cups_embarque_atual, 
		   erp_cups_embarque_real, 
		   erp_cups_contrato, 
		   erp_cups_chegada_porto, 
		   erp_cups_chegada_cd, 
		   erp_cups_processo_ccf_cca, 
		   erp_cups_embarque_liberado, 
		   erp_cups_seq_produto, 
		   erp_cups_incoterm, 
		   erp_cups_id_contrato, 
		   erp_imp_num_fatura, 
		   erp_imp_cod_processo, 
		   erp_imp_tipo_importacao, 
		   erp_percent_verbas, 
		   bloq_embarque, 
		   erp_ebs_ctrl_pagto_parcela, 
		   erp_ebs_vlr_siscomex, 
		   erp_ebs_vlr_custo_fob_di, 
		   erp_ebs_vlr_taxa_di, 
		   erp_ebs_vlr_taxa_bl, 
		   erp_importado, 
		   erp_moeda, 
		   erp_total_qtd_distrib, 
		   erp_percent_distrib, 
		   erp_total_caixas_original, 
		   erp_pack_resto, 
		   '228' as ctb_tipo_operacao, /* Tipo de Operação Contabil = Bonificação */
		   'RECEBIMENTO BONIFICAÇÃO/DOAÇÃO/BRINDE' as desc_tipo_operacao, /* Tipo de Operação Contabil = Bonificação */
		   gerar_wf, 
		   chave_processo_se, 
		   erp_distribuicao, 
		   erp_manual, 
		   erp_liberado_cq, 
		   erp_faturado, 
		   erp_cab_opcao, 
		   erp_cab_cod_bolacha 
	FROM   compras 
	where pedido = @PEDIDO_ORIGEM


	/* COLUNAS NÃO NULAS DA TABELA COMPRAS_PRODUTO
		
		PRODUTO				=> PEGAR DO PEDIDO ORIGINAL
		PEDIDO				=> @newpedido
		ENTREGA				=> PARAMETRO PASSADO PARA A PROC
		COR_PRODUTO			=> PEGAR DO PEDIDO ORIGINAL
		LIMITE_ENTREGA		=> PARAMETRO PASSADO PARA A PROC
		CUSTO1				=> PEGAR DO PEDIDO ORIGINAL
		CUSTO2				=> PREENCHER COM 0.00
		CUSTO3				=> PREENCHER COM 0.00
		CUSTO4				=> PREENCHER COM 0.00
		CUSTO_MOEDA1		=> PREENCHER COM 0.00
		CUSTO_MOEDA2		=> PREENCHER COM 0.00
		CUSTO_MOEDA3		=> PREENCHER COM 0.00
		CUSTO_MOEDA4		=> PREENCHER COM 0.00
		ERP_CONJUNTO		=> PEGAR DO PEDIDO ORIGINAL SE VERDADEIRO, PREENCHER TAMBEM A COLUNA ERP_COR_PRODUTO2 DO PEDIDO ORIGINAL

	*/

	INSERT INTO COMPRAS_PRODUTO
		  (produto, pedido, entrega, cor_produto, limite_entrega, requisicao, custo1, custo2, custo3, custo4, 
		   custo_moeda1, custo_moeda2, custo_moeda3, custo_moeda4, qtde_original, qtde_cancelada, qtde_entregue, 
		   qtde_entregar, valor_original, valor_entregue, valor_entregar, desconto_item, ipi, packs, 
		   co1, co2, co3, co4, co5, co6, co7, co8, co9, co10, co11, co12, co13, co14, co15, co16, co17, co18, co19, co20, 
		   co21, co22, co23, co24, co25, co26, co27, co28, co29, co30, co31, co32, co33, co34, co35, co36, co37, co38, co39, 
		   co40, co41, co42, co43, co44, co45, co46, co47, co48, ce1, ce2, ce3, ce4, ce5, ce6, ce7, ce8, ce9, ce10, ce11, ce12, 
		   ce13, ce14, ce15, ce16, ce17, ce18, ce19, ce20, ce21, ce22, ce23, ce24, ce25, ce26, ce27, ce28, ce29, ce30, ce31, 
		   ce32, ce33, ce34, ce35, ce36, ce37, ce38, ce39, ce40, ce41, ce42, ce43, ce44, ce45, ce46, ce47, ce48, 
		   data_para_transferencia, erp_cups_packs_por_caixa, erp_cups_custo_fob, erp_perc_margem, erp_cups_sequencia, 
		   erp_cups_custo_fob_minimo, qtde, erp_verbas_empenho, erp_verbas_data_empenho, erp_verbas_empenho_ano_mes, 
		   erp_verbas_status_pr, data_acerto_consignacao, erp_conjunto, erp_cor_produto2)
	SELECT produto, @newpedido, entrega, cor_produto, limite_entrega, requisicao, custo1, custo2, custo3, custo4, 
			custo_moeda1, custo_moeda2, custo_moeda3, custo_moeda4, qtde_original, qtde_cancelada, qtde_entregue, qtde_entregar, 
			valor_original, valor_entregue, valor_entregar, desconto_item, ipi, packs, co1, co2, co3, co4, co5, co6, co7, co8, co9, 
			co10, co11, co12, co13, co14, co15, co16, co17, co18, co19, co20, co21, co22, co23, co24, co25, co26, co27, co28, co29, 
			co30, co31, co32, co33, co34, co35, co36, co37, co38, co39, co40, co41, co42, co43, co44, co45, co46, co47, co48, ce1, 
			ce2, ce3, ce4, ce5, ce6, ce7, ce8, ce9, ce10, ce11, ce12, ce13, ce14, ce15, ce16, ce17, ce18, ce19, ce20, ce21, ce22, 
			ce23, ce24, ce25, ce26, ce27, ce28, ce29, ce30, ce31, ce32, ce33, ce34, ce35, ce36, ce37, ce38, ce39, ce40, ce41, ce42, 
			ce43, ce44, ce45, ce46, ce47, ce48, data_para_transferencia, erp_cups_packs_por_caixa, erp_cups_custo_fob, erp_perc_margem, 
			erp_cups_sequencia, erp_cups_custo_fob_minimo, qtde, erp_verbas_empenho, erp_verbas_data_empenho, erp_verbas_empenho_ano_mes, 
			erp_verbas_status_pr, data_acerto_consignacao, erp_conjunto, erp_cor_produto2 
	FROM   compras_produto 
	where pedido = @PEDIDO_ORIGEM

	INSERT INTO PROP_COMPRAS (PROPRIEDADE,PEDIDO,ITEM_PROPRIEDADE,VALOR_PROPRIEDADE,DATA_PARA_TRANSFERENCIA)
	select	PROPRIEDADE,
			@newpedido,
			ITEM_PROPRIEDADE,
			VALOR_PROPRIEDADE,
			DATA_PARA_TRANSFERENCIA 
	from prop_compras where pedido = @PEDIDO_ORIGEM

	IF EXISTS(SELECT 1 FROM PROP_COMPRAS WHERE PEDIDO=@newpedido AND PROPRIEDADE='00093')
	BEGIN
		UPDATE PROP_COMPRAS
		SET VALOR_PROPRIEDADE = 'SIM' /* PROPRIEDADE BONIFICADO = 'SIM' */
		WHERE PEDIDO=@newpedido AND PROPRIEDADE='00093'
	END
	ELSE
	BEGIN
		INSERT INTO PROP_COMPRAS (PROPRIEDADE,PEDIDO,ITEM_PROPRIEDADE,VALOR_PROPRIEDADE,DATA_PARA_TRANSFERENCIA)
		VALUES ('00093',@newpedido,1,'SIM',GETDATE())
	END

	INSERT INTO CAEDU_COMPRAS_PRODUTOS_PACKS (PEDIDO,PRODUTO,COR_PRODUTO,DESC_COR_PRODUTO,QTDE,Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, 
												Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, 
												Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, 
												Q44, Q45, Q46, Q47, Q48)
	SELECT @newpedido,PRODUTO,COR_PRODUTO,DESC_COR_PRODUTO,QTDE,Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, 
			Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, 
			Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48
	FROM CAEDU_COMPRAS_PRODUTOS_PACKS
	where pedido = @PEDIDO_ORIGEM

	INSERT INTO CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL (PEDIDO,PRODUTO,QTDE,Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, 
												Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, 
												Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, 
												Q44, Q45, Q46, Q47, Q48)
	SELECT @newpedido,PRODUTO,QTDE,Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, 
			Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, 
			Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48
	FROM CAEDU_COMPRAS_PRODUTOS_PACKS
	where pedido = @PEDIDO_ORIGEM


END


select * from compras where (TOT_QTDE_ORIGINAL=TOT_QTDE_ENTREGAR) order by EMISSAO DESC