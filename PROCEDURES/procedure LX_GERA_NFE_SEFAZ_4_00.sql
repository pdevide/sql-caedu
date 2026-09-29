alter PROCEDURE [dbo].[LX_GERA_NFE_SEFAZ_4_00]  @NOTAFISCAL VARCHAR(15), 
												 @SERIENOTA VARCHAR(6), 
												 @FILIALNOTA VARCHAR(25), 
												 @RETORNA_XML BIT = 0, 
												 @APP_VERSAO VARCHAR(20) = NULL
WITH ENCRYPTION 
AS 
/*
09/10/2025	-	Carlos Alberto   - #184# - ENTERMODA-30950  - 2.25.020 - Correção na apresentação da tav vItem para notas que não possuam impostos relacionados à RT
24/09/2025	-	Szalontai		 - #183# - ENTERMODA-29988	- 2.25.020 - Inclusão tag vItem e ajuste na vNFTot
11/09/2025	-	Szalontai		 - #182# - ENTERMODA-29356	- 2.25.011/020 - Melhoria no ajuste #179#.  Inclusão de filtro para trazer as tags da Reforma quando CST_IBS_CBS e CBS_BASE não forem nulos
11/09/2025	-	Szalontai		 - #181# - ENTERMODA-29388	- 2.25.011/020 - Inclusão de parâmetro que controla a visualização ou não da TAG vIBS.
10/09/2025	-	Szalontai		 - #180# - ENTERMODA-29283	- 2.25.011/020 - Ajuste no valor da tag vBCIBSCBS. Deixar somente com o valor do IBS_EST_BASE
10/09/2025  -   Rafael cassio    - #179# - ENTERMODA-29264  - 2.25.020 - Permitir gerar as tags da Reforma mesmo quando valores de CBS/IBS estiverem zerados
27/08/2025	-	Szalontai		 - #178# - ENTERMODA-28132	- 2.25.010 - Retirada temporária da TAG vIBS.
22/08/2025	-	Juliana Nascimento #177# - ENTERMODA-28131	- 2.25.010 - Ajuste para gerar o grupo gCred.
12/08/2025	-	Szalontai		 - #176# - ENTERMODA-26717	- 2.25.010 - Inclusão de novos campos/tags para atender a Nota Técnica 2025.002-RTC - Versão 1.20 Julho de 2025.
05/08/2025	-	Juliana Nascimento #175# - ENTERMODA-27147	- 2.25.010 - Tratamento para não gerar "SEM CBENEF" para SC.
30/07/2025	-	Szalontai		 - #174# - ENTERMODA-26717	- 2.25	   - Inclusão dos campos IBS_EST_RED_ALIQ, IBS_MUN_RED_ALIQ,CBS_RED_ALIQ,IBS_EST_RED_ALIQ_ORIGINAL,IBS_MUN_RED_ALIQ_ORIGINAL e CBS_RED_ALIQ_ORIGINAL para popular o grupo gRed.
22/07/2025	-	Szalontai		 - #173# - ENTERMODA-25726	- 2.25	   - Inclusão dos campos TP_ENTE_GOVERNO,REDUTOR_COMPRA_GOVERNO e TP_OPER_GOVERNO para popular o grupo gCompraGov
21/07/2025	-	Juliana Nascimento #172# - ENTERMODA-26249	- 2.25	   - Ajuste na tag cAut
21/07/2025	-	Szalontai		 - #171# - ENTERMODA-26326	- 2.25	   - Correção - Mostrar as tags do CST quando houver valores
18/07/2025	-	Szalontai		 - #170# - ENTERMODA-26279	- 2.25	   - Correção - Diferença de Centavos no CBS e Base De Calculo do IBS e CBS.  
16/07/2025	-	Szalontai		 - #169# - ENTERMODA-25900	- 2.25	   - Correção - Ajustes nas tags da RT.  
15/07/2025	-	Szalontai		 - #168# - ENTERMODA-25900	- 2.25	   - Correção - Retitada das tag´s de agrupamento  
15/07/2025	-	Szalontai		 - #167# - ENTERMODA-25900	- 2.25	   - Correção - Na geração da tag IBSCBS, colocado tratamento do ISNULL para os campos FE_ITENS.IBS_EST_BASEe, NFE_ITENS.IBS_MUN_BASE e NFE_ITENS.CBS_BASE  
14/07/2025	-	Szalontai		 - #166# - ENTERMODA-25820	- 2.25	   - Retirada temporária da tag indBemMovelUsado
14/07/2025	-	Szalontai		 - #165# - ENTERMODA-25773	- 2.25	   - Correção - Gerando a tag IBSCBS vazia quando não tem o imposto na exceção
11/07/2025	-	Szalontai		 - #164# - ENTERMODA-23236	- 2.25	   - Retirada temporária das tags gCompraGov e gPagAntecipado.
01/07/2025	-	Szalontai		 - #163# - ENTERMODA-23236	- 2.25	   - Inclusão das novas tags para atender a RT.
20/06/2025  -   Felipe Cunha     - #162# - EN TERMODA-23598  - 1.25.050 - PR - Fisco passa a estabelecer a necessidade de vincular o comprovante de pagamento ao documento fiscal (idTermPag,CNPJReceb) B2C
14/05/2025  -   Carlos Alberto   - #161# - ENTERMODA-22854  - 1.25.040 - Parametrização para geração da tag <fone>
08/05/2025  -   Dario Silva      - #160# - ENTERMODA-22472  - 1.25.040 - Ajuste na geração da Tag pDevol
30/04/2025  -   Dario Silva      - #159# - ENTERMODA-21894  - 1.25.040 - Retirando espaços a esquerda e direita da tag IEST.
07/04/2025  -   Marcelo Faria    - #158# - ENTERMODA-20044  - 1.25.030 - Fator de conversão por fornecedor.
31/03/2025  -   Marcelo Faria    - #157# - ENTERMODA-19920  - 1.25.030 - Nota Técnica 2019.001 v.1.60/1.62 - Campo (cBenefRBC).
10/01/2025  -   Marcelo Faria    - #156# - ENTERMODA-15028  - SPK1.25  - Erro ao enviar NFe de Devolução de Compra.
09/01/2025  -   Marcelo Faria    - #155# - ENTERMODA-15009  - SPK1.25  - Rejeição - Falha no esquema - Tag xNome inválida.
08/01/2025  -   Marcelo Faria    - #154# - ENTERMODA-14959  - SPK1.25  - Correção: A tag pDevol está sendo preenchida com 100% em devoluções parciais.
06/01/2025  -   Marcelo Faria    - #153# - LINXERP-20712  - SPK1.25  - Rejeição caracteres especiais
25/11/2024  -   Carlos/Helder    - #152# - LINXERP-20712  - 2.24.30  - Melhoras de performance
31/07/2024  -   Marcelo Faria	 - #151# - LINXERP-18914  - 1.24.50  - obsCont e ObsFisco
04/07/2024  -   Marcelo Faria	 - #150# - LINXERP-17627  - 1.24.40  - Unidade tributária no Produto (código de barras)
29/05/2024  -   Dario Silva		 - #149# - PRODSHOP-24548 - 1.24.30  - Ajuste na geração da Tag pDevol
13/05/2024  -   Felipe Cunha     - #148# - LINXERP-17352  - 1.24.20  - NF-e/NF-e - Nota Técnica 2019.001 v1.60 - Nova Tag gCred
02/05/2024  -   Rafael Cassio    - #147# - LINXERP-17931  - 1.24.10  - Correção na tag indDeduzDeson para mostrar apenas após 01/07/2024 em produção
27/03/2024  -   Rafael Cassio    - #146# - LINXERP-17153  - 1.24     - Inclusão do campo CPF para DI
07/03/2024  -   FELIPE CUNHA     - #145# - LINXERP-17149  - 1.24     - NF-e/NFC-e - Publicada a versão 1.0 da Nota Técnica 2023.004
04/03/2024  -   Rafael Cassio    - #144# - LINXERP-17191  - 1.24     - Ajuste para inclusão do PIX/BOLETO em card e inclusão do campo dPag
30/05/2023  -	Juliana Nascimento #143# - PRODSHOP-19585 - 1.23.030 - Ajuste na tag IEST
07/03/2023  -	FELIPE CUNHA	 - #142# - PRODSHOP-18311 - 2.22.050 - Ajuste na tag tpAto - Grupo Z B2C
01/03/2023  -   Valmir Soares    - #141# - LINXERP-13645  - 2.22.050 - Padronização do nome do campo NOME_LOCAL_RETIRADA ref. ajuste #140#
17/02/2023	-	Valmir Soares	 - #140# - LINXERP-6399  - 2.22.050 - Procedimentos relativos à ponto de retirada de mercadoria - Ajuste SINIEF nº 14, de 01.07.2022 - DOU de 06.07.2022 e Decreto nº 49.824, de 25.11.2020 - DOE PE de 26.11.2020
03/02/2023	-	Valmir Soares	 - #139# - LINXERP-13188 - Fisco SC passa a exigir o preenchimento do campo cBenef no documento fiscal
20/01/2022	-	Valmir Soares	 - #138# - LINXERP-13141 - Ajuste ref. retirada de espaços do nome dos campos
04/01/2022	-	RODRIGO BARBOSA	 - #137# - LINXERP-9161  - Geração das novas Tags obsItem, obsCont e obsFisco no XML NFe
23/11/2022  -   FELIPE CUNHA	 - #136# - LINXERP-9648 - 2.22.020 - Ajuste da Nova Tag tpAto - Grupo Z da NF-e	
17/11/2022  -   FELIPE CUNHA	 - #135# - LINXERP-9648 - 2.22.020 - Nova Tag tpAto - Grupo Z da NF-e	
10/11/2022  -   RODRIGO BARBOSA  - #134# - LINXEP-11953 - 2.22.020 - *******ISSUE CANCELADA*****    CRIAÇÃO DA TAG REFCTE QUANDO A NOTA REFERENCIADA FOR 57 - CT-E     *******CANCELADA**
18/10/2022  -   CARLOS ALBERTO   - #133# - LINXEP-8263  - 2.22.010 - AJUSTES NAS TAGS DE CÓDIGO DE BENEFÍCIO.
13/07/2022  -   Rodrigo Barbosa  - #132# - LINXEP-7774  - 1.22.040 - Incluídas as tags <pFCPDif>; <vFCPDif> e <vFCPEfet>.
21/07/2022  -   Valmir Soares    - #131# - LINXERP-856  - 1.22.040 - Alteração na mensagem do FECP
21/06/2022  -   CARLOS ALBERTO	 - #130# - LINXEP-10473 - 1.22.030 - AJUSTE PARA TRAZER O VALOR DAS PARCELAS A RECEBER CORRETAMENTE, MESMO QUE JÁ TENDO SIDO BAIXADAS POR AVISOS DE CRÉDITO
03/05/2022  -   Marcelo Szalontai- #129# - LINXERP-9941 - 1.22.010 - Ajuste na correções #128# para não gerar conteudo na tag indproc
28/04/2022  -   Felipe Cunha       #128# - LINXERP-9648 - 1.22.010 - Ajuste nas correções #126# e #127# para gerar a Tag indproc = 9 - Outros.
25/04/2022  -   Marcelo Szalontai- #127# - LINXERP-9648 - 1.22.010 - Ajuste para mostrar a tag procRef somente quando NFE.TIPO_PROCESSO = 0
19/04/2022  -   Rodrigo Barbosa  - #126# - LINXERP-9648 - 1.22.010 - preenchimento da nova tag tpAto, no grupo Z da NF-e Para atender a NT 2021.004
18/04/2022  -   Marcelo Szalontai- #125# - LINXERP-9584 - 1.22.010 - Regra de validação Tipo Transporte
                                                          Se Modalidade do Frete = 9 (id: X02, campo: modFrete), o Grupo Transportador (id: X03, campo: transporta) não pode ser informado
15/02/2022  -   Valmir Soares    - #124# - LINXERP-8978 - Ajuste condição para gerar tag infAdProd
12/11/2021  -   Marcelo Szalontai- #123# - LINXERP-6692 - ROT - Emissão de NF-e/NFC-e por optante do ROT-RS (Alteração na TAG ICMS - EFETIVO)
11/10/2021  -   Marcelo Faria    - #122# - LINXERP-6519 - DUIMP - Tratamento para não informar tag quando for Duimp
02/08/2021  -   Diego Quaresma   - #121# - LINXERP-3974 - ADEQUAÇÃO #120# AJUSTE NO NOME DOS CAMPOS PARA DEIXAR DE ACORDO COM POSSP-5157 (FISCALFLOW).
26/02/2021  -   Diego Quaresma   - #120# - LINXERP-3974 - NF-e/NFC-e - NT 2020.006 - Versão 1.00 - dentificação do intermediador/marketplace.
12/01/2021  -   Valmir Soares    - #119# - LINXERP-405  - Mensagem de Não Incidência de FECP em Dados Adicionais
28/09/2020  -   Rodrigo Souza    - #118# - SUSTSP-1372  - Correção nas tags Pdevol e vIPIDevol.
22/09/2020  -   Douglas Garcia   - #117# - SUSTSP-1225  - Ajuste na correção #96#, voltando a função de remoção de caracteres especiais
27/01/2020  -   Douglas Garcia   - #116# - MODASP-10431 - Implementar versão completa do Service Pack/Hotfix na tag <verProc>
27/12/2019  -   Edson Filenti    - #115# - ModaSP-8986  - Replicação - Correção de performance realizada pelo DBA Crispim. 
08/10/2019  -	Edson Filenti    - #114# - MODASP-7003  - Ajuste no grupo ICMS 90, geração das tags. 
-#113#-
25/09/2019  -   Diego Quaresma	 - #113# - MODASP-6507- Tratamento para gerar "SEM CBENEF" para CST 90 estado do Parana - PR
20/09/2019  -   Carlos Gonçalves - #112# - MODASP-6238- Alterado da função FX_REPLACE_CARCTER_ESPECIAL_NFE para FX_REPLACE_CARCTER_ESPECIAL_REINF, pois nao pode remover "-" do codigo do produto  caso exista
19/09/2019  -   Edson Filenti	 - #111# - MODASP-6385- Solicitado ajuste pelo analista Roberto Beda na seleção do IMCSST90. Bloco de seleção do imposto desonerado calculando apenas quando ocorrer ST. Ajuste para ser calculado em TODAS as situações.
19/09/2019  -   Adalberto (WAFX) - #110# - MODASP-6083- Voltando alteração da tag #109#. 
13/09/2019  -   Adalberto (WAFX) - #109# - MODASP-6083- Alteração da tag pDevol para finalidade 2 ou 4 e tipo operacao = D.
11/09/2019  -   Adalberto (WAFX) - #108# - MODASP-6008- Alteração das tags pDIF, vICMSDIF e vICMS do CST-51 (diferimento).
09/09/2019  -   Rodrigo Souza    - #107# - MODASP-5933- Correção na tag Pdevol em notas fiscais de entrada para evitar duplicidade.
28/08/2019  -   Adalberto (WAFX) - #106# - MODASP-2930- retirando espaços a esquerda e direita da tag cBenef.
28/08/2019  -   Adalberto (WAFX) - #105# - MODASP-2930- Voltando as alterações das tags pDIF, vICMSDIF e vICMS do CST-51 (diferimento).
22/08/2019  -   Ailton (FCamara) - #104# - MODASP-4893- Verifica se o Código de Segurança é Fraco ou igual o número da NF, se for refaz para evitar rejeição no SEFAZ conforme NT 2019_001_v1
19/08/2019  -   Adalberto (WAFX) - #103# - MODASP-2930- Alteração das tags pDIF, vICMSDIF e vICMS do CST-51 (diferimento). 
13/08/2019  -   Adalberto (WAFX) - #102# - MODASP-2930- Correção para gerar a tag pDif para o CST-51 (diferimento). 
02/08/2019  -   Adalberto (WAFX) - #101# - MODASP-2930- Correção para ordenar as tags vICMSDeson e motDesICMS corretamente para o CST-70. 
													  - Correção para não gerar registros duplicados das tags vICMSDeson e motDesICMS. 
23/07/2019  -   Adalberto (WAFX) - #100# - MODASP-2930- Alteração para não gerar as tags vICMSDeson e motDesICMS quando NFE_ITENS.ICMS_DESONERADO = 0. 
11/07/2019  -   Adalberto (WAFX) - #99# - MODASP-2930- Alteração para atender Decreto 46.536/2018 SEFAZ RJ, desoneração do ICMS, alterar as tags vICMSDeson e motDesICMS. 
24/06/2019  -   Ailton(FCamara)  - #98# - MODASP-2933- Substituição da função trim() por ltrim(rtrim()), necessário para manter compatibilidade com versões antigas do SQL Server
13/06/2019  -   Ailton(FCamara)  - #97# - MODASP-2933- Alteração para atender Fisco do RJ por meio da Lei nº 8.405/2019, identificação de produtos que não estão sujeitos ao FCP, através de msg na tag infAdProd
12/06/2019	-   Rodrigo Souza	 - #96# - DM 121887  - Correção para não remover caracter especial do nome da transportadora.
22/05/2019  -   Wendel Crespigio - #95# - DM 119772  - Ajuste para quando o codigo da filial for diferentes entre filiais e loja varejo.
13/05/2019  -   Edson Filenti    - #94# - DM 118921  - Ajuste de performance.  Avaliação feita junta a equipe DBA Maria e Crispim.
23/04/2019	-   Rodrigo Souza	 - #93# - DM 115936  - Correção para gerar o a tag PDevol corretamente quando a entrada estiver utilizando os CFOPs ('1201','1202','1410','1411','5921','6921')
22/04/2019  -   Szalontai        - #92# - DM 116856  - NOTA TECNICA 2018.005 Versão 1.20. As notas notas fiscais com o imposto efetivo, está gerando a tag vICMSSubstituto
                                                       Feita correção, tratando para trazer o tag vICMSSubstituto somente quando INDICA_OPERACAO_FINAL = 0
02/04/2019  -   Szalontai        - #91# - DM 112979  - NOTA TECNICA 2018.005 Versão 1.20. Colocar no 60 500.
22/03/2019	-   Rodrigo Souza	 - #90# - DM 113713  - Correção para evitar duplicidade na tag Pdevol.
11/12/2018	-   Rodrigo Souza	 - #89# - DM 103936  - Correção na tag Pdevol adicionada a validação da tabela FATURAMENTO_NF_AVULSA_REFERENCIADA.
06/11/2018	-   Rodrigo Souza	 - #88# - DM 100312  - Correção na tag Pdevol alterada a correção feita na tag anterior.
16/10/2018  -	Rodrigo Souza	 - #87# - DM 97777   - Correção na tag Pdevol para gerar zerada quando estiver null pois em alguns casos não existe a nota fiscal de origem no sistema.
29/08/2018  -	Diego Quaresma	 - #86# - DM 90286   - Inclusão da tag cBenef.
27/08/2018  -	Rodrigo Souza	 - #85# - DM 91172   - Melhoria de performance. Retirado a cláusula EXISTS e adicionado o filtro pelo tipo de operação
23/08/2018  -	Edson Filenti    - #84# - DM 90613   - B2C - Correção no calculo do Pdevol para B2C. Inner join com a tabela LOJA_VENDA_TROCA_ORIGEM erro cartesiano, pois a tabela armazena por item. 
17/08/2018  -   Edson Filenti    - #83# - DM 89878   - B2C - Correção paara tratar pedidos com duas ou mais formas de pagamento. 
09/08/2018	-	Edson Filenti	 - #82# - DM 86565	 - Replicação da correção "#29# - geração da tag "pDevol" para notas de entradas por devolução." para o produto B2C.
07/08/2018  -	Diego Quaresma	 - #81# - DM 88288   - Correção para gerar corretamente a tag "pFCP' quando o valor tiver > 0 e tiver 3 casas decimais.
03/08/2018  -	Rodrigo Souza	 - #80# - DM 87862   - Correção para gerar corretamente a tag "vDup' para utilizar o valor liquido pois em alguns casos existe desconto.
31/07/2018  -	Rodrigo Souza	 - #79# - DM 86919   - Correção na geração das tags "DetPag" e "card".
25/07/2018  -	Edson.Filenti	 - #78# - DM 86074   - Tratamento no camnpo TROCO para geração da Tag VPAG. Devido a demanda 83908, a view W_INFORMACAO_PAGAMENTO preciso retornar o valor NULL quando TRCOCO = 0.00.
17/07/2018  -	Diego Moreno	 - #77# - DM 67612   - REPLICAÇÃO DAS MELHORIAS REALIZADAS NO LINX POS PARA ATENDER A NT 2016.002 V1.60 LINX B2C SHOP.
16/07/2018  -	Diego Moreno	 - #76# - DM 84580   - REPLICAÇÃO DAS MELHORIAS REALIZADAS NO LINX POS PARA ATENDER A NT 2016.002 V1.60 LINX B2C SHOP.
13/07/2018  -   Rodrigo Souza    - #75# - DM 84331   - Correção na geração das tags "vBCFCPST","pFCPST" e "vFCPST".
04/07/2018  -   Rodrigo Souza    - #74# - DM 82728   - Correção na geração das VDesc nos dados da cobrança.
04/07/2018  -   Rodrigo Souza    - #73# - DM 82679   - Correção na geração das tags referente ao icms efetivo.
28/06/2018  -   Diego Quaresma   - #72# - DM 80341   - Retirada a validação do código fiscal de operação.
26/06/2018  -	Diego Moreno	 - #71# - DM 80412   - NOTA TECNICA 2016.002 Versão 1.60.
05/06/2018  -   Rodrigo Souza    - #70# - DM 77532   - Correção na geração das Tags vIPIDevol e pDevol.
28/05/2018  -   Diego Quaresma   - #69# - DM 73038   - Tratamento para levar a tag indpag no Grupo de detalhamento da forma de pagamento.
25/05/2018  -   Diego Quaresma   - #68# - DM 73038   - Tratamento para não levar as tags pFCPUFDest e vFCPUFDest para o XML quando o valor das mesmas for = 0.
04/04/2018  -   Diego Quaresma   - #67# - DM 00000   - Correção na tag InfAdProd.
20/03/2018  -   Diego Quaresma   - #66# - DM 67974   - Correção para gerar informação de pagamento 14 duplicata para faturamento de loja atacado.
28/02/2018  -   Marcelo Szalontai- #65# - DM 64187   - Correção para somar a alíquota do ICMS-STA+FECP-STA ou  ICMS-STAR+FECP-STAR  na tag <pST>
20/09/2017  -   DIEGO MORENO     - #64# - DM 58430	 - Adequacao NFE 4.00. Melhoria para atender ao layout 4.0.
11/09/2017  -   JAQUE LAURENTI   - #63# - DM 43293   - Correção na geração da tag "vIPIDevol" adicionado filtro de filial para evitar duplicidade.[
-- replicação da demanda 38372
11/09/2017  -   JAQUE LAURENTI   - #62# - DM 43158   - Correção na geração da tag "pDevol" para utilizar a quantidade da tabela FATURAMENTO_ITEM.
-- replicação da demanda 38372
20/09/2017  -   Diego Quaresma   - #61# - DM 16464   - Adequacao NFE 4.00.
03/03/2017  -   Marcelo Szalontai- #60# - DM 24582   - Adição de tratamento do parametro DATA_VALIDADE_CFOP_EXPE.
                                                       Parâmetro criado para informar a data em que a nota técnica referente a validação das unidades de medida de exportação serão validadas
23/02/2017  -   Marcelo Szalontai- #59# - DM 23769   - Adição de tratamento para utilizar Unidades de Medidas Tributáveis para o Comércio Exterior no campo vUnTrib.
23/02/2017  -   Marcelo Szalontai- #58# - DM 23769   - Correção nao select para tratar o código do NCM sem pontuação
20/02/2017  -   Marcelo Szalontai- #57# - DM 16786   - Adição de tratamento para utilizar Unidades de Medidas Tributáveis para o Comércio Exterior
13/06/2016  -   RODRIGO SOUZA    - #56# - ID 3824    - Correção para somente gerar as tags da partilha se existir valor de DICMS.
09/06/2016  -   Gerson Prado     - #55# - DM 802     - Correção na criação da TAG infAdFisco, formatar a variavel @OBS_INTERESSE_FISCO
06/06/2016  -   Salomão Junior   - #54# - ID 2647    - Aletraçao da informar a versão do Linx na TAG no verproc deixando espaço para o mid incluir sua versao
06/05/2016  -   Salomão Junior   - #53# - ID 2647    - Informar a versão do Linx na TAG no verproc
04/04/2016  -   JAQUE LAURENTI   - #52# - DM 2385    - Retirada da soma do DICMS_DEST_VALOR + FECP_DEST_VALOR 
04/04/2016  -   Eder Silva       - #51# - DM 2193    - Replicação da demanda 802 >> Correção na criação da tag "infAdFisco".
30/03/2016  -   Edson Filenti    - #50# - ID 2053    - Remoção do filtro da DM 1550 #48#. Simples Nacional exige geração da Tags de partilha.
22/02/2016  -   Wendel Crespigio - #49# - ID 1873    - Tratamento para nota fiscal NFE referenciada.
14/01/2016  -   RODRIGO SOUZA    - #48# - ID 1550    - Correção para somente gerar as tags da partilha se existir valor de DICMS.
12/01/2016  -   Wendel Crespigio - #47# - DM 1455    - Tratamento para informar a filial no caso de uma devolução. 
06/01/2016  -   BARBARA LIMA	 - #46# - ID 668	 - Acrescentar o nono dígito nos campos de telefone, substituindo o tamanho de 8 para 9.
18/12/2015  -   DIEGO MORENO     - #45# - #1518#     - Passou a enviar sempre os dados da IEST quando existir informação.
14/12/2015  -   DIEGO QUARESMA   - #44# - #1324#     - Gerar o grupo de ICMS para a UF de destino mesmo que a aliquota de destino for menor do que a interestadual, pois a Sefaz não autoriza a nota.
03/12/2015  -   DIEGO QUARESMA   - #43# - #PARTILHA# - Ajuste no calculo do "vICMSUFDest", valor do DICMS-DESTINO + valor do FECP_DESTINO.
25/11/2015  -   DIEGO QUARESMA   - #42# - #PARTILHA# - Inclusão dos campos para atender a NT2015/003.
30/10/2015  -   GIEDSON SILVA    - #41# - 10857325 - Replicação do objeto do LinxPOS para o objeto do ERP Banco Online - Trecho replicado para Correção da clausula WHERE e JOIN na validação dos itens referenciados para nota de consignação)
26/10/2015  -   GERSON PRADO\ Wendel Crespigio - #40# - 10661421 - Replicação do objeto do LinxPOS para o objeto do ERP Banco Online - Trecho replicado (TP10622549 - Gerson Prado e Roberto Beda - (11/10/2015) - Correção da clausula WHERE na validação dos itens referenciados na nota de troca)
29/09/2015  -   RODRIGO SOUZA   - #39# - TP 9866682 - Correção na geração da tag "pDevol" em notas de entrada por devolução.
13/08/2015  -   RODRIGO SOUZA   - #38# - TP 9381183 - Modificada correção #37#
24/06/2015  -   RODRIGO SOUZA   - #37# - TP 9156094 - Correção para gerar corretamente a NFE quando possui ICMS_SNST.
16/06/2015  -   RODRIGO SOUZA   - #36# - Correção na geração da tag NFRef.
14/05/2015  -   DIEGO QUARESMA  - #35# - TP 8530613 - Realizado tratamento para não considerar a CHAVE_NFE nula.
26/04/2015  -   RODRIGO SOUZA   - #34# - Correção para somente gerar o a tag "pDevol" quando a nota referenciada existir (alteração por causa da nota avulsa).
23/04/2015  -   RODRIGO SOUZA   - #33# - Correção na geração da tag autXML adicionado RTRIM() para eliminar espaços em branco.
22/04/2015  -   RODRIGO SOUZA   - #32# - Correção na validação feita na tag #28# substituida a variavel @FILIALNOTA pela coluna FILIAL da tabela LOJA_RESERVA.
16/04/2015  -   RODRIGO SOUZA   - #31# - Correção na geração da tag ImpostoDevol quando os itens possuem exceções diferentes.
17/04/2015  -   RODRIGO SOUZA   - #30# - Correção para somar no total a base do imposto 12 (ICMS_ST) com o imposto 13 (ICMS_STR).
17/04/2015  -   RODRIGO SOUZA   - #29# - Correção na geração da tag "pDevol" para notas de entradas por devolução.
14/04/2015  -   JORGE.DAMASCO   - #28# - TP8304984 - IMPLEMENTAÇÃO PARA QUANDO SE TRATAR DE UMA NOTA DE DEVOLUÇÃO P/ RESERVA/CONSIGNAÇÃO.
01/04/2015  -	JORGE.DAMASCO   - #27# - TP8226401 - Replicações de demandas referentes à BANCO ONLINE.
27/03/2015  -   RODRIGO SOUZA   - #26# - Correção feita para somente gerar as tags "vICMSDeson" e "motDesICMS" quando existir valor de ICMS-ZF.
02/02/2015  -   RODRIGO SOUZA   - #25# - Inclusão das Tags "pDevol" e "vIPIDevol".
11/11/2014  -   DIEGO QUARESMA  - #24# - Realizado tratamento na iscrição estadual da trasportadora "IE" quando for '' passar NULL. 
30/10/2014  -   SAMUEL SANTOS   - #23# - Acerto no campo data_contingencia, para utilizar a data_contingencia_utc, para nao dar problemas na versao 2.00
30/10/2014  -   SAMUEL SANTOS   - #22# - Inclusao do Valor e mot ICMS Desonerado para ICMS 90
30/10/2014  -   SAMUEL SANTOS   - #21# - INCLUIR TAGS PARA VALIDAR ICMS COM DIFERIMENTO (UTILIZAR SEMPRE ICMS-BST - 51)
30/10/2014	-	DIEGO QUARESMA	- #20# - REALIZADO TRATAMENTO ISSQN NAS TAGS "NCM" e "vServ".
29/10/2014	-	DIEGO QUARESMA	- #19# - REALIZADO TRATAMENTO ISSQN NAS TAGS "cListServ" e "dCompet".
25/09/2014	-	GERSON PRADO	- #18# - ADD TRATAMENTO PARA LEVAR OITO DIGITOS NA TAG DE NCM QUANDO TAMBÉM QUANDO A SITUAÇÃO TRIBUTARIA DO IPI FOR '53' - "Saída Não-Tributada"
09/09/2014  -	DIEGO QUARESMA  - #17# - ADD TRATAMENTO PARA LEVAR OITO DIGITOS NA TAG DE NCM QUANDO A SITUAÇÃO TRIBUTARIA DO IPI FOR '03'
24/10/2014  -   RODRIGO- #16# - Correção para abater o ICMS_ZF do valor dos descontos e não somar no total.
03/10/2014  -	RODRIGO- #15# - NOTA TÉCNICA 2013.005 V1.03 - Adicionado as tags campos indISS , nProcesso e indIncentivo.
02/10/2014  -	RODRIGO- #14# - NOTA TÉCNICA 2013.005 V1.03 - Não gerar a tag CNPJ na operação com exterior.
08/09/2014  -   SAMUEL - #13# - NOTA TÉCNICA 2013.005 V1.03 - 
29/08/2014  -   EDSON  - #12# - NOTA TÉCNICA 2013.005 V1.02 - 03.7 - IDENTIFICAÇÃO DO DESTINATÁRIO
29/08/2014  -   EDSON  - #11# - NOTA TÉCNICA 2013.005 v1.02 - 03.2 - ALTERAÇÃO NO FORMATO DA DATA PARA UTC E REMOVER INF HORA.
29/08/2014  -   EDSON  - #10# - NOTA TÉCNICA 2013.005 V1.02 - 03.7 - IDENTIFICAÇÃO DO DESTINATÁRIO. OPERAÇÃO COM O EXTERIOR, OU PARA COMPRADOR ESTRANGEIRO. INFORMAR O NÚMERO DO PASSAPORTE OU OUTRO DOCUMENTO LEGAL PARA IDENTIFICAR PESSOA ESTRANGEIRA.
29/08/2014  -   EDSON  - #9#  - NOTA TÉCNICA 2013.005 v1.02 - 03.6 - INDICA PRESENÇA DO COMPRADOR - indPres
29/08/2014  -   EDSON  - #8#  - NOTA TÉCNICA 2013.005 v1.02 - 03.6 - INDICA OPERAÇÃO COM CONSUMIDOR FINAL - indFinal
29/08/2014  -   EDSON  - #7#  - INCLUSÃO DA COLUNA idDest - Ref.: LAYOUT 3.10 - NOTA TÉCNICA 2013.005 v1.02 - 03.3 - INCLUSÃO DO ID LOCAL DESTINO. (1 - INTERNO; 2 - INTERESTADUAL; 3 - EXTERIOR)
Versão Atualização Linx: 2.00.0010 <<<-- 
29/08/2013  -	RAFAEL - #6# - ADD TRATAMENTO PARA CARREGAR O CAMPO CODIGO_FCI NOTA TÉCNICA 2013/006
06/08/2013  -	RAFAEL - #5# - TP 3997086 - CORREÇÃO DO TRATAMENTO DO EMAIL
19/07/2013  -   WENDEL OLIVEIRA - #4# - TP3997086 - TIRANDO ESPAÇO EM BRANCO DO CAMPO EMAIL_NFE 
29/05/2013  -   SAMUEL - #3# - ACERTO NO CALCULO DO VALOR TOTAL DOS IMPOSTOS #2#
16/05/2013	-	RAFAEL  - #2# - INCLUSAO DO TRATAMENTO PARA O VALOR TOTAL DOS IMPOSTOS DO ITEM CONFORME LEI 12741/2012
25/04/2013	-	RAFAEL	- #1# - INCLUSAO DO TRATAMENTO PARA O VALOR TOTAL DOS IMPOSTOS DO ITEM
09/10/2012  -	RAFAEL  - INCLUSAO DO CAMPO UF_PLACA_VEICULO
08/10/2012  -	RAFAEL  - INCLUSAO DO TRATAMENTO DO VEICULO_PLACA
27/09/2012	-	Roberto Beda - TP 2984304 - VARIÁVEL @NOME_CLIFOR PASSA A TER 40 CARACTERES PARA SUPORTAR CLIENTES_VAREJO.CLIENTE_VAREJO
05/09/2012  -	RAFAEL  - INCLUSAO DO CAMPO - HORA_SAIDA
18/11/2011  -   PADIAL	- INCLUSÃO DO CAMPO NOME_FANTASIA_EMITENTE PARA O EMITENTE DA NOTA DE ACORDO COM PARAMETRO EXIBE_NOME_FANTASIA_XML
11/11/2011	-	PADIAL	- INCLUIDA A REGRA DA SUFRAMA DENTRO DA VIEW DE ACORDO COM O INDICADOR FISCAL TERCEIRO

Versão Atualização Linx: 2.00.0008 <<<-- 

NT2011.004
31/10/2011  -	PADIAL	- ALTERAÇÃO DA REGRA DO IMPOSTO II PARA SEMPRE SER GERADO NO ITEM MESMO QUE FOR ZERADO
17/10/2011  -   PADIAL	- SEPARACAO DAS INFORMACOES REFERENTES A NOTA DE SERVICO PARA TOTAL DOS ITENS, PIS E COFINS
03/10/2011  -	PADIAL	- ERRO NA REGRA DE VALIDACAO DOS MUNICIPIOS 1600303 E 1600600 DO CAMPO ISUF
19/09/2011	-	PADIAL	- INCLUSAO DO IMPOSTO ICMS_ZF PARA TRATAMENTO DE DESONERACAO DO ICMS40	
19/04/2011	-	PADIAL	- ALTERACAO DO TRATAMENTO DO ICMS60 ONDE OS CAMPOS vBCSTRet, vICMSSTRet NÃO SÃO MAIS OBRIGATORIOS

18/08/2011  -	PADIAL	- O IMPOSTO ISS_R NÃO ESTAVA SENDO TRATADO CORRETAMENTE
16/08/2011  -	PADIAL	- ALTERACAO DA ESTRUTURA DO GRUPO ISSQN QUE ESTAVA NO LUGAR ERRADO DEVIDO AO SCHEMA IT 1.00
						- INCLUIDO O GRUPO ISSQN ANTES DO IMPOSTO PIS

Versão Atualização Linx: 2.00.0005 <<<--  
24/05/2011	-	PADIAL	- INCLUSAO DOS CAMPOS COM VALOR DE PARAMETRO NA VIEW PARA RETIRAR O SELECT DO XML
16/05/2011  -   PADIAL	- ALTERACAO DO GRUPO retTrib, ONDE NÃO É INCLUIDO OS ELEMENTOS COM OS VALORES ZERADOS
06/05/2011	-	PADIAL	- INCLUSAO DO CAMPO EAN PARA O ITEM
06/05/2011	-	PADIAL	- ALTERACAO DO GRUPO ICMSSN900 PARA INCLUIR O VALOR O SIMPLES_F NO LUGAR DO IMPOSTO ICMS QUE ERA UTILIZADO ANTERIORMENTE
05/05/2011  -	PADIAL	- TRATAMENTO DO CAMPO EXTIPI PARA NAO ENVIAR COM VALOR MENOR QUE DOIS CARACTERES
05/05/2011	-	PADIAL	- INCLUSAO DA FX REPLACE NO CAMPO CEP PARA TRATAMENTO DE CAMPOS NUMÉRICOS

Versão Atualização Linx: 2.00.0004 <<<--  

27/04/2011  -  PADIAL	- ALTERACAO DO CAMPO PMVAST QUE SE FOR ZERO COLOCAR NULO PARA NAO EXIBIR A TAG NO XML		

11/04/2011 -	PADIAL	- INCLUSAO DO IMPOSTO ICMS_BST PARA SER TRATADO NO ICMS51 SOMENTE. EM NENHUM OUTRO CASO ELE GERA VALOR NO XML.
04/04/2011 -	PADIAL	- TRATAMENTO PARA O CAMPO INFORMACAO DO FISCO, CASO SEJA EM BRANCO LEVAR NULLO PORQUE A SEFAZ NAO ACEITA	
04/04/2011 -	PADIAL	- TRATAMENTO NOTA TÉCNICA 2010/009 

Versão Atualização Linx: 2.00.0002 <<<--  

25/02/2011 -	PADIAL - INCLUSAO DA ATUALIZACAO DA CHAVE NFE PARA LOJA/ENTRADA E FATURAMENTO
25/02/2011 -    PADIAL - TRATAMENTO CARACTER ESPECIAL NO CAMPO "infAdProd"
23/02/2011 -	PADIAL - INCLUIDO UPPER NA OBSERVACAO COLOCAR DEPOIS NOS OBJETOS DA NF-E
23/02/2011 -	PADIAL - CORREÇÃO DOS DADOS DE ENTREGA QUE NAO ESTAVA CONTEMPLANDO PESSOA FISICA
23/02/2011 -	PADIAL - INCLUSÃO DO TRATAMENTO DO IMPOSTO ICMS_SN (55) PARA O SIMPLES NACIONAL QDO HOVER AS TAGS "pCredSN" e "VCredICMSSN"
						 ONDE O SIMPLES_F É O ICMS NORMAL DO SIMPLES NACIONAL E O IMPOSTO ICMS_SN É SOMENTE O VALOR DO ICMS A SE CREDITAR
						 DEFINIDO COM JOAO CESTARI EM 23/02/2011
16/02/2011 -	PADIAL  - FX_REPLACE_CARACTER_ESPECIAL_NFE NO CAMPO JUSTIFICATIVA_CONTINGENCIA
03/02/2011 -	PADIAL	- CORREÇÃO DO CODIGO DO IPITRIB PARA QUANDO NAO É BEBIDA
17/01/2011 -	PADIAL	- INCLUSÃO DE PARAMETRO NA FUNCAO FX_REPLACE_CARACTER_ESPECIAL

12/01/2011	-	PADIAL	- ALTERADO O TRATAMENTO DO NOME FANTASIA E RAZAO SOCIAL PARA O EMITENTE DA NFE
29/12/2010	-	PADIAL	- TEM QUE SER TRATADO O NOME CLIFOR CORRETO PARA ENTRADA SENAO DA PROBLEMA NA NOTA REFERENCIADA
30/11/2010	-	PADIAL	- ALTERACAO DO TRATAMENTO DO NCM PARA O IPI NAO TRIBUTADO. VERIFICAR COM CESTARI SOBRE COMO TRATAR CORRETAMENTE ESTE CASO
29/11/2010	-	PADIAL	- INCLUSAO DO TRATAMENTO PARA O IPI POR QUANTIDADE PARA BEBIDAS NOS ELEMENTOS qUnid e vUnid
17/11/2010	-	PADIAL	- COMENTADO A PARTE DE VALORES DO ICMS 51 - DIFERIMENTO: EM CONVERSA COM CESTARI EM 17/10/2010, FICOU ACERTADO QUE NAO VAMOS ENVIAR 
						  OS VALORES DO ICMS, PRINCIPALMENTE PORQUE TERIAMOS QUE FAZER UM TRATAMENTO ESPECIFICO PARA ESTES VALORES, PORQUE NAO FAZEM PARTE 
						  DA BASE DE CALCULO DO TOTAL DA NOTA.
17/11/2010	-	PADIAL	- TRATAMENTO DA VERSAO 2.0 PARA O CAMPO ISUF (INSCRICAO SUFRAMA)
-------------------------------------------------------------------------------------
16/11/2010	-	PADIAL	- INCLUIDO O CAMPO COD_MUNICIPIO DO IBGE NO LUGAR DOS SELECTS
-------------------------------------------------------------------------------------
12/11/2010	-	PADIAL	- INCLUSAO DO TRATAMENTO DA REFERENCIA DO ECF
						- TRATAMENTO DO TELEFONE DO EXTERIOR COM A INCLUSÃO DO DDI
						- INCLUSAO DO TRATAMENTO DO GRUPO DE ARMA
10/11/2010 - PADIAL	- INCLUSÃO DO TRATAMENTO CORRETO DO IMPOSTO SIMPLES_F PARA TRATAMENTO DO CODIGO DE REGIME TRIBUTARIO 1 (SIMPLES NACIONAL)
04/11/2010 - PADIAL - TRATAMENTO PARA O CAMPO OBS_INTERESSE_FISCO
25/10/2010 - PADIAL - REGRAS DOS IMPOSTOS:
					- O IMPOSTO ICMSST DEVERÁ SER PREENCHIDO NAS OPERAÇÕES INTERESTADUAIS COM COMBUSTÍVEIS PELO CONTRIBUINTE QUE TIVER RECEBIDO O
					  COMBUSTÍVEL DIRETAMENTE DO SUJEITO PASSIVO POR SUBSTITUIÇÃO.
					- O IMPOSTO ICMSPART REFERENTE AS INFORMAÇÕES RELATIVAS AO ICMS DA OPERAÇÃO DE FATURAMENTO DIREITO DE VEÍCULOS DEVEM SER INFORMADA NESTE GRUPO, FICANDO REVOGADA A
					  ORIENTAÇÃO DE PREENCHIMENTO DO ICMS DIVULGADA NO ITEM 3 DA NT 2008/004. 

VERSÃO ATUALIZAÇÃO LINX: 1.00.0005 - NAO LIBERADA
02/11/2011 - PADIAL - TRATAMENTO DE CARACTER COM ACENTO NO CAMPO TIPO_VOLUME

VERSÃO ATUALIZAÇÃO LINX: 1.00.0004
14/10/2010 - PADIAL - INCLUSAO DOS NOVOS CODIGOS DO PIS E CONFINS (49,50,51,52,53,54,55,56,60,61,62,63,64,65,66,67,70,71,72,73,74,75,98) COMO O CODIGO 99.
					  ESTRE TRATAMENTO FOI FEITO CONFORME NOTA TECNICA 2010/001 E PELO SCHEMA DA VERSAO 1.10 E 2.00 NAO POSSUIREM ESTE CAMPO	
14/10/2010 - PADIAL	- ALTERAÇÃO DO CAMPO IE DESTINATARIO PARA LEVAR E ELEMENTO EM BRANCO CASO SEJA PESSOA FISICA INDEPENDENTE DO PREENCHIMENTO DO CAMPO(PROBLEMA PEGO EM GOIAS, EM SAO PAULO HOMOLOGOU)
14/10/2010 - PADIAL	- INCLUIDO O TRATAMENTO DO RTRIM NO CODIGO DO MUNICIPIO PARA O GRUPO IDE
27/09/2010 - PADIAL -- INICIO DO DESENVOLVIMENTO DA NF-E
*/

DECLARE --@NOTAFISCAL VARCHAR(7), @SERIENOTA VARCHAR(6), @FILIALNOTA VARCHAR(25),  
		@NFE_XML XML, @NFE_XML_REPLACE VARCHAR(MAX), 
		@CHAVEACESSO CHAR(44), @CODIGONF AS CHAR(9), @SOMAPONDERACOES AS INT,  @CNT INT, @PESO INT, @RESTODIVISAO INT, @DIGITOVERIFICADOR CHAR(1),
		@CONDICAO_PGTO CHAR(3), @INDICA_FORMA_PGTO CHAR(1), @TIPO_DOC CHAR(2), @TIPO_CONDICAO VARCHAR(6), @INFCOMPLEMENTAR VARCHAR(5000),
		@OBS_FAT VARCHAR(5000), @TEXTO_LEGAL VARCHAR(5000), @NOME_CLIFOR VARCHAR(40), @VALOR_IMPOSTO_ITEM VARCHAR(16),
		@CNPJ_EMITENTE VARCHAR(14),	@CIDADE_EMITENTE VARCHAR(35), @UF_EMITENTE CHAR(2), @AAMM_EMISSAO CHAR(4),
		@MODELO CHAR(2), @TIPO_EMISSAO TINYINT, @VERSAO_CHAVE_NFE CHAR(6), @CODIGO_UF_IBGE CHAR(2), @SERIENOTA_OFICIAL VARCHAR(6), @VERSAO_LAYOUT_XML_NFE VARCHAR(5), @EMAIL_NFE VARCHAR(60), @EMAIL_DESTINATARIO VARCHAR(100), 
		@OBS_INTERESSE_FISCO VARCHAR(2000), @COD_MUNICIPIO_IBGE CHAR(7), @TIPO_DOC_CHAVE CHAR(2), @CLIFOR_FILIALNOTA CHAR(6),@NF_NUMERO_REFERENCIADA char(1), --#49#
		@QTDE_PARCELA int,--#64#
		@CODIGO_FILIAL char(6) --#115#
		,@OPTANTE_ROT bit /*#123#*/
		,@BAIXA_IAC_FATURAMENTO BIT /*#130#*/
		,@ENVIAR_TELEFONE_NFE BIT /*#161#*/
		,@GERA_COM_RT BIT = 0 /*#163# */
		,@MOSTRA_vIBS BIT = 0 /*#181# */
		,@UFs_NAO_VALIDAm_VIBS varchar(60)/*#181# */
		,@UF_vIBS char(2) /*#181# */

--#53# 

---@APP_VERSAO VARCHAR(20)  PARAMETRO DE ASSINATURA DO LINXPOS

SELECT @BAIXA_IAC_FATURAMENTO = CASE WHEN ISNULL(DBO.FX_PARAMETRO('BAIXA_IAC_POR_FATURAMENTO'), '.F.') = '.F.' THEN 0 ELSE 1 END /*#130#*/


declare @VERPROC VARCHAR(20),@LINX_VERSAO VARCHAR(50),@VER_LINX_SERVICE_PACK VARCHAR(50),@VER_HOTFIX VARCHAR(50)
		,@DATA_VALIDADE_CFOP_EXPE date/*#60#*/

--#115#	Obter o codigo da filial para passar como filtro em algumas views e tabelas que possuem o campo codigo_filial ao invés do campo filial.
SELECT @CODIGO_FILIAL = CODIGO_FILIAL FROM dbo.LOJAS_VAREJO as lj where  lj.FILIAL = @FILIALNOTA 

DECLARE @INF_AD_ALIQ_PROD_NA_OBS BIT = CASE WHEN dbo.fx_parametro('INF_AD_COB_ALIQ_NF_NA_OBS')='.T.' THEN 1 ELSE 0 END -- #119#

/*#60# - Inicio*/
SELECT @DATA_VALIDADE_CFOP_EXPE = GETDATE()
IF EXISTS(SELECT CONVERT(DATE,VALOR_ATUAL) FROM PARAMETROS WHERE PARAMETRO = 'DATA_VALIDADE_CFOP_EXPE')
	SELECT @DATA_VALIDADE_CFOP_EXPE = CONVERT(DATE,VALOR_ATUAL) FROM PARAMETROS WHERE PARAMETRO = 'DATA_VALIDADE_CFOP_EXPE'
/*#60# - Fim*/

/*#161#*/
/*INTEGRA VENDAS CANCELADAS POR DESISTÊNCIA*/
SELECT @ENVIAR_TELEFONE_NFE = CASE WHEN ISNULL(VALOR_ATUAL, '.F.') = '.T.' THEN 1 ELSE 0 END 
FROM DBO.PARAMETROS 
WHERE PARAMETRO = 'ENVIAR_TELEFONE_NFE';

SELECT @ENVIAR_TELEFONE_NFE = ISNULL(@ENVIAR_TELEFONE_NFE, 1);
/*#161#*/


/*#57# - Inicio*/
DECLARE @ARRAY VARCHAR(8000), @DELIMITADOR VARCHAR(100), @S VARCHAR(8000)
SELECT @ARRAY = VALOR_ATUAL from parametros where parametro ='VALIDA_CFOP_EXPE'
SELECT @DELIMITADOR = ',' 
IF LEN(@ARRAY) > 0 SET @ARRAY = @ARRAY + @DELIMITADOR 
	CREATE TABLE #ARRAY(ITEM_ARRAY VARCHAR(8000)COLLATE DATABASE_DEFAULT)
 
WHILE LEN(@ARRAY) > 0
BEGIN
   SELECT @S = LTRIM(SUBSTRING(@ARRAY, 1, CHARINDEX(@DELIMITADOR, @ARRAY) - 1))
   INSERT INTO #ARRAY (ITEM_ARRAY) VALUES (@S)
   SELECT @ARRAY = SUBSTRING(@ARRAY, CHARINDEX(@DELIMITADOR, @ARRAY) + 1, LEN(@ARRAY))
END
/*#57# - Fim*/

IF @APP_VERSAO IS NULL
BEGIN
	SELECT @LINX_VERSAO = SUBSTRING(LTRIM(VALOR_ATUAL),1,4) FROM PARAMETROS WHERE PARAMETRO = 'LINX_VERSAO'
	SELECT @VER_LINX_SERVICE_PACK = LTRIM(VALOR_ATUAL) FROM PARAMETROS WHERE PARAMETRO = 'VER_LINX_SERVICE_PACK'
	SELECT @VER_HOTFIX = LTRIM(VALOR_ATUAL) FROM PARAMETROS WHERE PARAMETRO = 'VER_HOTFIX'

--#53# 

	--IF @VER_LINX_SERVICE_PACK <> SUBSTRING(@VER_HOTFIX,1,5) 
	--	BEGIN 
	--		SET @VERPROC = 'LINXERP ' + LTRIM(RTRIM(@LINX_VERSAO)) + '.' + LTRIM(RTRIM(@VER_LINX_SERVICE_PACK))
	--	END
	--ELSE
	--	BEGIN 
	--		SET @VERPROC = 'LXERP ' + LTRIM(RTRIM(@LINX_VERSAO)) + '.' + LTRIM(RTRIM(@VER_HOTFIX))
	--	END

	--IF @VER_LINX_SERVICE_PACK <> SUBSTRING(@VER_HOTFIX,1,5) 
	--	  BEGIN 
	--			SET @VERPROC = 'LINXERP ' + LTRIM(RTRIM(REPLACE(@LINX_VERSAO,'.',''))) + ' ' +LTRIM(RTRIM(REPLACE(@VER_LINX_SERVICE_PACK,'.','')))
	--	  END
	--ELSE
	--	  BEGIN 
	--			SET @VERPROC = 'LINXERP ' + LTRIM(RTRIM(REPLACE(@LINX_VERSAO,'.',''))) + ' ' +LTRIM(RTRIM(REPLACE(@VER_HOTFIX,'.','')))     
	--	  END
--#53# 
--#54# 
 
        --SET @LINX_VERSAO = REPLACE(REPLACE(@LINX_VERSAO, '.', ''), '0', '') #116#
  
        IF @VER_LINX_SERVICE_PACK <> SUBSTRING(@VER_HOTFIX, 1, 5)
            BEGIN
				/* #116# - Início */
                /*SET @VER_LINX_SERVICE_PACK = SUBSTRING(@VER_LINX_SERVICE_PACK, 2, 1) + SUBSTRING(@VER_LINX_SERVICE_PACK, 4, 2)
				SET @VERPROC = 'LINXERP'+LTRIM(RTRIM(@LINX_VERSAO)) + LTRIM(RTRIM(@VER_LINX_SERVICE_PACK))*/
				SET @VERPROC = LTRIM(RTRIM(@LINX_VERSAO)) + '-' + LTRIM(RTRIM(@VER_LINX_SERVICE_PACK))
				/* #116# - Fim */
            END
        ELSE
            BEGIN
				/* #116# - Início */
                /*SET @VER_HOTFIX = SUBSTRING(@VER_HOTFIX, 2, 1) + SUBSTRING(@VER_HOTFIX, 4, 2) + RIGHT(RTRIM(SUBSTRING(@VER_HOTFIX, 7, 5)), 2)
				SET @VERPROC = 'LINXERP'+LTRIM(RTRIM(@LINX_VERSAO)) + LTRIM(RTRIM(@VER_HOTFIX))*/
				SET @VERPROC = LTRIM(RTRIM(@LINX_VERSAO)) + '-' + LTRIM(RTRIM(@VER_HOTFIX))
				/* #116# - Fim */
            END
--#54# 
END;
--#53# 


SELECT @MODELO = RTRIM(ES.NUMERO_MODELO_FISCAL), @SERIENOTA_OFICIAL = SN.COD_SERIE_SINTEGRA 
	FROM SERIES_NF SN INNER JOIN CTB_ESPECIE_SERIE ES ON SN.ESPECIE_SERIE = ES.ESPECIE_SERIE 
WHERE SERIE_NF = @SERIENOTA

SELECT @CHAVEACESSO = NULL

--SELECT @VERSAO_CHAVE_NFE = (SELECT RTRIM(VALOR_ATUAL) FROM PARAMETROS WHERE PARAMETRO = 'VERSAO_LAYOUT_XML_NFE')




--#152#

	IF OBJECT_ID('tempdb..#FATURAMENTO_ENTRADA_DEVOLUCAO') is not null DROP TABLE #FATURAMENTO_ENTRADA_DEVOLUCAO
	SELECT 
			 QTDE_DEVOLVIDA
			,ITEM_IMPRESSAO_SAIDA
			,ITEM_IMPRESSAO_ENTRADA
			,SUB_ITEM_SAIDA
			,SUB_ITEM_ENTRADA
			,FILIAL
			,NF_SAIDA
			,SERIE_NF
			,NOME_CLIFOR
			,NF_ENTRADA
			,SERIE_NF_ENTRADA
	INTO	
			#FATURAMENTO_ENTRADA_DEVOLUCAO
	FROM 
			FATURAMENTO_ENTRADA_DEVOLUCAO AS B
	WHERE  
			NF_SAIDA=@NOTAFISCAL  --#154#
			AND SERIE_NF=@SERIENOTA  --#154#
			AND FILIAL =@FILIALNOTA

	--#156#
	IF OBJECT_ID('tempdb..#FATURAMENTO_ENTRADA_DEVOLUCAO_SAIDA') is not null DROP TABLE #FATURAMENTO_ENTRADA_DEVOLUCAO_SAIDA
	SELECT 
			 QTDE_DEVOLVIDA
			,ITEM_IMPRESSAO_SAIDA
			,ITEM_IMPRESSAO_ENTRADA
			,SUB_ITEM_SAIDA
			,SUB_ITEM_ENTRADA
			,FILIAL
			,NF_SAIDA
			,SERIE_NF
			,NOME_CLIFOR
			,NF_ENTRADA
			,SERIE_NF_ENTRADA
	INTO	
			#FATURAMENTO_ENTRADA_DEVOLUCAO_SAIDA
	FROM 
			FATURAMENTO_ENTRADA_DEVOLUCAO AS B
	WHERE  
			NF_ENTRADA=@NOTAFISCAL 
			AND SERIE_NF_ENTRADA=@SERIENOTA 
			--AND FILIAL =@FILIALNOTA  #160#
	--#156#


	IF OBJECT_ID('tempdb..#IMPRESSAO_NFE') is not null 
		DROP TABLE #IMPRESSAO_NFE;

	SELECT 
			 DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NOME_FANTASIA_EMITENTE) AS NOME_FANTASIA_EMITENTE
			,NFE.FILIAL
			,NFE.CNPJ_EMITENTE
			,NFE.NF
			,NFE.SERIE_NF
			,NFE.ID_DESTINO_OPERACAO
			,NFE.INDICA_OPERACAO_FINAL
			,NFE.INDICA_PRESENCA_COMPRADOR
			,NFE.DOC_ESTRANGEIRO
			,NFE.INDICADOR_IE_DESTINARARIO
			,NFE.COD_SERIE_SINTEGRA
			,NFE.NOME_CLIFOR
			,NFE.CONDICAO_PGTO
			,NFE.NATUREZA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA) AS TRANSPORTADORA --#155#
			,NFE.COD_TRANSACAO
			,NFE.EMISSAO
			,NFE.DATA_SAIDA
			,NFE.HORA_SAIDA
			,NFE.FRETE
			,NFE.SEGURO
			,NFE.DESCONTO
			,NFE.DESCONTO_COND_PGTO
			,NFE.ENCARGO
			,NFE.VALOR_TOTAL
			,NFE.FATURA
			,NFE.OBS
			,NFE.PESO_LIQUIDO
			,NFE.PESO_BRUTO
			,NFE.VOLUMES
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TIPO_VOLUME) AS TIPO_VOLUME
			,NFE.VEICULO_PLACA
			,NFE.UF_PLACA_VEICULO
			,NFE.ENTREGA_CIF
			,NFE.DEVOLUCAO
			,NFE.REPRESENTANTE
			,NFE.GERENTE
			,NFE.TIPO
			,NFE.TIPO_FRETE
			,NFE.VALOR_SUB_ITENS
			,NFE.VALOR_IMPOSTO_AGREGAR
			,NFE.CFOP
			,NFE.TEXTO_LEGAL
			,NFE.FIN_EMISSAO_NFE
			,NFE.TIPO_EMISSAO_NFE
			,NFE.TIPO_PGTO_NFE
			,NFE.CHAVE_NFE
			,NFE.VALOR_SUB_ITENS_BRUTO
			,NFE.TRANSPORTADORA_PF_PJ
			,NFE.TRANSPORTADORA_CNPJ
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA_ENDERECO) AS TRANSPORTADORA_ENDERECO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA_CIDADE) AS TRANSPORTADORA_CIDADE
			,NFE.TRANSPORTADORA_UF
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TRANSPORTADORA_IE) AS TRANSPORTADORA_IE
			,NFE.CEP_EMITENTE
			,NFE.PJ_PF_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RAZAO_SOCIAL_EMITENTE) AS RAZAO_SOCIAL_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENDERECO_EMITENTE) AS ENDERECO_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERO_EMITENTE) AS NUMERO_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.COMPLEMENTO_EMITENTE) AS COMPLEMENTO_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.BAIRRO_EMITENTE) AS BAIRRO_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.CIDADE_EMITENTE) AS CIDADE_EMITENTE
			,NFE.UF_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.PAIS_EMITENTE) AS PAIS_EMITENTE
			,NFE.DDD1_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TELEFONE1_EMITENTE) AS TELEFONE1_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IE_EMITENTE) AS IE_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IM_EMITENTE) AS IM_EMITENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.CNAE) AS CNAE
			,NFE.CLIFOR
			,NFE.CNPJ_DESTINATARIO
			,NFE.EMAIL_NFE
			,NFE.EMAIL_DESTINATARIO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RAZAO_SOCIAL) AS RAZAO_SOCIAL
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RG_IE) AS RG_IE
			,NFE.IEST
			,NFE.IM 
			,NFE.IM_ENTREGA
			,NFE.PJ_PF
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.PAIS) AS PAIS
			,NFE.ENTREGA_PAIS
			,NFE.ENTREGA_DDD
			,CASE WHEN @ENVIAR_TELEFONE_NFE = 1 THEN NFE.ENTREGA_TELEFONE ELSE NULL END AS ENTREGA_TELEFONE /*#161#*/
			,NFE.INSCRICAO_SUFRAMA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.CEP) AS CEP
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENDERECO) AS ENDERECO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERO) AS NUMERO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.COMPLEMENTO) AS COMPLEMENTO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.CIDADE) AS CIDADE
			,NFE.UF
			,CASE WHEN @ENVIAR_TELEFONE_NFE = 1 THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TELEFONE1) ELSE NULL END AS TELEFONE1 /*#161#*/
			,NFE.COBRANCA_NUMERO
			,NFE.COBRANCA_COMPLEMENTO
			,NFE.COBRANCA_CIDADE
			,NFE.BANCO
			,NFE.CARTEIRA
			,NFE.COBRANCA_UF
			,NFE.COBRANCA_CEP
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_ENDERECO) AS ENTREGA_ENDERECO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_NUMERO) AS ENTREGA_NUMERO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_COMPLEMENTO) AS ENTREGA_COMPLEMENTO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_CIDADE) AS ENTREGA_CIDADE
			,NFE.ENTREGA_UF
			,NFE.ENTREGA_CEP
			,NFE.INDICA_FORNECEDOR
			,NFE.INDICA_CLIENTE
			,NFE.IND_REPRESENTANTE
			,NFE.INDICA_FILIAL
			,NFE.ENTREGA_CGC
			,NFE.ENTREGA_IE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.BAIRRO) AS  BAIRRO --#153#
			,NFE.OBS_DE_FATURAMENTO
			,NFE.DDD1
			,NFE.DDI
			,NFE.CONTA_CONTABIL_CLIENTE
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_BAIRRO) AS ENTREGA_BAIRRO
			,NFE.COBRANCA_BAIRRO
			,NFE.NOME_LOCAL_RETIRADA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_RAZAO_SOCIAL) AS RETIRADA_ENTREGA_RAZAO_SOCIAL
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_ENDERECO) AS RETIRADA_ENTREGA_ENDERECO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_NUMERO) AS RETIRADA_ENTREGA_NUMERO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_COMPLEMENTO) AS RETIRADA_ENTREGA_COMPLEMENTO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_CIDADE) AS RETIRADA_ENTREGA_CIDADE
			,NFE.RETIRADA_ENTREGA_UF
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_BAIRRO) AS RETIRADA_ENTREGA_BAIRRO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_CEP) AS RETIRADA_ENTREGA_CEP
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_PAIS) AS RETIRADA_ENTREGA_PAIS
			,CASE WHEN @ENVIAR_TELEFONE_NFE = 1 THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_TELEFONE) ELSE NULL END AS RETIRADA_ENTREGA_TELEFONE /*#161#*/
			,NFE.RETIRADA_ENTREGA_DDD
			,NFE.RETIRADA_ENTREGA_DDI
			,NFE.RETIRADA_ENTREGA_CGC
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_IE) AS RETIRADA_ENTREGA_IE
			,NFE.RETIRADA_COD_MUNICIPIO_IBGE_ENTREGA
			,NFE.RETIRADA_PJ_PF
			,NFE.RETIRADA_EMAIL_NFE
			,NFE.CAIXAS_ENVIADAS
			,NFE.CLASSIFICACOES
			,NFE.PEDIDOS_ENVIADOS
			,NFE.PEDIDOS_CLIENTE_ENVIADOS
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.DESC_NATUREZA) AS DESC_NATUREZA
			,NFE.CTB_TIPO_OPERACAO
			,NFE.LX_TIPO_LANCAMENTO
			,NFE.DESC_NF_NATUREZA
			,NFE.DESC_TIPO_LANCAMENTO
			,NFE.DESC_TIPO_OPERACAO
			,NFE.DESC_CONDICAO_PGTO
			,NFE.CLIFOR_REPRESENTANTE
			,NFE.DESC_CONTA_CONTABIL_CLIENTE
			,NFE.ICMS
			,NFE.ICMS_BASE
			,NFE.IPI
			,NFE.IPI_BASE
			,NFE.IPI_E
			,NFE.IPI_E_BASE
			,NFE.IRRF
			,NFE.IRRF_BASE
			,NFE.INSS
			,NFE.INSS_BASE
			,NFE.PIS
			,NFE.PIS_BASE
			,NFE.COFINS
			,NFE.COFINS_BASE
			,NFE.I_IMPORT
			,NFE.I_IMPORT_BASE
			,NFE.IVA
			,NFE.IVA_BASE
			,NFE.RECARGO
			,NFE.RECARGO_BASE
			,NFE.IRPF
			,NFE.IRPF_BASE
			,NFE.DICMS
			,NFE.DICMS_BASE
			,NFE.ICMS_ST
			,NFE.ICMS_ST_BASE
			,NFE.ICMS_STR
			,NFE.ICMS_STR_BASE
			,NFE.ISS
			,NFE.ISS_BASE
			,NFE.IVA_IC
			,NFE.IVA_IC_BASE
			,NFE.PC_CSL
			,NFE.PC_CSL_BASE
			,NFE.PIS_R
			,NFE.PIS_R_BASE
			,NFE.COFINS_R
			,NFE.COFINS_R_BASE
			,NFE.CSLL_R
			,NFE.CSLL_R_BASE
			,NFE.IRRF_R
			,NFE.IRRF_R_BASE
			,NFE.INSS_R
			,NFE.INSS_R_BASE
			,NFE.ISS_R
			,NFE.ISS_R_BASE
			,NFE.PIS_S
			,NFE.PIS_S_BASE
			,NFE.COFINS_S
			,NFE.COFINS_S_BASE
			,NFE.CSLL_S
			,NFE.CSLL_S_BASE
			,NFE.RTEIVA
			,NFE.RTEIVA_BASE
			,NFE.RTEIVA_R
			,NFE.RTEIVA_R_BASE
			,NFE.ICA
			,NFE.ICA_BASE
			,NFE.RTEICA
			,NFE.RTEICA_BASE
			,NFE.RTEFTE
			,NFE.RTEFTE_BASE
			,NFE.RTEFTE_R
			,NFE.RTEFTE_R_BASE
			,NFE.ICMS_ZF
			,NFE.ICMS_ZF_BASE
			,NFE.ICMS_ZF_ALIQ
			,NFE.PIS_ZF
			,NFE.PIS_ZF_BASE
			,NFE.PIS_ZF_ALIQ
			,NFE.COFINS_ZF
			,NFE.COFINS_ZF_BASE
			,NFE.COFINS_ZF_ALIQ
			,NFE.DICMS_R
			,NFE.DICMS_R_BASE
			,NFE.FECP
			,NFE.FECP_BASE
			,NFE.SIMPLES_E
			,NFE.SIMPLES_E_BASE
			,NFE.SIMPLES_F
			,NFE.SIMPLES_F_BASE
			,NFE.ICMS_BST
			,NFE.ICMS_DESONERADO
			,NFE.ICMS_DESONERADO_BASE
			,NFE.ICMS_DESONERADO_ALIQ
			,NFE.CP_INSS
			,NFE.CP_INSS_BASE
			,NFE.PIS_SOBRE_SERVICO
			,NFE.COFINS_SOBRE_SERVICO
			,NFE.FECP_DEST
			,NFE.FECP_BASE_DEST
			,NFE.DICMS_ORIG
			,NFE.DICMS_BASE_ORIG
			,NFE.DICMS_DEST
			,NFE.DICMS_BASE_DEST
			,NFE.FECP_ST
			,NFE.FECP_STR
			,NFE.FECP_STA
			,NFE.FECP_STAR
			,NFE.COD_FILIAL
			,NFE.DESCRICAO_TIPO_FRETE
			,NFE.DESCRICAO_SERIE
			,NFE.ANO_FISCAL
			,NFE.NOTA_CANCELADA
			,NFE.NF_E_NUMERO
			,NFE.NF_E_DATA_EMISSAO
			,NFE.NF_E_COD_VERIFICACAO
			,NFE.NF_E_DATA_QUITACAO_GUIA
			,NFE.NF_E_GERACAO
			,NFE.ORIGEM_NF
			,NFE.NF_NUMERO_REFERENCIADA
			,NFE.SEQUENCIAL_UNICO
			,NFE.DATA_GERACAO_NSU
			,NFE.OBS_INTERESSE_FISCO
			,NFE.DATA_CONTINGENCIA_UTC
			,NFE.DATA_CONTINGENCIA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.JUSTIFICATIVA_CONTINGENCIA) AS JUSTIFICATIVA_CONTINGENCIA
			,NFE.CRT
			,NFE.UF_EMBARQUE_EXPORTACAO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.LOCAL_EMBARQUE_EXPORTACAO) AS LOCAL_EMBARQUE_EXPORTACAO
			,NFE.NOTA_EMPENHO_COMPRA
			,NFE.PEDIDO_COMPRA
			,NFE.CONTRATO_COMPRA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.MARCA_VOLUMES) AS MARCA_VOLUMES
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERACAO_VOLUMES) AS NUMERACAO_VOLUMES
			,NFE.EMITENTE_COD_MUNICIPIO_IBGE
			,NFE.COD_MUNICIPIO_IBGE
			,NFE.COD_MUNICIPIO_IBGE_ENTREGA
			,NFE.AMBIENTE_NFE
			,NFE.VERSAO_LAYOUT_NFE
			,NFE.FORMATO_IMP_DANFE_NFE
			,NFE.VERSAO_EMISSOR_NFE
			,NFE.IMPORTACAO
			,NFE.IMPORTACAO_ALFANDEGA
			,NFE.IMPORTACAO_OUTRAS_DESPESAS
			,NFE.IMPORTACAO_FRETE
			,NFE.IMPORTACAO_SEGURO
			,NFE.IMPORTACAO_DESEMBARACO
			,NFE.IMPORTACAO_TX_CAPATAZIA
			,NFE.IMPORTACAO_ICMS
			,NFE.IMPORTACAO_IMPOSTO
			,NFE.DANFE_NFE_IMPORTACAO_CALC
			,NFE.UTC_EMISSAO
			,NFE.UTC_DATA_SAIDA
			,NFE.COD_PAIS_BC
			,NFE.INFORMACAO_COMPLEMENTAR
			,NFE.MODELO_FISCAL
			,NFE.INFO_PGTO
			,NFE.TIPO_OPERACAO
			,NFE.INTERMERDIADOR_CNPJ
			,NFE.INTERMERDIADOR_IDCADINTTRAN
			,NFE.DESC_MEIO_PGTO
			,NFE.INTERMERDIADOR
			,NFE.NUMERO_PROCESSO
			,NFE.TIPO_PROCESSO
			,NFE.ATO_CONCESSORIO
			/*#163# - Início*/
			,NFE.TP_NF_DEBITO	
			,NFE.TP_NF_CREDITO	
			,NFE.IS_VALOR 
			,NFE.IS_BASE
			,NFE.IBS_EST_VALOR 
			,NFE.IBS_EST_BASE
			,NFE.IBS_MUN_VALOR 
			,NFE.IBS_MUN_BASE	
			,NFE.CBS_VALOR 
			,NFE.CBS_BASE
			/*#163# - Fim*/
			/*#173# - Início*/
			,NFE.TP_ENTE_GOVERNO	
			,NFE.REDUTOR_COMPRA_GOVERNO	
			,NFE.TP_OPER_GOVERNO 
			/*#173# - Fim*/
		
	INTO #IMPRESSAO_NFE 
	FROM 
			W_IMPRESSAO_NFE NFE
	WHERE 
			NFE.NF = @NOTAFISCAL
			AND NFE.SERIE_NF = @SERIENOTA
			AND NFE.FILIAL = @FILIALNOTA;

SELECT @CHAVEACESSO = NFE.CHAVE_NFE,
	@OBS_FAT = NFE.OBS,
	@TEXTO_LEGAL = NFE.TEXTO_LEGAL,
	@TIPO_DOC = RIGHT(RTRIM(NFE.ORIGEM_NF),1),
	@TIPO_DOC_CHAVE = SUBSTRING(ORIGEM_NF,1,1),	
	@NOME_CLIFOR = NFE.NOME_CLIFOR,
	@CNPJ_EMITENTE = NFE.CNPJ_EMITENTE,  
	@CIDADE_EMITENTE  = NFE.CIDADE_EMITENTE,
	@UF_EMITENTE =  NFE.UF_EMITENTE,
	@AAMM_EMISSAO = SUBSTRING(CONVERT(VARCHAR(20),NFE.EMISSAO,112),3,4),
	@TIPO_EMISSAO = NFE.TIPO_EMISSAO_NFE,
	@CODIGO_UF_IBGE = SUBSTRING(NFE.EMITENTE_COD_MUNICIPIO_IBGE,1,2),
	@EMAIL_NFE = LTRIM(RTRIM(EMAIL_NFE)), @EMAIL_DESTINATARIO = LTRIM(RTRIM(EMAIL_DESTINATARIO)), --#5#
	@OBS_INTERESSE_FISCO = NFE.OBS_INTERESSE_FISCO,
	@VERSAO_CHAVE_NFE = VERSAO_LAYOUT_NFE,
	@NF_NUMERO_REFERENCIADA = NF_NUMERO_REFERENCIADA --#49#	
FROM  #IMPRESSAO_NFE NFE --#152#
WHERE  NF = @NOTAFISCAL  AND 
  	   SERIE_NF = @SERIENOTA AND 
	   FILIAL = @FILIALNOTA;

--#152#
	IF OBJECT_ID('tempdb..#INFORMACAO_PAGAMENTO') is not null DROP TABLE #INFORMACAO_PAGAMENTO
	SELECT 
			NF
			,SERIE_NF
			,FILIAL
			,PARCELA
			,TIPO_AMBIENTE_LINX
			,INFO_PGTO
			,TIPO_INTEGRA
			,CNPJ_CREDENCIADORA
			,BANDEIRA
			,AUTORIZACAO
			,VALOR
			,TIPO_NOTA
			,TROCO
			,DATA_PAGAMENTO
			,CNPJ_RECEB
			,TERMINAL
	INTO
			#INFORMACAO_PAGAMENTO
	FROM 
			W_INFORMACAO_PAGAMENTO WITH (NOLOCK)
	WHERE 
			NF = @NOTAFISCAL
		AND SERIE_NF = @SERIENOTA
		AND FILIAL = @FILIALNOTA



--#64# - Inicio
SELECT @QTDE_PARCELA = case when MAX(isnull(PARCELA,0)) = 0 then 1 else MAX(PARCELA) end FROM  #INFORMACAO_PAGAMENTO WITH(NOLOCK) --#152#
					  WHERE NF = @NOTAFISCAL AND 
							SERIE_NF = @SERIENOTA AND
							FILIAL = @FILIALNOTA
--#64# - Fim


--#13#
select	@CLIFOR_FILIALNOTA = CLIFOR
		,@OPTANTE_ROT = OPTANTE_ROT /*#123#*/
FROM FILIAIS WHERE FILIAL = @FILIALNOTA

--#152#
	IF OBJECT_ID('tempdb..#IMPRESSAO_NFE_ITENS') is not null 
		DROP TABLE #IMPRESSAO_NFE_ITENS;

	SELECT
			 NFE_ITENS.NOME_CLIFOR
			,NFE_ITENS.NF
			,NFE_ITENS.SERIE_NF
			,NFE_ITENS.FILIAL
			,NFE_ITENS.ITEM_NFE
			,NFE_ITENS.ITEM_IMPRESSAO
			,NFE_ITENS.SUB_ITEM_TAMANHO
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE_ITENS.DESCRICAO_ITEM) AS DESCRICAO_ITEM
			,NFE_ITENS.QTDE_ITEM
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_REINF(NFE_ITENS.CODIGO_ITEM) AS CODIGO_ITEM
			,NFE_ITENS.TRIBUT_ICMS 
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE_ITENS.UNIDADE) AS UNIDADE
			,NFE_ITENS.CLASSIF_FISCAL 
			,NFE_ITENS.CODIGO_FISCAL_OPERACAO 
			,NFE_ITENS.PRECO_UNITARIO 
			,NFE_ITENS.DESCONTO_ITEM 
			,NFE_ITENS.VALOR_ITEM 
			,NFE_ITENS.TRIBUT_ORIGEM
			,NFE_ITENS.VALOR_IMPOSTO_ITEM
			,NFE_ITENS.CST_IPI
			,NFE_ITENS.CST_PIS
			,NFE_ITENS.CST_COFINS
			,NFE_ITENS.CST_ISS
			,NFE_ITENS.NUMERO_PROCESSO_ISS
			,NFE_ITENS.INDICADOR_INCENTIVO_ISS
			,NFE_ITENS.PREDBC
			,NFE_ITENS.PREDBCST
			,NFE_ITENS.PMVAST
			,NFE_ITENS.PREDBCEFET
			,NFE_ITENS.ICMS_EFET_BASE
			,NFE_ITENS.ICMS_EFET_ALIQUOTA
			,NFE_ITENS.ICMS_EFET_VALOR
			,NFE_ITENS.COD_SERVICO
			,NFE_ITENS.ICMS 
			,NFE_ITENS.ICMS_ALIQUOTA
			,NFE_ITENS.ICMS_BASE
			,NFE_ITENS.IPI 
			,NFE_ITENS.IPI_ALIQUOTA
			,NFE_ITENS.IPI_BASE
			,NFE_ITENS.IPI_E
			,NFE_ITENS.ICMS_STA
			,NFE_ITENS.ICMS_STA_ALIQUOTA
			,NFE_ITENS.ICMS_STA_BASE
			,NFE_ITENS.ICMS_STAR
			,NFE_ITENS.ICMS_STAR_ALIQUOTA
			,NFE_ITENS.ICMS_STAR_BASE
			,NFE_ITENS.FECP_STA
			,NFE_ITENS.FECP_STA_ALIQUOTA
			,NFE_ITENS.FECP_STA_BASE
			,NFE_ITENS.FECP_STAR
			,NFE_ITENS.FECP_STAR_ALIQUOTA
			,NFE_ITENS.FECP_STAR_BASE
			,NFE_ITENS.IRRF  
			,NFE_ITENS.IRRF_BASE
			,NFE_ITENS.INSS 
			,NFE_ITENS.INSS_BASE
			,NFE_ITENS.PIS 
			,NFE_ITENS.PIS_ALIQUOTA
			,NFE_ITENS.PIS_BASE
			,NFE_ITENS.COFINS
			,NFE_ITENS.COFINS_ALIQUOTA
			,NFE_ITENS.COFINS_BASE
			,NFE_ITENS.I_IMPORT
			,NFE_ITENS.I_IMPORT_BASE
			,NFE_ITENS.DICMS_BASE
			,NFE_ITENS.ICMS_ST 
			,NFE_ITENS.ICMS_ST_ALIQUOTA
			,NFE_ITENS.ICMS_ST_BASE
			,NFE_ITENS.ICMS_STR
			,NFE_ITENS.ICMS_STR_ALIQUOTA
			,NFE_ITENS.ICMS_STR_BASE
			,NFE_ITENS.ISS
			,NFE_ITENS.ISS_ALIQUOTA
			,NFE_ITENS.ISS_BASE
			,NFE_ITENS.ISS_R
			,NFE_ITENS.ISS_R_ALIQUOTA
			,NFE_ITENS.ISS_R_BASE
			,NFE_ITENS.PIS_S 
			,NFE_ITENS.COFINS_S
			,NFE_ITENS.CSLL_S 
			,NFE_ITENS.VALOR_DESCONTOS
			,NFE_ITENS.FRETE
			,NFE_ITENS.SEGURO
			,NFE_ITENS.ENCARGO
			,NFE_ITENS.INDTOT
			,NFE_ITENS.PEDIDO_COMPRA 
			,NFE_ITENS.ITEM_PEDIDO_COMPRA
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,NFE_ITENS.INFORMACAO_ADICIONAL_PROD) AS INFORMACAO_ADICIONAL_PROD
			,NFE_ITENS.VDESPADU
			,NFE_ITENS.CODIGO_ENQUADRAMENTO
			,NFE_ITENS.CODIGO_CLASSE_TRIBUTACAO
			,NFE_ITENS.ICMS_SN
			,NFE_ITENS.ICMS_SN_ALIQUOTA
			,NFE_ITENS.ICMS_BST 
			,NFE_ITENS.EAN
			,NFE_ITENS.ICMS_ZF 
			,NFE_ITENS.PIS_ZF
			,NFE_ITENS.COFINS_ZF
			,NFE_ITENS.ICMS_DESONERADO
			,NFE_ITENS.ST_MOT_DESONERACAO
			,NFE_ITENS.IND_DEDUZ_DESON
			,NFE_ITENS.CODIGO_FCI
			,NFE_ITENS.CODIGO_CEST
			,NFE_ITENS.EMISSAO_RECEBIMENTO
			,NFE_ITENS.FECP_DEST_ALIQUOTA
			,NFE_ITENS.FECP_DEST_VALOR
			,NFE_ITENS.FECP_DEST_BASE
			,NFE_ITENS.ICMS_DEST_ALIQUOTA
			,NFE_ITENS.PART_ICMS_DEST_ALIQUOTA
			,NFE_ITENS.DICMS_DEST_VALOR
			,NFE_ITENS.DICMS_ORIG_VALOR
			,NFE_ITENS.FECP_ALIQUOTA
			,NFE_ITENS.FECP_VALOR
			,NFE_ITENS.FECP_BASE
			,NFE_ITENS.FECP_ST_ALIQUOTA
			,NFE_ITENS.FECP_ST_VALOR
			,NFE_ITENS.FECP_ST_BASE
			,NFE_ITENS.FECP_STR_ALIQUOTA
			,NFE_ITENS.FECP_STR_VALOR
			,NFE_ITENS.FECP_STR_BASE
			,NFE_ITENS.SUB_ITEM_SPED
			,NFE_ITENS.ICMS_SUBSTITUTO
			,NFE_ITENS.FECP_DIF_VALOR
			,NFE_ITENS.FECP_DIF_BASE
			,NFE_ITENS.OBS_CONTRIB_NOME
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,NFE_ITENS.OBS_CONTRIB_CONTEUDO) AS OBS_CONTRIB_CONTEUDO
			,NFE_ITENS.OBS_FISCO_NOME
			,DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,NFE_ITENS.OBS_FISCO_CONTEUDO) AS OBS_FISCO_CONTEUDO
			,NFE_ITENS.PORC_CRED_PRESUMIDO
			,NFE_ITENS.GERAR_BENEF_RBC
			,NFE_ITENS.GERAR_GCRED_PRESUMIDO
			,NFE_ITENS.CODIGO_AJUSTE
			,NFE_ITENS.CBENEFRBC --#157#	
			,NFE_ITENS.COD_GCRED_PRESUMIDO --#157#
			/*#163# - Início*/
			,NFE_ITENS.CST_IBS_CBS		
			,NFE_ITENS.CCLASSTRIB       
			,NFE_ITENS.IBS_EST_BASE		
			,NFE_ITENS.IBS_EST_ALIQUOTA	
			,NFE_ITENS.IBS_EST_VALOR	
			,NFE_ITENS.CBS_BASE			
			,NFE_ITENS.CBS_ALIQUOTA		
			,NFE_ITENS.CBS_VALOR		
			,NFE_ITENS.IS_BASE			
			,NFE_ITENS.IS_ALIQUOTA		
			,NFE_ITENS.IS_VALOR			
			,NFE_ITENS.IBS_MUN_BASE		
			,NFE_ITENS.IBS_MUN_ALIQUOTA	
			,NFE_ITENS.IBS_MUN_VALOR	
			/*#163# - Fim*/
			/*#174# - Início*/
			,NFE_ITENS.IBS_EST_RED_ALIQ		
			,NFE_ITENS.IBS_MUN_RED_ALIQ       
			,NFE_ITENS.CBS_RED_ALIQ		
			,NFE_ITENS.IBS_EST_RED_ALIQ_ORIGINAL
			,NFE_ITENS.IBS_MUN_RED_ALIQ_ORIGINAL
			,NFE_ITENS.CBS_RED_ALIQ_ORIGINAL
			/*#174# - Fim*/
	INTO 	#IMPRESSAO_NFE_ITENS 
	FROM 
		W_IMPRESSAO_NFE_ITENS AS NFE_ITENS
	WHERE
		NFE_ITENS.NF = @NOTAFISCAL
		AND NFE_ITENS.SERIE_NF = @SERIENOTA
		AND NFE_ITENS.FILIAL = @FILIALNOTA


		--SELECT * FROM #IMPRESSAO_NFE_ITENS

/*#158# Criado uma temporária por uma questão de performance*/
IF OBJECT_ID('tempdb..#XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA') is not null 
		DROP TABLE #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA;
SELECT ID_UNIDADE_TRIBUTARIA, FATOR_CONVERSAO_UNIDADE_TRIBUTARIA, ORDEM, CODIGO_BARRA INTO #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA FROM 
	(
		SELECT PRODUTOS_REF_FORNECEDOR.ID_UNIDADE_TRIBUTARIA,PRODUTOS_REF_FORNECEDOR.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA, 1 AS ORDEM, PRODUTOS_REF_FORNECEDOR.CODIGO_BARRA
		FROM #IMPRESSAO_NFE_ITENS A 
		JOIN PRODUTOS_REF_FORNECEDOR ON PRODUTOS_REF_FORNECEDOR.CODIGO_BARRA=A.EAN
		WHERE PRODUTOS_REF_FORNECEDOR.FORNECEDOR = A.NOME_CLIFOR 
			AND ID_UNIDADE_TRIBUTARIA IS NOT NULL
		UNION ALL
		SELECT PRODUTOS_BARRA.ID_UNIDADE_TRIBUTARIA,PRODUTOS_BARRA.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA, 2 AS ORDEM, PRODUTOS_BARRA.CODIGO_BARRA
		FROM #IMPRESSAO_NFE_ITENS A 
		JOIN PRODUTOS_BARRA ON PRODUTOS_BARRA.CODIGO_BARRA = A.EAN
		WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
			AND ID_UNIDADE_TRIBUTARIA IS NOT NULL
	) A
/*#158#*/


--#1#/#2#
SELECT @VALOR_IMPOSTO_ITEM = CASE WHEN sum(ISNULL(VALOR_IMPOSTO_ITEM,0)) = 0 THEN '0.00' ELSE 
--CONVERT(VARCHAR(16),((sum(ISNULL(VALOR_IMPOSTO_ITEM, 0))/sum(VALOR_ITEM))*100)) --#3#
SUM(ISNULL(VALOR_IMPOSTO_ITEM,0)) END 
FROM #IMPRESSAO_NFE_ITENS NFE_VALOR --#152#
WHERE  NF = @NOTAFISCAL  AND 
  	   SERIE_NF = @SERIENOTA AND 
	   FILIAL = @FILIALNOTA

-- MONTAGEM DO CAMPO CHAVE
IF @CHAVEACESSO IS NULL
	BEGIN
		-- BUSCA A SÉRIE OFICIAL DA NOTA FISCAL NA COLUNA COD_SERIE_SINTEGRA DA TABELA SERIES_NF PARA COMPOR A CHAVE NF-E
		SELECT @SERIENOTA_OFICIAL = RTRIM(CASE WHEN COD_SERIE_SINTEGRA IS NULL OR COD_SERIE_SINTEGRA = '' THEN @SERIENOTA ELSE COD_SERIE_SINTEGRA END) FROM SERIES_NF WHERE SERIE_NF = @SERIENOTA
		-- FIM DA BUSCA DA SÉRIE OFICIAL

		IF @TIPO_EMISSAO = 0
			SELECT @TIPO_EMISSAO = 1

		--------------------------------------------
		-- EXCLUIR ESTE CODIGO APOS CONCLUIR O TESTE
		--------------------------------------------


		-- @VERSAO_CHAVE_NFE: 1.10	
		-- @VERSAO_CHAVE_NFE: 2.00	(ENTRA EM VIGOR A PARTIR DO DIA

		-- MONTAGEM DA CHAVE DE ACESSO DA NOTA FISCAL E DO CALCULO DO DIGITO VERIFICADOR
		IF RTRIM(@VERSAO_CHAVE_NFE) = '1.10'
			BEGIN
				SELECT @CODIGONF = RIGHT(STR(RAND(),11,9),9) 

				--#104# - Início - Verifica se o Código de Segurança é Fraco ou igual o número da NF, se for refaz para evitar rejeição no SEFAZ conforme NT 2019_001_v1
				While exists(Select @CODIGONF where @CODIGONF in ('00000000', '11111111', '22222222', '33333333', '44444444', '55555555', '66666666', '77777777', '88888888', '99999999', '12345678', '23456789', '34567890', '45678901', '56789012', '67890123', '78901234', '89012345', '90123456', '01234567')) or
					  exists(select @CODIGONF where @CODIGONF = RTRIM(LTRIM(CONVERT(INTEGER,@NOTAFISCAL)))) -- Faz o convert de @NOTAFISCAL conforme a gravação da tag "nNF" (Ver Abaixo)
					Begin
						Select @CODIGONF = RIGHT(STR(RAND(),11,9),9) 
					End
				--#104# - Fim

				SELECT @CHAVEACESSO = @CODIGO_UF_IBGE +
										@AAMM_EMISSAO +
										@CNPJ_EMITENTE +
										@MODELO +
										RIGHT('00'+RTRIM(CASE WHEN @SERIENOTA_OFICIAL = 'U' OR @SERIENOTA_OFICIAL = 'UN' THEN '0' ELSE @SERIENOTA_OFICIAL END),3)+
										RIGHT('00000000'+RTRIM(@NOTAFISCAL),9)+
										@CODIGONF

			END

		IF RTRIM(@VERSAO_CHAVE_NFE) = '2.00' OR RTRIM(@VERSAO_CHAVE_NFE) = '3.10' OR RTRIM(@VERSAO_CHAVE_NFE) = '4.00'  -- VERSAO 2.00 #61#
			BEGIN
				SELECT @CODIGONF = RIGHT(STR(RAND(),11,9),8) 

				--#104# - Início - Verifica se o Código de Segurança é Fraco ou igual o número da NF, se for refaz para evitar rejeição no SEFAZ conforme NT 2019_001_v1   
				While exists(Select @CODIGONF where @CODIGONF in ('00000000', '11111111', '22222222', '33333333', '44444444', '55555555', '66666666', '77777777', '88888888', '99999999', '12345678', '23456789', '34567890', '45678901', '56789012', '67890123', '78901234', '89012345', '90123456', '01234567')) or
					  exists(select @CODIGONF where @CODIGONF = RTRIM(LTRIM(CONVERT(INTEGER,@NOTAFISCAL)))) -- Faz o convert de @NOTAFISCAL conforme a gravação da tag "nNF" (Ver Abaixo)
					Begin
						Select @CODIGONF = RIGHT(STR(RAND(),11,9),8) 
					End
				--#104# - Fim

				SELECT @CHAVEACESSO = @CODIGO_UF_IBGE +
										@AAMM_EMISSAO +
										@CNPJ_EMITENTE +
										@MODELO +
										RIGHT('00'+RTRIM(CASE WHEN @SERIENOTA_OFICIAL = 'U' OR @SERIENOTA_OFICIAL = 'UN' THEN '0' ELSE @SERIENOTA_OFICIAL END),3)+
										RIGHT('00000000'+RTRIM(@NOTAFISCAL),9)+
										CONVERT(CHAR(1),@TIPO_EMISSAO)+
										@CODIGONF
			END

		-- FAZ A VALIDAÇÃO DA SERIE, SE FOR CARACTER, NAO GERA O DIGITO VERIFICADOR
		IF @SERIENOTA_OFICIAL NOT LIKE '%[!-/]%' AND @SERIENOTA_OFICIAL NOT LIKE '%[A-Z]%'
		BEGIN
			SELECT  @CNT = 43 , @PESO = 2, @SOMAPONDERACOES = 0
			WHILE @CNT > 0
				BEGIN
					IF @PESO > 9
						SELECT @PESO = 2

					SELECT @SOMAPONDERACOES = @SOMAPONDERACOES + (CONVERT(INT,SUBSTRING(@CHAVEACESSO,@CNT,1)) * @PESO)

					SELECT @PESO = @PESO + 1
					SELECT @CNT  = @CNT - 1
				END 

			SELECT	@RESTODIVISAO = (@SOMAPONDERACOES - (FLOOR((@SOMAPONDERACOES / 11)) * 11))
			SELECT @DIGITOVERIFICADOR = CASE WHEN @RESTODIVISAO = 1 OR @RESTODIVISAO = 0 THEN '0' ELSE LTRIM(RTRIM(STR(11 - @RESTODIVISAO))) END 
		END

		SELECT @CHAVEACESSO = RTRIM(@CHAVEACESSO)+RTRIM(@DIGITOVERIFICADOR) 
		
		-- CODIGO PARA ATUALIZACAO DA CHAVE NA TABELA DE ENTRADA/SAIDA/LOJA????
		IF @TIPO_DOC_CHAVE = 'L'
			UPDATE LOJA_NOTA_FISCAL
				SET CHAVE_NFE = @CHAVEACESSO
				WHERE NF_NUMERO = @NOTAFISCAL  AND 
  						SERIE_NF = @SERIENOTA AND 
						CODIGO_FILIAL = (SELECT CODIGO_FILIAL FROM LOJAS_VAREJO (NOLOCK) WHERE FILIAL = @FILIALNOTA)
		
		IF @TIPO_DOC_CHAVE = 'S'
			UPDATE FATURAMENTO
				SET CHAVE_NFE = @CHAVEACESSO
				WHERE NF_SAIDA = @NOTAFISCAL  AND 
  						SERIE_NF = @SERIENOTA AND 
						FILIAL = @FILIALNOTA
						
		IF @TIPO_DOC_CHAVE = 'E'
			UPDATE ENTRADAS
				SET CHAVE_NFE = @CHAVEACESSO
				WHERE NF_ENTRADA = @NOTAFISCAL  AND 
  						SERIE_NF_ENTRADA = @SERIENOTA AND 
						NOME_CLIFOR = @NOME_CLIFOR		
		
	END
ELSE
	BEGIN
		IF @SERIENOTA_OFICIAL IS NULL
			SELECT @SERIENOTA_OFICIAL = @SERIENOTA
	END 

SELECT @INFCOMPLEMENTAR = ''

IF (@TEXTO_LEGAL <> '' AND @TEXTO_LEGAL IS NOT NULL) 
	SELECT @INFCOMPLEMENTAR = @INFCOMPLEMENTAR+' '+UPPER(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@TEXTO_LEGAL))

IF @OBS_FAT IS NOT NULL AND @OBS_FAT <> ' ' 
	SELECT @INFCOMPLEMENTAR = @INFCOMPLEMENTAR+' '+UPPER(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@OBS_FAT))

----#1#/#2#
--IF @VALOR_IMPOSTO_ITEM IS NOT NULL AND @VALOR_IMPOSTO_ITEM <> '0.0000' 
--	SELECT @INFCOMPLEMENTAR = @INFCOMPLEMENTAR+' VALOR TOTAL DE IMPOSTO NOS ITENS '+UPPER(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@VALOR_IMPOSTO_ITEM))

IF @INFCOMPLEMENTAR = '' OR LTRIM(RTRIM(@INFCOMPLEMENTAR))= '.' OR LTRIM(RTRIM(@INFCOMPLEMENTAR))= '..'
	SELECT @INFCOMPLEMENTAR = NULL
	
-- SE @OBS_INTERESSE_FISCO FOR EM BRANCO, RETORNA NULL
IF @OBS_INTERESSE_FISCO = '' 
	SELECT @OBS_INTERESSE_FISCO = NULL	
SELECT @OBS_INTERESSE_FISCO = DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@OBS_INTERESSE_FISCO) --#5'5#

SELECT @DIGITOVERIFICADOR = SUBSTRING(@CHAVEACESSO,44,1)

SELECT @CODIGONF = CASE WHEN @VERSAO_CHAVE_NFE = '1.10' THEN SUBSTRING(@CHAVEACESSO,35,9) ELSE substring(@CHAVEACESSO,36,8) END 

/*#163# - Inicio*/
SELECT @GERA_COM_RT = 0
IF EXISTS(SELECT VALOR_ATUAL FROM PARAMETROS WHERE PARAMETRO = 'UTILIZA_GERA_IMPOSTOS')
	SELECT @GERA_COM_RT = CASE WHEN ISNULL(VALOR_ATUAL, '.F.') = '.T.' THEN 1 ELSE 0 END FROM PARAMETROS WHERE PARAMETRO = 'UTILIZA_GERA_IMPOSTOS'
/*#163# - Fim*/


/*#181# - Inicio*/
SELECT @MOSTRA_vIBS = 0
IF EXISTS(SELECT VALOR_ATUAL FROM PARAMETROS WHERE PARAMETRO = 'UFS_NAO_VALIDAM_VIBS')
BEGIN

	SELECT @UFs_NAO_VALIDAm_VIBS = ISNULL(VALOR_ATUAL, '')  FROM PARAMETROS WHERE PARAMETRO = 'UFS_NAO_VALIDAM_VIBS'
	SELECT @UF_vIBS = LTRIM(RTRIM(UF_EMITENTE)) from #IMPRESSAO_NFE

	IF (CHARINDEX('|' + @UF_vIBS + '|', '|' + @UFs_NAO_VALIDAm_VIBS + '|') )=0
		SET @MOSTRA_vIBS = 1
	ELSE
		SET @MOSTRA_vIBS = 0

END
/*#181# - Fim*/


SELECT @NFE_XML = (

-- NFE ---
SELECT  'SUBSTITUIR' "@SUBSTITUI1",

--- INFNFE
(
	SELECT RTRIM(@VERSAO_CHAVE_NFE)  "@versao",
			'NFe'+RTRIM(@CHAVEACESSO) "@Id",

				
------- IDE 	
	
	(	
		SELECT	SUBSTRING(NFE.EMITENTE_COD_MUNICIPIO_IBGE,1,2)						"cUF",	-- CODIGO DO IBGE
				RTRIM(@CODIGONF)													"cNF",	
			   	--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.DESC_NATUREZA)		"natOp",
			   	NFE.DESC_NATUREZA													"natOp",
				--#61# Retirado NFE 4.00
				--NFE.TIPO_PGTO_NFE													"indPag", -- 0 - PAGTO A VISTA, 1 - PAGTO A PRAZO E 2 - OUTROS. --#68#
				--#61#

				@MODELO																"mod",	  -- REFERENTE AO MODELO 1 E 1A. PEGAR DA TABELA CTB_ESPECIE_SERIE
				CASE WHEN @SERIENOTA_OFICIAL = 'U' OR @SERIENOTA_OFICIAL = 'UN' THEN '0' ELSE Rtrim(@SERIENOTA_OFICIAL) END "serie",
				RTRIM(LTRIM(CONVERT(INTEGER,NFE.NF)))								"nNF",
				--convert(varchar(24),NFE.EMISSAO,127)+'-03:00'						"dhEmi",
				--convert(varchar(24),NFE.DATA_SAIDA,127)+'-03:00'					"dhSaiEnt",	-- 1-0. CAMPO NÃO OBRIGATÓRIO
				NFE.UTC_EMISSAO						"dhEmi",
				NFE.UTC_DATA_SAIDA					"dhSaiEnt",	-- 1-0. CAMPO NÃO OBRIGATÓRIO


				--NFE.HORA_SAIDA													"hSaiEnt",	-- #11# (2.0) removido para layout 3.10
				--CONVERT(VARCHAR(8),NFE.DATA_SAIDA,108)							"hSaiEnt",	-- (2.0)
				CASE WHEN RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'S' THEN 1 ELSE 0 END 	"tpNF",		-- CRIADO O CAMPO. 0-ENTRADA / 1-SAIDA
				RTRIM(NFE.ID_DESTINO_OPERACAO)										"idDest",	-- #7# LAYOUT 3.10 - NOTA TÉCNICA 2013.005 v1.02 - 03.3 - INCLUSÃO DO ID LOCAL DESTINO. (1 - INTERNO; 2 - INTERESTADUAL; 3 - EXTERIOR)
				RTRIM(NFE.EMITENTE_COD_MUNICIPIO_IBGE)								"cMunFG",	-- CODIGO DO IBGE
-- #163# - Início
				-- TESTE	
				
		--		CASE WHEN @GERA_COM_RT = 0 THEN NULL ELSE RTRIM(NFE.EMITENTE_COD_MUNICIPIO_IBGE) END								"cMunFGIBS", /*Código do Município de consumo, fato gerador do IBS / CBS*/
				--CASE WHEN RTRIM(NFE.INDICA_PRESENCA_COMPRADOR) IN (5) /*Operação presencial, fora do estabelecimento*/
				--	THEN
				--		RTRIM(NFE.EMITENTE_COD_MUNICIPIO_IBGE)
				--	ELSE 
				--		NULL
				--	END																"cMunFGIBS", /*Código do Município de consumo, fato gerador do IBS / CBS*/

-- #163# - Fim

	-- Edson -  removido	Bloco NFREF		
						
				 
				LTRIM(RTRIM(NFE.FORMATO_IMP_DANFE_NFE))																			"tpImp",		-- PARAMETRO DE ONDE SERA INFORMADO O TIPO DO FORMATO DA IMPRESSAO DO DANFE (RETRATO OU PAISAGEM)
				CASE WHEN ISNULL(NFE.TIPO_EMISSAO_NFE,'') = '' THEN 1 ELSE RTRIM(NFE.TIPO_EMISSAO_NFE) END						"tpEmis",		-- FORMA EMISSAO DANFE 1-NORMAL / 2-CONTINGENCIA 
				@DIGITOVERIFICADOR																								"cDV",			-- DIGITO VERIFICADOR DA CHAVE DE ACESSO
				CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 THEN '1' ELSE '2' END												"tpAmb",		-- 1-PRODUCAO / 2-HOMOLOGACAO   
				CASE WHEN ISNULL(NFE.FIN_EMISSAO_NFE,'') = '' THEN 1 ELSE RTRIM(NFE.FIN_EMISSAO_NFE) END						"finNFe",		-- 1-NFE NORMAL/ 2-NFE COMPLEMENTAR / 3-NFE AJUSTE   
---- #163# - Início
--				-- TESTE
--				CASE WHEN @GERA_COM_RT = 0  
--					THEN 
--						NULL 
--					ELSE 
--						CASE WHEN ISNULL(NFE.FIN_EMISSAO_NFE,'') = 1 
--							THEN 
--								NULL	
--							ELSE
--								CASE WHEN RTRIM(NFE.FIN_EMISSAO_NFE) = 6 
--									THEN 
--										RTRIM(NFE.TP_NF_DEBITO)
--									ELSE 
--										NULL 
--									END
--							END
--				END																												"tpNFDebito",	/* Tipo de Nota de Débito */		

--				CASE WHEN @GERA_COM_RT = 0  
--					THEN 
--						NULL 
--					ELSE 
--						CASE WHEN ISNULL(NFE.FIN_EMISSAO_NFE,'') = 1 
--							THEN 
--								NULL	
--							ELSE
--								CASE WHEN RTRIM(NFE.FIN_EMISSAO_NFE) = 5 
--									THEN 
--										RTRIM(NFE.TP_NF_CREDITO)
--									ELSE 
--										NULL 
--									END
--							END
--				END																												"tpNFCredito",	/* Tipo de Nota de Crédito */		

---- #163# - Fim				
				RTRIM(NFE.INDICA_OPERACAO_FINAL)																				"indFinal",		--#8#
				RTRIM(NFE.INDICA_PRESENCA_COMPRADOR)																			"indPres",		--#9#
				CASE WHEN RTRIM(NFE.INDICA_PRESENCA_COMPRADOR) IN (2,3,4,9) 
								AND NFE.INTERMERDIADOR_IDCADINTTRAN IS NOT NULL THEN 1 			
					 WHEN		RTRIM(NFE.INDICA_PRESENCA_COMPRADOR) IN (2,3,4,9) 
								AND NFE.INTERMERDIADOR_IDCADINTTRAN IS NULL THEN 0 
								
				ELSE NULL END																									"indIntermed",	--#120# --#121#
				0																												"procEmi",		-- PROCESSO DE EMISSAO DA NFE
--#53#
--			RTRIM(NFE.VERSAO_EMISSOR_NFE)																					"verProc",		-- VERSAO DO LINX / RETAGUARDA OU LOJA 
				SUBSTRING(CASE WHEN @TIPO_DOC_CHAVE = 'L'
						 THEN CASE 
								WHEN LEN(ISNULL(@APP_VERSAO,'')) > 0 
								THEN @APP_VERSAO ELSE 'LINX' 
							  END 
							  ELSE ISNULL(@APP_VERSAO, RTRIM(@VERPROC)) -- CASO TIPO @TIPO_DOC_CHAVE <> 'L', PORÉM @APP_VERSAO <> VAZIO
				END,1,20)																									"verProc", -- TRUNCAR NO MAXIMO 20 CARACTERES 
																						                
--#53#

				CASE WHEN NFE.TIPO_EMISSAO_NFE = 1 THEN NULL ELSE CONVERT(VARCHAR(25),NFE.DATA_CONTINGENCIA_UTC,126) END		"dhCont",		--(2.0) contingencia somente para tipo emissao <> 1 #23#
				--#152#CASE WHEN NFE.TIPO_EMISSAO_NFE = 1 THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.JUSTIFICATIVA_CONTINGENCIA) END	"xJust",				-- (2.0)
				CASE WHEN NFE.TIPO_EMISSAO_NFE = 1 THEN NULL ELSE NFE.JUSTIFICATIVA_CONTINGENCIA END							"xJust",				-- (2.0)

	---------------------------------------------------------------------------------	
	--Edson Inicio	#40# [Inicio]							
-- NFREF 
		( 
			  SELECT 
					W_NOTAS_REFERENCIADAS.CHAVE_NFE									"refNFe",
							
					-- REFNF -- NOTA FISCAL ORIGINAL DA DEVOLUCAO  == TRATAMENTO ==
					( SELECT 
						SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,1,2)					"cUF",	-- BUSCAR O CODIGO DO IBGE
						SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,3,4)					"AAMM",
						SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,7,14)					"CNPJ",
						SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,21,2)					"mod",	-- DE ONTE PEGAR O CODIGO DO MODELO FISCAL
						CAST(SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,23,3) AS INTEGER)	"serie",
						CAST(SUBSTRING(W_NOTAS_REFERENCIADAS.CHAVEACESSO,26,9) AS INTEGER)  "nNF"
					WHERE W_NOTAS_REFERENCIADAS.CHAVE_NFE IS NULL	
					  FOR XML PATH(''), TYPE 
					) AS refNF
						
					FROM W_NOTAS_REFERENCIADAS 
						--LEFT JOIN LOJA_RESERVA B ON W_NOTAS_REFERENCIADAS.NF = B.NUMERO_NF_RETORNO --#41#														-- #28#
						--AND W_NOTAS_REFERENCIADAS.SERIE = B.SERIE_NF_RETORNO --#41#																		-- #28#
					WHERE 	--W_NOTAS_REFERENCIADAS.CHAVE_NFE IS not null		and  -#36#
						W_NOTAS_REFERENCIADAS.NF = @NOTAFISCAL
							AND W_NOTAS_REFERENCIADAS.SERIE = @SERIENOTA
							--AND W_NOTAS_REFERENCIADAS.FILIAL = @FILIALNOTA
							AND W_NOTAS_REFERENCIADAS.FILIAL = CASE WHEN @TIPO_DOC = 'E' and (@TIPO_DOC_CHAVE != 'L' Or @NF_NUMERO_REFERENCIADA = 1)   --#49#
							THEN @NOME_CLIFOR ELSE @FILIALNOTA END -- #41#							
							--AND W_NOTAS_REFERENCIADAS.FILIAL = CASE WHEN @TIPO_DOC = 'E' THEN ISNULL(B.FILIAL,@NOME_CLIFOR) ELSE @FILIALNOTA END	--#28# - #32#
							--#32#--AND W_NOTAS_REFERENCIADAS.FILIAL = CASE WHEN @TIPO_DOC = 'E' THEN ISNULL(@FILIALNOTA,@NOME_CLIFOR) ELSE @FILIALNOTA END	-- #32#
							AND W_NOTAS_REFERENCIADAS.ORIGEM_ENTRADA_SAIDA = @TIPO_DOC
							--AND W_NOTAS_REFERENCIADAS.FILIAL = @FILIALNOTA --#27#
			  FOR XML PATH('NFref'),TYPE 
			),
					
			-- EDSON -- NF ORIGEM VINCULADA A NF TROCA e CANCELAMENTO	#27#
			( 
				  SELECT 
							W_NOTAS_REFERENCIADAS_DEV.CHAVE_NFE									"refNFe",							
					( SELECT 
						SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,1,2)					"cUF",	-- BUSCAR O CODIGO DO IBGE
						SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,3,4)					"AAMM",
						SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,7,14)					"CNPJ",
						SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,21,2)					"mod",	-- DE ONTE PEGAR O CODIGO DO MODELO FISCAL
						CAST(SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,23,3) AS INTEGER)	"serie",
						CAST(SUBSTRING(W_NOTAS_REFERENCIADAS_DEV.CHAVEACESSO,26,9) AS INTEGER)  "nNF"
					WHERE W_NOTAS_REFERENCIADAS_DEV.CHAVE_NFE IS NULL	
					  FOR XML PATH(''), TYPE 
					) AS refNF
					
					FROM W_NOTAS_REFERENCIADAS_DEV 
					WHERE W_NOTAS_REFERENCIADAS_DEV.NF = @NOTAFISCAL
						AND W_NOTAS_REFERENCIADAS_DEV.SERIE = @SERIENOTA
						AND W_NOTAS_REFERENCIADAS_DEV.FILIAL  = @NOME_CLIFOR --edson aplicar
						
			  FOR XML PATH('NFref'),TYPE --#27#
			),
		-- NFREF ECF				
		( 
			SELECT 
				(
					SELECT 
						 MODELO_FISCAL			"mod", 
						 NUMERO_ECF				"nECF", 
						 NUMERO_COO				"nCOO"
					
					  FOR XML PATH('refECF'), TYPE 
				) 
				FROM W_REFERENCIA_ECF_NFE   
					WHERE W_REFERENCIA_ECF_NFE.NF = @NOTAFISCAL
							AND W_REFERENCIA_ECF_NFE.SERIE = @SERIENOTA
							-- #29# AND W_REFERENCIA_ECF_NFE.FILIAL = CASE WHEN @TIPO_DOC = 'E' THEN  @NOME_CLIFOR ELSE @FILIALNOTA END
							AND @TIPO_DOC = 'S'	-- #29# (As notas de entrada são tratadas com a view W_REFERENCIA_ECF_NFE_DEV)
							AND W_REFERENCIA_ECF_NFE.ORIGEM_ENTRADA_SAIDA = @TIPO_DOC		
							AND W_REFERENCIA_ECF_NFE.FILIAL = @FILIALNOTA --#18#
				FOR XML PATH('NFref'),TYPE 
			),
			--EDSON #14#
			-- VERIFICA OS ECF CASO NF DE ORIGEM NÃO EXISTA
			(	
				SELECT 
					(
						SELECT 
							MODELO_FISCAL					"mod", 
							NUMERO_ECF_ORIGEM				"nECF", 
							NUMERO_COO_ORIGEM				"nCOO"
							
						FOR XML PATH('refECF'), TYPE 
					) 
					FROM W_REFERENCIA_ECF_NFE_DEV	   
						WHERE W_REFERENCIA_ECF_NFE_DEV.NF = @NOTAFISCAL
						AND W_REFERENCIA_ECF_NFE_DEV.SERIE = @SERIENOTA
						AND W_REFERENCIA_ECF_NFE_DEV.FILIAL = @CODIGO_FILIAL /* #47# #115# Alteração de @filialnota para @codigo_Filial */
					  --AND W_REFERENCIA_ECF_NFE_DEV.ORIGEM_ENTRADA_SAIDA = @TIPO_DOC	
						AND W_REFERENCIA_ECF_NFE_DEV.CHAVE_NFE_ORIGEM IS NULL
			FOR XML PATH('NFref'),TYPE 
			),
		--EDSON #14#			
-- Edson Fim #40# [Fim]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- #163# - Início

-- #173#* - Início
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE
		-- Grupo de Compra Governamental
		-- gCompraGov				
		(	
			SELECT	NFE.TP_ENTE_GOVERNO	 																							"tpEnteGov",	/* Tipo de ente governamental */
					isnull(NFE.REDUTOR_COMPRA_GOVERNO,0)  																			"pRedutor",		/* Percentual de redução de alíquota em compra governamental */
					NFE.TP_OPER_GOVERNO	  																							"tpOperGov"		/* Tipo de operação com o ente governamental  */
		
			where isnull(NFE.TP_ENTE_GOVERNO,0)<>0
			FOR XML PATH('gCompraGov'),TYPE 
		) 
	END,
-- #173#* - Fim

CASE WHEN @GERA_COM_RT = 0 or 1=1 /* #164# */
	THEN 
		NULL
	ELSE
		-- Grupo de notas de antecipação de pagamento
		-- gPagAntecipado				
		(	
			SELECT	space(44)	 																					"refNFe"		/* Chave de acesso da NF-e de antecipação de pagamento  */
		
			
			FOR XML PATH('gPagAntecipado'),TYPE 
		) 
	END
-- #163# - Fim
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		FOR XML PATH(''), TYPE 
		
	) AS ide,
	
------- EMIT
	(
		SELECT CASE WHEN NFE.PJ_PF_EMITENTE = 1 THEN RTRIM(NFE.CNPJ_EMITENTE) ELSE NULL END							"CNPJ",
				CASE WHEN NFE.PJ_PF_EMITENTE = 0 THEN RTRIM(NFE.CNPJ_EMITENTE) ELSE NULL END						"CPF",		
				--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,SUBSTRING(NFE.RAZAO_SOCIAL_EMITENTE,1,60))				"xNome",
				SUBSTRING(NFE.RAZAO_SOCIAL_EMITENTE,1,60)															"xNome",
				CASE WHEN NFE.PJ_PF_EMITENTE = 1 THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NOME_FANTASIA_EMITENTE) ELSE NULL END "xFant",
		---------------------------------------------------------------------------------				
		-- ENDEREMIT
		( 	
			--#152#SELECT SUBSTRING(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENDERECO_EMITENTE),1,60)				"xLgr",
			SELECT SUBSTRING(NFE.ENDERECO_EMITENTE,1,60)															"xLgr",
					CASE WHEN ISNULL(NFE.NUMERO_EMITENTE,'') = '' 
						THEN '0' 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERO_EMITENTE) END					"nro",
						ELSE NFE.NUMERO_EMITENTE END																"nro",
					CASE WHEN ISNULL(NFE.COMPLEMENTO_EMITENTE,'') = '' 
						THEN NULL 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.COMPLEMENTO_EMITENTE) END				"xCpl",
						ELSE NFE.COMPLEMENTO_EMITENTE END															"xCpl",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.BAIRRO_EMITENTE)								"xBairro",
					NFE.BAIRRO_EMITENTE																				"xBairro",
					RTRIM(NFE.EMITENTE_COD_MUNICIPIO_IBGE)															"cMun",	-- BUSCAR O CODIGO DO MUNICIPIO DO IBGE
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.CIDADE_EMITENTE)								"xMun",
					NFE.CIDADE_EMITENTE																				"xMun",
					RTRIM(NFE.UF_EMITENTE) "UF",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,RTRIM(NFE.CEP_EMITENTE))									"CEP",
					RTRIM(NFE.CEP_EMITENTE)																			"CEP",
					(SELECT TOP 1 RIGHT(RTRIM(COD_PAIS_BC),4) FROM LCF_LX_PAIS WHERE DESC_PAIS = NFE.PAIS_EMITENTE) "cPais", -- CODIGO DO PAIS DO IBGE
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.PAIS_EMITENTE)									"xPais",
					NFE.PAIS_EMITENTE																				"xPais",
					CASE WHEN NFE.DDD1_EMITENTE IS NOT NULL AND NFE.TELEFONE1_EMITENTE IS NOT NULL and (DDD1_EMITENTE + TELEFONE1_EMITENTE) <> ''  
						--#152#THEN RIGHT(RTRIM(NFE.DDD1_EMITENTE),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TELEFONE1_EMITENTE)),9) --#46#
						THEN RIGHT(RTRIM(NFE.DDD1_EMITENTE),2) + RIGHT(RTRIM(NFE.TELEFONE1_EMITENTE),9) --#46#
						ELSE NULL END  "fone"
						
				FOR XML PATH(''), TYPE 
		) AS enderEmit,		
		---------------------------------------------------------------------------------	
			--#152#CASE WHEN ISNULL(NFE.IE_EMITENTE,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IE_EMITENTE) END		"IE",
			CASE WHEN ISNULL(NFE.IE_EMITENTE,'') = '' THEN NULL ELSE NFE.IE_EMITENTE END		"IE",
			--#152#CASE WHEN (NFE.ICMS_ST > 0 OR NFE.ICMS_STR > 0 OR NFE.DICMS>0) AND NFE.UF = NFE.ENTREGA_UF THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IEST) ELSE NULL END "IEST",	-- CRIADO "IEST PARA SUBSTITUIÇÃO TRIBUTÁRIA" #143#
			CASE WHEN (NFE.ICMS_ST > 0 OR NFE.ICMS_STR > 0 OR NFE.DICMS>0) AND NFE.UF = NFE.ENTREGA_UF THEN LTRIM(RTRIM(NFE.IEST)) ELSE NULL END "IEST",	-- CRIADO "IEST PARA SUBSTITUIÇÃO TRIBUTÁRIA" #143# #159#
		  --CASE WHEN ISNULL(NFE.IEST,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IEST) END  AS					"IEST",	-- CRIADO "IEST PARA SUBSTITUIÇÃO TRIBUTÁRIA" #45#
			--#152#CASE WHEN (NFE.ISS_R > 0 OR NFE.ISS > 0) THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.CNAE) ELSE NULL END				"CNAE",	--0.1 = CRIADO O CAMPO
			--#152#CASE WHEN (NFE.ISS_R > 0 OR NFE.ISS > 0) THEN DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.IM_EMITENTE) ELSE NULL END 		"IM",   --0.1 = CRIADO O CAMPO
			CASE WHEN (NFE.ISS_R > 0 OR NFE.ISS > 0) THEN NFE.IM_EMITENTE ELSE NULL END 		"IM",   --0.1 = CRIADO O CAMPO
			CASE WHEN (NFE.ISS_R > 0 OR NFE.ISS > 0) THEN NFE.CNAE ELSE NULL END				"CNAE",	--0.1 = CRIADO O CAMPO
			NFE.CRT	  "CRT"	--(2.0)

		FOR XML PATH(''), TYPE 

	) AS emit,

------- AVULSA  (VERIFICAR COM O JOAO CESTARI SE HÁ NECESSIDADE DESTE GRUPO DE INFORMAÇÕES PARA A LINX. R: NAO SERA UTILIZADA.)

------- DEST
	(
		SELECT  CASE WHEN NFE.PJ_PF = 1 AND NFE.UF <> 'EX' THEN RTRIM(NFE.CNPJ_DESTINATARIO) ELSE NULL END								"CNPJ",
				--CASE WHEN NFE.PJ_PF = 1 AND NFE.UF  = 'EX' THEN '' ELSE NULL END														"CNPJ", --#14#
				CASE WHEN NFE.PJ_PF = 0 AND NFE.UF <> 'EX' THEN RTRIM(NFE.CNPJ_DESTINATARIO) ELSE NULL END								"CPF",	
				--CASE WHEN NFE.PJ_PF = 0 AND NFE.UF  = 'EX' THEN '' ELSE NULL END														"CNPJ",	--#14#	
				RTRIM(NFE.DOC_ESTRANGEIRO)																								"idEstrangeiro", --#10#	
				DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,SUBSTRING(NFE.RAZAO_SOCIAL,1,60))											"xNome",
		---------------------------------------------------------------------------------		
		-- ENDERDEST

		( 	
			--#152#SELECT SUBSTRING(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENDERECO),1,60)											"xLgr",
			SELECT SUBSTRING(NFE.ENDERECO,1,60)																							"xLgr",
					CASE WHEN ISNULL(NFE.NUMERO,'') = '' 
						THEN '0' 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERO) END												"nro",
						ELSE NFE.NUMERO END																								"nro",
					CASE WHEN ISNULL(NFE.COMPLEMENTO,'') = '' 
						THEN NULL 
						ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.COMPLEMENTO) END											"xCpl",
					--#152#CASE WHEN ISNULL(NFE.BAIRRO,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.BAIRRO) END	"xBairro",
					CASE WHEN ISNULL(NFE.BAIRRO,'') = '' THEN NULL ELSE NFE.BAIRRO END													"xBairro",
					CASE WHEN NFE.UF = 'EX' THEN '9999999' ELSE RTRIM(NFE.COD_MUNICIPIO_IBGE) END										"cMun",  -- CODIGO DO MUNICIPIO DO IBGE
					CASE WHEN NFE.UF = 'EX' THEN 'EXTERIOR' ELSE 
						--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.CIDADE) END													"xMun",
						NFE.CIDADE END																									"xMun",
					CASE WHEN ISNULL(NFE.UF,'') = '' THEN NULL ELSE RTRIM(NFE.UF) END													"UF",
					--#152#CASE WHEN ISNULL(NFE.CEP,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,RTRIM(NFE.CEP)) END			"CEP",
					CASE WHEN ISNULL(NFE.CEP,'') = '' THEN NULL ELSE RTRIM(NFE.CEP) END													"CEP",
					(SELECT TOP 1 RIGHT(RTRIM(COD_PAIS_BC),4) FROM LCF_LX_PAIS WHERE DESC_PAIS = NFE.PAIS)								"cPais", -- CODIGO DO PAIS DO IBGE
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.PAIS)																"xPais",
					NFE.PAIS																											"xPais",
					CASE WHEN NFE.DDD1 IS NOT NULL AND NFE.TELEFONE1 IS NOT NULL AND (DDD1 + TELEFONE1) <> '' AND NFE.UF <> 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.DDD1),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TELEFONE1)),9) --#46#
						THEN RIGHT(RTRIM(NFE.DDD1),2) + RIGHT(RTRIM(NFE.TELEFONE1),9) --#46#
						ELSE NULL END																									"fone",						
					CASE WHEN NFE.DDI IS NOT NULL AND NFE.DDD1 IS NOT NULL AND NFE.TELEFONE1 IS NOT NULL AND (DDI + DDD1 + TELEFONE1) <> '' AND NFE.UF = 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.DDD1),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TELEFONE1)),9) --#46#
						THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.DDD1),2) + RIGHT(RTRIM(NFE.TELEFONE1),9) --#46#
						ELSE NULL END																									"fone"
					
			FOR XML PATH(''), TYPE 

		) AS enderDest,		
		---------------------------------------------------------------------------------	
		NFE.INDICADOR_IE_DESTINARARIO																			"indIEDest", -- #12#
		--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RG_IE)    "IE",
		NFE.RG_IE																							    "IE",
		--CASE WHEN (NFE.PJ_PF = 0) THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RG_IE) END			"IE",
		-- RETIRADO EM 11/11/2011 REGRA INSCR. SUFRAMA INFORMADA: AC-ACRE, OU AM-AMAZONAS, OU RO-RONDÔNIA, OU RR-RORAIMA, OU AP-AMAPÁ (SÓ PARA MUNICÍPIOS 1600303-MACAPÁ E 1600600-SANTANA)
		--CASE WHEN (NFE.PJ_PF = 0 AND ISNULL(NFE.INSCRICAO_SUFRAMA,'') = '') OR (NFE.UF NOT IN ('AC','AM','RO','RR')) 
		--			OR (NFE.COD_MUNICIPIO_IBGE NOT IN ('1600303','1600600'))	
		--	THEN NULL ELSE RTRIM(NFE.INSCRICAO_SUFRAMA) END														"ISUF",	-- Regra 2.00
		RTRIM(NFE.INSCRICAO_SUFRAMA)																			"ISUF",	-- Regra 2.00
		LTRIM(RTRIM(NFE.EMAIL_NFE))																				"email"	--(2.0) --#5#

		FOR XML PATH(''), TYPE 
	) AS dest,

	
	-- LOCAL DE RETIRADA (SAÍDAS) -- #140# -- #141#
		( 	
			SELECT CASE WHEN NFE.RETIRADA_PJ_PF = 1 AND NFE.RETIRADA_ENTREGA_UF  <> 'EX' THEN RTRIM(NFE.RETIRADA_ENTREGA_CGC) ELSE NULL END					"CNPJ",
					CASE WHEN NFE.RETIRADA_PJ_PF = 1 AND NFE.RETIRADA_ENTREGA_UF  = 'EX' THEN '' ELSE NULL END												"CNPJ",
					CASE WHEN NFE.RETIRADA_PJ_PF = 0 AND NFE.RETIRADA_ENTREGA_UF <> 'EX' THEN RTRIM(NFE.RETIRADA_ENTREGA_CGC) ELSE NULL END					"CPF",	 -- (2.0)
					CASE WHEN NFE.RETIRADA_PJ_PF = 0 AND NFE.RETIRADA_ENTREGA_UF  = 'EX' THEN '' ELSE NULL END												"CNPJ",			
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,SUBSTRING(NFE.RETIRADA_ENTREGA_RAZAO_SOCIAL,1,60))											"xNome",
					--#152#SUBSTRING(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_ENDERECO),1,60)												"xLgr",
					SUBSTRING(NFE.RETIRADA_ENTREGA_RAZAO_SOCIAL,1,60)																						"xNome",
					SUBSTRING(NFE.RETIRADA_ENTREGA_ENDERECO,1,60)																							"xLgr",
					CASE WHEN NFE.RETIRADA_ENTREGA_NUMERO = '' OR NFE.RETIRADA_ENTREGA_NUMERO IS NULL 
						THEN '0' 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_NUMERO) END													"nro",
						ELSE NFE.RETIRADA_ENTREGA_NUMERO END																								"nro",
					CASE WHEN NFE.RETIRADA_ENTREGA_COMPLEMENTO = '' OR NFE.RETIRADA_ENTREGA_COMPLEMENTO IS NULL 
						THEN NULL 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_COMPLEMENTO) END												"xCpl",
						ELSE NFE.RETIRADA_ENTREGA_COMPLEMENTO END																							"xCpl",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_BAIRRO)																"xBairro",
					NFE.RETIRADA_ENTREGA_BAIRRO																												"xBairro",
					CASE WHEN NFE.RETIRADA_ENTREGA_UF = 'EX' THEN '9999999' ELSE 
						RTRIM(NFE.RETIRADA_COD_MUNICIPIO_IBGE_ENTREGA) END																					"cMun",	-- BUSCAR O CODIGO DO MUNICIPIO DO IBGE
					CASE WHEN NFE.RETIRADA_ENTREGA_UF = 'EX' THEN 'EXTERIOR' ELSE 
						--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_CIDADE) END														"xMun",
						NFE.RETIRADA_ENTREGA_CIDADE END																										"xMun",
					RTRIM(NFE.RETIRADA_ENTREGA_UF)																											"UF",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,RTRIM(NFE.RETIRADA_ENTREGA_CEP))																	"CEP",
					RTRIM(NFE.RETIRADA_ENTREGA_CEP)																											"CEP",
					(SELECT TOP 1 RIGHT(RTRIM(COD_PAIS_BC),4) FROM LCF_LX_PAIS WHERE DESC_PAIS = NFE.RETIRADA_ENTREGA_PAIS)									"cPais", -- CODIGO DO PAIS DO IBGE
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_PAIS)																	"xPais",
					NFE.RETIRADA_ENTREGA_PAIS																												"xPais",

					CASE WHEN NFE.RETIRADA_ENTREGA_DDD IS NOT NULL AND NFE.RETIRADA_ENTREGA_TELEFONE IS NOT NULL AND (RETIRADA_ENTREGA_DDD + RETIRADA_ENTREGA_TELEFONE) <> '' AND NFE.UF <> 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_TELEFONE)),9) --#46#
						THEN RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_TELEFONE),9) --#46#
						ELSE NULL END																														"fone",						
					CASE WHEN NFE.DDI IS NOT NULL AND NFE.RETIRADA_ENTREGA_DDD IS NOT NULL AND NFE.RETIRADA_ENTREGA_TELEFONE IS NOT NULL AND (DDI + RETIRADA_ENTREGA_DDD + RETIRADA_ENTREGA_TELEFONE) <> '' AND NFE.UF = 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_TELEFONE)),9) --#46#
						THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_TELEFONE),9) --#46#
						ELSE NULL END																														"fone",
					LTRIM(RTRIM(NFE.RETIRADA_EMAIL_NFE))																									"email",
					--#152#CASE WHEN ISNULL(NFE.RETIRADA_ENTREGA_IE,'') = '' OR NFE.RETIRADA_PJ_PF = 0 THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_IE) END AS "IE"
					CASE WHEN ISNULL(NFE.RETIRADA_ENTREGA_IE,'') = '' OR NFE.RETIRADA_PJ_PF = 0 THEN NULL ELSE NFE.RETIRADA_ENTREGA_IE END AS "IE"
			WHERE RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'S' 
			  AND NFE.NOME_LOCAL_RETIRADA IS NOT NULL AND NFE.NOME_LOCAL_RETIRADA<>NFE.NOME_CLIFOR AND NFE.INDICA_PRESENCA_COMPRADOR IN (2,3)
			FOR XML PATH(''), TYPE 
		) AS retirada,
	-- LOCAL DE RETIRADA (SAÍDAS) -- #140# -- #141#


	-- LOCAL DE ENTREGA (ENTRADAS) -- #140# -- #141#
		( 	
			SELECT CASE WHEN NFE.RETIRADA_PJ_PF = 1 AND NFE.RETIRADA_ENTREGA_UF  <> 'EX' THEN RTRIM(NFE.RETIRADA_ENTREGA_CGC) ELSE NULL END					"CNPJ",
					CASE WHEN NFE.RETIRADA_PJ_PF = 1 AND NFE.RETIRADA_ENTREGA_UF  = 'EX' THEN '' ELSE NULL END												"CNPJ",
					CASE WHEN NFE.RETIRADA_PJ_PF = 0 AND NFE.RETIRADA_ENTREGA_UF <> 'EX' THEN RTRIM(NFE.RETIRADA_ENTREGA_CGC) ELSE NULL END					"CPF",	 -- (2.0)
					CASE WHEN NFE.RETIRADA_PJ_PF = 0 AND NFE.RETIRADA_ENTREGA_UF  = 'EX' THEN '' ELSE NULL END												"CNPJ",			
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,SUBSTRING(NFE.RETIRADA_ENTREGA_RAZAO_SOCIAL,1,60))											"xNome",
					--#152#SUBSTRING(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_ENDERECO),1,60)												"xLgr",
					SUBSTRING(NFE.RETIRADA_ENTREGA_RAZAO_SOCIAL,1,60)																						"xNome",
					SUBSTRING(NFE.RETIRADA_ENTREGA_ENDERECO,1,60)																							"xLgr",
					CASE WHEN NFE.RETIRADA_ENTREGA_NUMERO = '' OR NFE.RETIRADA_ENTREGA_NUMERO IS NULL 
						THEN '0' 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_NUMERO) END													"nro",
						ELSE NFE.RETIRADA_ENTREGA_NUMERO END																								"nro",
					CASE WHEN NFE.RETIRADA_ENTREGA_COMPLEMENTO = '' OR NFE.RETIRADA_ENTREGA_COMPLEMENTO IS NULL 
						THEN NULL 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_COMPLEMENTO) END												"xCpl",
						ELSE NFE.RETIRADA_ENTREGA_COMPLEMENTO END																							"xCpl",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_BAIRRO)																"xBairro",
					NFE.RETIRADA_ENTREGA_BAIRRO																												"xBairro",
					CASE WHEN NFE.RETIRADA_ENTREGA_UF = 'EX' THEN '9999999' ELSE 
						RTRIM(NFE.RETIRADA_COD_MUNICIPIO_IBGE_ENTREGA) END																					"cMun",	-- BUSCAR O CODIGO DO MUNICIPIO DO IBGE
					CASE WHEN NFE.RETIRADA_ENTREGA_UF = 'EX' THEN 'EXTERIOR' ELSE 
						--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_CIDADE) END														"xMun",
						NFE.RETIRADA_ENTREGA_CIDADE END																										"xMun",
					RTRIM(NFE.RETIRADA_ENTREGA_UF)																											"UF",
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,RTRIM(NFE.RETIRADA_ENTREGA_CEP))																	"CEP",
					RTRIM(NFE.RETIRADA_ENTREGA_CEP)																											"CEP",
					(SELECT TOP 1 RIGHT(RTRIM(COD_PAIS_BC),4) FROM LCF_LX_PAIS WHERE DESC_PAIS = NFE.RETIRADA_ENTREGA_PAIS)									"cPais", -- CODIGO DO PAIS DO IBGE
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.RETIRADA_ENTREGA_PAIS)																	"xPais",
					NFE.RETIRADA_ENTREGA_PAIS																												"xPais",

					CASE WHEN NFE.RETIRADA_ENTREGA_DDD IS NOT NULL AND NFE.RETIRADA_ENTREGA_TELEFONE IS NOT NULL AND (RETIRADA_ENTREGA_DDD + RETIRADA_ENTREGA_TELEFONE) <> '' AND NFE.UF <> 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_TELEFONE)),9) --#46#
						THEN RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_TELEFONE),9) --#46#
						ELSE NULL END																														"fone",						
					CASE WHEN NFE.DDI IS NOT NULL AND NFE.RETIRADA_ENTREGA_DDD IS NOT NULL AND NFE.RETIRADA_ENTREGA_TELEFONE IS NOT NULL AND (DDI + RETIRADA_ENTREGA_DDD + RETIRADA_ENTREGA_TELEFONE) <> '' AND NFE.UF = 'EX'
						--#152#THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_TELEFONE)),9) --#46#
						THEN RIGHT(RTRIM(NFE.DDI),5) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_DDD),2) + RIGHT(RTRIM(NFE.RETIRADA_ENTREGA_TELEFONE),9) --#46#
						ELSE NULL END																														"fone",
					LTRIM(RTRIM(NFE.RETIRADA_EMAIL_NFE))																									"email",
					--#152#CASE WHEN ISNULL(NFE.RETIRADA_ENTREGA_IE,'') = '' OR NFE.RETIRADA_PJ_PF = 0 THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.RETIRADA_ENTREGA_IE) END AS "IE"
					CASE WHEN ISNULL(NFE.RETIRADA_ENTREGA_IE,'') = '' OR NFE.RETIRADA_PJ_PF = 0 THEN NULL ELSE NFE.RETIRADA_ENTREGA_IE END AS "IE"
			WHERE RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'E' 
			  AND NFE.NOME_LOCAL_RETIRADA IS NOT NULL AND NFE.NOME_LOCAL_RETIRADA<>NFE.NOME_CLIFOR AND NFE.INDICA_PRESENCA_COMPRADOR IN (2,3)
			FOR XML PATH(''), TYPE 
		) AS entrega,
	-- LOCAL DE RETIRADA (ENTRADAS) -- #140# -- #141#


------- RETIRADA (NAO INCLUI ESTE GRUPO)

------- ENTREGA
		( 	
			SELECT CASE WHEN NFE.PJ_PF = 1 AND NFE.UF <> 'EX' THEN RTRIM(NFE.ENTREGA_CGC) ELSE NULL END				"CNPJ",
					CASE WHEN NFE.PJ_PF = 1 AND NFE.UF = 'EX' THEN '' ELSE NULL END									"CNPJ",
					CASE WHEN NFE.PJ_PF = 0 AND NFE.UF <> 'EX' THEN RTRIM(NFE.ENTREGA_CGC) ELSE NULL END			"CPF",	 -- (2.0)
					CASE WHEN NFE.PJ_PF = 0 AND NFE.UF = 'EX' THEN '' ELSE NULL END									"CNPJ",			
					--#152#SUBSTRING(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_ENDERECO),1,60)				"xLgr",
					SUBSTRING(NFE.ENTREGA_ENDERECO,1,60)															"xLgr",
					CASE WHEN NFE.ENTREGA_NUMERO = '' OR NFE.ENTREGA_NUMERO IS NULL 
						THEN '0' 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_NUMERO) END					"nro",
						ELSE NFE.ENTREGA_NUMERO END																	"nro",
					CASE WHEN NFE.ENTREGA_COMPLEMENTO = '' OR NFE.ENTREGA_COMPLEMENTO IS NULL 
						THEN NULL 
						--#152#ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_COMPLEMENTO) END				"xCpl",
						ELSE NFE.ENTREGA_COMPLEMENTO END															"xCpl",
					DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_BAIRRO)								"xBairro",
					CASE WHEN NFE.UF = 'EX' THEN '9999999' ELSE 
						RTRIM(NFE.COD_MUNICIPIO_IBGE_ENTREGA) END													"cMun",	-- BUSCAR O CODIGO DO MUNICIPIO DO IBGE
					CASE WHEN NFE.UF = 'EX' THEN 'EXTERIOR' ELSE 
						DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.ENTREGA_CIDADE) END						"xMun",
					RTRIM(NFE.ENTREGA_UF) "UF"

			WHERE NFE.ENDERECO <> NFE.ENTREGA_ENDERECO OR NFE.NUMERO <> NFE.ENTREGA_NUMERO
			FOR XML PATH(''), TYPE 
		) AS entrega,
		
		
------- AUTXML	(Pessoas autorizadas a acessar o XML da NF-e)	 --#3.10#
------- XML permite até 10 ocorrencias da tag autXML
		( 
				SELECT TOP 10 CASE WHEN FAX.PJ_PF = 1 THEN RTRIM(CGC_CPF) ELSE NULL END "CNPJ", --#33#
					CASE WHEN FAX.PJ_PF = 0 THEN RTRIM(CGC_CPF) ELSE NULL END "CPF" --#33#
				FROM FILIAIS_ACESSO_XML as FAX			 
				WHERE FAX.CLIFOR = @CLIFOR_FILIALNOTA AND FAX.INATIVO = 0

			FOR XML PATH('autXML'), TYPE),  --#3.10#

			
------- DET (Detalhamento de Produtos e Serviços)
		(	

			SELECT	
			
			CASE WHEN NFE_ITENS.ITEM_NFE IS NULL 
						THEN RTRIM(LTRIM(STR(CONVERT(INT,NFE_ITENS.ITEM_IMPRESSAO))))
						ELSE RTRIM(LTRIM(STR(NFE_ITENS.ITEM_NFE))) END "@nItem",
			
------- PROD		
			(

				SELECT	NFE_ITENS.CODIGO_ITEM												"cProd", --#112# --#152#
						NFE_ITENS.EAN														"cEAN",	-- ???(2.0) CRIAR FUNCAO
						NFE_ITENS.DESCRICAO_ITEM											"xProd", --#152#

					CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
							THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) ELSE --#20#
						CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
								--OR (NFE_ITENS.CST_IPI IS NOT NULL AND NFE_ITENS.CST_IPI NOT IN('03','53') ) OR (NFE.CRT = 3) --#17#
								--OR (NFE_ITENS.CST_IPI IS NOT NULL AND NFE_ITENS.CST_IPI NOT IN('53') ) OR (NFE.CRT = 3) --#17# --#18#
								OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
							THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
						CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
							THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END END 				"NCM",			-- (2.0)
							--NFE_ITENS.CODIGO_CEST "CEST"

		( 
				SELECT TOP 8  RTRIM(LTRIM(NFE_ITENS_NVE.NVE))  "NVE"
				FROM W_IMPRESSAO_NFe_ITENS_NVE  as NFE_ITENS_NVE			 
				WHERE NFE_ITENS_NVE.NF_ENTRADA = NFE_ITENS.NF 
					  AND NFE_ITENS_NVE.SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF
					  AND NFE_ITENS_NVE.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
					  AND NFE_ITENS_NVE.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
					  AND NFE_ITENS_NVE.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
				FOR XML PATH(''), TYPE ),

				REPLACE(NFE_ITENS.CODIGO_CEST,'.','')																				"CEST",	  --#42#	
				/*#133#
				CASE WHEN RTRIM(NFE_ITENS.TRIBUT_ICMS) = '90' 
						AND RTRIM(LTRIM(NFE.UF_EMITENTE)) = 'PR' 
						AND RTRIM(LTRIM(NFE_ITENS.SUB_ITEM_SPED)) IS NULL
						THEN 'SEM CBENEF' 
				ELSE CASE WHEN RTRIM(LTRIM(NFE_ITENS.SUB_ITEM_SPED)) = '' THEN NULL 
				ELSE RTRIM(LTRIM(NFE_ITENS.SUB_ITEM_SPED)) END END																	"cBenef", --#86#-#106#-#113#- 
				*/
				/*#133#*/
				CASE WHEN RTRIM(NFE_ITENS.TRIBUT_ICMS) = '90' AND RTRIM(LTRIM(NFE.UF_EMITENTE)) IN ('GO', 'PR', 'RS', 'RJ', 'DF', 'SC') --#139#	
					 THEN CASE WHEN RTRIM(LTRIM(NFE.UF_EMITENTE)) IN ('GO', 'PR', 'RS') --#139#	--#175#	
									AND RTRIM(LTRIM(ISNULL(NFE_ITENS.SUB_ITEM_SPED,''))) = ''
							   THEN 'SEM CBENEF' 
							   ELSE CASE WHEN RTRIM(LTRIM(ISNULL(NFE_ITENS.SUB_ITEM_SPED,''))) = '' 
										 THEN NULL 
										 ELSE RTRIM(LTRIM(ISNULL(NFE_ITENS.SUB_ITEM_SPED,''))) 
									END 
						  END
					ELSE CASE WHEN RTRIM(LTRIM(NFE_ITENS.SUB_ITEM_SPED)) = '' 
							  THEN NULL 
							  ELSE RTRIM(LTRIM(NFE_ITENS.SUB_ITEM_SPED)) 
						 END 
				END																													"cBenef",
				/*#133#*/

				/*#148#*/
					( 
						SELECT 
								RTRIM(NFE_ITENS.COD_GCRED_PRESUMIDO) /*#157#*/																	 "cCredPresumido",
								CONVERT(NUMERIC(3,2),NFE_ITENS.PORC_CRED_PRESUMIDO)												 "pCredPresumido",
								CASE WHEN ISNULL(NFE_ITENS.PORC_CRED_PRESUMIDO,0) > 0 THEN 
								CONVERT(NUMERIC(13,2), ISNULL((NFE_ITENS.VALOR_IMPOSTO_ITEM - (NFE_ITENS.VALOR_ITEM * (NFE_ITENS.PORC_CRED_PRESUMIDO / 100))), 0))*-1
								--ISNULL((NFE_ITENS.VALOR_IMPOSTO_ITEM - (NFE_ITENS.VALOR_ITEM * (NFE_ITENS.PORC_CRED_PRESUMIDO  / 100))), 0) 
								WHEN ISNULL(NFE_ITENS.PORC_CRED_PRESUMIDO,0) = 0 THEN '0.00' --#177#
								ELSE NULL END																						 "vCredPresumido"					
								WHERE ISNULL(NFE_ITENS.GERAR_GCRED_PRESUMIDO,0) = 1				
						FOR XML PATH(''), TYPE				
					) AS gCred,
				/*#148#*/

					CASE WHEN (NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 )
						OR (SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),9,3) = '') OR LEN(SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),9,3)) <= 1 THEN NULL ELSE
						SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),9,3) END													"EXTIPI",		-- 1-0 TIRAR A TAG CASO SEJA NF DE SERVICO		
						
					--CASE WHEN NFE_ITENS.CODIGO_CEST IS NOT NULL THEN 'S' END														"indEscala", Sefaz ainda não esta validando 03/02/2018			
						
					--CASE WHEN NFE_ITENS.ISS > 0 OR NFE_ITENS.ISS_R > 0 THEN 99 ELSE
					--	SUBSTRING(NFE_ITENS.CLASSIF_FISCAL,1,2)	END																	"genero",	-- (2.0) NAO EXISTE MAIS
					NFE_ITENS.CODIGO_FISCAL_OPERACAO																				"CFOP",
					NFE_ITENS.UNIDADE																								"uCom", --#152#
					CONVERT(NUMERIC(15,4), NFE_ITENS.QTDE_ITEM) 																	"qCom",
					CONVERT(NUMERIC(21,10), NFE_ITENS.PRECO_UNITARIO)																"vUnCom",
					CONVERT(NUMERIC(15,2), NFE_ITENS.VALOR_ITEM)																	"vProd",	-- DEVE SER O VALOR BRUTO DO PRODUTO
					NFE_ITENS.EAN																									"cEANTrib",	-- ???(2.0) CRIAR FUNCAO												
					/*#57# - tratamento NCM - Inicio*/					
					CASE WHEN 
						(
							GETDATE()>=@DATA_VALIDADE_CFOP_EXPE AND /*#60#*/
							(							
								(
									(ltrim(rtrim(NFE.ORIGEM_NF)) = 'S' and NFE.ID_DESTINO_OPERACAO = 3)	or 
									(NFE_ITENS.CODIGO_FISCAL_OPERACAO COLLATE DATABASE_DEFAULT IN (SELECT * FROM #ARRAY)) 
								)
								AND 
								(EXISTS /*#150#*/
									(
										SELECT *
											FROM LCF_LX_NCM A 
											INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
												ON A.ID_NCM = B.ID_NCM
											INNER JOIN UNIDADES_TRIBUTARIA_EXTERIOR C 
												ON B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
										
 											WHERE (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
													ELSE --#20#
														CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
															OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
															THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
														CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
													END ) /*#58#*/ =  A.COD_NCM									
									)
								/*#150#*/
								OR EXISTS
									(	/*#158#*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
								)
								/*#150#*/
							)
						)
					THEN 
						/*#150#*/
						CASE WHEN EXISTS
									(
										/*#158#*/
										/*SELECT ID_UNIDADE_TRIBUTARIA
											FROM PRODUTOS_BARRA
											WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
												AND PRODUTOS_BARRA.CODIGO_BARRA=NFE_ITENS.EAN
												AND ID_UNIDADE_TRIBUTARIA IS NOT NULL*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
						THEN
							(
								/*#158#*/
								/*SELECT LTRIM(RTRIM(C.UNIDADE_TRIBUTARIA_ABREVIATURA)) AS UNIDADE_TRIBUTARIA_ABREVIATURA
								FROM PRODUTOS_BARRA A 
								INNER JOIN UNIDADES_TRIBUTARIA_EXTERIOR C 
									ON A.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
								WHERE A.TIPO_COD_BAR = 1
									AND A.CODIGO_BARRA=NFE_ITENS.EAN*/
								SELECT TOP 1 LTRIM(RTRIM(C.UNIDADE_TRIBUTARIA_ABREVIATURA)) AS UNIDADE_TRIBUTARIA_ABREVIATURA
								FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
								JOIN UNIDADES_TRIBUTARIA_EXTERIOR C  ON F.ID_UNIDADE_TRIBUTARIA=C.ID_UNIDADE_TRIBUTARIA
								WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
								ORDER BY ORDEM
								/*#158#*/
							)
						ELSE
						/*#150#*/
							(
								SELECT LTRIM(RTRIM(C.UNIDADE_TRIBUTARIA_ABREVIATURA)) AS UNIDADE_TRIBUTARIA_ABREVIATURA
								FROM LCF_LX_NCM A 
								INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
									ON A.ID_NCM = B.ID_NCM
								INNER JOIN UNIDADES_TRIBUTARIA_EXTERIOR C 
									ON B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA											
 								WHERE   (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
												THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
												ELSE --#20#
													CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
														OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
													CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
												END ) /*#58#*/ =  A.COD_NCM			
							)
						END
					ELSE
						NFE_ITENS.UNIDADE										
					END																												"uTrib",	--#152#

					CASE WHEN 
						(							
							GETDATE()>=@DATA_VALIDADE_CFOP_EXPE AND /*#60#*/
							(							
								(
									(ltrim(rtrim(NFE.ORIGEM_NF)) = 'S' and NFE.ID_DESTINO_OPERACAO = 3)	or 
									(NFE_ITENS.CODIGO_FISCAL_OPERACAO COLLATE DATABASE_DEFAULT IN (SELECT * FROM #ARRAY)) 							
								)
								AND 
								(EXISTS /*150*/
									(
 										SELECT TOP 1 1
										FROM LCF_LX_NCM A 
										INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
											ON A.ID_NCM = B.ID_NCM
										inner join UNIDADES_CONVERSOES_TRIBUTARIA C 
											on B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
										WHERE  (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
													ELSE --#20#
														CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
															OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
															THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
														CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
													END ) /*#58#*/ =  A.COD_NCM
										AND C.UNIDADE = NFE_ITENS.UNIDADE --#152#
									
									)
								/*#150#*/
								OR EXISTS
									(
										/*SELECT ID_UNIDADE_TRIBUTARIA
											FROM PRODUTOS_BARRA
											WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
												AND PRODUTOS_BARRA.CODIGO_BARRA=NFE_ITENS.EAN
												AND ID_UNIDADE_TRIBUTARIA IS NOT NULL*/
										/*#158#*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
								)
								/*#150#*/
							)
						)
					THEN 						
						/*#150#*/
						CASE WHEN EXISTS
									(
										/*SELECT ID_UNIDADE_TRIBUTARIA
											FROM PRODUTOS_BARRA
											WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
												AND PRODUTOS_BARRA.CODIGO_BARRA=NFE_ITENS.EAN
												AND ID_UNIDADE_TRIBUTARIA IS NOT NULL*/
										/*#158#*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
						THEN
							(
								/*SELECT CONVERT(NUMERIC(15,4), NFE_ITENS.QTDE_ITEM * ISNULL		 (A.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA,1))
								FROM PRODUTOS_BARRA A 
								INNER JOIN UNIDADES_TRIBUTARIA_EXTERIOR C 
									ON A.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
								WHERE A.TIPO_COD_BAR = 1
									AND A.CODIGO_BARRA=NFE_ITENS.EAN*/
								/*#158#*/
								SELECT TOP 1 CONVERT(NUMERIC(15,4), NFE_ITENS.QTDE_ITEM * ISNULL		 (F.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA,1)) FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
										WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
								/*#158#*/
							)
						ELSE
						/*#150#*/
							(
								SELECT CONVERT(NUMERIC(15,4), NFE_ITENS.QTDE_ITEM * C.FATOR_CONVERSAO_UNIDADE)
								FROM LCF_LX_NCM A 
								INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
									ON A.ID_NCM = B.ID_NCM
								inner join UNIDADES_CONVERSOES_TRIBUTARIA C 
									on B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
								WHERE  (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
												THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
												ELSE --#20#
													CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
														OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
													CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
												END ) /*#58#*/ =  A.COD_NCM
								AND C.UNIDADE = NFE_ITENS.UNIDADE --#152#
							)
						END
					ELSE
						CONVERT(NUMERIC(15,4),NFE_ITENS.QTDE_ITEM)
					END					
																																	"qTrib",
					/*#57# - tratamento NCM - Fim*/
					/*#59#  - Inicio*/					
					CASE WHEN 
						(							
							GETDATE()>=@DATA_VALIDADE_CFOP_EXPE AND /*#60#*/
							(							
								(
									(ltrim(rtrim(NFE.ORIGEM_NF)) = 'S' and NFE.ID_DESTINO_OPERACAO = 3)	or 
									(NFE_ITENS.CODIGO_FISCAL_OPERACAO COLLATE DATABASE_DEFAULT IN (SELECT * FROM #ARRAY)) 							
								)
								AND 
								(EXISTS /*#150#*/
									(
 										SELECT TOP 1 1
										FROM LCF_LX_NCM A 
										INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
											ON A.ID_NCM = B.ID_NCM
										inner join UNIDADES_CONVERSOES_TRIBUTARIA C 
											on B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
										WHERE (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
													ELSE --#20#
														CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
															OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
															THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
														CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
													END ) /*#58#*/ =  A.COD_NCM
										AND C.UNIDADE = NFE_ITENS.UNIDADE --#152#
									
									)	
								/*#150#*/
								OR EXISTS
									(
										/*SELECT ID_UNIDADE_TRIBUTARIA
											FROM PRODUTOS_BARRA
											WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
												AND PRODUTOS_BARRA.CODIGO_BARRA=NFE_ITENS.EAN
												AND ID_UNIDADE_TRIBUTARIA IS NOT NULL*/
										/*#158#*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
								)
								/*#150#*/
							)
						)
					THEN 						
						/*#150#*/
						CASE WHEN EXISTS
									(
										/*SELECT ID_UNIDADE_TRIBUTARIA
											FROM PRODUTOS_BARRA
											WHERE PRODUTOS_BARRA.TIPO_COD_BAR = 1
												AND PRODUTOS_BARRA.CODIGO_BARRA=NFE_ITENS.EAN
												AND ID_UNIDADE_TRIBUTARIA IS NOT NULL*/
										/*#158#*/
										SELECT TOP 1 ID_UNIDADE_TRIBUTARIA FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
											WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
												ORDER BY ORDEM
										/*#158#*/
									)
						THEN
							(
								/*SELECT CONVERT(NUMERIC(15,4), NFE_ITENS.PRECO_UNITARIO / ISNULL		 (A.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA,1))
								FROM PRODUTOS_BARRA A 
								INNER JOIN UNIDADES_TRIBUTARIA_EXTERIOR C 
									ON A.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
								WHERE A.TIPO_COD_BAR = 1
									AND A.CODIGO_BARRA=NFE_ITENS.EAN*/
								/*#158#*/
								SELECT TOP 1 CONVERT(NUMERIC(15,4), NFE_ITENS.PRECO_UNITARIO / ISNULL		 (F.FATOR_CONVERSAO_UNIDADE_TRIBUTARIA,1)) FROM #XML_FATOR_CONVERSAO_UNIDADE_TRIBUTARIA F
										WHERE F.CODIGO_BARRA=NFE_ITENS.EAN
										ORDER BY ORDEM
								/*#158#*/
							)
						ELSE
						/*#150#*/
							(
								SELECT CONVERT(NUMERIC(15,4), NFE_ITENS.PRECO_UNITARIO / C.FATOR_CONVERSAO_UNIDADE)
								FROM LCF_LX_NCM A 
								INNER JOIN UNIDADES_TRIBUTARIA_NCM B 
									ON A.ID_NCM = B.ID_NCM
								inner join UNIDADES_CONVERSOES_TRIBUTARIA C 
									on B.ID_UNIDADE_TRIBUTARIA = C.ID_UNIDADE_TRIBUTARIA
								WHERE (CASE WHEN NFE_ITENS.ISS + NFE_ITENS.ISS_R > 0 
												THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,2) 
												ELSE --#20#
													CASE WHEN SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) IN ('3','7') 
														OR (NFE_ITENS.CST_IPI IS NOT NULL ) OR (NFE.CRT = 3) --#17# --#18#
														THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) ELSE 
													CASE WHEN NFE_ITENS.CST_IPI IS NULL OR NFE_ITENS.IPI = 0
													THEN SUBSTRING(REPLACE(NFE_ITENS.CLASSIF_FISCAL,'.',''),1,8) END END 
												END ) /*#58#*/ =  A.COD_NCM
								AND C.UNIDADE = NFE_ITENS.UNIDADE --#152#
							)
						END
					ELSE						
						CONVERT(NUMERIC(21,10),NFE_ITENS.PRECO_UNITARIO)
					END	
					/*#59#  - Fim*/					
																																	"vUnTrib",
					CASE WHEN NFE_ITENS.FRETE = 0 THEN NULL ELSE CONVERT(NUMERIC(15,2),NFE_ITENS.FRETE) END							"vFrete",-- FALTA COLOCAR NO ITEM (CRIAR CAMPO) --OK
					CASE WHEN NFE_ITENS.SEGURO = 0 THEN NULL ELSE CONVERT(NUMERIC(15,2),NFE_ITENS.SEGURO) END						"vSeg",	 -- FALTA COLOCAR NO ITEM (CRIAR CAMPO) --OK
					CASE WHEN (NFE_ITENS.VALOR_DESCONTOS - NFE_ITENS.ICMS_ZF) = 0 THEN NULL ELSE CONVERT(NUMERIC(15,2),NFE_ITENS.VALOR_DESCONTOS) - NFE_ITENS.ICMS_ZF END	"vDesc", --#16#										
					CASE WHEN (NFE_ITENS.ENCARGO) = 0 THEN NULL ELSE CONVERT(NUMERIC(15,2),NFE_ITENS.ENCARGO) END					"vOutro",--(2.0)
					CASE WHEN NFE_ITENS.ISS > 0 OR NFE_ITENS.ISS_R > 0 THEN 0 ELSE NFE_ITENS.INDTOT END								"indTot",-- (2.0)
-- #163# - Início
-- #166# - Início
				CASE WHEN @GERA_COM_RT = 0  or 1=1	THEN NULL ELSE 1 END																"indBemMovelUsado", /* Indicador de fornecimento de bem móvel usado */
-- #166# - Fim
-- #163# - Fim
					-------------------------------------------------------
					--- DI
					(
						SELECT RTRIM(W_DI_NFE.NUMERO_DI)													"nDI", -- FALTA CUPOM FISCAL ??	
								CONVERT(CHAR(10),W_DI_NFE.DATA_REGISTRO_DI,21)								"dDI",
								DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,W_DI_NFE.LOCAL_DESEMBARACO)	"xLocDesemb",
								W_DI_NFE.UF_DESEMBARACO														"UFDesemb",
								CONVERT(CHAR(10),W_DI_NFE.DATA_DESEMBARACO,21)								"dDesemb",
								
								--#3.10#
								W_DI_NFE.TIPO_TRANSPORTE													"tpViaTransp",
								W_DI_NFE.VALOR_AFRMM														"vAFRMM",
								W_DI_NFE.TIPO_INTERMEDIO													"tpIntermedio",
								--W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE										"CNPJ",
								
								CASE WHEN (   LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' 
										   OR LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325') 
								AND LEN(W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE)> 11 
									 THEN W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE
									 WHEN (W_DI_NFE.TIPO_INTERMEDIO=2 OR W_DI_NFE.TIPO_INTERMEDIO=3)
								AND (   LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO<'20240701' 
										   OR LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO<'20240325') 
									 THEN W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE ELSE NULL END	"CNPJ", /*#146#*/

								CASE WHEN (W_DI_NFE.TIPO_INTERMEDIO=2 OR W_DI_NFE.TIPO_INTERMEDIO=3) AND LEN(W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE)<=11
								AND (   LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' 
										OR LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325')
									THEN W_DI_NFE.CGC_ENCOMENDANTE_ADQUIRENTE ELSE NULL END	"CPF",	/*#146#*/

								W_DI_NFE.UF_ENCOMENDANTE_ADQUIRENTE										    "UFTerceiro",
								--#3.10#
								
								DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,W_DI_NFE.CODIGO_EXPORTADOR) 	"cExportador",
								--- ADI
								(
									SELECT /*#122#*/CASE WHEN RTRIM(ISNULL(W_DI_NFE.TIPO_DOC_IMPORTACAO,''))<> '2 - Declaração Única de Importação - DUIMP' THEN W_ADICAO_DI_NFE.NUMERO_DA_ADICAO ELSE NULL END		"nAdicao" /*#122#*/,
											W_ADICAO_DI_NFE.ID_ITEM											"nSeqAdic",
											DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,W_ADICAO_DI_NFE.FABRICANTE_ESTRANGEIRO)  "cFabricante",
											CASE WHEN W_ADICAO_DI_NFE.DESCONTO_ITEM = 0 OR W_ADICAO_DI_NFE.DESCONTO_ITEM IS NULL THEN NULL ELSE CONVERT(NUMERIC(15,2),W_ADICAO_DI_NFE.DESCONTO_ITEM) END "vDescDI",
											--#3.10#
											W_ADICAO_DI_NFE.NUMERO_DRAWBACK "nDraw"
											--#3.10#
									FROM W_ADICAO_DI_NFE
									WHERE W_ADICAO_DI_NFE.NF_ENTRADA = NFE_ITENS.NF 
										AND W_ADICAO_DI_NFE.SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF 
										AND W_ADICAO_DI_NFE.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO 
										AND W_ADICAO_DI_NFE.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
										AND W_ADICAO_DI_NFE.NUMERO_DI = W_DI_NFE.NUMERO_DI 
									FOR XML PATH('adi'), TYPE				
								)  			
                        FROM (  
								SELECT DISTINCT NUMERO_DI, DATA_REGISTRO_DI, LOCAL_DESEMBARACO, UF_DESEMBARACO, DATA_DESEMBARACO, CODIGO_EXPORTADOR, 
											   TIPO_TRANSPORTE, VALOR_AFRMM, TIPO_INTERMEDIO, CGC_ENCOMENDANTE_ADQUIRENTE, UF_ENCOMENDANTE_ADQUIRENTE/*#122#*/,TIPO_DOC_IMPORTACAO/*#122#*/
                                       FROM W_DI_NFE
                                       WHERE W_DI_NFE.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
                                       AND         W_DI_NFE.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
                                       AND         W_DI_NFE.NF_ENTRADA = NFE_ITENS.NF
                                       AND         W_DI_NFE.SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF
                                       AND         W_DI_NFE.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR) W_DI_NFE
                        FOR XML PATH('DI'), TYPE       
					),														
					
------ #3.10#
------ detExport
					--- detExport
					(
						SELECT 	detEexportacao.NUMERO_DRAWBACK "nDraw",
								--- exportInd
								(
									SELECT  NUMERO_REGISTRO		"nRE",
											CHAVE_ACESSO_NFE	"chNFe",
											QTDE_ITEM			"qExport"
									FROM W_IMPRESSAO_NFE_ITENS_EXPORTACAO ItensExport
									WHERE ItensExport.NF_SAIDA			= detEexportacao.NF_SAIDA AND 
										  ItensExport.SERIE_NF			= detEexportacao.SERIE_NF AND 
										  ItensExport.ITEM_IMPRESSAO	= detEexportacao.ITEM_IMPRESSAO AND 
										  ItensExport.SUB_ITEM_TAMANHO	= detEexportacao.SUB_ITEM_TAMANHO AND 
										  ItensExport.NUMERO_DRAWBACK	= detEexportacao.NUMERO_DRAWBACK 
									FOR XML PATH('exportInd'), TYPE				
								)  			
                        FROM ( SELECT DISTINCT ItensExportacao.NUMERO_DRAWBACK, ItensExportacao.NF_SAIDA, ItensExportacao.SERIE_NF, 
											   ItensExportacao.FILIAL, ItensExportacao.ITEM_IMPRESSAO, ItensExportacao.SUB_ITEM_TAMANHO 
							   FROM W_IMPRESSAO_NFE_ITENS_EXPORTACAO ItensExportacao
							      WHERE ItensExportacao.ITEM_IMPRESSAO		= NFE_ITENS.ITEM_IMPRESSAO AND
                                        ItensExportacao.SUB_ITEM_TAMANHO	= NFE_ITENS.SUB_ITEM_TAMANHO AND
                                        ItensExportacao.NF_SAIDA			= NFE_ITENS.NF AND
                                        ItensExportacao.SERIE_NF			= NFE_ITENS.SERIE_NF AND
                                        ItensExportacao.FILIAL				= NFE_ITENS.FILIAL) detEexportacao
                        FOR XML PATH('detExport'), TYPE       
					),

------ detExport
------ #3.10#

					
					-- VERIFICAR ONDE ESTAO ESTES DADOS
					---------------------------------------------------------
					NFE_ITENS.PEDIDO_COMPRA				"xPed",				--(2.0) ?? Número do Pedido de Compra - C(15)
					NFE_ITENS.ITEM_PEDIDO_COMPRA		"nItemPed",			--(2.0) ?? Item do Pedido de Compra   - N(6)
					CONVERT(UNIQUEIDENTIFIER, NFE_ITENS.CODIGO_FCI)	 "nFCI",				--#6#
						
					-- arma - 2.00
					(
						SELECT 
							 TIPO_ARMA				"tpArma", 
							 NUMERO_SERIE			"nSerie", 
							 NUMERO_SERIE_CANO		"nCano",
							 DESCRICAO_ARMA			"descr"
							 
							FROM W_ARMA_NFE  
								WHERE W_ARMA_NFE.NF = @NOTAFISCAL
										AND W_ARMA_NFE.SERIE = @SERIENOTA
										AND W_ARMA_NFE.FILIAL = CASE WHEN @TIPO_DOC = 'E' THEN  @NOME_CLIFOR ELSE @FILIALNOTA END
										AND W_ARMA_NFE.ORIGEM_ENTRADA_SAIDA = @TIPO_DOC							 

						  FOR XML PATH('arma'), TYPE 
					)

				FOR XML PATH(''), TYPE
			) AS prod, 
			
------------- IMPOSTO		
			( SELECT
--#2#			
--------------- VTOTTRIB		
				( SELECT NFE_ITENS.VALOR_IMPOSTO_ITEM "vTotTrib" FOR XML PATH(''), TYPE ),-- AS vTotTrib,
--------------- VTOTTRIB
--#2#
						

				--- ICMS
				( SELECT  	

					--- ICMS00
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CST",
								3												"modBC",
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)		"vBC",
							 	CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)	"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)			"vICMS",
								--#61#	
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END								"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0)THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END	"vFCP" --#81#
				
								--#61#
						WHERE NFE_ITENS.TRIBUT_ICMS in('00')
						FOR XML PATH(''), TYPE				
					) AS ICMS00,

					--- ICMS10
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)													"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)													"CST",
								3																				"modBC",
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)										"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)									"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)											"vICMS",
								--#61#	
								CASE WHEN NFE_ITENS.FECP_BASE	  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_BASE)	 ELSE NULL END								"vBCFCP",
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END								"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0) THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END	"vFCP", --#81#
								--#61#	
								4																				"modBCST",
								CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END				"pMVAST",	-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST)										"pRedBCST",	-- NAO POSSUI CONFORME CONVERSA COM JC --#13#								

						(	SELECT  -- PEGA O IMPOSTO 12 + 13
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST"

							WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
							FOR XML PATH(''), TYPE
						),
								--#61#	
							CASE WHEN NFE_ITENS.FECP_ST_BASE + NFE_ITENS.FECP_STR_BASE> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE+NFE_ITENS.FECP_STR_BASE)	ELSE NULL END  "vBCFCPST", --#75#
							CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA + NFE_ITENS.FECP_STR_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA+NFE_ITENS.FECP_STR_ALIQUOTA)	ELSE NULL END  "pFCPST",--#75#
							CASE WHEN NFE_ITENS.FECP_ST_VALOR + NFE_ITENS.FECP_STR_VALOR   > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR+NFE_ITENS.FECP_STR_VALOR)	ELSE NULL END  "vFCPST"--#75#								
								--#61#							
						WHERE NFE_ITENS.TRIBUT_ICMS = '10'
						FOR XML PATH(''), TYPE				
					) AS ICMS10,

					--- ICMS20   -- REDUCAO POSITIVO: ACRESCIMO /  NEGATIVO
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CST",
								3												"modBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC)			"pRedBC",						-- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)		"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)	"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)			"vICMS",
								--#61#	
								CASE WHEN NFE_ITENS.FECP_BASE	  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_BASE)	 ELSE NULL END								"vBCFCP",
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END								"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0) THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END	"vFCP", --#81#
								--#61#	
								--#3.10# 
								--#26#
								--#99#-#100#-Início
							(  SELECT Case 
								When NFE_ITENS.ICMS_ZF > 0 THEN CONVERT(NUMERIC(15,2), NFE_ITENS.ICMS_ZF)   
								when NFE_ITENS.ICMS_DESONERADO > 0 THEN CONVERT(NUMERIC(15,2), NFE_ITENS.ICMS_DESONERADO) 
								else 0.00 end as "vICMSDeson",
								Case when NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0 THEN RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) ELSE ' ' end as "motDesICMS",					
								CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								ELSE NULL END  AS "indDeduzDeson"  --#145# --#147#
                                WHERE (NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0)
                                FOR XML PATH(''), TYPE 
							)								
								--#99#-#100#-Fim

								--CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ZF)	"vICMSDeson",
								--RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) 		"motDesICMS"  
								--#26#
								--#3.10# 
						WHERE NFE_ITENS.TRIBUT_ICMS = '20'
						FOR XML PATH(''), TYPE				
					) AS ICMS20,

					--- ICMS30
					( 

						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)										"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)										"CST",
								4																	"modBCST",
								CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END	"pMVAST",	-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST)							"pRedBCST",	-- NAO POSSUI CONFORME CONVERSA COM JC --#13#

						(	SELECT  -- PEGA O IMPOSTO 12 + 13
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST",

								--#61#	
								CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST",								
								--#61#								
														
								--#3.10# 
								--#26#
								--#99#-#100#-Início
								(SELECT Case When NFE_ITENS.ICMS_ZF > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ZF)   
								when NFE_ITENS.ICMS_DESONERADO > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_DESONERADO) ELSE 0.00 end  "vICMSDeson",
								Case when NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0 THEN RTRIM(NFE_ITENS.ST_MOT_DESONERACAO)  ELSE ' ' END    "motDesICMS",
								CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								ELSE NULL END  AS "indDeduzDeson"  --#145# --#147#
                                WHERE (NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0)
                                FOR XML PATH(''), TYPE)								
								--#99#-#100#-Fim

								--CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ZF)	"vICMSDeson",
								--RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) 		"motDesICMS"  
								--#26#
								
								--#3.10# 
							--#99#-Início	
--							WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
							WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR + NFE_ITENS.ICMS_ZF + NFE_ITENS.ICMS_DESONERADO) >= 0 
							--#99#-Fim
							FOR XML PATH(''), TYPE
						)
						WHERE NFE_ITENS.TRIBUT_ICMS = '30'
						FOR XML PATH(''), TYPE				
					) AS ICMS30,

					--- ICMS40
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CST",	
								--#99#-Início
								(SELECT
								Case When NFE_ITENS.ICMS_ZF > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ZF)  when NFE_ITENS.ICMS_DESONERADO > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_DESONERADO) ELSE 0.00 END  "vICMSDeson",

								Case when (NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0) THEN RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) ELSE ' ' END 		"motDesICMS" ,
								CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
								ELSE NULL END  AS "indDeduzDeson"  --#145# --#147#
								WHERE NFE_ITENS.ICMS_ZF > 0 OR NFE_ITENS.ICMS_DESONERADO > 0
								FOR XML PATH(''), TYPE
								)
								--#99#-Fim
						WHERE NFE_ITENS.TRIBUT_ICMS IN ('40','41','50')
						FOR XML PATH(''), TYPE				
					) AS ICMS40,

					--- ICMS51
					--- COMENTADO A PARTE DE ICMS 51 - DIFERIMENTO: EM CONVERSA COM CESTARI EM 17/10/2010, FICOU ACERTADO QUE NAO VAMOS ENVIAR OS VALORES DO ICMS 
					--- PRINCIPALMENTE PORQUE TERIAMOS QUE FAZER UM TRATAMENTO ESPECIFICO PARA ESTES VALORES, PORQUE NAO FAZEM PARTE DA BASE DE CALCULO DO TOTAL DA NOTA.
					
					-- 25/03/2011   - PADIAL    - RETIRADO A TRAVA PARA CALCULO DO ICMS DOS CSTS QUE POSSUEM VALOR DE ICMS SOMENTE. CONFORME CONVERSA COM CESTARI, ACOMPANHADO POR RAFAEL,
					--							  ONDE SERA SEMPRE INCLUIDO O VALOR DO ICMS NO DESTAQUE INDEPENDEMENTE DA REGRA DA SEFAZ, SEGUINDO SEMPRE A PARAMETRIZACAO DO LINX.
					--							  IMPLEMENTAÇÃO DO IMPOSTO 51 QUE HAVIA SIDO OCULTO DA GERACAO DOS VALORES E TAMBEM DO XML PARA O CLIENTE
					
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)																												"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)																												"CST",
						(	SELECT 
								3																																			"modBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC)																										"pRedBC", -- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)--#13#
								CASE WHEN NFE_ITENS.GERAR_BENEF_RBC = 1 THEN /*#157#*/ RTRIM(NFE_ITENS.CBENEFRBC) /*#157#*/ ELSE NULL END													"cBenefRBC", 
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)																									"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)																								"pICMS", --#13#					
								--#3.1# #21#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)   														"vICMSOp",
								--#102#-#103#-#105#-#108#Início
								CONVERT(NUMERIC(5,2),((case when ISNULL(NFE_ITENS.ICMS,0) = 0 THEN 0 ELSE(NFE_ITENS.ICMS_BST/NFE_ITENS.ICMS )END)*100)) "pDif",
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BST) 															"vICMSDif", 
								--#102#-Fim
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS-NFE_ITENS.ICMS_BST) 												"vICMS",
								--#103#-#105#-#108#-Fim
								--#61#	
								CASE WHEN NFE_ITENS.FECP_BASE	  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_BASE)	 ELSE NULL END										"vBCFCP",
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END										"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0) THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END			"vFCP", --#81#
								--#61#	
								--#132#  inicio
								CASE WHEN NFE_ITENS.FECP_DIF_VALOR > 0  THEN CONVERT(NUMERIC(5,2),((case when ISNULL(NFE_ITENS.FECP_VALOR,0) = 0 THEN 0 ELSE(NFE_ITENS.FECP_DIF_VALOR/NFE_ITENS.FECP_VALOR )END)*100)) END "pFCPDif",
								CASE WHEN NFE_ITENS.FECP_DIF_VALOR  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DIF_VALOR)	 ELSE NULL END										"vFCPDif",
								CASE WHEN (NFE_ITENS.FECP_DIF_VALOR >= 0 AND NFE_ITENS.FECP_DIF_BASE > 0) THEN (CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR) - CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DIF_VALOR))   ELSE NULL END		"vFCPEfet"
								
							    --#132#  fim						
								
								--#99#-
							WHERE NFE_ITENS.ICMS_BST > 0
							FOR XML PATH(''), TYPE				
						)
						WHERE TRIBUT_ICMS = '51'
						FOR XML PATH(''), TYPE				
					) AS ICMS51,

					--- ICMS60
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)																									"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)																									"CST",

						(	SELECT  -- PEGA O IMPOSTO 12 + 13 + 64 + 65
								--#61#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE  + 
													  NFE_ITENS.ICMS_STR_BASE + 
													  NFE_ITENS.ICMS_STA_BASE + 
													  NFE_ITENS.ICMS_STAR_BASE)																					"vBCSTRet",		--(2.0)													
								
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_STA_ALIQUOTA + 
													  NFE_ITENS.FECP_STA_ALIQUOTA + 
													  NFE_ITENS.ICMS_STAR_ALIQUOTA +
													  NFE_ITENS.FECP_STAR_ALIQUOTA )																				"pST",/*#65#*/
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_SUBSTITUTO	)																				  "vICMSSubstituto", /*#91#*/	
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST  + 
													  NFE_ITENS.ICMS_STR + 
													  NFE_ITENS.ICMS_STA + 
													  NFE_ITENS.ICMS_STAR)																						"vICMSSTRet"	--(2.0)
								
							--#61#
							WHERE ((NFE_ITENS.ICMS_ST ) > 0 AND NFE_ITENS.PMVAST IS NOT NULL) OR 
							--(NFE_ITENS.ICMS_STR + NFE_ITENS.ICMS_STA + NFE_ITENS.ICMS_STAR+NFE_ITENS.ICMS_SUBSTITUTO) > 0  --#61#
							 RTRIM(NFE.INDICA_OPERACAO_FINAL)=0 /*#92#*/
							FOR XML PATH(''), TYPE						
						),
						--#61#
						(							
							SELECT
								CASE 
									WHEN (NFE_ITENS.FECP_STA_BASE + NFE_ITENS.FECP_STAR_BASE) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA_BASE + NFE_ITENS.FECP_STAR_BASE) 
								ELSE NULL END 																												"vBCFCPSTRet",
								CASE 
									WHEN (NFE_ITENS.FECP_STA_ALIQUOTA + NFE_ITENS.FECP_STAR_ALIQUOTA) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA_ALIQUOTA + NFE_ITENS.FECP_STAR_ALIQUOTA) 
								ELSE NULL END																												"pFCPSTRet",
								CASE 
									WHEN (NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR)	
								ELSE NULL END																												"vFCPSTRet"
				
							WHERE (NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR) > 0 
							
							FOR XML PATH(''), TYPE
						),						
						(							
						--#71# - NF 1.60							
							SELECT							
								case when @OPTANTE_ROT = 0 then CONVERT(NUMERIC(7,4),NFE_ITENS.pRedBCEfet) else 0 end			"pRedBCEfet", --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then NFE_ITENS.ICMS_EFET_BASE  else 0 end							"vBCEfet",	  --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_EFET_ALIQUOTA)  else 0 end	"pICMSEfet",  --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then NFE_ITENS.ICMS_EFET_VALOR  else 0 end							"vICMSEfet"	  --#73# /*#123#*/
								--CASE WHEN NFE_ITENS.pRedBCEfet			> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.pRedBCEfet)			ELSE NULL	END		"pRedBCEfet",	--#73#
								--CASE WHEN NFE_ITENS.ICMS_EFET_BASE		> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_EFET_BASE)		ELSE NULL	END		"vBCEfet",		--#73#		
								--CASE WHEN NFE_ITENS.ICMS_EFET_ALIQUOTA	> 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_EFET_ALIQUOTA)		ELSE NULL	END		"pICMSEfet",	--#73#	
								--CASE WHEN NFE_ITENS.ICMS_EFET_VALOR		> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_EFET_VALOR)		ELSE NULL	END		"vICMSEfet"		--#73#					
							WHERE ((NFE_ITENS.ICMS_EFET_VALOR) > 0 )  OR ((NFE_ITENS.ICMS_EFET_VALOR) = 0 AND  @OPTANTE_ROT=1 ) /*#123#*/
							FOR XML PATH(''), TYPE
						--#71# - NF 1.60	
						)

										

						--#61#
						WHERE NFE_ITENS.TRIBUT_ICMS = '60'
						FOR XML PATH(''), TYPE	
									
					) AS ICMS60,

					--- ICMS70
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CST",

							(select	
								3															"modBC",
								ISNULL(CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC),0)			"pRedBC", -- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)--#13#
								ISNULL(CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE),0)		"vBC",
								ISNULL(CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA),0)		"pICMS",--#13#
								ISNULL(CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS),0)				"vICMS"
								WHERE (NFE_ITENS.ICMS > 0 
								OR CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE) > 0) --#61#
								FOR XML PATH(''), TYPE
							),
								--#61#	
								CASE WHEN NFE_ITENS.FECP_BASE	  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_BASE)	 ELSE NULL END								"vBCFCP",
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END								"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0) THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END	"vFCP", --#81#
								--#61#	
								--#99#-#100#-#101#

						(	SELECT
								4																		"modBCST",							
								CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END		"pMVAST",	-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST)								"pRedBCST",	-- NAO POSSUI CONFORME CONVERSA COM JC--#13#

						--(	SELECT  -- PEGA O IMPOSTO 12 + 13
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST",
								--#61#	
								CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST"								
								--#61#
								--#3.1#
								--#26#
								--#26#
							WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR ) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL --#3.1#
							FOR XML PATH(''), TYPE
						),
						--#99#-#100#-#101#-Início
						( SELECT Case When NFE_ITENS.ICMS_DESONERADO > 0 THEN CONVERT(NUMERIC   (15,2),NFE_ITENS.ICMS_DESONERADO) ELSE NULL end "vICMSDeson",
								Case when NFE_ITENS.ICMS_DESONERADO > 0 THEN RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) ELSE NULL END 	"motDesICMS" ,
						CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
						WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
						ELSE NULL END  AS "indDeduzDeson"  --#145# --#147#
						WHERE NFE_ITENS.ICMS_DESONERADO > 0 
						FOR XML PATH(''), TYPE
						)
						--#99#-#100#-#101#-Fim
						WHERE NFE_ITENS.TRIBUT_ICMS = '70'
						FOR XML PATH(''), TYPE				
					) AS ICMS70,

					--- ICMS90 -- ICMS OUTROS  
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)	"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)	"CST",

							( SELECT

								3																"modBC",							-- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO)
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)						"vBC",
								CASE WHEN NFE_ITENS.PREDBC > 0 AND NFE_ITENS.ICMS > 0 
									THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC) ELSE NULL END	"pRedBC",		-- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)	--#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)					"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)							"vICMS",
								--#61#	
								CASE WHEN NFE_ITENS.FECP_BASE	  > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_BASE)	 ELSE NULL END								"vBCFCP",
								CASE WHEN NFE_ITENS.FECP_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ALIQUOTA) ELSE NULL END								"pFCP",
								CASE WHEN (NFE_ITENS.FECP_VALOR >= 0 AND NFE_ITENS.FECP_BASE > 0) THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_VALOR)   ELSE NULL END	"vFCP" --#81#
								--#114# #26# #3.1# #22# #61# Bloco movido após select "modBCST" 4																															 
								WHERE NFE_ITENS.ICMS > 0
								FOR XML PATH(''), TYPE
							    ),						
								--#99#-#100#-#101#-Fim
							( SELECT
									4																				"modBCST",
									CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END					"pMVAST",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
									CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST)										"pRedBCST",						-- NAO POSSUI CONFORME CONVERSA COM JC--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
									CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST"

								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE

							),
								--#114# #26# #3.1# #22# #61#
								( SELECT CASE	WHEN NFE_ITENS.ICMS_ZF			> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ZF)   
												WHEN NFE_ITENS.ICMS_DESONERADO	> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_DESONERADO)
											ELSE 0.00 
											END									"vICMSDeson",  --#111##3.10# "vICMS", --(2.0) ICMS ZF para tratamento de qq desoneração
									RTRIM(NFE_ITENS.ST_MOT_DESONERACAO) 		"motDesICMS",  --(2.0) Motivos conforme nota técnica
									CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
									WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  NFE_ITENS.IND_DEDUZ_DESON --#147#
									ELSE NULL END  AS "indDeduzDeson"  --#145# --#147#
									WHERE NFE_ITENS.ICMS_ZF > 0 
										OR NFE_ITENS.ICMS_DESONERADO > 0 --#111#
									FOR XML PATH(''), TYPE
								),
								--#114##26# #3.1# #22# #61#

								--#61#	
								CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST"								
								--#61#

						WHERE NFE_ITENS.TRIBUT_ICMS = '90'
						FOR XML PATH(''), TYPE				
					)   AS ICMS90,
					
					--- ICMSPart (2.0)  SOMENTE PARA VEICULOS
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)	"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)	"CST",

							( SELECT

								3																"modBC",							-- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO)
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)						"vBC",
								CASE WHEN NFE_ITENS.PREDBC > 0 AND NFE_ITENS.ICMS > 0 
									THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC) ELSE NULL END	"pRedBC",		-- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)	--#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)					"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)							"vICMS"
								WHERE NFE_ITENS.ICMS > 0
								FOR XML PATH(''), TYPE
							),
							
							( SELECT
									4																				"modBCST",
									CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END					"pMVAST",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
									CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST)										"pRedBCST",						-- NAO POSSUI CONFORME CONVERSA COM JC--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
									CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST",
									CONVERT(NUMERIC(7,4),0)															"pBCOp",		-- (2.0)	???? --#13#
									NFE.UF																			"UFST"			-- (2.0)
									

								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE

							)

						WHERE 1=2		-- NFE_ITENS.TRIBUT_ICMS = '90' OR NFE_ITENS.TRIBUT_ICMS = '10' 
						FOR XML PATH(''), TYPE				
					)   AS ICMSPart,
					
					--- ICMSST (2.0)  SOMENTE PARA COMBUSTIVEL
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)	"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)	"CST",
							( SELECT
									CONVERT(NUMERIC(15,2),0)														"vBCSTRet",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST
									CONVERT(NUMERIC(15,2),0)														"vICMSSTRet",						-- NAO POSSUI CONFORME CONVERSA COM JC
									CONVERT(NUMERIC(15,2),0)														"vBCSTDest",
									CONVERT(NUMERIC(15,2),0)														"vICMSSTDest"

								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE
							)

						WHERE 1=2		-- NFE_ITENS.TRIBUT_ICMS = '41'
						FOR XML PATH(''), TYPE				
					)   AS ICMSST,
					
					--- ICMSSN101 (2.0)  OK
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)						"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)						"CSOSN",
							 	CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_SN_ALIQUOTA)	"pCredSN", --#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_SN)			"vCredICMSSN"

						WHERE NFE_ITENS.TRIBUT_ICMS = '101' AND NFE.CRT = 1
						FOR XML PATH(''), TYPE				
	
					)   AS ICMSSN101,		
					
					--- ICMSSN102 (2.0)  OK
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CSOSN"

						WHERE NFE_ITENS.TRIBUT_ICMS IN ('102','103','300','400') AND NFE.CRT = 1
						FOR XML PATH(''), TYPE				
	
					)   AS ICMSSN102,
					
					--- ICMSSN201 (2.0)  OK
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)														"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)														"CSOSN",

							( SELECT
									4																				"modBCST",
									CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END					"pMVAST",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
									CASE WHEN NFE_ITENS.PREDBCST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST) ELSE NULL END					"pRedBCST",						-- NAO POSSUI CONFORME CONVERSA COM JC--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
									CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST"

								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE
							),
								--#61#	
								CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST",							
								--#61#
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_SN_ALIQUOTA)									"pCredSN", --#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_SN)											"vCredICMSSN"


							WHERE NFE_ITENS.TRIBUT_ICMS = '201' AND NFE.CRT = 1
							FOR XML PATH(''), TYPE										
					)   AS ICMSSN201,						

					--- ICMSSN202 (2.0)  OK
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)														"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)														"CSOSN",

							( SELECT
									4																				"modBCST",
									CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END					"pMVAST",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
									CASE WHEN NFE_ITENS.PREDBCST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST) ELSE NULL END					"pRedBCST",						-- NAO POSSUI CONFORME CONVERSA COM JC--#13#							
								--CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE +ICMS_SNST_BASE )			"vBCST", --#37#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE )			"vBCST", --#38#
								
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA  )	"pICMSST",--#13# --#37#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR  )						"vICMSST" --#37#


								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR  ) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE
							),
								--#61#	
								CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
								CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST"								
								--#61#
						WHERE NFE_ITENS.TRIBUT_ICMS IN ('202','203') AND NFE.CRT = 1
						FOR XML PATH(''), TYPE										
					)   AS ICMSSN202,
					
					--- ICMSSN500 (2.0)  OK
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)					"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)					"CSOSN",
								
						(	SELECT  -- PEGA O IMPOSTO 12 + 13 + 64 + 65
								--#61#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE  + 
													  NFE_ITENS.ICMS_STR_BASE + 
													  NFE_ITENS.ICMS_STA_BASE + 
													  NFE_ITENS.ICMS_STAR_BASE)																					"vBCSTRet",		--(2.0)													
								
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_STA_ALIQUOTA + 
													  NFE_ITENS.FECP_STA_ALIQUOTA + 
													  NFE_ITENS.ICMS_STAR_ALIQUOTA +
													  NFE_ITENS.FECP_STAR_ALIQUOTA )																				"pST",/*#65#*/
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_SUBSTITUTO)																				 "vICMSSubstituto", /*#91#*/	
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST  + 
													  NFE_ITENS.ICMS_STR + 
													  NFE_ITENS.ICMS_STA + 
													  NFE_ITENS.ICMS_STAR)																						"vICMSSTRet"	--(2.0)
								--#61#

							WHERE ((NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) > 0 AND NFE_ITENS.PMVAST IS NOT NULL) OR
								   --(NFE_ITENS.ICMS_STR + NFE_ITENS.ICMS_STA + NFE_ITENS.ICMS_STAR+NFE_ITENS.ICMS_SUBSTITUTO) > 0 --#61#
								   RTRIM(NFE.INDICA_OPERACAO_FINAL)=0/*#92#*/
							FOR XML PATH(''), TYPE
						),	
						--#61#
						(							
							SELECT
								CASE 
									WHEN (NFE_ITENS.FECP_STA_BASE + NFE_ITENS.FECP_STAR_BASE) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA_BASE + NFE_ITENS.FECP_STAR_BASE) 
								ELSE NULL END 																												"vBCFCPSTRet",
								CASE 
									WHEN (NFE_ITENS.FECP_STA_ALIQUOTA + NFE_ITENS.FECP_STAR_ALIQUOTA) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA_ALIQUOTA + NFE_ITENS.FECP_STAR_ALIQUOTA) 
								ELSE NULL END																												"pFCPSTRet",
								CASE 
									WHEN (NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR) > 0 
									THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR)	
							ELSE NULL END																													"vFCPSTRet"										
							WHERE (NFE_ITENS.FECP_STA + NFE_ITENS.FECP_STAR) > 0 
							
							FOR XML PATH(''), TYPE
						), 					
						--#61#
						(		
						--#71# - NF 1.60					
							SELECT																			
								case when @OPTANTE_ROT = 0 then CONVERT(NUMERIC(7,4),NFE_ITENS.pRedBCEfet) else 0 end			"pRedBCEfet", --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then NFE_ITENS.ICMS_EFET_BASE else 0 end					    		"vBCEfet",	  --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_EFET_ALIQUOTA)  else 0 end	"pICMSEfet",  --#73# /*#123#*/
								case when @OPTANTE_ROT = 0 then NFE_ITENS.ICMS_EFET_VALOR  else 0 end							"vICMSEfet"	  --#73# /*#123#*/

								--CASE WHEN NFE_ITENS.pRedBCEfet			> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.pRedBCEfet)			ELSE NULL	END		"pRedBCEfet",	--#73#
								--CASE WHEN NFE_ITENS.ICMS_EFET_BASE		> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_EFET_BASE)		ELSE NULL	END		"vBCEfet",		--#73#		
								--CASE WHEN NFE_ITENS.ICMS_EFET_ALIQUOTA	> 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_EFET_ALIQUOTA)		ELSE NULL	END		"pICMSEfet",	--#73#	
								--CASE WHEN NFE_ITENS.ICMS_EFET_VALOR		> 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_EFET_VALOR)		ELSE NULL	END		"vICMSEfet"		--#73#					
							WHERE ((NFE_ITENS.ICMS_EFET_VALOR) > 0 )  OR ((NFE_ITENS.ICMS_EFET_VALOR) = 0 AND  @OPTANTE_ROT=1 ) /*#123#*/

							
							FOR XML PATH(''), TYPE
						--#71# - NF 1.60	
						) 

						WHERE NFE_ITENS.TRIBUT_ICMS = '500' AND NFE.CRT = 1 -- Mesma parametrizacao do ICMS 60
						FOR XML PATH(''), TYPE				
	
					)   AS ICMSSN500,		
					
					--- ICMSSN900 (2.0)  ALTERADO EM 06/05/2011 APOS DEFINICAO COM CESTARI E FABIANO ARAUJO. USO DO SIMPLES_F NO LUGAR DO ICMS (AGUARDANDO DEFINICAO PORQUE DEU ERRO NA SEFAZ)
					( 
						SELECT 	RTRIM(NFE_ITENS.TRIBUT_ORIGEM)	"orig",
								RTRIM(NFE_ITENS.TRIBUT_ICMS)	"CSOSN",
								
							( SELECT

								3																"modBC",							-- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO)
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_BASE)						"vBC",
								CASE WHEN NFE_ITENS.PREDBC > 0 AND NFE_ITENS.ICMS > 0 
									THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBC) ELSE NULL END	"pRedBC",		-- PERCENTUAL DE REDUCAO DA MARGEM DE CALCULO (PORCENT_REDUCAO_DE_BASE)	--#13#
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)					"pICMS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS)							"vICMS"
								--WHERE NFE_ITENS.ICMS > 0
								FOR XML PATH(''), TYPE
							),

							( SELECT
									4																				"modBCST",
									CASE WHEN NFE_ITENS.PMVAST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PMVAST) ELSE NULL END					"pMVAST",						-- PEGAR DA PORCENTAGEM DO VALOR NEGATIVO(PORCENT_REDUCAO_DE_BASE) NO CASO DO ICMS ST --#13#
									CASE WHEN NFE_ITENS.PREDBCST > 0  
										THEN CONVERT(NUMERIC(7,4),NFE_ITENS.PREDBCST) ELSE NULL END					"pRedBCST",
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST_BASE + NFE_ITENS.ICMS_STR_BASE)			"vBCST",
									CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ST_ALIQUOTA + NFE_ITENS.ICMS_STR_ALIQUOTA)	"pICMSST",--#13#
									CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR)					"vICMSST"
									-- NAO POSSUI CONFORME CONVERSA COM JC																					
								WHERE (NFE_ITENS.ICMS_ST + NFE_ITENS.ICMS_STR) >= 0 AND NFE_ITENS.PMVAST IS NOT NULL
								FOR XML PATH(''), TYPE
							),
							--#61#	
							CASE WHEN NFE_ITENS.FECP_ST_BASE	 > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_BASE)		ELSE NULL END  "vBCFCPST",
							CASE WHEN NFE_ITENS.FECP_ST_ALIQUOTA > 0 THEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_ST_ALIQUOTA)	ELSE NULL END  "pFCPST",
							CASE WHEN NFE_ITENS.FECP_ST_VALOR    > 0 THEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_ST_VALOR)	ELSE NULL END  "vFCPST",								
							--#61#
							( SELECT
								CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_SN_ALIQUOTA)									"pCredSN",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_SN)											"vCredICMSSN"
								WHERE NFE_ITENS.ICMS_SN > 0
								FOR XML PATH(''), TYPE
							)	
							WHERE NFE_ITENS.TRIBUT_ICMS = '900' AND NFE.CRT = 1
							FOR XML PATH(''), TYPE										
					)   AS ICMSSN900
					
				 ----#42#   Inicio
				 ----Partilha do ICMS
				 --( 
					--	SELECT 	CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_BASE)							"vBCUFDest",
					--			CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_DEST_ALIQUOTA)					"pFCPUFDest",
					--			CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_DEST_ALIQUOTA)					"pICMSUFDest",
					--			CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_ALIQUOTA)						"pICMSInter",
					--			CONVERT(NUMERIC(7,4),NFE_ITENS.PART_ICMS_DEST_ALIQUOTA)				"pICMSInterPart",
					--			CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DEST_VALOR)					"vFCPUFDest",					
					--			CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_DEST_VALOR)					"vICMSUFDest",
					--			CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_ORIG_VALOR)					"vICMSUFRemet"
					--	WHERE NFE.ID_DESTINO_OPERACAO in (1)
					--	AND NFE.UF_EMITENTE <> NFE.UF
					--	AND SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) = '6'  
					--	AND NFE_ITENS.ICMS_DEST_ALIQUOTA > NFE_ITENS.ICMS_ALIQUOTA
					--	FOR XML PATH(''), TYPE
				 -- ) AS ICMSUFDest
				 -- --#42#   Fim 																										
				
				  WHERE (NFE_ITENS.ISS + NFE_ITENS.ISS_R = 0)							
				  FOR XML PATH(''), TYPE
				) AS ICMS,


				--- IPI --- VERIFICAR ONDE ENCONTRA A SITUACAO TRIBUTARIA DO IPI
				( SELECT  	
						RTRIM(NFE_ITENS.CODIGO_CLASSE_TRIBUTACAO)	"clEnq",					-- CRIADO CAMPO NA EXCECAO
						NULL										"CNPJProd",					-- VERIFICAR A NECESSIDADE. DESC.: CNPJ DO PRODUTOR DA MERCADORIA, QUANDO DIFERENTE DO EMITENTE. SOMENTE PARA OS CASOS DE EXPORTAÇÃO DIRETA OU INDIRETA.
						NULL										"cSelo",
						NULL										"qSelo",
						RTRIM(NFE_ITENS.CODIGO_ENQUADRAMENTO)		"cEnq",						-- CRIADO CAMPO NA EXCECAO

						
					--- IPITRIB POR BASE E ALIQUOTA
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_IPI)						"CST",
								CONVERT(NUMERIC(15,2),NFE_ITENS.IPI_BASE)		"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.IPI_ALIQUOTA)	"pIPI", --#13#
								NULL											"qUnid",				 
								NULL											"vUnid",				 
								CONVERT(NUMERIC(15,2),NFE_ITENS.IPI)			"vIPI"

						WHERE NFE_ITENS.CST_IPI IN ('00','49','50','99') AND NFE_ITENS.CODIGO_CLASSE_TRIBUTACAO IS NULL
						FOR XML PATH(''), TYPE				

					) AS IPITrib,
					
					--- IPITRIB POR QTDE E VALOR UNITARIO(BEBIDAS)
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_IPI)						"CST",
								NULL											"vBC",
								NULL											"pIPI",
								CONVERT(NUMERIC(16,4),NFE_ITENS.IPI_ALIQUOTA)	"qUnid",		-- UTILIZAR A ALIQUOTA DO IPI DA EXCECAO 
								CONVERT(NUMERIC(15,4),NFE_ITENS.IPI_BASE)		"vUnid",		-- QTDE NORMAL DO ITEM 
								CONVERT(NUMERIC(15,2),NFE_ITENS.IPI)			"vIPI"

						WHERE NFE_ITENS.CST_IPI IN ('00','49','50','99') AND NFE_ITENS.CODIGO_CLASSE_TRIBUTACAO IS NOT NULL
						FOR XML PATH(''), TYPE				
					) AS IPITrib,							


					--- IPINT
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_IPI)	"CST"
						
						WHERE NFE_ITENS.CST_IPI IN ('01','02','03','04','05','51','52','53','54','55')
						FOR XML PATH(''), TYPE				
					) AS IPINT


					WHERE --NFE_ITENS.IPI > 0 AND 
						NFE_ITENS.CST_IPI IN ('01','02','03','04','05','51','52','53','54','55','00','49','50','99')
						AND (NFE_ITENS.ISS + NFE_ITENS.ISS_R = 0)
					FOR XML PATH(''), TYPE			
				) AS IPI,

				--- II   (DEFINIR DE ONDE VIRÃO ESTAS INFORMAÇÕES)  IMPOSTO 7 -  IIMPORT 
				( SELECT	CONVERT(NUMERIC(15,2),NFE_ITENS.I_IMPORT_BASE)		"vBC",
							CONVERT(NUMERIC(15,2),vDespAdu)						"vDespAdu",  -- OK
							CONVERT(NUMERIC(15,2),NFE_ITENS.I_IMPORT)			"vII",
							CONVERT(NUMERIC(15,2),0)							"vIOF"		-- CONFORME CONVERSA JC E COMO NÃO TEMOS IOF, COLOCAR 0	
					WHERE NFE_ITENS.I_IMPORT >= 0
						AND (NFE_ITENS.ISS + NFE_ITENS.ISS_R = 0)
						AND SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) = '3' 
					FOR XML PATH(''), TYPE	
				) AS II,

				--- ISSQN  (0-1)  PEGAR O IMPOSTO 14-ISS OU 22-ISSR
				-- FOI QUEBRADO EM DOIS SELECTS PARA MOSTRAR OS DOIS TIPOS DE ISS (VISTO COM JC)
				(
					SELECT 		CONVERT(NUMERIC(15,2),NFE_ITENS.ISS_BASE)		"vBC",   
								CONVERT(NUMERIC(7,4),NFE_ITENS.ISS_ALIQUOTA)	"vAliq", --#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ISS)			"vISSQN",
								CASE WHEN NFE.ENDERECO <> NFE.ENTREGA_ENDERECO 
									THEN RTRIM(NFE.COD_MUNICIPIO_IBGE_ENTREGA) 
									ELSE RTRIM(NFE.COD_MUNICIPIO_IBGE) 
									 END										"cMunFG",		-- MUNICIPIO DO DESTINATARIO DO IBGE
								RTRIM(NFE_ITENS.COD_SERVICO)	"cListServ",	-- INCLUIDO CAMPO NO ITEM DA NOTA FISCAL **#19#
								RTRIM(NFE_ITENS.CST_ISS)						"indISS", --#15#
																				--"cServico",
								case when NFE.ENTREGA_UF = 'EX' then '9999999' else NFE.COD_MUNICIPIO_IBGE_ENTREGA end "cMun",
																				--"cPais",
							case	when RTRIM(NFE_ITENS.CST_ISS)='6' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS)
									when RTRIM(NFE_ITENS.CST_ISS)='7' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS) ELSE NULL END "nProcesso", --#15#
								
										
								--#3.1# - Nao informar este bloco,  campo não obrigatorios
																				--"vDeducao",
																				--"vOutro",
																				--"vDescIncond",
																				--"vDescCond",
																				--"vISSRet",
																				--"indISS",
																				--"cServico",
																				--"cMun",
																				--"cPais",
																				--"nProcesso",
																			
								--#3.1#
							case	when RTRIM(NFE_ITENS.CST_ISS)='6' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS)
									when RTRIM(NFE_ITENS.CST_ISS)='7' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS) ELSE NULL END "nProcesso", --#15#
								
							case	when ISNULL(NFE_ITENS.INDICADOR_INCENTIVO_ISS,0)=0 then 2  
									when NFE_ITENS.INDICADOR_INCENTIVO_ISS =0 then 2  
									else NFE_ITENS.INDICADOR_INCENTIVO_ISS end 		"indIncentivo" --#15#
								--RTRIM(NFE_ITENS.CST_ISS)						"cSitTrib"		-- (2.0) CÓDIGO DE TRIBUTAÇÃO DO ISSQN 009075 - criar CST especifico para isto em conversa com JC em 29/09/2010								


								--RTRIM(NFE_ITENS.CST_ISS)						"cSitTrib"		-- (2.0) CÓDIGO DE TRIBUTAÇÃO DO ISSQN 009075 - criar CST especifico para isto em conversa com JC em 29/09/2010
								

						WHERE NFE_ITENS.ISS > 0 
						FOR XML PATH(''), TYPE				
	
				) AS ISSQN,

				(
					SELECT 		CONVERT(NUMERIC(15,2),NFE_ITENS.ISS_R_BASE)		"vBC",   
								CONVERT(NUMERIC(7,4),NFE_ITENS.ISS_R_ALIQUOTA)	"vAliq",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.ISS_R)			"vISSQN",
								CASE WHEN NFE.ENDERECO <> NFE.ENTREGA_ENDERECO 
									THEN RTRIM(NFE.COD_MUNICIPIO_IBGE_ENTREGA) 
									ELSE RTRIM(NFE.COD_MUNICIPIO_IBGE) 
									 END										"cMunFG",		-- MUNICIPIO DO DESTINATARIO DO IBGE
								RTRIM(NFE_ITENS.COD_SERVICO)					"cListServ",	-- INCLUIDO CAMPO NO ITEM DA NOTA FISCAL
								RTRIM(NFE_ITENS.CST_ISS)						"indISS", --#15#
								
								
								--#3.1# - Nao informar este bloco,  campo não obrigatorios
																				--"vDeducao",
																				--"vOutro",
																				--"vDescIncond",
																				--"vDescCond",
																				--"vISSRet",
																				--"indISS",
																				--"cServico",
																				--"cMun",
																				--"cPais",
																				--"nProcesso",
																				--"indIncentivo",
								--#3.1#
							case	when RTRIM(NFE_ITENS.CST_ISS)='6' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS)
									when RTRIM(NFE_ITENS.CST_ISS)='7' then RTRIM(NFE_ITENS.NUMERO_PROCESSO_ISS) ELSE NULL END "nProcesso", --#15#
								
							case	when ISNULL(NFE_ITENS.INDICADOR_INCENTIVO_ISS,0)=0 then 2  
									when NFE_ITENS.INDICADOR_INCENTIVO_ISS =0 then 2  
									else NFE_ITENS.INDICADOR_INCENTIVO_ISS end 		"indIncentivo" --#15#
								--RTRIM(NFE_ITENS.CST_ISS)						"cSitTrib"		-- (2.0) CÓDIGO DE TRIBUTAÇÃO DO ISSQN 009075 - criar CST especifico para isto em conversa com JC em 29/09/2010								

						WHERE NFE_ITENS.ISS_R > 0
						FOR XML PATH(''), TYPE				
	
				) AS ISSQN,
				-- ISSQN

				--- PIS   
				( SELECT	
					--- PISALIQ
					( 
						SELECT	RTRIM(NFE_ITENS.CST_PIS)						"CST",			
								CONVERT(NUMERIC(15,2),NFE_ITENS.PIS_BASE)		"vBC"	,
								CONVERT(NUMERIC(7,4),NFE_ITENS.PIS_ALIQUOTA)	"pPIS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.PIS)			"vPIS"

						WHERE NFE_ITENS.CST_PIS IN ('01','02')
						FOR XML PATH(''), TYPE				
					) AS PISAliq,

					--- PISQTDE
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_PIS)						"CST",
								CONVERT(NUMERIC(16,4),NFE_ITENS.QTDE_ITEM)		"qBCProd",
								CONVERT(NUMERIC(15,4),NFE_ITENS.PIS_ALIQUOTA)	"vAliqProd",
								CONVERT(NUMERIC(15,2),NFE_ITENS.PIS)			"vPIS"

						WHERE NFE_ITENS.CST_PIS IN ('03')
						FOR XML PATH(''), TYPE				
					) AS PISQtde,

					--- PISNT
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_PIS)	"CST"
						
						WHERE NFE_ITENS.CST_PIS IN ('04','05','06','07','08','09')
						FOR XML PATH(''), TYPE				

					) AS PISNT,

					--- PISOUTR
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_PIS)						"CST", -- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO) - 
								CONVERT(NUMERIC(15,2),NFE_ITENS.PIS_BASE)		"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.PIS_ALIQUOTA)	"pPIS",--#13#
								--CONVERT(NUMERIC(16,4),NFE_ITENS.QTDE_ITEM)	"qBCProd"
								--CONVERT(NUMERIC(15,4),NFE_ITENS.PIS_ALIQUOTA)	"vAliqProd",   -- VERIFICAR O QUE COLOCAR
								CONVERT(NUMERIC(15,2),NFE_ITENS.PIS)			"vPIS"

						WHERE NFE_ITENS.CST_PIS IN ('99','49','50','51','52','53','54','55','56','60','61','62','63','64','65','66','67','70','71','72','73','74','75','98')
						FOR XML PATH(''), TYPE				
					) AS PISOutr

				  WHERE --NFE_ITENS.PIS > 0 AND 
					NFE_ITENS.CST_PIS IN ('01','02','03','04','05','06','07','08','09','99','49','50','51','52','53','54','55','56','60','61','62','63','64','65','66','67','70','71','72','73','74','75','98')
				  FOR XML PATH(''), TYPE
				) AS PIS,

				--- PISST   NAO POSSUI ESTE IMPOSTO PREVISTO AINDA (CONVERSA JC)
				(
					SELECT 		''	"vBC",
								''	"pPIS",
								''	"qBCProd",
								''	"vAliqProd",
								''	"vPIS"

						WHERE 1=2
						FOR XML PATH(''), TYPE				
	
				) AS PISST,
				
-------------------------------- COFINS ------------------------------------------
				--- COFINS  
				( SELECT	

					--- COFINSALIQ
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_COFINS)						"CST",			
								CONVERT(NUMERIC(15,2),NFE_ITENS.COFINS_BASE)	"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.COFINS_ALIQUOTA)	"pCOFINS",--#13#
								CONVERT(NUMERIC(15,2),NFE_ITENS.COFINS)			"vCOFINS"
						
						WHERE NFE_ITENS.CST_COFINS IN ('01','02')
						FOR XML PATH(''), TYPE				

					) AS COFINSAliq,
					
					--- COFINSQTDE
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_COFINS)							"CST",
								CONVERT(NUMERIC(16,4),NFE_ITENS.QTDE_ITEM)			"qBCProd",
								CONVERT(NUMERIC(15,4),NFE_ITENS.COFINS_ALIQUOTA)	"vAliqProd",
								CONVERT(NUMERIC(15,2),NFE_ITENS.COFINS)				"vCOFINS"
									
						WHERE NFE_ITENS.CST_COFINS IN ('03')
						FOR XML PATH(''), TYPE				

					) AS COFINSQtde,
				
					--- COFINSNT
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_COFINS)	"CST"
						
						WHERE NFE_ITENS.CST_COFINS IN ('04','05','06','07','08','09')
						FOR XML PATH(''), TYPE				

					) AS COFINSNT,
								
		
					--- COFINSOUTR
					( 
						SELECT 	RTRIM(NFE_ITENS.CST_COFINS)							"CST", -- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO) - RTRIM(NFE_ITENS.CST_COFINS)
								CONVERT(NUMERIC(15,2),NFE_ITENS.COFINS_BASE)		"vBC",
								CONVERT(NUMERIC(7,4),NFE_ITENS.COFINS_ALIQUOTA)		"pCOFINS",--#13#
								--CONVERT(NUMERIC(16,4),NFE_ITENS.QTDE_ITEM)		"qBCProd"
								--CONVERT(NUMERIC(15,4),NFE_ITENS.COFINS_ALIQUOTA)	"vAliqProd",
								CONVERT(NUMERIC(15,2),NFE_ITENS.COFINS)				"vCOFINS"

						WHERE	NFE_ITENS.CST_COFINS IN ('99','49','50','51','52','53','54','55','56','60','61','62','63','64','65','66','67','70','71','72','73','74','75','98')
						FOR XML PATH(''), TYPE				
					) AS COFINSOutr

				  WHERE	-- NFE_ITENS.COFINS > 0 AND 
						NFE_ITENS.CST_COFINS IN ('01','02','03','04','05','06','07','08','09','99','49','50','51','52','53','54','55','56','60','61','62','63','64','65','66','67','70','71','72','73','74','75','98')
				  FOR XML PATH(''), TYPE
				) AS COFINS,
				
				--- COFINSST    NAO POSSUI ESTE IMPOSTO PREVISTO AINDA (CONVERSA JC)
				(
					SELECT 		 -- DAQUI PARA BAIXO TODOS SAO NÃO OBRIGATORIOS(NO)
								''	"vBC",
								''	"pCOFINS",
								''	"qBCProd",
								''	"vAliqProd",
								''	"vCOFINS"

						WHERE 1 = 2
						FOR XML PATH(''), TYPE				
	
				) AS COFINSST,

				 --#42#   Inicio
				 --Partilha do ICMS
				( 
                        SELECT			CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_BASE)                                      "vBCUFDest",
										--#61#
										CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DEST_BASE)								    "vBCFCPUFDest",
										--#61#
                                        --#68#
									    CASE 
											WHEN CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_DEST_ALIQUOTA) = 0
												THEN NULL
											ELSE CONVERT(NUMERIC(7,4),NFE_ITENS.FECP_DEST_ALIQUOTA) 
										END																				 "pFCPUFDest",
                                        --#68#
									    CONVERT(NUMERIC(7,4),NFE_ITENS.ICMS_DEST_ALIQUOTA)                               "pICMSUFDest",
                                        CONVERT(NUMERIC(15,2),NFE_ITENS.ICMS_ALIQUOTA)                                   "pICMSInter", 
                                        CONVERT(NUMERIC(7,4),NFE_ITENS.PART_ICMS_DEST_ALIQUOTA)                          "pICMSInterPart",
                                        --#68#
										CASE 
											WHEN CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DEST_VALOR) = 0 
												THEN NULL
											ELSE CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DEST_VALOR) 
									    END																				 "vFCPUFDest",                            
                                        --#68#
									    CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_DEST_VALOR)								 "vICMSUFDest", -- +#52#                  
                                        -- CONVERT(NUMERIC(15,2),NFE_ITENS.FECP_DEST_VALOR)                                  --#43# #52#
                                        CONVERT(NUMERIC(15,2),NFE_ITENS.DICMS_ORIG_VALOR)                                "vICMSUFRemet"
						WHERE NFE.ID_DESTINO_OPERACAO = 2
						AND NFE.UF_EMITENTE <> NFE.UF
						--AND SUBSTRING(NFE_ITENS.CODIGO_FISCAL_OPERACAO,1,1) = '6' --#72#
						--AND NFE_ITENS.ICMS_DEST_ALIQUOTA > NFE_ITENS.ICMS_ALIQUOTA --#44#
						AND NFE.INDICADOR_IE_DESTINARARIO = 9 --#44#
						AND NFE_ITENS.DICMS_BASE > 0 --#48# #50# #56#
						FOR XML PATH(''), TYPE
				) AS ICMSUFDest,
				  --#42#   Fim
				  
-- #163# - Início

-------------------------------- IS ------------------------------------------
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE
		-- Informações do Imposto Seletivo
		-- IS				
				(	
					SELECT	RTRIM(NFE_ITENS.CST_IBS_CBS)								"CSTIS",			/* Código de Situação Tributária do Imposto Seletivo */
							RTRIM(NFE_ITENS.CCLASSTRIB)									"cClassTribIS",		/* Código de Classificação Tributária do Imposto Seletivo */
						
						--- GRUPO UB04
						( 
							SELECT 	CONVERT(NUMERIC(15,2),NFE_ITENS.IS_BASE)			"vBCIS",			/* Valor da Base de Cálculo do Imposto Seletivo */
									CONVERT(NUMERIC(7,4),NFE_ITENS.IS_ALIQUOTA)			"pIS",				/* Alíquota do Imposto Seletivo */
									NULL												"pISEspec",			/* Alíquota específica por unidade de medida apropriada */
						
							--- GRUPO UB08
							( 
								SELECT 	NULL											"uTrib",			/* Unidade de Medida Tributável */
										NULL											"qTrib",			/* Quantidade Tributável */
										CONVERT(NUMERIC(15,2),NFE_ITENS.IS_VALOR)		"vIS"				/* Valor do Imposto Seletivo */
						
								FOR XML PATH(''), TYPE				
							) AS ISUB08
		
							FOR XML PATH(''), TYPE				
						) AS ISUB04

					WHERE NFE_ITENS.IS_BASE > 0 
					FOR XML PATH('IS'),TYPE 
				) 
	END,

-------------------------------- IBSCBS ------------------------------------------
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE

		-- Informações do Imposto de Bens e Serviços - IBS e da Contribuição de Bens e Serviços - CBS
		-- IBSCBS				
				(	
					SELECT	RTRIM(NFE_ITENS.CST_IBS_CBS)												"CST",				/* Código de Situação Tributária do IBS e CBS */
							RTRIM(NFE_ITENS.CCLASSTRIB)													"cClassTrib",		/* Código de Classificação Tributária do IBS e CBS */
						
					--- gIBSCBS - Grupo de Informações do IBS e da CBS
					( 
						SELECT 		/* Base de cálculo do IBS e CBS */


/*
*#170# - Início - Ajuste no cálculo do vBC
/*#169# - Início - Inclusão do isnull*/
(						
CONVERT(NUMERIC(15,2), isnull(NFE_ITENS.VALOR_ITEM,0))																												
+	0																																						
+	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.FRETE,0)) 																	
+	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.SEGURO,0)) 																
+	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.ENCARGO,0)) 															
+	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.I_IMPORT,0))																												
-	(CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.VALOR_DESCONTOS,0)) -isnull( NFE_ITENS.ICMS_ZF,0) 	)
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.PIS,0))																											
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.COFINS,0))																											
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.ICMS,0))																											
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.DICMS_DEST_VALOR,0))																								
-	CASE WHEN (isnull(NFE_ITENS.FECP_VALOR,0) >= 0 AND isnull(NFE_ITENS.FECP_BASE,0) > 0)THEN CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.FECP_VALOR,0))   ELSE 0 END				
-	CONVERT(NUMERIC(15,2),isnull(NFE.FECP_DEST,0))										
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.ISS,0))																													
-	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IS_VALOR,0))	
)/*#169# - Fim - Inclusão do isnull*/
*/

						case WHEN ISNULL(NFE_ITENS.CBS_BASE,0) >0 
						THEN 
							ISNULL(NFE_ITENS.CBS_BASE,0)
						ELSE
							CASE WHEN ISNULL(NFE_ITENS.IBS_EST_BASE,0)>0  
							THEN  
								ISNULL(NFE_ITENS.IBS_EST_BASE,0) 
							ELSE
								CASE WHEN ISNULL(NFE_ITENS.IBS_MUN_BASE,0)>0  
								THEN  
									ISNULL(NFE_ITENS.IBS_MUN_BASE,0) 	
								ELSE 
									0 
								END
							END
						END	"vBC",				/* Base de cálculo do IBS e CBS */
--*#170# - Final - Ajuste no cálculo do vBC

						--- gIBSUF - Grupo de Informações do IBS para a UF
						( 
							SELECT 
								CASE WHEN CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_RED_ALIQ,0))<>0
									THEN 	
										CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_RED_ALIQ_ORIGINAL,0))
									ELSE
										CONVERT(NUMERIC(7,4),isnull(NFE_ITENS.IBS_EST_ALIQUOTA,0))	
									END /*#169#*//*#174#*/												"pIBSUF",			/* Alíquota do IBS de competência das UF */
						
							--- GRUPO UB19
							( 			
								SELECT 	null ,
								--- gDif - Grupo de Informações do Diferimento
								( 
									SELECT 	0.0		/*Exemplo*/									"pDif",				/* Percentual do diferimento */
											0.0		/*Exemplo*/									"vDif"				/* Valor do Diferimento */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDif,

								--- gDevTrib - Grupo de Informações da devolução de tributos
								( 
									SELECT 	0.0		/*Exemplo*/									"vDevTrib"			/* Valor do tributo devolvido */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDevTrib

								WHERE 1=2
								FOR XML PATH(''), TYPE				
							),
							--AS IBSCBSUB19, /*#168#*/

							--- gRed - Grupo de informações da redução da alíquota
							(	
								/*#174# - Início*/
								SELECT 	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_RED_ALIQ,0))				"pRedAliq",			/* Percentual da redução de alíquota do cClassTrib */									
										CONVERT(NUMERIC(7,4),ISNULL(NFE_ITENS.IBS_EST_ALIQUOTA,0))				"pAliqEfet"			/* Alíquota Efetiva do IBS de competência das UF que será aplicada a Base de Cálculo */								
								WHERE CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_RED_ALIQ,0))<>0
								/*#174# - Fim*/
								FOR XML PATH(''), TYPE				
							) AS gRed,

							CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_VALOR,0))/*#169#*/						"vIBSUF"			/* Valor do IBS de competência da UF */

							--WHERE NFE_ITENS.IBS_EST_VALOR > 0 /*#169#*/ 
							FOR XML PATH(''), TYPE				
						) AS gIBSUF,		

						--- gIBSMun - Grupo de Informações do IBS para o município
						( 
							SELECT 
									CASE WHEN CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_MUN_RED_ALIQ,0))<>0
									THEN 	
										CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_MUN_RED_ALIQ_ORIGINAL,0))
									ELSE
										CONVERT(NUMERIC(7,4),isnull(NFE_ITENS.IBS_MUN_ALIQUOTA,0))	
									END /*#169#*//*#174#*/													"pIBSMun",			/* Alíquota do IBS de competência do Município */
						

							--- GRUPO UB38
							( 	
								SELECT NULL,
								--- gDif - Grupo de Informações do Diferimento
								( 
									SELECT 	0.0		/*#169#*/												"pDif",				/* Percentual do diferimento */
											0.0		/*#169#*/												"vDif"				/* Valor do Diferimento */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDif,

								--- gDevTrib - Grupo de Informações da devolução de tributos
								( 
									SELECT 	0.0		/*Exemplo*/												"vDevTrib"			/* Valor do tributo devolvido */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDevTrib

								WHERE 1=2
								FOR XML PATH(''), TYPE				
							),
							--AS IBSCBSUB38,/*#168#*/

							--- gRed - Grupo de informações da redução da alíquota
							( 
								/*#174# - Início*/
								SELECT 	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_MUN_RED_ALIQ,0))			"pRedAliq",			/* Percentual da redução de alíquota do cClassTrib */
										CONVERT(NUMERIC(7,4),ISNULL(NFE_ITENS.IBS_MUN_ALIQUOTA,0))			"pAliqEfet"			/* Alíquota Efetiva do IBS de competência das UF que será aplicada a Base de Cálculo */								
								WHERE CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_MUN_RED_ALIQ,0))<>0
								/*#174# - Fim*/
								FOR XML PATH(''), TYPE		

							) AS gRed,

							CONVERT(NUMERIC(15,2),ISNULL(NFE_ITENS.IBS_MUN_VALOR,0))/*#169#*/					"vIBSMun"			/* Valor do IBS de competência do Município */

							--WHERE NFE_ITENS.IBS_MUN_VALOR > 0/*#169#*/
							FOR XML PATH(''), TYPE				
						) AS gIBSMun,		

--#178# - Início --#181# - Início*/
-- #176# - Início
CASE WHEN @MOSTRA_vIBS = 1 
	then 					
						CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_EST_VALOR,0)) +	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.IBS_MUN_VALOR,0))							
	else
		null
	end																											"vIBS"	,			/* Valor do IBS */
-- #176# - Fim
--#178# - Fim --#181# - Fim*/


						--- gCBS - Grupo de Informações da CBS
						( 
							SELECT 		CASE WHEN CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.CBS_RED_ALIQ,0))<>0
									THEN 	
										CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.CBS_RED_ALIQ_ORIGINAL,0))
									ELSE
										CONVERT(NUMERIC(7,4),isnull(NFE_ITENS.CBS_ALIQUOTA,0))	
									END /*#169#*//*#174#*/													"pCBS",			/* Alíquota da CBS */
																		
							--- GRUPO UB57
							( 	
								SELECT NULL,
								--- gDif - Grupo de Informações do Diferimento
								( 
									SELECT 	0.0		/*Exemplo*/									"pDif",				/* Percentual do diferimento */
											0.0		/*Exemplo*/									"vDif"				/* Valor do Diferimento */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDif,

								--- gDevTrib - Grupo de Informações da devolução de 
								( 
									SELECT 	0.0		/*Exemplo*/									"vDevTrib"			/* Valor do tributo devolvido */
									
									WHERE 1=2
									FOR XML PATH(''), TYPE				
								) AS gDevTrib

								WHERE 1=2
								FOR XML PATH(''), TYPE				
							) ,
							--AS IBSCBSUB57,/*#168#*/

							--- gRed - Grupo de informações da redução da alíquota
							( 
								/*#174# - Início*/
								SELECT 	CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.CBS_RED_ALIQ,0))			"pRedAliq",			/* Percentual da redução de alíquota do cClassTrib */
										CONVERT(NUMERIC(7,4),ISNULL(NFE_ITENS.CBS_ALIQUOTA,0))			"pAliqEfet"			/* Alíquota Efetiva do IBS de competência das UF que será aplicada a Base de Cálculo */								
								WHERE CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.CBS_RED_ALIQ,0))<>0
								/*#174# - Fim*/
								FOR XML PATH(''), TYPE				
							) AS gRed,

							CONVERT(NUMERIC(15,2),isnull(NFE_ITENS.CBS_VALOR,0))/*#169#*/							"vCBS"				/* Valor da CBS */

							--WHERE isnull(NFE_ITENS.CBS_VALOR,0) > 0 /*#169#*/
							FOR XML PATH(''), TYPE				
						) AS gCBS,	
	
						 	
						--- gTribRegular - Grupo de informações da Tributação Regular
						( 
							SELECT 	123		/*Exemplo*/											"CSTReg",			/* Código de Situação Tributária do IBS e CBS */
									123456	/*Exemplo*/											"cClassTribReg",	/* Código de Classificação Tributária do IBS e CBS */
									
									0.0		/*Exemplo*/											"pAliqEfetRegIBSUF",/* Valor da alíquota do IBS da UF */
									0.0		/*Exemplo*/											"vTribRegIBSUF",	/* Valor do Tributo do IBS da UF */
									
									0.0		/*Exemplo*/											"pAliqEfetRegIBSMun",/* Valor da alíquota do IBS do Município */
									0.0		/*Exemplo*/											"vTribRegIBSMun",	/* Valor do Tributo do IBS do Município */
									
									0.0		/*Exemplo*/											"pAliqEfetRegCBS",	/* Valor da alíquota da CBS */
									0.0		/*Exemplo*/											"vTribRegCBS"		/* Valor do Tributo da CBS */
						
							WHERE 1=2 
							FOR XML PATH(''), TYPE				
						) AS gTribRegular,	
						
						--- gIBSCredPres - Grupo de Informações do Crédito Presumido referente ao IBS
						( 
							SELECT 	12		/*Exemplo*/											"cCredPres",		/* Código de Classificação do Crédito Presumido */
									0.0		/*Exemplo*/											"pCredPres",		/* Percentual do Crédito Presumido */								
									0.0		/*Exemplo*/											"vCredPres",		/* Valor do Crédito Presumido */
									0.0		/*Exemplo*/											"vCredPresCondSus"	/* Valor do Crédito Presumido em condição suspensiva */
						
							WHERE 1=2 
							FOR XML PATH(''), TYPE				
						) AS gIBSCredPres,	

						--- gCBSCredPres - Grupo de Informações do Crédito Presumido referente a CBS
						( 
							SELECT 	12		/*Exemplo*/											"cCredPres",		/* Código de Classificação do Crédito Presumido */
									0.0		/*Exemplo*/											"pCredPres",		/* Percentual do Crédito Presumido */								
									0.0		/*Exemplo*/											"vCredPres",		/* Valor do Crédito Presumido */
									0.0		/*Exemplo*/											"vCredPresCondSus"	/* Valor do Crédito Presumido em condição suspensiva */
						
							WHERE 1=2 
							FOR XML PATH(''), TYPE				
						) AS gCBSCredPres,	

						--- gTribCompraGov - Grupo de informações da composição do valor do IBS e da CBS em compras governamentais
						( 
							SELECT 	0.0		/*Exemplo*/									"pAliqIBSUF",/*#176#*/		/* Alíquota do IBS de competência do Estado */
									0.0		/*Exemplo*/									"vTribIBSUF",/*#176#*/		/* Valor do Tributo do IBS da UF calculado */		
									
									0.0		/*Exemplo*/									"pAliqIBSMun",/*#176#*/		/* Alíquota do IBS de competência do Município */
									0.0		/*Exemplo*/									"vTribIBSMun",/*#176#*/		/* Valor do Tributo do IBS do Município calculado */

									0.0		/*Exemplo*/									"pAliqCBS",/*#176#*/		/* Alíquota da CBS */
									0.0		/*Exemplo*/									"vTribCBS"/*#176#*/			/* Valor do Tributo da CBS calculado */
						
							WHERE 1=2 
							FOR XML PATH(''), TYPE				
						) AS gTribCompraGov	

								--WHERE	(ISNULL(NFE_ITENS.IBS_EST_BASE,0) + ISNULL(NFE_ITENS.IBS_MUN_BASE,0) + ISNULL(NFE_ITENS.CBS_BASE,0)) > 0  /*#165#*//*#167#*/ 	/*#169#*/				
								FOR XML PATH(''), TYPE				
					) AS gIBSCBS,

					--- gIBSCBSMono - Grupo de Informações do IBS e CBS em operações com imposto monofásico
					( 
						SELECT
							--- GRUPO gMonoPadrao
							( 					
							SELECT 	0.0		/*Exemplo*/										"qBCMono",				/* Quantidade tributada na monofasia */
									0.0		/*Exemplo*/										"adRemIBS",				/* Alíquota ad rem do IBS */								
									0.0		/*Exemplo*/										"adRemCBS",				/* Alíquota ad rem da CBS */
									0.0		/*Exemplo*/										"vIBSMono",				/* Valor do IBS monofásico */
									0.0		/*Exemplo*/										"vCBSMono"				/* Valor da CBS monofásica */
								FOR XML PATH(''), TYPE				
							)
							AS gMonoPadrao, /*#176#*/																/* Grupo de informações da Tributação Monofásica Padrão */
						
							--- GRUPO gMonoReten
							( 					
								SELECT 	0.0		/*Exemplo*/								"qBCMonoReten",			/* Quantidade tributada sujeita à retenção na monofasia */
										0.0		/*Exemplo*/								"adRemIBSReten",		/* Alíquota ad rem do IBS sujeito a retenção */
										0.0		/*Exemplo*/								"vIBSMonoReten",		/* Valor do IBS monofásico sujeito a retenção */
										0.0		/*Exemplo*/								"adRemCBSReten",		/* Alíquota ad rem da CBS sujeito a retenção */
										0.0		/*Exemplo*/								"vCBSMonoReten"			/* Valor da CBS monofásica sujeita a retenção */	
								FOR XML PATH(''), TYPE				
							)
							AS gMonoReten,/*#168#*//*#176#*/														/* Grupo de informações da Tributação Monofásica Sujeita à Retenção */
						

							--- GRUPO gMonoRet
							( 					
								SELECT 	0.0		/*Exemplo*/								"qBCMonoRet",			/* Quantidade tributada retida anteriormente */
										0.0		/*Exemplo*/								"adRemIBSRet",			/* Alíquota ad rem do IBS retida anteriormente */
										0.0		/*Exemplo*/								"vIBSMonoRet",			/* Valor do IBS monofásico retida anteriormente */
										0.0		/*Exemplo*/								"adRemCBSRet",			/* Alíquota ad rem da CBS retida anteriormente */
										0.0		/*Exemplo*/								"vCBSMonoRet"			/* Valor da CBS monofásica retida anteriormente */	
								FOR XML PATH(''), TYPE				
							)
							AS gMonoRet,/*#168#*//*#176#*/														/* Grupo de informações da Tributação Monofásica Retida Anteriormente */

							--- GRUPO gMonoDif
							( 					
								SELECT 	0.0		/*Exemplo*/								"pDifIBS",				/* Percentual do diferimento do imposto monofásico */
										0.0		/*Exemplo*/								"vIBSMonoDif",			/* Valor do IBS monofásico diferido */
										0.0		/*Exemplo*/								"pDifCBS",				/* Percentual do diferimento do imposto monofásico */
										0.0		/*Exemplo*/								"vCBSMonoDif"			/* Valor da CBS Monofásica diferida */
								FOR XML PATH(''), TYPE				
							)
							AS gMonoDif,/*#168#*//*#176#*/													/* Grupo de informações do Diferimento da Tributação Monofásica */

		
							0.0		/*Exemplo*/											"vTotIBSMonoItem",		/* Total de IBS Monofásico */
							0.0		/*Exemplo*/											"vTotCBSMonoItem",		/* Total da CBS Monofásica */

							--- gTransfCred  - Transferências de Crédito
							( 					
								SELECT 	0.0		/*Exemplo*/								"vIBS",					/* Valor do IBS a ser transferido */
										0.0		/*Exemplo*/								"vCBS"					/* Valor da CBS a ser transferida */	
								FOR XML PATH(''), TYPE				
							) AS gTransfCred,

							--- gCredPresIBSZFM  - nformações do crédito presumido de IBS para fornecimentos a partir da ZFM
							( 					
								SELECT 	0		/*Exemplo*/								"tpCredPresIBSZFM",		/* Tipo de classificação de acordo com o art. 450, § 1º, da LC 214/25 para o cálculo do crédito presumido na ZFM */
										0.0		/*Exemplo*/								"vCredPresIBSZFM"		/* Valor do crédito presumido calculado sobre o saldo devedor apurado  */
								FOR XML PATH(''), TYPE				
							) AS gCredPresIBSZFM

						WHERE 1=2
						FOR XML PATH(''), TYPE				
					) AS gIBSCBSMono	

					--WHERE	(ISNULL(NFE_ITENS.IBS_EST_BASE,0) + ISNULL(NFE_ITENS.IBS_MUN_BASE,0) + ISNULL(NFE_ITENS.CBS_BASE,0)) > 0  /*#165#*/ /*#167#*/ /*#169#*/ /*#171#*/ /*#179#*/
					WHERE NFE_ITENS.CST_IBS_CBS IS NOT NULL AND NFE_ITENS.CBS_BASE IS NOT NULL /*#182#*/
					FOR XML PATH('IBSCBS'),TYPE 
				) --AS IBSCBS


	END
-- #163# - Fim


		FOR XML PATH(''), TYPE		
		
	) AS imposto,
------------ IMPOSTO

--#25# Samuel
------------ impostoDevol 
                    (    --IF @TIPO_DOC_CHAVE = 'L'  
							
								-- RETAGUARDA
								SELECT 
													(       SELECT   pDevol AS "pDevol" 
															FROM 
															( --SELECT       CONVERT(NUMERIC(3,2),(B.QTDE_DEVOLVIDA/C.QTDE_ITEM))*100 AS "pDevol" --#62# --#88#
															SELECT		CONVERT(NUMERIC(5,2),(SUM(B.QTDE_DEVOLVIDA)/SUM(C.QTDE_ITEM)))*100 AS "pDevol" --#90#
															FROM   #IMPRESSAO_NFE_ITENS  AS A --#152#
																	JOIN #FATURAMENTO_ENTRADA_DEVOLUCAO AS B --#152# --#156#
																			ON     A.NF=B.NF_SAIDA
																			AND    A.SERIE_NF=B.SERIE_NF
																			AND    A.FILIAL =B.FILIAL
																			AND    A.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_SAIDA
																			AND    A.SUB_ITEM_TAMANHO=B.SUB_ITEM_SAIDA
																	JOIN ENTRADAS_ITEM AS C
																			ON     C.NF_ENTRADA=B.NF_ENTRADA
																			AND    C.SERIE_NF_ENTRADA=B.SERIE_NF_ENTRADA
																			AND    C.NOME_CLIFOR=B.NOME_CLIFOR
																			AND    C.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_ENTRADA
																			AND    C.SUB_ITEM_TAMANHO=B.SUB_ITEM_ENTRADA
															WHERE  A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
															AND	   A.FILIAL		 = NFE_ITENS.FILIAL /*#149#*/
															AND    A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
															AND    A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
															AND    A.NF = NFE_ITENS.NF
															AND    A.SERIE_NF =NFE_ITENS.SERIE_NF
															--and  IPI > 0 /*#27#*/
															UNION
															SELECT CONVERT(NUMERIC(5,2),(SUM(B.QTDE_DEVOLVIDA)/SUM(B.QTDE_ITEM))*100) AS "pDevol" --#70#
															FROM   #IMPRESSAO_NFE_ITENS  AS A --#152#
																/*#39#*/
															JOIN	(	SELECT	--#118#
																				CASE WHEN Isnull(FT.CODIGO_CLIENTE_VAREJO, '') = '' THEN FED.NOME_CLIFOR
																					ELSE CV.CLIENTE_VAREJO 
																					END AS NOME_CLIFOR 
																				--#118#
																				,FED.NF_ENTRADA , FED.SERIE_NF_ENTRADA , FED.ITEM_IMPRESSAO_ENTRADA , FED.SUB_ITEM_ENTRADA,SUM(FED.QTDE_DEVOLVIDA) AS QTDE_DEVOLVIDA ,SUM(FI.QTDE_ITEM) AS QTDE_ITEM 
																		FROM	#FATURAMENTO_ENTRADA_DEVOLUCAO_SAIDA AS FED --#152# --#156#
																			JOIN FATURAMENTO_ITEM AS FI
																				ON	FED.FILIAL = FI.FILIAL 
																				AND	FED.NF_SAIDA = FI.NF_SAIDA 
																				AND	FED.SERIE_NF= FI.SERIE_NF 
																				AND	FED.SUB_ITEM_SAIDA = FI.SUB_ITEM_TAMANHO 
																				AND	FED.ITEM_IMPRESSAO_SAIDA = FI.ITEM_IMPRESSAO 
																			--#118#
																			JOIN FATURAMENTO AS FT
																				ON	FT.NF_SAIDA = FI.NF_SAIDA 
																				AND FT.SERIE_NF = FI.SERIE_NF 
																				AND FT.FILIAL  = FI.FILIAL 
																			LEFT JOIN CLIENTES_VAREJO CV
																				ON CV.CODIGO_CLIENTE = FT.CODIGO_CLIENTE_VAREJO
																			--#118#
																		GROUP BY FED.NOME_CLIFOR ,FED.NF_ENTRADA , FED.SERIE_NF_ENTRADA , FED.ITEM_IMPRESSAO_ENTRADA , FED.SUB_ITEM_ENTRADA,CV.CLIENTE_VAREJO,FT.CODIGO_CLIENTE_VAREJO ) AS B
																/*#39#*/
																ON     A.NF=B.NF_ENTRADA
																AND    A.SERIE_NF=B.SERIE_NF_ENTRADA
																AND    A.NOME_CLIFOR =B.NOME_CLIFOR
																AND    A.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_ENTRADA
																AND    A.SUB_ITEM_TAMANHO=B.SUB_ITEM_ENTRADA
															WHERE A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
															AND	   A.FILIAL		 = NFE_ITENS.FILIAL /*#149#*/
															AND    A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
															AND    A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
															AND    A.NF = NFE_ITENS.NF
															AND    A.SERIE_NF =NFE_ITENS.SERIE_NF
															--and  IPI > 0 /*#27#*/
															UNION
															--#88#
															SELECT	0.00 AS "pDevol"
															FROM	ENTRADAS_NF_AVULSA_REFERENCIADA
															WHERE	NF_ENTRADA=NFE_ITENS.NF
															AND		SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF
															AND		NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
															UNION
															--#89#
															SELECT	0.00 AS "pDevol"
															FROM	FATURAMENTO_NF_AVULSA_REFERENCIADA
															WHERE	NF_SAIDA=NFE_ITENS.NF
															AND		SERIE_NF = NFE_ITENS.SERIE_NF
															AND		FILIAL = NFE_ITENS.FILIAL
															--#88#
															UNION
															--#110#-Início
															SELECT top 1 0.00 AS "pDevol"
															FROM	FATURAMENTO_ITEM_RELACIONADO
															WHERE	NF_SAIDA = NFE_ITENS.NF
															AND		SERIE_NF = NFE_ITENS.SERIE_NF
															AND		FILIAL = NFE_ITENS.FILIAL
															--#110#-Fim
															UNION
															--#93#
															SELECT	100.00 AS "pDevol"
															FROM	ENTRADAS_ITEM
																LEFT JOIN #FATURAMENTO_ENTRADA_DEVOLUCAO_SAIDA FATURAMENTO_ENTRADA_DEVOLUCAO --#152# --#156#
																	ON     ENTRADAS_ITEM.NF_ENTRADA=FATURAMENTO_ENTRADA_DEVOLUCAO.NF_ENTRADA
																	AND    ENTRADAS_ITEM.SERIE_NF_ENTRADA=FATURAMENTO_ENTRADA_DEVOLUCAO.SERIE_NF_ENTRADA
																	AND    ENTRADAS_ITEM.NOME_CLIFOR=FATURAMENTO_ENTRADA_DEVOLUCAO.NOME_CLIFOR
																	AND    ENTRADAS_ITEM.ITEM_IMPRESSAO=FATURAMENTO_ENTRADA_DEVOLUCAO.ITEM_IMPRESSAO_ENTRADA
																	AND    ENTRADAS_ITEM.SUB_ITEM_TAMANHO=FATURAMENTO_ENTRADA_DEVOLUCAO.SUB_ITEM_ENTRADA
															WHERE	ENTRADAS_ITEM.NF_ENTRADA=NFE_ITENS.NF
															AND		ENTRADAS_ITEM.SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF
															AND		ENTRADAS_ITEM.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
															AND		ENTRADAS_ITEM.ITEM_IMPRESSAO =NFE_ITENS.ITEM_IMPRESSAO
															AND		ENTRADAS_ITEM.SUB_ITEM_TAMANHO =NFE_ITENS.SUB_ITEM_TAMANHO
															AND		FATURAMENTO_ENTRADA_DEVOLUCAO.NF_ENTRADA IS NULL 
															AND		NFE_ITENS.CODIGO_FISCAL_OPERACAO IN ('1201','1202','1410','1411','5921','6921')
															--#107#
															AND     NOT EXISTS (	SELECT	top 1 *
																					FROM	ENTRADAS_NF_AVULSA_REFERENCIADA
																					WHERE	NF_ENTRADA=NFE_ITENS.NF
																					AND		SERIE_NF_ENTRADA = NFE_ITENS.SERIE_NF
																					AND		NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR)
															--#107#
															--#93#
															UNION
															--#29#
															--LOJA
															--#82# Implementado o SUM
															SELECT CONVERT(NUMERIC(5,2), (SUM(A.QTDE_ITEM)/SUM(H.QTDE_ITEM))) * 100 AS "pDevol"
															FROM #IMPRESSAO_NFE_ITENS A --#152#
																INNER JOIN FILIAIS B 
																ON A.FILIAL = B.FILIAL
																INNER join LOJAS_VAREJO LV -- #95#
																on B.FILIAL = LV.FILIAL 
																INNER JOIN LOJA_VENDA_PGTO C 
																ON A.NF = C.NUMERO_FISCAL_TROCA 
																AND A.SERIE_NF = C.SERIE_NF_ENTRADA 
																AND LV.CODIGO_FILIAL = C.CODIGO_FILIAL --#95#
																INNER JOIN LOJA_VENDA D ON C.LANCAMENTO_CAIXA = D.LANCAMENTO_CAIXA 
																AND C.CODIGO_FILIAL = D.CODIGO_FILIAL
																CROSS APPLY (SELECT DISTINCT TRO.CODIGO_FILIAL, TRO.TICKET, 
																TRO.CODIGO_FILIAL_ORIGEM, TRO.TICKET_ORIGEM,  TRO.DATA_VENDA_ORIGEM --#94#  
																			 FROM LOJA_VENDA_TROCA_ORIGEM TRO 
																			 WHERE
																			 TRO.CODIGO_FILIAL = D.CODIGO_FILIAL 
																			 AND TRO.TICKET = D.TICKET 
																			 AND  TRO.DATA_VENDA = D.DATA_VENDA ) E --#84# #94#
																INNER JOIN LOJA_VENDA F ON E.TICKET_ORIGEM = F.TICKET 
																AND E.CODIGO_FILIAL_ORIGEM = F.CODIGO_FILIAL  
																AND F.DATA_VENDA = E.DATA_VENDA_ORIGEM --#94#
																INNER JOIN LOJA_VENDA_PGTO G ON F.LANCAMENTO_CAIXA = G.LANCAMENTO_CAIXA 
																AND F.CODIGO_FILIAL = G.CODIGO_FILIAL
																INNER JOIN LOJA_NOTA_FISCAL_ITEM H ON G.NUMERO_FISCAL_VENDA = H.NF_NUMERO 
																AND G.SERIE_NF_SAIDA = H.SERIE_NF 
																AND G.CODIGO_FILIAL = H.CODIGO_FILIAL
																AND A.CODIGO_ITEM = H.CODIGO_ITEM -- #84# 
																WHERE      A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
																	AND	   A.FILIAL		 = NFE_ITENS.FILIAL /*#149#*/
																	AND    A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
																	AND    A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
																	AND    A.NF = NFE_ITENS.NF
																	AND    A.SERIE_NF =NFE_ITENS.SERIE_NF
																	AND	   A.NF = @NOTAFISCAL --#84#
																	AND    A.SERIE_NF =@SERIENOTA --#84#
																	--and  IPI > 0
																	) IPI_DEVOLUCAO

															FOR XML PATH(''), TYPE    
													 ) , 
													(	 
														 --#61#
														 SELECT CONVERT(NUMERIC(15,2),ISNULL(NFE_ITENS.IPI_E,0)) AS "vIPIDevol" 
														 --WHERE NFE.IPI_E > 0
														 FOR XML PATH(''), TYPE 

														 	  )   AS    IPI
													--#109#-#110#-
													WHERE	NFE.FIN_EMISSAO_NFE = 4 
													AND		NFE.TIPO_OPERACAO='D' --#85#
													--and NFE_ITENS.IPI > 0 /*#27# #31#*/ --#70#

													--#34#						
													--AND  EXISTS(	SELECT  1
													--				FROM	W_IMPRESSAO_NFE_ITENS  AS A
													--			JOIN FATURAMENTO_ENTRADA_DEVOLUCAO AS B
													--				ON     A.NF=B.NF_SAIDA
													--				AND    A.SERIE_NF=B.SERIE_NF
													--				AND    A.FILIAL =B.FILIAL
													--				AND    A.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_SAIDA
													--				AND    A.SUB_ITEM_TAMANHO=B.SUB_ITEM_SAIDA
													--			JOIN ENTRADAS_ITEM AS C
													--				ON     C.NF_ENTRADA=B.NF_ENTRADA
													--				AND    C.SERIE_NF_ENTRADA=B.SERIE_NF_ENTRADA
													--				AND    C.NOME_CLIFOR=B.NOME_CLIFOR
													--				AND    C.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_ENTRADA
													--				AND    C.SUB_ITEM_TAMANHO=B.SUB_ITEM_ENTRADA
													--		WHERE	A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
													--		AND		A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
													--		AND		A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
													--		AND		A.NF = NFE_ITENS.NF
													--		AND     A.SERIE_NF =NFE_ITENS.SERIE_NF
													--		AND		A.FILIAL = NFE_ITENS.FILIAL --#62#
													--		--AND  IPI > 0 
													--		UNION
													--		SELECT 1
													--		FROM   W_IMPRESSAO_NFE_ITENS  AS A
													--				JOIN FATURAMENTO_ENTRADA_DEVOLUCAO AS B
													--						ON     A.NF=B.NF_ENTRADA
													--						AND    A.SERIE_NF=B.SERIE_NF_ENTRADA
													--						AND    A.NOME_CLIFOR =B.NOME_CLIFOR
													--						AND    A.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_ENTRADA
													--						AND    A.SUB_ITEM_TAMANHO=B.SUB_ITEM_ENTRADA
													--				JOIN FATURAMENTO_ITEM AS C
													--						ON     C.NF_SAIDA=B.NF_SAIDA
													--						AND    C.SERIE_NF=B.SERIE_NF
													--						AND    C.FILIAL=B.FILIAL
													--						AND    C.ITEM_IMPRESSAO=B.ITEM_IMPRESSAO_SAIDA
													--						AND    C.SUB_ITEM_TAMANHO=B.SUB_ITEM_SAIDA

													--		WHERE A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
													--		AND    A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
													--		AND    A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
													--		AND    A.NF = NFE_ITENS.NF
													--		AND    A.SERIE_NF =NFE_ITENS.SERIE_NF
													--		AND	   A.FILIAL = NFE_ITENS.FILIAL --#62#
													--		--and  IPI > 0 

													--		UNION
													--		--#29#
													--		--LOJA
													--		SELECT 1
													--		FROM W_IMPRESSAO_NFE_ITENS A
													--			INNER JOIN FILIAIS B ON A.FILIAL = B.FILIAL
													--			INNER JOIN LOJA_VENDA_PGTO C ON A.NF = C.NUMERO_FISCAL_TROCA AND A.serie_nf = C.SERIE_NF_ENTRADA AND B.COD_FILIAL = C.CODIGO_FILIAL
													--			INNER JOIN LOJA_VENDA D ON C.LANCAMENTO_CAIXA = D.LANCAMENTO_CAIXA AND C.CODIGO_FILIAL = D.CODIGO_FILIAL
													--			INNER JOIN LOJA_VENDA_TROCA_ORIGEM E ON D.TICKET = E.TICKET AND D.CODIGO_FILIAL = E.CODIGO_FILIAL
													--			INNER JOIN LOJA_VENDA F ON E.TICKET_ORIGEM = F.TICKET AND E.CODIGO_FILIAL_ORIGEM = F.CODIGO_FILIAL
													--			INNER JOIN LOJA_VENDA_PGTO G ON F.LANCAMENTO_CAIXA = G.LANCAMENTO_CAIXA AND F.CODIGO_FILIAL = G.CODIGO_FILIAL
													--			INNER JOIN LOJA_NOTA_FISCAL_ITEM H ON G.NUMERO_FISCAL_VENDA = H.NF_NUMERO AND G.SERIE_NF_SAIDA = H.SERIE_NF AND G.CODIGO_FILIAL = H.CODIGO_FILIAL AND A.ITEM_IMPRESSAO = H.ITEM_IMPRESSAO
													--			WHERE      A.NOME_CLIFOR = NFE_ITENS.NOME_CLIFOR
													--				AND    A.ITEM_IMPRESSAO = NFE_ITENS.ITEM_IMPRESSAO
													--				AND    A.SUB_ITEM_TAMANHO = NFE_ITENS.SUB_ITEM_TAMANHO
													--				AND    A.NF = NFE_ITENS.NF
													--				AND    A.SERIE_NF =NFE_ITENS.SERIE_NF
													--				AND	   A.FILIAL = NFE_ITENS.FILIAL --#62#
													--				--and  IPI > 0
													--				)
									
												FOR XML PATH(''), TYPE   
												--#61#
   
								         
						
					
					) AS   impostoDevol,  
------------ impostoDevol 
--#25#

		-- #97# - Início
			/*
			------------- INFADPROD		
			case when DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE_ITENS.INFORMACAO_ADICIONAL_PROD) = '' --#67#
				then null 
			else DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE_ITENS.INFORMACAO_ADICIONAL_PROD) end as "infAdProd"
			------------- INFADPROD	
			*/
			case when (NFE_ITENS.INFORMACAO_ADICIONAL_PROD = '' and @UF_EMITENTE <> 'RJ') 											--#152#
				   or (NFE_ITENS.INFORMACAO_ADICIONAL_PROD = '' and @UF_EMITENTE='RJ' and @INF_AD_ALIQ_PROD_NA_OBS=1) then --#124#	--#152#
				null
			else
				case when
					 @UF_EMITENTE = 'RJ' 
					 and  NFE_ITENS.FECP_BASE = 0										/*  <- Trecho usado na gravação da tag vBCFCP   */
					 and  NFE_ITENS.FECP_ALIQUOTA = 0									/*  <- Trecho usado na gravação da tag pFCP     */						
					 and (NFE_ITENS.FECP_VALOR >= 0 and NFE_ITENS.FECP_BASE = 0)        /*  <- Trecho usado na gravação da tag vFCP     */
					 and (NFE_ITENS.FECP_ST_BASE     + NFE_ITENS.FECP_STR_BASE = 0)		/*  <- Trecho usado na gravação da tag vBCFCPST */	
					 and (NFE_ITENS.FECP_ST_ALIQUOTA + NFE_ITENS.FECP_STR_ALIQUOTA = 0) /*  <- Trecho usado na gravação da tag pFCPST   */
					 and (NFE_ITENS.FECP_ST_VALOR    + NFE_ITENS.FECP_STR_VALOR = 0)    /*  <- Trecho usado na gravação da tag vFCPST   */ 
				then
					case when NFE_ITENS.INFORMACAO_ADICIONAL_PROD = '' AND @INF_AD_ALIQ_PROD_NA_OBS=0 then	--#152#
						 'Nao ha Cobranca em favor do Fundo Estadual de Combate a Pobreza e as Desigualdades Sociais - FECP para o produto eou Servico comercializado, conforme dispoe a Lei 8405 2019' -- #131#	--#152#
					else
					     --#98#-
						 --#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,rtrim(ltrim(NFE_ITENS.INFORMACAO_ADICIONAL_PROD))) + CASE WHEN @INF_AD_ALIQ_PROD_NA_OBS=0 THEN ' ' + DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,'Não há Cobrança em favor do Fundo Estadual de Combate à Pobreza e às Desigualdades Sociais - FECP para o produto e/ou Serviço comercializado, conforme dispõe a Lei 8.405/2019.') ELSE '' END -- #119# -- #131#
						 rtrim(ltrim(NFE_ITENS.INFORMACAO_ADICIONAL_PROD)) + CASE WHEN @INF_AD_ALIQ_PROD_NA_OBS=0 THEN ' ' + 'NAO HA COBRANCA EM FAVOR DO FUNDO ESTADUAL DE COMBATE A POBREZA E AS DESIGUALDADES SOCIAIS - FECP PARA O PRODUTO E/OU SERVICO COMERCIALIZADO, CONFORME DISPOE A LEI 8405 2019.' ELSE '' END -- #119# -- #131#
					end
				else
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(default,NFE_ITENS.INFORMACAO_ADICIONAL_PROD)
					NFE_ITENS.INFORMACAO_ADICIONAL_PROD
				end
			end as "infAdProd",

 			--INICIO #137#
            CASE WHEN (LTRIM(RTRIM(NFE_ITENS.OBS_CONTRIB_NOME)) <> '' AND LTRIM(RTRIM(NFE_ITENS.OBS_CONTRIB_CONTEUDO)) <> '')
				THEN
					(
 						SELECT	LTRIM(RTRIM(NFE_ITENS.OBS_CONTRIB_NOME))		AS "@xCampo",  --#138#
								--NFE_ITENS.OBS_CONTRIB_CONTEUDO	AS xTexto
								LTRIM(RTRIM(NFE_ITENS.OBS_CONTRIB_CONTEUDO)) AS xTexto	--#152#
						FOR XML PATH('obsCont'), TYPE	
					) 
				ELSE
					NULL
				END AS "obsItem",
            CASE WHEN (LTRIM(RTRIM(NFE_ITENS.OBS_FISCO_NOME)) <> '' AND LTRIM(RTRIM(NFE_ITENS.OBS_FISCO_CONTEUDO)) <> '')
				THEN  
					(
						SELECT	LTRIM(RTRIM(NFE_ITENS.OBS_FISCO_NOME))			AS "@xCampo", --#138#
								--NFE_ITENS.OBS_FISCO_CONTEUDO		AS xTexto
								rtrim(ltrim(NFE_ITENS.OBS_FISCO_CONTEUDO)) AS xTexto	--#152#
						FOR XML PATH('obsFisco'), TYPE		
					)
				ELSE
					NULL
				END AS "obsItem"
			--FINAL  #137#
		-- #97# - Fim
		
		-- #183# - Início /*#184#*/
		,CASE WHEN NFE_ITENS.CST_IBS_CBS IS NOT NULL AND NFE_ITENS.CBS_BASE IS NOT NULL 
			  THEN CONVERT(NUMERIC(15,2), NFE_ITENS.VALOR_ITEM) 
			  ELSE NULL END as "vItem"
		-- #183# - Fim	 /*#184#*/

		FROM  #IMPRESSAO_NFE_ITENS NFE_ITENS --#152#
		WHERE  NF = @NOTAFISCAL  AND 
				SERIE_NF = @SERIENOTA AND 
				FILIAL = @FILIALNOTA
		ORDER BY NFE_ITENS.ITEM_NFE

		FOR XML PATH('det'), TYPE
		),
------- DET

------- TOTAL
		(	
			SELECT 

-------------ICMSTOT		
			(
				SELECT 
	
					CONVERT(NUMERIC(15,2),NFE.ICMS_BASE)																		"vBC",
					CONVERT(NUMERIC(15,2),case when NFE.ICMS_BST > 0 then (NFE.ICMS-NFE.ICMS_BST) else NFE.ICMS end)	  	  "vICMS", --#21#-#108#
					--#99#-Início	
					CONVERT(NUMERIC(15,2),case when NFE.ICMS_ZF > 0 then NFE.ICMS_ZF when NFE.ICMS_DESONERADO > 0 then NFE.ICMS_DESONERADO else 0 end)				"vICMSDeson",
					--#99#-Fim
					--#68#
					CASE 
						WHEN CONVERT(NUMERIC(15,2),NFE.FECP_DEST) = 0															  
							THEN NULL
						ELSE CONVERT(NUMERIC(15,2),NFE.FECP_DEST)
					END																											"vFCPUFDest", --#42#
					--#68#
					CONVERT(NUMERIC(15,2),NFE.DICMS_DEST)																		"vICMSUFDest",--+ CONVERT(NUMERIC(15,2),NFE.FECP_DEST) "vICMSUFDest", --#42# #43#	#52#				 
					CONVERT(NUMERIC(15,2),NFE.DICMS_ORIG)																		"vICMSUFRemet", --#42#  						
					
					CONVERT(NUMERIC(15,2),NFE.FECP)																			    "vFCP",  --#61#	
					
					--CONVERT(NUMERIC(15,2),NFE.ICMS_ST_BASE+NFE.ICMS_STR_BASE+NFE.ICMS_SNST_BASE)								"vBCST", --#30# --#37# 
					CONVERT(NUMERIC(15,2),NFE.ICMS_ST_BASE+NFE.ICMS_STR_BASE)													"vBCST", --#38# 
					CONVERT(NUMERIC(15,2),NFE.ICMS_ST+NFE.ICMS_STR)																"vST",   --#38#
					CONVERT(NUMERIC(15,2),NFE.FECP_ST+NFE.FECP_STR)																"vFCPST", --#75#
					--#61#
					--CONVERT(NUMERIC(15,2),NFE.ICMS_ST+NFE.ICMS_STR+NFE.ICMS_SNST)												"vST",   --#30# --#37# 

					CONVERT(NUMERIC(15,2),NFE.FECP_STA + NFE.FECP_STAR)															"vFCPSTRet", --#61#
					
					CONVERT(NUMERIC(15,2),ABS(NFE.VALOR_SUB_ITENS - NFE.VALOR_SUB_ITENS_BRUTO))									"vProd",
					CONVERT(NUMERIC(15,2),NFE.FRETE)																			"vFrete",
					CONVERT(NUMERIC(15,2),NFE.SEGURO)																			"vSeg",
					CONVERT(NUMERIC(15,2),NFE.DESCONTO + NFE.DESCONTO_COND_PGTO +/*#16# NFE.ICMS_ZF #16#+*/ NFE.PIS_ZF + NFE.COFINS_ZF)	"vDesc",
					CONVERT(NUMERIC(15,2),NFE.I_IMPORT)																			"vII",
					CONVERT(NUMERIC(15,2),NFE.IPI)																				"vIPI",					
					--#61#
					CONVERT(NUMERIC(15,2),ISNULL(NFE.IPI_E,0))																    "vIPIDevol",
					--#61#
					CONVERT(NUMERIC(15,2),ABS(NFE.PIS - NFE.PIS_SOBRE_SERVICO))													"vPIS",
					CONVERT(NUMERIC(15,2),ABS(NFE.COFINS - NFE.COFINS_SOBRE_SERVICO))											"vCOFINS",
					CONVERT(NUMERIC(15,2),NFE.ENCARGO)																			"vOutro", -- NFE.VALOR_IMPOSTO_AGREGAR
					CONVERT(NUMERIC(15,2),NFE.VALOR_TOTAL)																		"vNF"
					--#2#
					,CONVERT(NUMERIC(15,2),@VALOR_IMPOSTO_ITEM)																	"vTotTrib"
					--#2#

					FOR XML PATH(''), TYPE

			) AS ICMSTot,
-------------ICMSTOT
	
-------------ISSQNTOT	   0 OU 1	    --- ACORDADO COM CESTARI
			(
				SELECT	CASE WHEN NFE.VALOR_SUB_ITENS_BRUTO > 0 THEN  CONVERT(NUMERIC(15,2),NFE.VALOR_SUB_ITENS_BRUTO) ELSE NULL END "vServ",
						CASE WHEN NFE.ISS_BASE  > 0 THEN CONVERT(NUMERIC(15,2),NFE.ISS_BASE) ELSE NULL END							 "vBC",
						CASE WHEN NFE.ISS  > 0 THEN CONVERT(NUMERIC(15,2),NFE.ISS) ELSE NULL END									 "vISS",
						CASE WHEN NFE.PIS_SOBRE_SERVICO  > 0 THEN CONVERT(NUMERIC(15,2),NFE.PIS_SOBRE_SERVICO) ELSE NULL END		 "vPIS",
						CASE WHEN NFE.COFINS_SOBRE_SERVICO  > 0 THEN CONVERT(NUMERIC(15,2),NFE.COFINS_SOBRE_SERVICO) ELSE NULL END	 "vCOFINS",
						convert(varchar(10),NFE.EMISSAO,127) "dCompet" --#19#
				WHERE NFE.ISS > 0
				FOR XML PATH(''), TYPE

			) AS ISSQNtot,
			(
				SELECT CASE WHEN NFE.VALOR_SUB_ITENS > 0 THEN  CONVERT(NUMERIC(15,2),NFE.VALOR_SUB_ITENS_BRUTO) ELSE NULL END		"vServ", --#20#
						CASE WHEN NFE.ISS_R_BASE > 0 THEN  CONVERT(NUMERIC(15,2),NFE.ISS_R_BASE) ELSE NULL END						"vBC",
						CASE WHEN NFE.ISS_R > 0 THEN  CONVERT(NUMERIC(15,2),NFE.ISS_R) ELSE NULL END								"vISS",
						CASE WHEN NFE.PIS_SOBRE_SERVICO > 0 THEN  CONVERT(NUMERIC(15,2),NFE.PIS_SOBRE_SERVICO) ELSE NULL END		"vPIS",
						CASE WHEN NFE.COFINS_SOBRE_SERVICO > 0 THEN  CONVERT(NUMERIC(15,2),NFE.COFINS_SOBRE_SERVICO) ELSE NULL END	"vCOFINS",
						convert(varchar(10),NFE.EMISSAO,127) "dCompet" 
				WHERE NFE.ISS_R > 0
				FOR XML PATH(''), TYPE

			) AS ISSQNtot,
-------------ISSQNTOT

-------------RETTRIB		0 OU 1		
			(
				SELECT  CASE WHEN NFE.PIS_S > 0 THEN CONVERT(NUMERIC(15,2),NFE.PIS_S) ELSE NULL END									"vRetPIS",
						CASE WHEN NFE.COFINS_S > 0 THEN CONVERT(NUMERIC(15,2),NFE.COFINS_S) ELSE NULL END 							"vRetCOFINS",
						CASE WHEN NFE.CSLL_S > 0 THEN CONVERT(NUMERIC(15,2),NFE.CSLL_S) ELSE NULL END								"vRetCSLL",
						CASE WHEN NFE.IRRF_BASE > 0 THEN CONVERT(NUMERIC(15,2),NFE.IRRF_BASE) ELSE NULL END							"vBCIRRF",
						CASE WHEN NFE.IRRF > 0 THEN CONVERT(NUMERIC(15,2),NFE.IRRF) ELSE NULL END									"vIRRF",
						CASE WHEN NFE.INSS_BASE > 0 THEN CONVERT(NUMERIC(15,2),NFE.INSS_BASE) ELSE NULL END							"vBCRetPrev",
 						CASE WHEN NFE.INSS > 0 THEN CONVERT(NUMERIC(15,2),NFE.INSS) ELSE NULL END									"vRetPrev"

					WHERE (NFE.PIS_S+NFE.COFINS_S+NFE.CSLL_S+NFE.IRRF_BASE+NFE.IRRF+NFE.INSS_BASE+NFE.INSS) > 0
					FOR XML PATH(''), TYPE

			) AS retTrib,
-------------ISSQNTOT

-- #163# - Início

-------------------------------- ISTot ------------------------------------------
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE
		-- 
		-- ISTot - Grupo total do imposto seletivo			
				(	
					SELECT	CASE WHEN NFE.IS_VALOR > 0 THEN CONVERT(NUMERIC(15,2),NFE.IS_VALOR) ELSE NULL END		"vIS"				/* Total do imposto seletivo */
		
					WHERE NFE.IS_VALOR > 0
					FOR XML PATH('ISTot'),TYPE 
				) 
END,
-------------------------------- IBSCBSTot ------------------------------------------
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE

		-- 
		-- IBSCBSTot - Totais da NF-e com IBS e CBS			
				(	
					SELECT	/*CASE WHEN (NFE.IBS_EST_BASE+NFE.IBS_MUN_BASE+NFE.CBS_BASE) > 0  
							THEN CONVERT(NUMERIC(15,2),NFE.IBS_EST_BASE+NFE.IBS_MUN_BASE+NFE.CBS_BASE)  
							ELSE NULL END*//*#180#*/
							CASE WHEN (NFE.IBS_EST_BASE) > 0  
							THEN CONVERT(NUMERIC(15,2),NFE.IBS_EST_BASE)  
							ELSE NULL END
																					"vBCIBSCBS",		/* Valor total da BC do IBS e da CBS */
	
					--- GRUPO gIBS - Grupo total do IBS
					( 
						SELECT NULL,
						--- GRUPO gIBSUF - Grupo total do IBS da UF
						( 
							SELECT	0.00											"vDif",				/* Valor total do diferimento */
									0.00											"vDevTrib",			/* Valor total de devolução de tributos */
									CASE WHEN NFE.IBS_EST_VALOR > 0 THEN CONVERT(NUMERIC(15,2),NFE.IBS_EST_VALOR) ELSE NULL END		
																					"vIBSUF"			/* Valor total do IBS da UF */
									
							FOR XML PATH(''), TYPE				
						) AS gIBSUF,

						--- GRUPO gIBSMun - Grupo total do IBS do Município
						( 
							SELECT	0.00											"vDif",				/* Valor total do diferimento */
									0.00											"vDevTrib",			/* Valor total de devolução de tributos */
									CASE WHEN ISNULL(NFE.IBS_MUN_VALOR,0) > 0 THEN CONVERT(NUMERIC(15,2),NFE.IBS_MUN_VALOR) ELSE 0.00 END			
																					"vIBSMun"			/* Valor total do IBS do Município */
							
							FOR XML PATH(''), TYPE				
						) AS gIBSMun,

						CONVERT(NUMERIC(15,2),NFE.IBS_EST_VALOR+NFE.IBS_MUN_VALOR)	"vIBS",				/* Valor total do IBS */
						0.00														"vCredPres",		/* Valor total do crédito presumido */
						0.00													"vCredPresCondSus"	/* Valor total do crédito presumido em condição suspensiva */

						WHERE NFE.IBS_EST_VALOR > 0 OR 	NFE.IBS_MUN_VALOR > 0
						FOR XML PATH(''), TYPE				
					) AS gIBS,

					--- GRUPO gCBS - Grupo total da CBS
					( 
						SELECT	0.00												"vDif",					/* Valor total do diferimento */
								0.00												"vDevTrib",				/* Valor total de devolução de tributos */
								CASE WHEN NFE.CBS_VALOR > 0 THEN CONVERT(NUMERIC(15,2),NFE.CBS_VALOR) ELSE NULL END		"vCBS",					/* Valor total da CBS */
								0.00												"vCredPres",			/* Valor total do crédito presumido */
								0.00												"vCredPresCondSus"		/* Valor total do crédito presumido em condição suspensiva */
						
						WHERE NFE.CBS_VALOR > 0
						FOR XML PATH(''), TYPE				
					) AS gCBS,

					--- GRUPO gMono - Grupo total da Monofasia
					( 
						SELECT	0.0		/*Exemplo*/									"vIBSMono",				/* Total do IBS monofásico */
								0.0		/*Exemplo*/									"vCBSMono",				/* Total da CBS monofásica */
								0.0		/*Exemplo*/									"vIBSMonoReten",		/* Total do IBS monofásico sujeito a retenção */
								0.0		/*Exemplo*/									"vCBSMonoReten",		/* Total da CBS monofásica sujeita a retenção */
								0.0		/*Exemplo*/									"vIBSMonoRet",			/* Total do IBS monofásico retido anteriormente */
								0.0		/*Exemplo*/									"vCBSMonoRet"			/* Total da CBS monofásica retida anteriormente */

						WHERE 1=2
						FOR XML PATH(''), TYPE				
					) AS gMono
					
					WHERE (NFE.IBS_EST_VALOR+NFE.IBS_MUN_VALOR+NFE.CBS_VALOR) > 0 
					FOR XML PATH('IBSCBSTot'),TYPE 
				) 
END,
		-- 
		-- vNFTot - 			
CASE WHEN @GERA_COM_RT = 0 
	THEN 
		NULL
	ELSE
			/* 
			#183# - Início
			CASE WHEN (NFE.IS_VALOR+NFE.IBS_EST_VALOR+NFE.IBS_MUN_VALOR+NFE.CBS_VALOR) > 0 
			THEN CONVERT(NUMERIC(15,2),NFE.IS_VALOR+NFE.IBS_EST_VALOR+NFE.IBS_MUN_VALOR+NFE.CBS_VALOR) 
			ELSE NULL END
			*/
			CASE WHEN CONVERT(NUMERIC(15,2),NFE.VALOR_SUB_ITENS) > 0 
			THEN CONVERT(NUMERIC(15,2),NFE.VALOR_SUB_ITENS) 
			ELSE NULL END
			/*#183# - Fim*/
			 
	END		"vNFTot"				/* Valor total da NF-e com IBS / CBS / IS */


						
-- #163# - Fim
			
		FOR XML PATH(''), TYPE
		) AS total,
------- TOTAL

------- TRANSP
		(	

				SELECT CASE WHEN NFE.ENTREGA_CIF = 1 THEN 0 ELSE 
					   CASE WHEN NFE.ENTREGA_CIF = 0 THEN 1 ELSE NFE.ENTREGA_CIF END END "modFrete",

				--- TRANSPORTA      OK
				( 
					SELECT 	
							--#110#-Início
							CASE WHEN NFE.TRANSPORTADORA_PF_PJ = 0 and ISNULL(NFE.TRANSPORTADORA_CNPJ,'') != ''  THEN RTRIM(NFE.TRANSPORTADORA_CNPJ) ELSE NULL END "CNPJ",
							CASE WHEN NFE.TRANSPORTADORA_PF_PJ = 1 and ISNULL(NFE.TRANSPORTADORA_CNPJ,'') != '' THEN RTRIM(NFE.TRANSPORTADORA_CNPJ) ELSE NULL END "CPF",
							--#110#-Fim
							--CASE WHEN ISNULL(NFE.TRANSPORTADORA,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA) END	"xNome",--#96#
							--#117#-Início
							--CASE WHEN ISNULL(NFE.TRANSPORTADORA,'') = '' THEN NULL ELSE REPLACE(RTRIM(NFE.TRANSPORTADORA),'/','') END	"xNome", --#96#
							--#152#CASE WHEN ISNULL(NFE.TRANSPORTADORA,'') = '' THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA) END	"xNome",
							CASE WHEN ISNULL(NFE.TRANSPORTADORA,'') = '' THEN NULL ELSE NFE.TRANSPORTADORA END	"xNome",
							--#117#-Fim
							--#152#CASE WHEN ((NFE.TRANSPORTADORA_PF_PJ = 1 AND NFE.TRANSPORTADORA_IE IS NULL) OR ISNULL(NFE.TRANSPORTADORA_IE,'') = '') THEN NULL ELSE DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(1,NFE.TRANSPORTADORA_IE) END	"IE", --#24#
							--#152#CASE WHEN ISNULL(NFE.TRANSPORTADORA_ENDERECO,'') = '' THEN NULL ELSE  DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,SUBSTRING(NFE.TRANSPORTADORA_ENDERECO,1,60)) END 	"xEnder", 
							--#152#CASE WHEN ISNULL(NFE.TRANSPORTADORA_CIDADE,'') = '' THEN NULL ELSE  DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TRANSPORTADORA_CIDADE) END 	"xMun",
							CASE WHEN ((NFE.TRANSPORTADORA_PF_PJ = 1 AND NFE.TRANSPORTADORA_IE IS NULL) OR ISNULL(NFE.TRANSPORTADORA_IE,'') = '') THEN NULL ELSE NFE.TRANSPORTADORA_IE END	"IE", --#24#
							CASE WHEN ISNULL(NFE.TRANSPORTADORA_ENDERECO,'') = '' THEN NULL ELSE  SUBSTRING(NFE.TRANSPORTADORA_ENDERECO,1,60) END 	"xEnder", 
							CASE WHEN ISNULL(NFE.TRANSPORTADORA_CIDADE,'') = '' THEN NULL ELSE  NFE.TRANSPORTADORA_CIDADE END 	"xMun",
							CASE WHEN ISNULL(NFE.TRANSPORTADORA_UF,'') = '' THEN NULL ELSE  RTRIM(NFE.TRANSPORTADORA_UF) END 	"UF"
					WHERE NFE.TRANSPORTADORA IS NOT NULL 
					and NFE.ENTREGA_CIF<>9 /*#125#*/
					FOR XML PATH(''), TYPE
				) AS transporta,

				--- RETTRANSP      --- VERIFICAR SE É NECESSÁRIO ESTA TAG
				( 
					SELECT 	0	"vServ",   
							0	"vBCRet",
							0	"pICMSRet",
							0	"vICMSRet",
							0	"CFOP",
							''	"cMunFG"

					WHERE 1 = 2
					FOR XML PATH(''), TYPE
				) AS retTransp,

				--- VEICTRANSP    --  VERIFICAR POSSIVEL NECESSIDADE
				( 
					SELECT 	NFE.VEICULO_PLACA		"placa",   --''	"placa",   
							NFE.UF_PLACA_VEICULO	"UF",		--''	"UF",
							NULL					"RNTC"	 --''	"RNTC"

					WHERE NFE.VEICULO_PLACA IS NOT NULL
					FOR XML PATH(''), TYPE
				) AS veicTransp,

				--- REBOQUE    --  VERIFICAR POSSIVEL NECESSIDADE
				( 
					SELECT 	NFE.VEICULO_PLACA		"placa",   --''	"placa",   
							NFE.UF_PLACA_VEICULO	"UF", --''	"UF",
							NULL					"RNTC" --''	"RNTC"

					WHERE 1 = 2
					FOR XML PATH(''), TYPE
				) AS reboque,

				--- VOL    --  VERIFICAR A NECESSIDADE DOS DADOS E SIGNIFICADO - IMFORMACAO 1..N
				( 
					SELECT 	CASE WHEN NFE.VOLUMES > 0 THEN NFE.VOLUMES ELSE NULL END									"qVol",   
							--#152#CASE WHEN ISNULL(NFE.TIPO_VOLUME,'') = '' THEN NULL ELSE RTRIM(DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.TIPO_VOLUME)) END	"esp",
							--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.MARCA_VOLUMES)								"marca",
							--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.NUMERACAO_VOLUMES)							"nVol",
							CASE WHEN ISNULL(NFE.TIPO_VOLUME,'') = '' THEN NULL ELSE RTRIM(NFE.TIPO_VOLUME) END			"esp",
							NFE.MARCA_VOLUMES																			"marca",
							NFE.NUMERACAO_VOLUMES																		"nVol",
							CASE WHEN NFE.PESO_LIQUIDO > 0 THEN CONVERT(NUMERIC(15,3),NFE.PESO_LIQUIDO) ELSE NULL END	"pesoL",
							CASE WHEN NFE.PESO_BRUTO > 0 THEN CONVERT(NUMERIC(15,3),NFE.PESO_BRUTO) ELSE NULL END		"pesoB",
							(
								SELECT		0																			"nLacre"
								WHERE 1 = 2
								FOR XML PATH(''), TYPE	
							) AS lacres
					WHERE NFE.VOLUMES > 0 OR NFE.PESO_LIQUIDO > 0 OR NFE.PESO_BRUTO > 0 OR (NFE.TIPO_VOLUME <> '' OR NFE.TIPO_VOLUME IS NOT NULL)
					FOR XML PATH(''), TYPE
				) AS vol
				FOR XML PATH(''), TYPE
		
		) AS transp,


------- TRANSP

------- COBR --  
		(	-- FATURAMENTO
			SELECT 	
				--- FAT 1..1     --- PREPARAR A VIEW PARA PEGAR ESTES DADOS OU FAZER SELECT EM CTB_A_RECEBER_FATURAS
				( 
					SELECT  RTRIM(MAX(FAT.NFAT))											"nFat", 
							SUM(FAT.VORIG)													"vOrig",
							--CASE WHEN SUM(FAT.VDESC) > 0 THEN SUM(FAT.VDESC) ELSE NULL END	"vDesc",	-- CAMPO REQUERIDO NO SCHEMA DA IT GROUP --#74#
							SUM(FAT.VDESC)													"vDesc",	-- CAMPO REQUERIDO NO SCHEMA DA IT GROUP --#74#
							/*#130#*/
							SUM(CASE WHEN @BAIXA_IAC_FATURAMENTO = 1 AND FAT.VLIQ = 0
									 THEN FAT.VORIG - FAT.VDESC
									 ELSE FAT.VLIQ END)										"vLiq"		-- CAMPO REQUERIDO NO SCHEMA DA IT GROUP
							/*#130#*/
					FROM DBO.FX_CTB_SIMULA_PARCELAS(CASE WHEN @TIPO_DOC = 'E' THEN @NOME_CLIFOR ELSE @FILIALNOTA END,@NOTAFISCAL,@SERIENOTA,@TIPO_DOC,NFE.COD_TRANSACAO) AS FAT --#74#
					FOR XML PATH('fat'), TYPE
				) ,

				--- DUP  1..N    --- PREPARAR A VIEW PARA PEGAR ESTES DADOS OU FAZER SELECT EM CTB_A_RECEBER_FATURAS

				( 
					SELECT RTRIM(NDUP)										"nDup",   
							CONVERT(CHAR(10),DUP.DVENC,21)					"dVenc",
							--#130#CONVERT(NUMERIC(15,2),DUP.VLIQ)					"vDup" --#80#
							/*#130#*/
							CONVERT(NUMERIC(15,2),CASE WHEN @BAIXA_IAC_FATURAMENTO = 1 AND DUP.VLIQ = 0
													   THEN DUP.VORIG - DUP.VDESC
													   ELSE DUP.VLIQ END)	"vDup" --#80#
							/*#130#*/
					FROM DBO.FX_CTB_SIMULA_PARCELAS(CASE WHEN @TIPO_DOC = 'E' THEN @NOME_CLIFOR ELSE @FILIALNOTA END,@NOTAFISCAL,@SERIENOTA,@TIPO_DOC,NFE.COD_TRANSACAO) AS DUP --#61#
					FOR XML PATH('dup'), TYPE
				) 
			WHERE @TIPO_DOC IN ('S','E') 
			AND EXISTS(SELECT TIPO_AMBIENTE_LINX FROM #INFORMACAO_PAGAMENTO WHERE FILIAL = @FILIALNOTA AND NF = @NOTAFISCAL AND SERIE_NF = @SERIENOTA AND TIPO_AMBIENTE_LINX = 'R') --#83# APEMAS NF RETAGUARDA --#152#
			AND EXISTS(SELECT VORIG FROM DBO.FX_CTB_SIMULA_PARCELAS(CASE WHEN @TIPO_DOC = 'E' THEN @NOME_CLIFOR ELSE @FILIALNOTA END,@NOTAFISCAL,@SERIENOTA,@TIPO_DOC,NFE.COD_TRANSACAO)) AND --#61#
			--#61#
			(EXISTS(SELECT INFO_PGTO FROM #IMPRESSAO_NFE  WHERE INFO_PGTO IN ('02','03','15') AND FILIAL = @FILIALNOTA AND NF = @NOTAFISCAL AND SERIE_NF = @SERIENOTA) OR --#68# --#152#
			 EXISTS(SELECT INFO_PGTO FROM #IMPRESSAO_NFE  WHERE INFO_PGTO IN ('02','03','15') AND NOME_CLIFOR = @NOME_CLIFOR AND NF = @NOTAFISCAL AND SERIE_NF = @SERIENOTA) OR --#68# --#152#
			 EXISTS(SELECT TOP 1 INFO_PGTO FROM #INFORMACAO_PAGAMENTO WHERE INFO_PGTO IN ('02','15') AND FILIAL = @FILIALNOTA AND NF = @NOTAFISCAL AND SERIE_NF = @SERIENOTA)) --#66# --#68# --#79# --#152#
			--#61#
			FOR XML PATH(''), TYPE
		) AS cobr,

----- PAGAMENTO #61#
		(
			SELECT
				(
					SELECT 	NFE.TIPO_PGTO_NFE											    "indPag", -- 0 - PAGTO A VISTA, 1 - PAGTO A PRAZO E 2 - OUTROS. --#69#
							CONVERT(varchar(3),RTRIM(W_INF_PGTO.INFO_PGTO))					"tPag",							
							CASE WHEN CONVERT(varchar(3),RTRIM(W_INF_PGTO.INFO_PGTO)) = '99' AND RTRIM(NFE.DESC_MEIO_PGTO) IS NOT NULL THEN RTRIM(NFE.DESC_MEIO_PGTO) ELSE NULL END "xPag", --#120# 
							CASE WHEN W_INF_PGTO.TIPO_AMBIENTE_LINX IN ('R', 'B') --#76# PARA TRATAR AS PARTICULARIDADES DO LINX ERP. #83#-Inclusão do Tipo B2C.
								THEN CONVERT(NUMERIC(15,2),RTRIM(W_INF_PGTO.VALOR))
							ELSE
								CASE WHEN W_INF_PGTO.TIPO_NOTA = 'O' THEN 0 ELSE
								(CONVERT(NUMERIC(15,2),RTRIM(W_INF_PGTO.VALOR)) +  CONVERT(NUMERIC(15,2),RTRIM(ISNULL(W_INF_PGTO.TROCO, 0)))	+ --#48##54# #78#	
								CONVERT(NUMERIC(15,2),RTRIM(b.valor)))	END 
							END																 "vPag",--#76#
							CASE WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701' THEN  CAST(W_INF_PGTO.DATA_PAGAMENTO AS DATE)  --#144#
								 WHEN LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325' THEN  CAST(W_INF_PGTO.DATA_PAGAMENTO AS DATE)  --#144#
								 ELSE NULL END "dPag", --#144#
					
							( 
								SELECT 	CONVERT(varchar(3),RTRIM(W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA))																				"tpIntegra",
								CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_AMBIENTE_LINX IN ('R', 'B') --#83#-Inclusão do Tipo 'B'para B2C.
									THEN
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL THEN CONVERT(varchar(14),RTRIM(W_INFORMACAO_PAGAMENTO.CNPJ_CREDENCIADORA)) END	
									ELSE 	
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL AND W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA = 1 THEN CONVERT(varchar(14),RTRIM(W_INFORMACAO_PAGAMENTO.CNPJ_CREDENCIADORA)) END END "CNPJ",  --#77#
								CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_AMBIENTE_LINX  IN ('R', 'B') --#83#-Inclusão do Tipo 'B'para B2C.
									THEN
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL THEN CONVERT(varchar(2),RTRIM(W_INFORMACAO_PAGAMENTO.BANDEIRA))			 END	
									ELSE
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL AND W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA = 1 THEN CONVERT(varchar(2),RTRIM(W_INFORMACAO_PAGAMENTO.BANDEIRA)) END END "tBand",
									
								CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_AMBIENTE_LINX IN ('R', 'B') --#83#-Inclusão do Tipo 'B'para B2C. 
									THEN
										CASE WHEN (W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL 
											OR ( W_INFORMACAO_PAGAMENTO.INFO_PGTO IN ('17','18') AND LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701') --#144# --#172#
											OR ( W_INFORMACAO_PAGAMENTO.INFO_PGTO IN ('17','18') AND LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325') --#144# --#172#
										) THEN RTRIM(W_INFORMACAO_PAGAMENTO.AUTORIZACAO)	END --#144#
									ELSE
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL AND W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA = 1 THEN RTRIM(W_INFORMACAO_PAGAMENTO.AUTORIZACAO) END END "cAut"  --#144#
			

								, CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_AMBIENTE_LINX IN ('R', 'B') --#83#-Inclusão do Tipo 'B'para B2C.
									THEN
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL THEN CONVERT(varchar(14),RTRIM(W_INFORMACAO_PAGAMENTO.CNPJ_RECEB)) END	
									ELSE 	
										CASE WHEN W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA IS NOT NULL AND W_INFORMACAO_PAGAMENTO.TIPO_INTEGRA = 1 THEN CONVERT(varchar(14),RTRIM(W_INFORMACAO_PAGAMENTO.CNPJ_RECEB)) END END "CNPJReceb",  --#162#
			 					
										CONVERT(varchar(3),RTRIM(W_INFORMACAO_PAGAMENTO.TERMINAL))		                              "idTermPag" --#162#




									FROM #INFORMACAO_PAGAMENTO W_INFORMACAO_PAGAMENTO --#152#
								WHERE W_INFORMACAO_PAGAMENTO.NF = @NOTAFISCAL AND 
									  W_INFORMACAO_PAGAMENTO.SERIE_NF = @SERIENOTA AND
									  W_INFORMACAO_PAGAMENTO.FILIAL = @FILIALNOTA AND
									 (W_INFORMACAO_PAGAMENTO.INFO_PGTO IN ('03','04')
										    OR ( W_INFORMACAO_PAGAMENTO.INFO_PGTO IN ('17','18') AND LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 1 AND NFE.EMISSAO>='20240701') --#144# --#172#
											OR ( W_INFORMACAO_PAGAMENTO.INFO_PGTO IN ('17','18') AND LTRIM(RTRIM(NFE.AMBIENTE_NFE)) = 2 AND NFE.EMISSAO>='20240325') --#144# --#172#
									  )
									  AND --#68#
									  W_INFORMACAO_PAGAMENTO.INFO_PGTO=W_INF_PGTO.INFO_PGTO AND --#79#
									  ISNULL(W_INFORMACAO_PAGAMENTO.BANDEIRA,'')=ISNULL(W_INF_PGTO.BANDEIRA,'') AND --#79# --#144#
						  			  ISNULL(W_INFORMACAO_PAGAMENTO.CNPJ_CREDENCIADORA,'')=ISNULL(W_INF_PGTO.CNPJ_CREDENCIADORA,'') AND --#79# --#144#
									  ISNULL(W_INFORMACAO_PAGAMENTO.AUTORIZACAO,'')=ISNULL(W_INF_PGTO.AUTORIZACAO,'') --#79# --#144#
						  	
								FOR XML PATH('card'), TYPE
							)
				
				--#64#				
				FROM #INFORMACAO_PAGAMENTO W_INF_PGTO --#152#
				left join [DBO].[FX_CALCULA_RATEIO_PARCELAS](@qtde_parcela,
					case 
						when (CONVERT(NUMERIC(15,2),NFE.ICMS_ST + NFE.ICMS_STR) > 0 and CONVERT(NUMERIC(15,2),NFE.FECP_ST) > 0) 
						then CONVERT(NUMERIC(15,2),NFE.ICMS_ST + NFE.ICMS_STR) + CONVERT(NUMERIC(15,2),NFE.FECP_ST) else 0 end) b

				on	W_INF_PGTO.PARCELA = b.parcela
				WHERE W_INF_PGTO.NF = @NOTAFISCAL AND 
							W_INF_PGTO.SERIE_NF = @SERIENOTA AND
							W_INF_PGTO.FILIAL = @FILIALNOTA
					FOR XML PATH('detPag'),TYPE
				),
				(
					--#152#
					SELECT	
							CONVERT(NUMERIC(15,2),RTRIM(SUM(TROCO)))				"vTroco"
					FROM 
							#INFORMACAO_PAGAMENTO 
					WHERE	
							NF = @NOTAFISCAL AND 
							SERIE_NF = @SERIENOTA AND
							FILIAL = @FILIALNOTA
					
					FOR XML PATH(''), TYPE
				)															
				FOR XML PATH(''), TYPE	
		) AS pag,
--#61#

--#120# --#121#
------- INFINTERMED --  
		
		(
				SELECT  
						CASE WHEN NFE.INTERMERDIADOR_CNPJ IS NOT NULL THEN LTRIM(RTRIM(NFE.INTERMERDIADOR_CNPJ)) ELSE NULL END										"CNPJ",
						CASE WHEN NFE.INTERMERDIADOR_IDCADINTTRAN IS NOT NULL THEN LTRIM(RTRIM(INTERMERDIADOR_IDCADINTTRAN)) ELSE NULL END							"idCadIntTran"				
				WHERE RTRIM(NFE.INDICA_PRESENCA_COMPRADOR) IN (1,2,3,4,9) and NFE.INTERMERDIADOR_IDCADINTTRAN IS NOT NULL 
				FOR XML PATH(''), TYPE
		) as infIntermed,
--#120# --#121#

------- INFADIC --  
		(	
			SELECT 		
					-- #55# [Início]										
					(  SELECT 						
							@OBS_INTERESSE_FISCO
						WHERE 							
							isnull(@OBS_INTERESSE_FISCO,'') <> ''
						FOR XML PATH('infAdFisco'), TYPE ),
					-- #55# [Fim]					
					DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@INFCOMPLEMENTAR)		  "infCpl",
					/*#151#*/
					(
						SELECT 
							DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,CAMPO) "@xCampo",
							DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,TEXTO) "xTexto"
						FROM NFE_OBS_CONT_FISCO
						WHERE 
							NFE_OBS_CONT_FISCO.FILIAL = NFE.FILIAL 
							AND NFE_OBS_CONT_FISCO.SERIE_NF = NFE.SERIE_NF
							AND NFE_OBS_CONT_FISCO.NF = NFE.NF
							AND NFE_OBS_CONT_FISCO.FATURAMENTO_ENTRADA = CASE WHEN RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'S' THEN 1 ELSE 2 END
							AND NFE_OBS_CONT_FISCO.TIPO = 1
						FOR XML PATH('obsCont'), TYPE	
					) ,
					(
						SELECT 
							DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,CAMPO) "@xCampo",
							DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,TEXTO) "xTexto"
						FROM NFE_OBS_CONT_FISCO
						WHERE 
							NFE_OBS_CONT_FISCO.FILIAL = NFE.FILIAL 
							AND NFE_OBS_CONT_FISCO.SERIE_NF = NFE.SERIE_NF
							AND NFE_OBS_CONT_FISCO.NF = NFE.NF
							AND NFE_OBS_CONT_FISCO.FATURAMENTO_ENTRADA = CASE WHEN RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'S' THEN 1 ELSE 2 END
							AND NFE_OBS_CONT_FISCO.TIPO = 2	
						FOR XML PATH('obsFisco'), TYPE	
					) ,
					/*#151# [fim] */ 

					--#126#
					--(
					--	SELECT NFE.TIPO_PROCESSO  "indProc"
					--	FOR XML PATH('indProc'), TYPE	
					--),					


					/*#129# - Inicio
					Retirada do que foi feito no ajuste 128*/			
					--/*#128#*/
					--(
					--SELECT LTRIM(RTRIM(NFE.NUMERO_PROCESSO)) "nProc",
					--									9	 "indProc"
					--WHERE 1=1	
					--FOR XML PATH(''), TYPE
					--	) AS procRef
					--						(
					--	SELECT		0	"nProc",
					--				0	"indProc"
					--	WHERE 1= 2
					--	FOR XML PATH(''), TYPE	
					--) AS procRef
					--	/*#129# - Final*/


						/*#127#*/
						--SELECT		0	"nProc",
						--			0	"indProc"
						--WHERE 1= 2

						--SELECT NFE.TIPO_PROCESSO "indProc",

	-- #135# #136# #142#
                     CASE WHEN ISNULL(NFE.NUMERO_PROCESSO,'') = '' 
                         THEN NULL 
					   ELSE (
                            (SELECT 
                                CASE WHEN ISNULL(NFE.NUMERO_PROCESSO,'') = '' THEN NULL ELSE LTRIM(RTRIM(NFE.NUMERO_PROCESSO)) END "nProc",
                                CASE WHEN ISNULL(NFE.TIPO_PROCESSO,'') = '' THEN NULL ELSE NFE.TIPO_PROCESSO END "indProc",
                                CASE WHEN NFE.TIPO_PROCESSO = 0 THEN CASE WHEN ISNULL(NFE.ATO_CONCESSORIO,'') = '' THEN NULL ELSE NFE.ATO_CONCESSORIO END ELSE NULL END "tpAto"
                             FOR XML PATH(''), TYPE 
                            )
                    --  --#126#
                    --WHERE   NFE.TIPO_PROCESSO = 0 FOR XML PATH(''), TYPE /*#127#*/
                        ) END AS procRef
                    /*#128#*/
    -- #135# #136# #142#
			WHERE (@INFCOMPLEMENTAR <> '' AND @INFCOMPLEMENTAR IS NOT NULL) OR (@OBS_INTERESSE_FISCO <> '' AND @OBS_INTERESSE_FISCO IS NOT NULL) OR (EXISTS(SELECT CAMPO
						FROM NFE_OBS_CONT_FISCO
						WHERE 
							NFE_OBS_CONT_FISCO.FILIAL = NFE.FILIAL 
							AND NFE_OBS_CONT_FISCO.SERIE_NF = NFE.SERIE_NF
							AND NFE_OBS_CONT_FISCO.NF = NFE.NF
							AND NFE_OBS_CONT_FISCO.FATURAMENTO_ENTRADA = CASE WHEN RIGHT(RTRIM(NFE.ORIGEM_NF),1) = 'S' THEN 1 ELSE 2 END)) /*#151# [adicionado ultima condição, caso tenha observação livre cria a tag]*/ 
			FOR XML PATH(''), TYPE
		) AS infAdic,

	   		 
------- INFADIC
------- EXPORTA --  ESTA INFORMACAO FOI INCLUIDA EM 29/09/2010 E FOI CONVERSADO COM CESTARIA SOBRE A INCLUSAO DESTES CAMPOS
		(	
			SELECT	NFE.UF_EMBARQUE_EXPORTACAO														    "UFSaidaPais",  --"UFEmbarq", #13#
					--#152#DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,NFE.LOCAL_EMBARQUE_EXPORTACAO)			"xLocExporta",  --"xLocEmbarq" #13#
					NFE.LOCAL_EMBARQUE_EXPORTACAO														"xLocExporta",  --"xLocEmbarq" #13#
					null "xLocDespacho" --  #13# Nova Tag, por enquanto null...
			WHERE NFE.UF_EMBARQUE_EXPORTACAO IS NOT NULL AND NFE.LOCAL_EMBARQUE_EXPORTACAO IS NOT NULL
			FOR XML PATH(''), TYPE
		) AS exporta,
------- EXPORTA

------- COMPRA --  VERIFICAR POSSIVEL NECESSIDADE
		(	
			SELECT  NFE.NOTA_EMPENHO_COMPRA		"xNEmp",
					NFE.PEDIDO_COMPRA			"xPed",
					NFE.CONTRATO_COMPRA			"xCont"

			WHERE NFE.NOTA_EMPENHO_COMPRA IS NOT NULL OR NFE.PEDIDO_COMPRA IS NOT NULL OR NFE.CONTRATO_COMPRA IS NOT NULL
			FOR XML PATH(''), TYPE
		) AS compra
------- COMPRA

FROM  #IMPRESSAO_NFE  NFE --#152#
WHERE  NF = @NOTAFISCAL  AND 
		SERIE_NF = @SERIENOTA AND 
		FILIAL = @FILIALNOTA
FOR XML PATH('infNFe'), TYPE 

) --AS INFNFE
FOR XML PATH('NFe'),TYPE 

)

DROP TABLE #ARRAY /* #57# */

SELECT @NFE_XML_REPLACE = CONVERT(VARCHAR(MAX) ,@NFE_XML )

--SELECT @NFE_XML_REPLACE =  ('<?'+'xml version="1.0" encoding="UTF-8"?>'+@NFE_XML_REPLACE)
SELECT @NFE_XML_REPLACE = REPLACE(@NFE_XML_REPLACE,'SUBSTITUI1="SUBSTITUIR"','xmlns="http://www.portalfiscal.inf.br/nfe"')

IF @RETORNA_XML = 1
	SELECT CONVERT(XML,@NFE_XML_REPLACE) AS XML_NFE, ROUND(LEN(@NFE_XML_REPLACE)/1024.00,2) AS TAMANHO_XML, RTRIM(@CHAVEACESSO) AS CHAVE_NFE, @EMAIL_NFE AS EMAIL_NFE, @EMAIL_DESTINATARIO AS EMAIL_DESTINATARIO
ELSE
	SELECT @NFE_XML_REPLACE AS XML_NFE, ROUND(LEN(@NFE_XML_REPLACE)/1024.00,2) AS TAMANHO_XML, RTRIM(@CHAVEACESSO) AS CHAVE_NFE, @EMAIL_NFE AS EMAIL_NFE, @EMAIL_DESTINATARIO AS EMAIL_DESTINATARIO

