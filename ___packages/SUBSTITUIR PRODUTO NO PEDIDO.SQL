CREATE PROCEDURE DBO.CGP_TROCA_PRODUTO_NO_PEDIDO
@produto_de varchar(8), 
@produto_para varchar(8)
AS
BEGIN

	--if Exists(Select * from Tempdb..SysObjects Where Name Like '#tmp_compras%')
	--begin
	--	drop table #Tmp_compras_produto
	--end

	SELECT @produto_para as produto, pedido, entrega, cor_produto, limite_entrega, requisicao, custo1, 
	 custo2, custo3, custo4, custo_moeda1, custo_moeda2, custo_moeda3, custo_moeda4, 
	 qtde_original, qtde_cancelada, qtde_entregue, qtde_entregar, valor_original, 
	 valor_entregue, valor_entregar, desconto_item, ipi, packs, co1, co2, co3, co4,  
	 co5, co6, co7, co8, co9, co10, co11, co12, co13, co14, co15, co16, co17, co18, 
	co19, co20, co21, co22, co23, co24, co25, co26, co27, co28, co29, co30, co31, 
	 co32, co33, co34, co35, co36, co37, co38, co39, co40, co41, co42, co43, co44, 
	 co45, co46, co47, co48, ce1, ce2, ce3, ce4, ce5, ce6, ce7, ce8, ce9, ce10, ce11, 
	 ce12, ce13, ce14, ce15, ce16, ce17, ce18, ce19, ce20, ce21, ce22, ce23, ce24,  
	 ce25, ce26, ce27, ce28, ce29, ce30, ce31, ce32, ce33, ce34, ce35, ce36, ce37, 
	 ce38, ce39, ce40, ce41, ce42, ce43, ce44, ce45, ce46, ce47, ce48, 
	 entregue_moeda_padrao, chegada_prevista, obs_item,  
	 data_confirmacao, data_para_transferencia, qtde_compra_rateio, 
	 valor_compra_rateio, cod_alocacao, multiplicador_alocacao, 
	 quantidade_agendamento, quantidade_cancelamento, erp_cups_packs_por_caixa, 
	 erp_cups_custo_fob, erp_perc_margem, erp_cups_sequencia, 
	 erp_cups_custo_fob_minimo, qtde, erp_verbas_empenho, erp_verbas_data_empenho, 
	 erp_verbas_empenho_ano_mes, erp_verbas_status_pr, data_acerto_consignacao, 
	 erp_conjunto, erp_cor_produto2
	 into #Tmp_compras_produto
	 FROM COMPRAS_PRODUTO
	 WHERE qtde_entregar > 0 and PRODUTO = @produto_de 
 
	 delete from compras_produto 
	 where produto = @produto_de AND PEDIDO IN 
	 (select PEDIDO from #Tmp_compras_produto)

	 INSERT INTO COMPRAS_PRODUTO
	 (produto, pedido, entrega, cor_produto, limite_entrega, requisicao, custo1, 
	 custo2, custo3, custo4, custo_moeda1, custo_moeda2, custo_moeda3, custo_moeda4, 
	 qtde_original, qtde_cancelada, qtde_entregue, qtde_entregar, valor_original, 
	 valor_entregue, valor_entregar, desconto_item, ipi, packs, co1, co2, co3, co4,  
	 co5, co6, co7, co8, co9, co10, co11, co12, co13, co14, co15, co16, co17, co18, 
	co19, co20, co21, co22, co23, co24, co25, co26, co27, co28, co29, co30, co31, 
	 co32, co33, co34, co35, co36, co37, co38, co39, co40, co41, co42, co43, co44, 
	 co45, co46, co47, co48, ce1, ce2, ce3, ce4, ce5, ce6, ce7, ce8, ce9, ce10, ce11, 
	 ce12, ce13, ce14, ce15, ce16, ce17, ce18, ce19, ce20, ce21, ce22, ce23, ce24,  
	 ce25, ce26, ce27, ce28, ce29, ce30, ce31, ce32, ce33, ce34, ce35, ce36, ce37, 
	 ce38, ce39, ce40, ce41, ce42, ce43, ce44, ce45, ce46, ce47, ce48, 
	 entregue_moeda_padrao, chegada_prevista, obs_item,  
	 data_confirmacao, data_para_transferencia, qtde_compra_rateio, 
	 valor_compra_rateio, cod_alocacao, multiplicador_alocacao, 
	 quantidade_agendamento, quantidade_cancelamento, erp_cups_packs_por_caixa, 
	 erp_cups_custo_fob, erp_perc_margem, erp_cups_sequencia, 
	 erp_cups_custo_fob_minimo, qtde, erp_verbas_empenho, erp_verbas_data_empenho, 
	 erp_verbas_empenho_ano_mes, erp_verbas_status_pr, data_acerto_consignacao, 
	 erp_conjunto, erp_cor_produto2
	 )
	 SELECT produto, pedido, entrega, cor_produto, limite_entrega, requisicao, custo1, 
	 custo2, custo3, custo4, custo_moeda1, custo_moeda2, custo_moeda3, custo_moeda4, 
	 qtde_original, qtde_cancelada, qtde_entregue, qtde_entregar, valor_original, 
	 valor_entregue, valor_entregar, desconto_item, ipi, packs, co1, co2, co3, co4,  
	 co5, co6, co7, co8, co9, co10, co11, co12, co13, co14, co15, co16, co17, co18, 
	co19, co20, co21, co22, co23, co24, co25, co26, co27, co28, co29, co30, co31, 
	 co32, co33, co34, co35, co36, co37, co38, co39, co40, co41, co42, co43, co44, 
	 co45, co46, co47, co48, ce1, ce2, ce3, ce4, ce5, ce6, ce7, ce8, ce9, ce10, ce11, 
	 ce12, ce13, ce14, ce15, ce16, ce17, ce18, ce19, ce20, ce21, ce22, ce23, ce24,  
	 ce25, ce26, ce27, ce28, ce29, ce30, ce31, ce32, ce33, ce34, ce35, ce36, ce37, 
	 ce38, ce39, ce40, ce41, ce42, ce43, ce44, ce45, ce46, ce47, ce48, 
	 entregue_moeda_padrao, chegada_prevista, obs_item,  
	 data_confirmacao, data_para_transferencia, qtde_compra_rateio, 
	 valor_compra_rateio, cod_alocacao, multiplicador_alocacao, 
	 quantidade_agendamento, quantidade_cancelamento, erp_cups_packs_por_caixa, 
	 erp_cups_custo_fob, erp_perc_margem, erp_cups_sequencia, 
	 erp_cups_custo_fob_minimo, qtde, erp_verbas_empenho, erp_verbas_data_empenho, 
	 erp_verbas_empenho_ano_mes, erp_verbas_status_pr, data_acerto_consignacao, 
	 erp_conjunto, erp_cor_produto2
	 FROM #Tmp_compras_produto

	 UPDATE A SET PRODUTO = @produto_para
	 FROM caedu_compras_produtos_packs A
	 INNER JOIN #Tmp_compras_produto B ON B.PEDIDO = A.PEDIDO

END
