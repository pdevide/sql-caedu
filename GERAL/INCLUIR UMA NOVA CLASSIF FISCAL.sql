select * from CLASSIF_FISCAL

lx_cade_coluna ncm

select * from TABELA_LX_NCM



insert into TABELA_LX_NCM values (30231, '85235900','CARTOES E ETIQUETAS DE ACIONAMENTO POR APROXIMACAO',GETDATE(),0)


select * from TABELA_LX_NCM where CODIGO_NCM like '%235910'

select * from TABELA_LX_NCM where CODIGO_NCM = '85235900'

select * from CLASSIF_FISCAL where classif_fiscal = '85235910'

insert into CLASSIF_FISCAL (CLASSIF_FISCAL,IPI,DESC_CLASSIFICACAO,CLASSIF_REDUZIDA,ABATER_ICMS_NO_MEDIO,ABATER_IPI_NO_MEDIO,
							DATA_PARA_TRANSFERENCIA,ABATER_PIS_NO_MEDIO,PASSIVEL_REDUCAO_BASE_ICMS,ABATER_COFINS_NO_MEDIO,RETE_FUENTE,RETE_IVA,
							RETE_ICA,CODIGO_SERVICO,COD_GENERO_SPED,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,ID_SERVICO_TIPO,INATIVO,LX_STATUS_REGISTRO)
values ('85235900',0,'CARTOES E ETIQUETAS DE ACIONAMENTO POR A','8523',0,0,
							getdate(),0,null,0,0,0,
							0,null,85,null,null,0,0)

select * from CLASSIF_FISCAL where CLASSIF_FISCAL = '85235900'




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
where CLASSIF_FISCAL = '85235900'
ORDER  BY classif_fiscal.classif_fiscal 


select * from lcf_lx_ncm

insert into lcf_lx_ncm (COD_NCM,DESC_NCM,CODIGO_CONTRIBUICAO_RECEITA_BRUTA,CODIGO_SERVICO) values ('85235900','CARTOES E ETIQUETAS DE ACIONAMENTO POR A','',null)

select * from tabela_lx_ncm where CODIGO_NCM = '85235900'

select * from tabela_lx_ncm where tabela_lx_ncm.codigo_ncm = '85235900'
select * from lcf_lx_ncm where lcf_lx_ncm.cod_ncm = '85235900'


select max(id_ncm) from lcf_lx_ncm

select * from CADASTRO_ITEM_FISCAL where codigo_item like '4217'

update CADASTRO_ITEM_FISCAL set CLASSIF_FISCAL = '85235900' where CODIGO_ITEM='4217'


select distinct p.COLECAO, c.DESC_COLECAO
from produtos p
left join COLECOES c on c.COLECAO = p.COLECAO

select * from colecoes
