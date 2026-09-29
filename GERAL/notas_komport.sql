SELECT     entradas.nf_entrada, 
           Isnull(dados_cadastro_xml_nfe.nome_clifor, entradas.nome_clifor) AS nome_clifor, 
           entradas.obs, 
           cadastro_cli_for.clifor, 
           Isnull(dados_cadastro_xml_nfe.uf, cadastro_cli_for.uf) AS uf, 
           cadastro_cli_for.conta_contabil, 
           Isnull(dados_cadastro_xml_nfe.cgc_destinatario, cadastro_cli_for.cgc_cpf) AS cgc_cpf,
           cadastro_cli_for.possui_recargo, 
           cadastro_cli_for.pj_pf, 
           cadastro_cli_for.indicador_fiscal_terceiro, 
           ctb_lx_indicador_fiscal_terceiro.descricao_fiscal_terceiro, 
           cadastro_cli_for.pais, 
           Isnull(dados_cadastro_xml_nfe.razao_social, cadastro_cli_for.razao_social) AS razao_social,
           Isnull(dados_cadastro_xml_nfe.rg_ie, cadastro_cli_for.rg_ie)               AS rg_ie, 
           cadastro_cli_for.aceita_dias_fixo, 
           Isnull(dados_cadastro_xml_nfe.endereco, cadastro_cli_for.endereco) AS endereco, 
           Isnull(dados_cadastro_xml_nfe.bairro, cadastro_cli_for.bairro)     AS bairro, 
           Isnull(dados_cadastro_xml_nfe.cep, cadastro_cli_for.cep)           AS cep, 
           Isnull(dados_cadastro_xml_nfe.cidade, cadastro_cli_for.cidade)     AS cidade, 
           Isnull(dados_cadastro_xml_nfe.uf, cadastro_cli_for.uf)             AS uf, 
           cadastro_cli_for.ddi, 
           cadastro_cli_for.ddd1, 
           Isnull(dados_cadastro_xml_nfe.telefone_destinatario, cadastro_cli_for.telefone1) AS telefone1,
           cadastro_cli_for.ramal1, 
           cadastro_cli_for.ddd2, 
           cadastro_cli_for.telefone2, 
           cadastro_cli_for.ramal2, 
           cadastro_cli_for.dddfax, 
           cadastro_cli_for.fax, 
           cadastro_cli_for.contato, 
           cadastro_cli_for.email, 
           entradas.emissao, 
           entradas.filial_entrada, 
           entradas.filial_cobranca, 
           entradas.filial, 
           filiais.clifor, 
           filiais.cod_filial, 
           entradas.empresa, 
           filiais.estoque_ctrl_peca, 
           cadastro_cli_for_a.uf   AS filial_uf, 
           cadastro_cli_for_a.pais AS filial_pais, 
           entradas.agrupamento_itens, 
           entradas.fatura, 
           entradas.cod_transacao, 
           entradas.natureza, 
           naturezas_entradas.desc_natureza, 
           naturezas_entradas.ctb_tipo_operacao, 
           ctb_lx_tipo_operacao.desc_tipo_operacao, 
           ctb_lx_tipo_operacao.tipo_operacao, 
           naturezas_entradas.nao_mostra_valores, 
           entradas.condicao_pgto, 
           cond_ent_pgtos.desc_cond_pgto, 
           cond_ent_pgtos.tipo_condicao, 
           entradas.recebimento, 
           entradas.nf_fatura, 
           entradas.serie_nf_entrada, 
           entradas.acerto_contas_p_r, 
           entradas.nf_propria_emitida, 
           entradas.nf_entrada_propria, 
           entradas.tabela_filha, 
           entradas.transf_filial, 
           entradas.lancamento, 
           entradas.tipo_entradas, 
           entradas.transportadora_a_pagar, 
           entradas.nf_entrada_conhecimento, 
           entradas.numero_conhecimento_relacionado, 
           entradas.moeda, 
           entradas.moeda_compra, 
           entradas.importacao, 
           entradas.data_digitacao, 
           entradas.origem, 
           entradas.conferencia, 
           entradas.embalagens, 
           cast((entradas.valor_total * power(( 
           CASE 
                      WHEN Isnull(cambio_na_data, 0) = 0 THEN 1 
                      ELSE cambio_na_data 
           END), (( 
           CASE 
                      WHEN dbo.fx_parametro('cambio_na_moeda_padrao') = '.t.' THEN 1 
                      ELSE -1 
           END) * -1))) AS                                                                                                                                                                                                        numeric(14, 2)) AS total_moeda_entrada,
           cast((valor_total + valor_frete_transportadora + importacao_imposto + importacao_icms + importacao_ipi + importacao_alfandega + importacao_outras_despesas + importacao_frete + importacao_seguro + importacao_desembaraco) AS numeric(14, 2)) AS total_geral_entrada,
           cast(0 AS                                                                                                                                                                                                        numeric(8, 2))  AS porc_total_geral,
           entradas.ctb_lancamento, 
           entradas.ctb_item, 
           entradas.tipo_volume, 
           entradas.rateio_filial, 
           ctb_filial_rateio.desc_rateio_filial, 
           entradas.rateio_centro_custo, 
           ctb_centro_custo_rateio.desc_rateio_centro_custo, 
           entradas.comprimento_de_rolos, 
           entradas.data_faturamento_relativo, 
           entradas.utiliza_dias_fixos_fornecedor, 
           entradas.nome_clifor_triangular, 
           entradas.serie_nf, 
           series_nf.descricao, 
           entradas.numero_conferencia, 
           entradas.numero_entrada, 
           entradas.fatura_nome_clifor, 
           entradas.fatura_serie, 
           entradas.fatura_numero, 
           entradas.marca_exportacao, 
           entradas.atualizacao_exportar, 
           entradas.data_exportacao, 
           entradas.status_transito, 
           filiais.empresa, 
           entradas.diferenca_valor, 
           entradas.frete, 
           entradas.seguro, 
           entradas.desconto, 
           entradas.encargo, 
           entradas.qtde_total, 
           entradas.qtde_total_aux, 
           entradas.valor_total, 
           entradas.devolucao, 
           entradas.frete_a_pagar, 
           entradas.importacao_imposto, 
           entradas.importacao_icms, 
           entradas.importacao_ipi, 
           entradas.importacao_alfandega, 
           entradas.importacao_outras_despesas, 
           entradas.importacao_frete, 
           entradas.importacao_seguro, 
           entradas.importacao_desembaraco, 
           entradas.peso, 
           entradas.peso_bruto, 
           entradas.porc_desconto, 
           entradas.porc_encargo, 
           entradas.comissao_valor, 
           entradas.comissao_valor_gerente, 
           entradas.porc_desconto_digitado, 
           entradas.valor_imposto_agregar, 
           entradas.valor_sub_itens, 
           entradas.valor_frete_transportadora, 
           entradas.cambio_na_data, 
           entradas.item_digitado, 
           CONVERT(bit, 0) AS sequencial_por_filial, 
           entradas.filial_saida, 
           entradas.nf_saida, 
           entradas.serie_nf_saida, 
           ctb_lx_tipo_operacao.gera_financeiro, 
           naturezas_entradas.lx_tipo_lancamento, 
           isnull(filiais.matriz_fiscal, filiais.filial) AS filial_matriz_fiscal, 
           isnull(filiais.matriz, filiais.filial)        AS filial_matriz_contabil, 
           cadastro_cli_for.indica_filial, 
           entradas.especie_serie, 
           ctb_especie_serie.desc_especie_serie, 
           entradas.valor_cancelado, 
           entradas.qtde_cancelada, 
           entradas.data_cancelamento, 
           entradas.nota_cancelada, 
           entradas.nota_complementar, 
           filiais_cobranca.cod_filial AS cod_filial_cobranca, 
           entradas.cod_clifor_sacado, 
           sacado.nome_clifor AS nome_sacado, 
           entradas.importacao_tx_capatazia, 
           entradas.sequencial_unico, 
           entradas.data_geracao_nsu, 
           cast(( 
           CASE 
                      WHEN isnull(entradas.codigo_cliente_varejo, '''') = '''' THEN 0 
                      ELSE 1 
           END) AS bit) AS utiliza_cliente_varejo, 
           entradas.codigo_cliente_varejo, 
           clientes_varejo.cliente_varejo, 
           entradas.protocolo_autorizacao_nfe, 
           entradas.status_nfe, 
           entradas.chave_nfe, 
           entradas.log_status_nfe, 
           entradas.motivo_cancelamento_nfe, 
           entradas.priorizacao, 
           entradas.tipo_emissao_nfe, 
           entradas.fin_emissao_nfe, 
           entradas.data_autorizacao_nfe, 
           entradas.registro_dpec, 
           entradas.data_registro_dpec, 
           entradas.protocolo_cancelamento_nfe, 
           entradas.obs_interesse_fisco, 
           entradas.cfop_cancelamento, 
           ctb_especie_serie.numero_modelo_fiscal, 
           entradas.data_contingencia, 
           entradas.justificativa_contingencia, 
           clientes_varejo.pf_pj                                                          AS cv_pf_pj,
           isnull(dados_cadastro_xml_nfe.cgc_destinatario, clientes_varejo.cpf_cgc)       AS cv_cpf_cgc,
           isnull(dados_cadastro_xml_nfe.rg_ie, clientes_varejo.rg_ie)                    AS cv_rg_ie,
           isnull(dados_cadastro_xml_nfe.endereco, clientes_varejo.endereco)              AS cv_endereco,
           isnull(dados_cadastro_xml_nfe.numero, clientes_varejo.numero)                  AS cv_numero,
           isnull(dados_cadastro_xml_nfe.complemento, clientes_varejo.complemento)        AS cv_complemento,
           isnull(dados_cadastro_xml_nfe.bairro, clientes_varejo.bairro)                  AS cv_bairro,
           isnull(dados_cadastro_xml_nfe.cidade, clientes_varejo.cidade)                  AS cv_cidade,
           isnull(dados_cadastro_xml_nfe.uf, clientes_varejo.uf)                          AS cv_uf,
           isnull(dados_cadastro_xml_nfe.telefone_destinatario, clientes_varejo.telefone) AS cv_telefone,
           isnull(dados_cadastro_xml_nfe.cep, clientes_varejo.cep)                        AS cv_cep,
           clientes_varejo.pais                                                           AS cv_pais,
           entradas.ind_nat_frt, 
           entradas.veiculo_placa, 
           entradas.marca_volumes, 
           entradas.numeracao_volumes, 
           entradas.uf_placa_veiculo, 
           entradas.calculo_pis_cofins, 
           entradas.entrada_xml, 
           entradas.calculo_icms_reduzido, 
           entradas.indica_presenca_comprador, 
           entradas.data_hora_emissao, 
           entradas.utc_emissao, 
           entradas.utc_data_autorizacao_nfe, 
           series_nf.cod_serie_sintegra AS serie_oficial, 
           entradas.indica_entrada_automatica, 
           entradas.construcao_civil, 
           entradas.info_pgto, 
           info_pgto.desc_info_pgto, 
           entradas.cadastro_cno 
FROM       entradas 
INNER JOIN cadastro_cli_for 
ON         entradas.nome_clifor = cadastro_cli_for.nome_clifor 
INNER JOIN cadastro_cli_for AS sacado 
ON         entradas.cod_clifor_sacado = sacado.cod_clifor 
INNER JOIN filiais 
ON         entradas.filial = filiais.filial 
LEFT JOIN  cadastro_cli_for AS cadastro_cli_for_a 
ON         filiais.filial = cadastro_cli_for_a.nome_clifor 
INNER JOIN naturezas_entradas 
ON         entradas.natureza = naturezas_entradas.natureza 
INNER JOIN ctb_lx_tipo_operacao 
ON         ctb_lx_tipo_operacao.ctb_tipo_operacao = naturezas_entradas.ctb_tipo_operacao 
INNER JOIN cond_ent_pgtos 
ON         entradas.condicao_pgto = cond_ent_pgtos.condicao_pgto 
LEFT JOIN  series_nf 
ON         entradas.serie_nf = series_nf.serie_nf 
LEFT JOIN  ctb_filial_rateio 
ON         entradas.rateio_filial = ctb_filial_rateio.rateio_filial 
LEFT JOIN  ctb_centro_custo_rateio 
ON         entradas.rateio_centro_custo = ctb_centro_custo_rateio.rateio_centro_custo 
LEFT JOIN  ctb_lx_indicador_fiscal_terceiro 
ON         cadastro_cli_for.indicador_fiscal_terceiro = ctb_lx_indicador_fiscal_terceiro.indicador_fiscal_terceiro
LEFT JOIN  filiais AS filiais_cobranca 
ON         entradas.filial_cobranca = filiais_cobranca.filial 
LEFT JOIN  ctb_especie_serie 
ON         ctb_especie_serie.especie_serie = entradas.especie_serie 
LEFT JOIN  clientes_varejo 
ON         entradas.codigo_cliente_varejo = clientes_varejo.codigo_cliente 
LEFT JOIN  dados_cadastro_xml_nfe 
ON         dados_cadastro_xml_nfe.chave_nfe = entradas.chave_nfe 
AND        entradas.nf_entrada = dados_cadastro_xml_nfe.nf_entrada 
AND        entradas.serie_nf_entrada =dados_cadastro_xml_nfe.serie_nf_entrada 
AND        entradas.nome_clifor = dados_cadastro_xml_nfe.nome_clifor 
LEFT JOIN  info_pgto 
ON         info_pgto.id_info_pgto = entradas.info_pgto 
WHERE      entradas.emissao >= '20180101' 
AND        entradas.emissao <= '20181231' 
AND        entradas.nome_clifor = 'KOMPORT' 
AND        entradas.cod_transacao = 'ENTRADAS_102' 
AND        filiais.matriz IN ('MATRIZ')