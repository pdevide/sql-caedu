SELECT produtos_indicador_cfop.produto, 
       produtos_indicador_cfop.filial, 
       produtos_indicador_cfop.indicador_cfop, 
       ctb_lx_indicador_cfop.descricao_indicador_cfop, 
       produtos_indicador_cfop.tribut_origem, 
       tribut_origem.descricao, 
       produtos_indicador_cfop.tipo_item_sped 
FROM   produtos_indicador_cfop 
       LEFT JOIN ctb_lx_indicador_cfop 
              ON produtos_indicador_cfop.indicador_cfop = 
                 ctb_lx_indicador_cfop.indicador_cfop 
       LEFT JOIN tribut_origem 
              ON produtos_indicador_cfop.tribut_origem = 
                 tribut_origem.tribut_origem 
WHERE  produtos_indicador_cfop.produto = '06120029'


select * from PRODUTOS_INDICADOR_CFOP

select * from ctb_lx_indicador_cfop 

INSERT INTO PRODUTOS_INDICADOR_CFOP
select DISTINCT PRODUTO, FILIAL, 11 AS INDICADOR_CFOP, 0 AS TRIBUT_ORIGEM, GETDATE() AS DATA_PARA_TRANSFERENCIA, '00' AS TIPO_ITEM_SPED, 1 AS LX_STATUS_REGISTRO 
from W_ESTOQUE_PRODUTOS_00 where filial = 'CD REGIS' AND REFER_FABRICANTE LIKE 'CHIK%'
AND PRODUTO NOT IN (SELECT PRODUTO FROM PRODUTOS_INDICADOR_CFOP)
