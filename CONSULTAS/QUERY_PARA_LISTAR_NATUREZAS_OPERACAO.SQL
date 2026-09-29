-- SAIDAS
SELECT naturezas_saidas.natureza_saida, 
       naturezas_saidas.desc_natureza, 
       naturezas_saidas.desc_nf, 
       naturezas_saidas.acerto_contas, 
       naturezas_saidas.irrf, 
       naturezas_saidas.possui_icms, 
       naturezas_saidas.inativo, 
       naturezas_saidas.obs1, 
       naturezas_saidas.obs2, 
       naturezas_saidas.lx_tipo_lancamento, 
       ctb_lx_lancamento_tipo.desc_tipo_lancamento, 
       naturezas_saidas.lancamento_padrao, 
       ctb_lanc_padrao.desc_lancamento_padrao, 
       ctb_lx_tipo_operacao.desc_tipo_operacao, 
       naturezas_saidas.ctb_tipo_operacao, 
       naturezas_saidas.tipo_operacao, 
       ctb_lx_tipo_operacao.gera_financeiro, 
       naturezas_saidas.nao_mostra_valores, 
       naturezas_saidas.natureza_entrada_automatica, 
       naturezas_entradas.desc_natureza         AS DESC_NATUREZA_ENTRADA, 
       naturezas_saidas.lancamento_padrao_imposto, 
       CTB_LANC_PADRAO_A.desc_lancamento_padrao AS DESC_LANCAMENTO_PADRAO1, 
       naturezas_saidas.cm_item_composicao, 
       cm_item_composicao.desc_item_composicao 
FROM   naturezas_saidas 
       LEFT JOIN ctb_lanc_padrao CTB_LANC_PADRAO_A 
              ON naturezas_saidas.lancamento_padrao_imposto = 
                 CTB_LANC_PADRAO_A.lancamento_padrao 
       LEFT JOIN ctb_lx_lancamento_tipo 
              ON naturezas_saidas.lx_tipo_lancamento = 
                 ctb_lx_lancamento_tipo.lx_tipo_lancamento 
       LEFT JOIN ctb_lanc_padrao 
              ON naturezas_saidas.lancamento_padrao = 
                 ctb_lanc_padrao.lancamento_padrao 
       LEFT JOIN ctb_lx_tipo_operacao 
              ON naturezas_saidas.ctb_tipo_operacao = 
                 ctb_lx_tipo_operacao.ctb_tipo_operacao 
       LEFT JOIN naturezas_entradas 
              ON naturezas_saidas.natureza_entrada_automatica = 
                 naturezas_entradas.natureza 
       LEFT JOIN cm_item_composicao 
              ON naturezas_saidas.cm_item_composicao = 
                 cm_item_composicao.item_composicao 
				 

-- ENTRADAS
SELECT naturezas_entradas.natureza, 
       naturezas_entradas.desc_natureza, 
       naturezas_entradas.tipo_operacao, 
       naturezas_entradas.desc_nf, 
       naturezas_entradas.inativo, 
       naturezas_entradas.obs1, 
       naturezas_entradas.obs2, 
       naturezas_entradas.lx_tipo_lancamento, 
       ctb_lx_lancamento_tipo.desc_tipo_lancamento, 
       naturezas_entradas.lancamento_padrao, 
       ctb_lanc_padrao.desc_lancamento_padrao, 
       ctb_lx_tipo_operacao.desc_tipo_operacao, 
       ctb_lx_tipo_operacao.indica_entrada_saida, 
       naturezas_entradas.ctb_tipo_operacao, 
       ctb_lx_tipo_operacao.gera_financeiro, 
       naturezas_entradas.nao_mostra_valores, 
       naturezas_entradas.lancamento_padrao_imposto, 
       CTB_LANC_PADRAO_A.desc_lancamento_padrao, 
       naturezas_entradas.cm_item_composicao, 
       cm_item_composicao.desc_item_composicao 
FROM   naturezas_entradas 
       LEFT JOIN ctb_lanc_padrao CTB_LANC_PADRAO_A 
              ON naturezas_entradas.lancamento_padrao_imposto = 
                 CTB_LANC_PADRAO_A.lancamento_padrao 
       LEFT JOIN ctb_lx_lancamento_tipo 
              ON naturezas_entradas.lx_tipo_lancamento = 
                 ctb_lx_lancamento_tipo.lx_tipo_lancamento 
       LEFT JOIN ctb_lanc_padrao 
              ON naturezas_entradas.lancamento_padrao = 
                 ctb_lanc_padrao.lancamento_padrao 
       LEFT JOIN ctb_lx_tipo_operacao 
              ON naturezas_entradas.ctb_tipo_operacao = 
                 ctb_lx_tipo_operacao.ctb_tipo_operacao 
       LEFT JOIN cm_item_composicao 
              ON naturezas_entradas.cm_item_composicao = 
                 cm_item_composicao.item_composicao 
ORDER  BY natureza 

				 