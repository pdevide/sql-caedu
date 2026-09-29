--SELECT ctb_excecao_imposto.id_excecao_imposto, 
--       ctb_excecao_imposto.desc_excecao, 
--       ctb_excecao_imposto.ctb_tipo_operacao, 
--       ctb_excecao_imposto.id_excecao_grupo, 
--       ctb_excecao_grupo.desc_excecao_grupo, 
--       ctb_lx_tipo_operacao.desc_tipo_operacao, 
--       ctb_excecao_imposto.codigo_fiscal_operacao, 
--       ctb_lx_naturezas_operacao.denominacao, 
--       ctb_excecao_imposto.indicador_cfop, 
--       ctb_lx_indicador_cfop.descricao_indicador_cfop, 
--       ctb_excecao_imposto.indicador_fiscal_terceiro, 
--       ctb_lx_indicador_fiscal_terceiro.descricao_fiscal_terceiro, 
--       ctb_excecao_imposto.uf, 
--       unidades_federacao.desc_uf, 
--       ctb_excecao_imposto.desc_detalhada, 
--       ctb_excecao_imposto.inativo, 
--       ctb_excecao_imposto.nao_fatura, 
--       ctb_excecao_imposto.uf_filial, 
--       ctb_excecao_imposto.exclusivo_cadastro, 
--       ctb_excecao_imposto.aplica_entrada, 
--       ctb_excecao_imposto.aplica_saida, 
--       ctb_excecao_imposto.dt_inicio_vigencia, 
--       ctb_excecao_imposto.dt_fim_vigencia, 
--       UNIDADES_FEDERACAO_A.desc_uf                      AS DESC_UF_FILIAL, 
--       ctb_excecao_imposto.tribut_origem, 
--       ctb_excecao_imposto.tribut_icms, 
--       tribut_origem.descricao                           AS DESC_TRIBUT_ORIGEM, 
--       tribut_icms.descricao                             AS DESC_TRIBUT_ICMS, 
--       ctb_excecao_imposto.nome_clifor, 
--       ctb_excecao_imposto.material, 
--       ctb_excecao_imposto.produto, 
--       produtos.desc_produto, 
--       materiais.desc_material, 
--       ctb_excecao_imposto.natureza_entrada, 
--       naturezas_entradas.desc_natureza                  AS 
--       DESC_NATUREZA_ENTRADA, 
--       ctb_excecao_imposto.natureza_saida, 
--       naturezas_saidas.desc_natureza                    AS DESC_NATUREZA_SAIDA, 
--       ctb_excecao_imposto.cod_filial, 
--       filiais.filial, 
--       ctb_excecao_imposto.cfop_obrigatorio, 
--       CTB_LX_NATUREZAS_OPERACAO_OBRIGATORIO.denominacao AS 
--       DENOMINACAO_OBRIGATORIO, 
--       ctb_excecao_imposto.classif_fiscal_ini, 
--       ctb_excecao_imposto.classif_fiscal_fim, 
--       ctb_excecao_imposto.codigo_enquadramento, 
--       ctb_excecao_imposto.codigo_classe_tributacao, 
--       lx_enquadramento_ipi.desc_enquadramento, 
--       ctb_excecao_imposto.codigo_item, 
--       cadastro_item_fiscal.item_descricao, 
--       ctb_excecao_imposto.matriz_fiscal,
--	   ctb_excecao_imposto.DATA_PARA_TRANSFERENCIA 
--FROM   ctb_excecao_imposto CTB_EXCECAO_IMPOSTO 
--       LEFT JOIN dbo.ctb_lx_tipo_operacao CTB_LX_TIPO_OPERACAO 
--              ON ctb_excecao_imposto.ctb_tipo_operacao = 
--                 ctb_lx_tipo_operacao.ctb_tipo_operacao 
--       LEFT JOIN dbo.tribut_origem TRIBUT_ORIGEM 
--              ON ctb_excecao_imposto.tribut_origem = tribut_origem.tribut_origem 
--       LEFT JOIN dbo.tribut_icms TRIBUT_ICMS 
--              ON ctb_excecao_imposto.tribut_icms = tribut_icms.tribut_icms 
--       LEFT JOIN dbo.unidades_federacao UNIDADES_FEDERACAO 
--              ON ctb_excecao_imposto.uf = unidades_federacao.uf 
--       LEFT JOIN dbo.ctb_lx_naturezas_operacao CTB_LX_NATUREZAS_OPERACAO 
--              ON ctb_excecao_imposto.codigo_fiscal_operacao = 
--                 ctb_lx_naturezas_operacao.codigo_fiscal_operacao 
--       LEFT JOIN dbo.ctb_lx_naturezas_operacao 
--                 CTB_LX_NATUREZAS_OPERACAO_OBRIGATORIO 
--              ON ctb_excecao_imposto.cfop_obrigatorio = 
--                 CTB_LX_NATUREZAS_OPERACAO_OBRIGATORIO .codigo_fiscal_operacao 
--       LEFT JOIN dbo.ctb_lx_indicador_fiscal_terceiro 
--                 CTB_LX_INDICADOR_FISCAL_TERCEIRO 
--              ON ctb_excecao_imposto.indicador_fiscal_terceiro = 
--                 ctb_lx_indicador_fiscal_terceiro.indicador_fiscal_terceiro 
--       LEFT JOIN dbo.ctb_lx_indicador_cfop CTB_LX_INDICADOR_CFOP 
--              ON ctb_excecao_imposto.indicador_cfop = 
--                 ctb_lx_indicador_cfop.indicador_cfop 
--       LEFT JOIN dbo.unidades_federacao UNIDADES_FEDERACAO_A 
--              ON ctb_excecao_imposto.uf_filial = UNIDADES_FEDERACAO_A.uf 
--       LEFT JOIN produtos 
--              ON ctb_excecao_imposto.produto = produtos.produto 
--       LEFT JOIN materiais 
--              ON ctb_excecao_imposto.material = materiais.material 
--       LEFT JOIN naturezas_entradas 
--              ON ctb_excecao_imposto.natureza_entrada = 
--                 naturezas_entradas.natureza 
--       LEFT JOIN naturezas_saidas 
--              ON ctb_excecao_imposto.natureza_saida = 
--                 naturezas_saidas.natureza_saida 
--       LEFT JOIN ctb_excecao_grupo 
--              ON ctb_excecao_imposto.id_excecao_grupo = 
--                 ctb_excecao_grupo.id_excecao_grupo 
--       LEFT JOIN filiais 
--              ON filiais.cod_filial = ctb_excecao_imposto.cod_filial 
--       LEFT JOIN lx_enquadramento_ipi 
--              ON ctb_excecao_imposto.codigo_enquadramento = 
--                 lx_enquadramento_ipi.codigo_enquadramento 
--       LEFT JOIN cadastro_item_fiscal 
--              ON cadastro_item_fiscal.codigo_item = 
--                 ctb_excecao_imposto.codigo_item 
--/*#28# LEFT JOIN FILIAIS MF ON MF.MATRIZ_FISCAL = CTB_EXCECAO_IMPOSTO.MATRIZ_FISCAL*/ 
--WHERE  ( filiais.matriz IN ( 'MATRIZ' ) 
--          OR filiais.matriz IS NULL ) 
--and DESC_EXCECAO like '%TRANSF%ATIVO%' AND ctb_excecao_imposto.INATIVO = 0
----AND ctb_excecao_imposto.ID_EXCECAO_IMPOSTO=9



/*

BEGIN TRAN
UPDATE ctb_excecao_imposto
SET INATIVO = 1 WHERE ctb_excecao_imposto.id_excecao_imposto IN (
258,287,306,313,317,320,321,335,348,356,357,358,375,377,378,379,392,412,413,414,420,422,429,444,445,446,461,
462,495,506,517,539,553,568,569,582,610,626,683,761,762, 127,132)
COMMIT

BEGIN TRAN
UPDATE ctb_excecao_imposto
SET INATIVO = 1 WHERE ctb_excecao_imposto.id_excecao_imposto IN (
140,202,203,259,269,270,271,272,274,286,315,330,350,362,363,370,405,407,411,418,419,426,428,449,513,514,518,526,528,529,542,
547,566,581,589,590,591,593,596,597,599,608)
COMMIT

BEGIN TRAN
UPDATE ctb_excecao_imposto
SET INATIVO = 1 WHERE ctb_excecao_imposto.id_excecao_imposto IN (
561,530,282,133,805,806,606,627,612,769,544,316,331,332,333,334,471,544,602,603,612,632,648,
195,351,643,660,693,122,302,385,475,476,477,533,700,702,704,93,541,281,595)
COMMIT

SELECT * FROM PARAMETROS WHERE PARAMETRO IN ('VERSAO_LAYOUT_XML_NFE','PASTA_SCHEMA_XML_NFE_SEFA','PASTA_SCHEMA_XML_NFE')


UPDATE PARAMETROS SET VALOR_ATUAL = '4.00' WHERE PARAMETRO = 'VERSAO_LAYOUT_XML_NFE' ;
UPDATE PARAMETROS SET VALOR_ATUAL = '\SCHEMA\SEFAZ\NFE_V4.00.XSD' WHERE PARAMETRO = 'PASTA_SCHEMA_XML_NFE_SEFA' ;
UPDATE PARAMETROS SET VALOR_ATUAL = '\SCHEMA\NFE_V4.00.XSD' WHERE PARAMETRO = 'PASTA_SCHEMA_XML_NFE' ;



VERSAO_LAYOUT_XML_NFE 	4.00
PASTA_SCHEMA_XML_NFE_SEFAZ	\SCHEMA\SEFAZ\NFE_V4.00.XSD
PASTA_SCHEMA_XML_NFE	\SCHEMA\NFE_V4.00.XSD



*/




update parametros set VALOR_ATUAL = '186.201.46.179' where parametro = 'IP_WS_NFE';
update parametros set VALOR_ATUAL = '2' where parametro = 'IDENTIFICA_AMBIENTE_NFE';
update parametros set VALOR_ATUAL = '2804' where parametro = 'PORTA_IP_WS_NFE';

--select * from parametros_loja where PARAMETRO='IDENTIFICA_AMBIENTE_NFE' 

update parametros_loja
set VALOR_ATUAL = '2' 
where PARAMETRO='IDENTIFICA_AMBIENTE_NFE' ;


