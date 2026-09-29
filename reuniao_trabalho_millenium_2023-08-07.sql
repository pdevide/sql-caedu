

select * from CTB_EXCECAO_IMPOSTO where ID_EXCECAO_IMPOSTO='2407'

select * 
--update a set id_imposto = 70
from CTB_EXCECAO_IMPOSTO_ITEM a where ID_EXCECAO_IMPOSTO='2407' --and id_imposto = 42


select * from UNIDADES_FEDERACAO_ICMS_PARTILHA

select * from EML_MOVTOS_INTEGRADOS

select * from LOJAS_VAREJO where filial = 'LOJA VIRTUAL'

LX_CADE_COLUNA SERIE


SELECT * 
--update a set COD_SERIE_SINTEGRA='001'
FROM SERIES_nf a where serie_nf='001'

select * from PARAMETROS where parametro like '%serie%'

SELECT DISTINCT FS.SERIE_NF
FROM SERIES_NF SN
INNER JOIN FATURAMENTO_SEQUENCIAIS FS ON FS.SERIE_NF = SN.SERIE_NF
INNER JOIN FILIAIS F ON F.FILIAL = FS.FILIAL
WHERE F.COD_FILIAL = '000141'
  AND cast(replicate ('0', 3 - DATALENGTH (dbo.trim (SN.COD_SERIE_SINTEGRA))) AS varchar(8000)) 
  + cast(dbo.trim (SN.COD_SERIE_SINTEGRA) AS varchar(8000)) = cast(replicate ('0', 3 - DATALENGTH (dbo.trim ('001'))) 
  AS varchar(8000)) + cast(dbo.trim ('001') AS varchar(8000))
  AND FS.INATIVA = 0



  select top 10 * from LOJA_NOTA_FISCAL_ITEM where CODIGO_FILIAL='000141'

  select * from CTB_LX_INDICADOR_CFOP

  lx_cade_coluna indicador_cfop

  LX_DADOS_CADASTRO_XML_NFE
