/****** Script do comando SelectTopNRows de SSMS  ******/
begin tran
insert into cadastro_cli_for
(NOME_CLIFOR
,CLIFOR
,CGC_CPF
,RAZAO_SOCIAL
,PJ_PF
,RG_IE
,UF
,COBRANCA_UF
,ENTREGA_UF
,COBRANCA_CGC
,CADASTRAMENTO
,COBRANCA_IE
,INDICA_FORNECEDOR
,INDICA_CLIENTE
,IND_REPRESENTANTE
,INDICA_FILIAL
,ENTREGA_CGC
,ENTREGA_IE
,INATIVO
,ISENTO_IPI
,ISENTO_ICMS
,ACEITA_DIAS_FIXO
,INCL_AUTO_GRP_ECON
,ENVIADO_SPC
,LX_STATUS_REGISTRO
,INDICA_CPRB
,ATIVIDADE_SIMPLES_NACIONAL
,CEP
,ENDERECO
,BAIRRO
,CIDADE
,TELEFONE1
,PAIS
,DDI
,TELEFONE2
,FAX
,DDD1
,RAMAL1
,RAMAL2
,DDD2
,COBRANCA_ENDERECO
,COBRANCA_CIDADE
,COBRANCA_BAIRRO
,DDDFAX
,COBRANCA_CEP
,COBRANCA_TELEFONE
,ENTREGA_ENDERECO
,ENTREGA_CIDADE
,ENTREGA_BAIRRO
,ENTREGA_CEP
,ENTREGA_TELEFONE
,COBRANCA_DDD
,CONTATO
,ENTREGA_DDD
,REF_ANTERIOR
,DATA_PARA_TRANSFERENCIA
,ENTREGA_PAIS
,COBRANCA_PAIS
,IRRF
,ACEITA_AGRUPAR_FATURA
,NUMERO_VIAS_FATURA
,DIAS_ANTECIPACAO_PGTO
,POSSUI_RECARGO
,TIPO_RELACAO_COMERCIAL
,ENTREGA_RAZAO_SOCIAL
,COBRANCA_RAZAO_SOCIAL
,COD_CLIFOR
,INDICADOR_FISCAL_TERCEIRO
,AGRUPAMENTO_ITENS
--,CODIGO_CONTATO
,NUMERO
,COMPLEMENTO
,COBRANCA_NUMERO
,COBRANCA_COMPLEMENTO
,ENTREGA_NUMERO
,ENTREGA_COMPLEMENTO
,COD_MUNICIPIO_IBGE
,COD_MUNICIPIO_IBGE_ENTREGA
,COD_MUNICIPIO_IBGE_COBRANCA
,EBS_ID_FORNECEDOR
,EBS_ID_LOCAL_FORNECEDOR
,EBS_ID_CLIENTE
,EBS_ID_LOCAL_CLIENTE)
SELECT [column1]
      ,[column2]
      ,[column3]
      ,[column4]
      ,[column5]
      ,case when isnull([column6],'') = '' then '000000000' else [column6] end
      ,[column7]
      ,[column8]
      ,[column9]
      ,[column10]
      ,[column11]
      ,case when isnull([column12],'') = '' then '000000000' else [column12] end
      ,[column13]
      ,[column14]
      ,[column15]
      ,[column16]
      ,[column17]
      ,case when isnull([column18],'') = '' then '000000000' else [column18] end
      ,[column19]
      ,[column20]
      ,[column21]
      ,[column22]
      ,[column23]
      ,[column24]
      ,[column25]
      ,[column26]
      ,[column27]
      ,[column28]
      ,[column29]
      ,[column30]
      ,[column31]
      ,null [column32]
      ,[column33]
      ,null [column34]
      ,null [column35]
      ,null [column36]
      ,null [column37]
      ,null [column38]
      ,null [column39]
      ,null [column40]
      ,[column41]
      ,[column42]
      ,[column43]
      ,null [column44]
      ,[column45]
      ,null [column46]
      ,[column47]
      ,[column48]
      ,[column49]
      ,[column50]
      ,null [column51]
      ,null [column52]
      ,null [column53]
      ,null [column54]
      ,null [column55]
      ,[column56]
      ,[column57]
      ,[column58]
      ,[column59]
      ,[column60]
      ,[column61]
      ,[column62]
      ,[column63]
      ,[column64]
      ,[column65]
      ,[column66]
      ,[column67]
      ,[column68]
      ,[column69]
      --,[column70]
      ,[column71]
      ,[column72]
      ,[column73]
      ,[column74]
      ,[column75]
      ,[column76]
      ,[column77]
      ,[column78]
      ,[column79]
      ,[column80]
      ,[column81]
      ,[column82]
      ,[column83]
  FROM [CAEDU].[ccp\paulo.devide].[CADASTRO_CLI_FOR_PROD]
commit
--rollback

