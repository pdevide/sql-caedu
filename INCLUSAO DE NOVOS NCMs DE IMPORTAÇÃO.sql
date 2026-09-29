/*
select * from TABELA_LX_NCM where codigo_ncm = '62012000'
select * from TABELA_LX_NCM where codigo_ncm = '62013000'
select * from TABELA_LX_NCM where codigo_ncm = '62014000'
select * from TABELA_LX_NCM where codigo_ncm = '62019000'
select * from TABELA_LX_NCM where codigo_ncm = '62022000'
select * from TABELA_LX_NCM where codigo_ncm = '62023000'
select * from TABELA_LX_NCM where codigo_ncm = '62024000'
select * from TABELA_LX_NCM where codigo_ncm = '62029000'

select * from TABELA_LX_NCM where id in (
9167,
9168,
9169,
9170,
9172,
9173,
9174,
9175)


NCM 8541.40.22 foi alterado para 8541.41.22.
OUTROS DIODOS EMISSORES DE LUZ (LED), EXCETO DIODOS LASER
NCM 9401.30.90 para 9401.39.00
-- OUTROS
*/

insert into TABELA_LX_NCM values (49167, '62012000','- DE LÃ OU DE PELOS FINOS',GETDATE(),0)
insert into TABELA_LX_NCM values (49168, '62013000','- DE ALGODÃO',GETDATE(),0)
insert into TABELA_LX_NCM values (49169, '62014000','- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS',GETDATE(),0)
insert into TABELA_LX_NCM values (49170, '62019000','- DE OUTRAS MATÉRIAS TÊXTEIS',GETDATE(),0)
insert into TABELA_LX_NCM values (49172, '62022000','- DE LÃ OU DE PELOS FINOS',GETDATE(),0)
insert into TABELA_LX_NCM values (49173, '62023000','- DE ALGODÃO',GETDATE(),0)
insert into TABELA_LX_NCM values (49174, '62024000','- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS',GETDATE(),0)
insert into TABELA_LX_NCM values (49175, '62029000','- DE OUTRAS MATÉRIAS TÊXTEIS',GETDATE(),0)

insert into TABELA_LX_NCM values (49176, '85414122','OUTROS DIODOS EMISSORES DE LUZ (LED), EXCETO DIODOS LASER',GETDATE(),0)
insert into TABELA_LX_NCM values (49177, '94013900','-- OUTROS',GETDATE(),0)

insert into TABELA_LX_NCM values (49180, '94054900','-- OUTROS',GETDATE(),0)


insert into CLASSIF_FISCAL (CLASSIF_FISCAL,IPI,DESC_CLASSIFICACAO,CLASSIF_REDUZIDA,ABATER_ICMS_NO_MEDIO,ABATER_IPI_NO_MEDIO,DATA_PARA_TRANSFERENCIA,
ABATER_PIS_NO_MEDIO,PASSIVEL_REDUCAO_BASE_ICMS,ABATER_COFINS_NO_MEDIO,RETE_FUENTE,RETE_IVA,RETE_ICA,CODIGO_SERVICO,COD_GENERO_SPED,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,
ID_SERVICO_TIPO,INATIVO,LX_STATUS_REGISTRO)
values ('94054900',0,'-- OUTROS','9405',0,0,getdate(),0,null,0,0,0,0,null,94,null,null,0,0)
--values ('62012000',0,'- DE LÃ OU DE PELOS FINOS','6201',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62013000',0,'- DE ALGODÃO','6201',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62014000',0,'- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS','6201',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62019000',0,'- DE OUTRAS MATÉRIAS TÊXTEIS','6201',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62022000',0,'- DE LÃ OU DE PELOS FINOS','6202',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62023000',0,'- DE ALGODÃO','6202',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62024000',0,'- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS','6202',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0),
--('62029000',0,'- DE OUTRAS MATÉRIAS TÊXTEIS','6202',0,0,getdate(),0,null,0,0,0,0,null,62,null,null,0,0)

/*
-- QUERY PARA VALIDAR SE O NCM FOI INCLUIDO CORRETAMENTE EM TODAS AS TABELAS
SELECT *
FROM   classif_fiscal CLASSIF_FISCAL 
       INNER JOIN tabela_lx_ncm 
               ON tabela_lx_ncm.codigo_ncm = Replace( 
                  classif_fiscal.classif_fiscal, '.' 
                                             , '') 
       INNER JOIN lcf_lx_ncm 
               ON tabela_lx_ncm.codigo_ncm = lcf_lx_ncm.cod_ncm 
       --LEFT JOIN unidades_tributaria_ncm 
       --       ON lcf_lx_ncm.id_ncm = unidades_tributaria_ncm.id_ncm 
       --LEFT JOIN unidades_tributaria_exterior 
       --       ON unidades_tributaria_exterior.id_unidade_tributaria = 
       --          unidades_tributaria_ncm.id_unidade_tributaria 
where CLASSIF_FISCAL = '94054900'
-- IN ('62012000','62013000','62014000','62019000','62022000','62023000','62024000','62029000')
ORDER  BY classif_fiscal.classif_fiscal 
*/
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('94054900','-- OUTROS','',null)

insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62012000','- DE LÃ OU DE PELOS FINOS','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62013000','- DE ALGODÃO','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62014000','- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62019000','- DE OUTRAS MATÉRIAS TÊXTEIS','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62022000','- DE LÃ OU DE PELOS FINOS','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62023000','- DE ALGODÃO','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62024000','- DE FIBRAS SINTÉTICAS OU ARTIFICIAIS','',null)
insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('62029000','- DE OUTRAS MATÉRIAS TÊXTEIS','',null)


Select * /*,NCM_NBS */
from TMP_TABELA_ALIQUOTA_IMPOSTO_ITEM  ALIQ 
where NCM_NBS = '62021200'

select classif_fiscal, * 
--update p set CLASSIF_FISCAL = '62023000'
from produtos p 
where p.produto = 'H3010035'


update CLASSIF_FISCAL set IPI = 11.25 where CLASSIF_FISCAL='94054900'

select * from CTB_EXCECAO_IMPOSTO

