--SELECT     ctb_excecao_imposto_item.id_excecao_imposto,
--           ctb_excecao_imposto_item.id_imposto,
--           ctb_lx_imposto_tipo.imposto,
--           ctb_excecao_imposto_item.isento_ou_outros,
--           ctb_excecao_imposto_item.porcent_reducao_de_base,
--           ctb_excecao_imposto_item.taxa_imposto,
--           ctb_excecao_imposto_item.texto_legal,
--           ctb_excecao_imposto_item.agrega_apos_desconto,
--           ctb_excecao_imposto_item.incidencia,
--           ctb_excecao_imposto_item.agrega_apos_encargo,
--           ctb_excecao_imposto_item.aplica_espelho_entrada,
--           ctb_excecao_imposto_item.porc_recuperacao,
--           ctb_excecao_imposto_item.codigo_arrecadacao,
--           ctb_excecao_imposto_item.valor_min_arrecadacao,
--           ctb_excecao_imposto_item.valor_max_arrecadacao,
--           ctb_excecao_imposto_item.valida_valor_parcela,
--           ctb_excecao_imposto_item.zera_valor_contabil,
--           ctb_excecao_imposto_item.zera_taxa_imposto,
--           ctb_excecao_imposto_item.zera_base_imposto,
--           ctb_excecao_imposto_item.zera_valor_imposto,
--           ctb_excecao_imposto_item.coluna_imp_agregado,
--           ctb_excecao_imposto_item.codigo_historico,
--           ctb_excecao_imposto_item.usa_tab_preco_base,
--           ctb_excecao_imposto_item.situacao_tributaria,
--           ctb_hist_padrao.historico_padrao,
--           ctb_excecao_imposto_item.natureza_receita,
--           ctb_excecao_imposto_item.tipo_credito,
--           ctb_excecao_imposto_item.cod_contribuicao_social_apurada,
--           ctb_excecao_imposto_item.excecao_classif_fiscal,
--           ctb_excecao_imposto_item.situacao_tributaria_municipal,
--           ctb_excecao_imposto_item.indica_rec_aliquota_base,
--           ctb_excecao_imposto_item.numero_processo,
--           ctb_excecao_imposto_item.indicador_incentivo,
--           ctb_excecao_imposto_item.cod_bc_credito,
--           ctb_excecao_imposto_item.sub_item_sped,
--           ctb_excecao_imposto_item.id_sub_item_apuracao,
--           zera_valor_excluido =  ctb_excecao_imposto_item.zera_valor_excluido,
--           id_processo_exclusao = ctb_excecao_imposto_item.id_processo,
--           numero_processo_exclusao = Isnull(processos.numero_processo, Cast('' AS VARCHAR(21)))


--update ctb_excecao_imposto_item set AGREGA_APOS_DESCONTO=1, AGREGA_APOS_ENCARGO=1
select *
FROM       ctb_excecao_imposto_item CTB_EXCECAO_IMPOSTO_ITEM
--INNER JOIN ctb_lx_imposto_tipo CTB_LX_IMPOSTO_TIPO
--ON         ctb_excecao_imposto_item.id_imposto = ctb_lx_imposto_tipo.id_imposto
--LEFT JOIN  ctb_hist_padrao
--ON         ctb_hist_padrao.codigo_historico = ctb_excecao_imposto_item.codigo_historico
--LEFT JOIN  processos
--ON         processos.id_processo = ctb_excecao_imposto_item.id_processo

update ctb_excecao_imposto_item set AGREGA_APOS_DESCONTO=1, AGREGA_APOS_ENCARGO=1
WHERE      ctb_excecao_imposto_item.id_excecao_imposto in (
'2379'
,'2351'
,'2214'
,'2078'
,'2079'
,'2080'
,'2081'
,'2061'
,'2016'
,'2028'
,'2003'
,'1965'
,'1970'
,'1971'
,'1972'
,'1973'
,'1974'
,'1946'
,'1949'
,'1950'
,'1956'
,'1959'
,'1922'
,'1906'
,'1882'
,'1850'
,'1852'
,'1853'
,'1854'
,'1855'
,'1856'
,'1866'
,'1830'
,'1831'
,'1837'
,'1841'
,'1847'
,'1827'
,'1803'
,'1787'
,'1752'
,'1753'
,'1754'
,'1755'
,'1756'
,'1762'
,'1766'
,'1728'
,'1729'
,'1710'
,'1715'
,'1723'
,'1650'
,'1636'
,'1610'
,'1611'
,'1553'
,'1558'
,'1501'
,'1506'
,'1509'
,'1515'
,'1467'
,'1469'
,'1470'
,'1473'
,'1474'
,'1480'
,'1483'
,'1485'
,'1487'
,'1446'
,'1447'
,'1463'
,'1429'
,'1430'
,'1437'
,'1440'
,'1396'
,'1408'
,'1413'
,'1415'
,'1417'
,'1384'
,'1391'
,'1333'
,'1337'
,'1304'
,'1305'
,'1306'
,'1307'
,'1308'
,'1309'
,'1310'
,'1311'
,'1312'
,'1313'
,'1314'
,'1316'
,'1317'
,'1318'
,'1328'
,'1329'
,'1274'
,'1275'
,'1235'
,'1240'
,'1245'
,'1250'
,'1254'
,'1255'
,'1220'
,'1233'
,'1183'
,'1092'
,'1095'
,'1098'
,'1099'
,'1043'
,'1015'
, '975'
, '976'
, '978'
, '931'
, '932'
, '829'
, '833'
, '843'
, '753'
, '679'
, '583'
, '367')
      
      


