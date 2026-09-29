select * from faturamento where nf_saida = '000047266'


select * from filiais where filial = 'matriz'

INSERT NCM 

Insert  TABELA_LX_NCM values ('39140','39233090','ARTIGOS DE TRANSPORTE OU DE EMBALAGEM, DE PLÁSTICO; ROLHAS, TAMPAS, CÁPSULAS E OUTROS DISPOSITIVOS PARA FECHAR RECIPIENTES, DE PLÁSTICO.', GETDATE(),'0')

insert into  LCF_LX_NCM ( COD_NCM, DESC_NCM, CODIGO_CONTRIBUICAO_RECEITA_BRUTA, CODIGO_SERVICO) 
VALUES ( 39233090, 'ARTIGOS DE TRANSPORTE OU DE EMBALAGEM, DE PLÁSTICO; ROLHAS, TAMPAS, CÁPSULAS E OUTROS DISPOSITIVOS PARA FECHAR RECIPIENTES, DE PLÁSTICO.',00, null)

select * from LCF_LX_NCM where cod_ncm = '39233000'


select * from LCF_LX_NCM order by ID_NCM desc


select * from TABELA_LX_NCM where CODIGO_NCM='39233090'


select * 
--update p set classif_fiscal = '39233090'
from produtos p where CLASSIF_FISCAL = '39239000' AND DATA_PARA_TRANSFERENCIA >='20210107'

SELECT classif_fiscal.desc_classificacao, 
       classif_fiscal.classif_reduzida, 
       classif_fiscal.classif_fiscal, 
       classif_fiscal.ipi, 
       classif_fiscal.abater_icms_no_medio, 
       classif_fiscal.abater_ipi_no_medio, 
       classif_fiscal.abater_pis_no_medio, 
       classif_fiscal.abater_cofins_no_medio, 
       classif_fiscal.rete_fuente, 
       classif_fiscal.rete_iva, 
       classif_fiscal.rete_ica, 
       classif_fiscal.codigo_servico, 
       classif_fiscal.cod_genero_sped, 
       classif_fiscal.codigo_contribuicao_receita_bruta, 
       classif_fiscal.id_servico_tipo, 
       classif_fiscal.inativo, 
       Isnull(unidades_tributaria_exterior.unidade_tributaria_abreviatura, '') 
       AS 
       UNIDADE_TRIBUTARIA_ABREVIATURA 
FROM   classif_fiscal CLASSIF_FISCAL 
       INNER JOIN tabela_lx_ncm 
               ON tabela_lx_ncm.codigo_ncm = Replace( 
                  classif_fiscal.classif_fiscal, '.' 
                                             , '') 
       INNER JOIN lcf_lx_ncm 
               ON tabela_lx_ncm.codigo_ncm = lcf_lx_ncm.cod_ncm 
       LEFT JOIN unidades_tributaria_ncm 
              ON lcf_lx_ncm.id_ncm = unidades_tributaria_ncm.id_ncm 
       LEFT JOIN unidades_tributaria_exterior 
              ON unidades_tributaria_exterior.id_unidade_tributaria = 
                 unidades_tributaria_ncm.id_unidade_tributaria 
WHERE classif_fiscal.classif_fiscal = '39233090'
ORDER  BY classif_fiscal.classif_fiscal 




insert into CLASSIF_FISCAL
(CLASSIF_FISCAL
,IPI
,DESC_CLASSIFICACAO
,CLASSIF_REDUZIDA
,ABATER_ICMS_NO_MEDIO
,ABATER_IPI_NO_MEDIO
,DATA_PARA_TRANSFERENCIA
,ABATER_PIS_NO_MEDIO
,PASSIVEL_REDUCAO_BASE_ICMS
,ABATER_COFINS_NO_MEDIO
,RETE_FUENTE
,RETE_IVA
,RETE_ICA
,CODIGO_SERVICO
,COD_GENERO_SPED
,CODIGO_CONTRIBUICAO_RECEITA_BRUTA
,ID_SERVICO_TIPO
,INATIVO
,LX_STATUS_REGISTRO)
select 
'39233090' AS CLASSIF_FISCAL
,IPI
,'ARTIGOS DE TRANSP. OU DE EMB., PLÁSTICO' DESC_CLASSIFICACAO
,CLASSIF_REDUZIDA
,ABATER_ICMS_NO_MEDIO
,ABATER_IPI_NO_MEDIO
,DATA_PARA_TRANSFERENCIA
,ABATER_PIS_NO_MEDIO
,PASSIVEL_REDUCAO_BASE_ICMS
,ABATER_COFINS_NO_MEDIO
,RETE_FUENTE
,RETE_IVA
,RETE_ICA
,CODIGO_SERVICO
,COD_GENERO_SPED
,CODIGO_CONTRIBUICAO_RECEITA_BRUTA
,ID_SERVICO_TIPO
,INATIVO
,LX_STATUS_REGISTRO
from CLASSIF_FISCAL where CLASSIF_FISCAL='39233000'

UPDATE CLASSIF_FISCAL SET UNI


