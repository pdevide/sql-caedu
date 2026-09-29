SELECT loja_entradas.romaneio_produto, 
       loja_entradas.filial, 
       regiao, 
       loja_entradas.filial_origem, 
       loja_entradas.tipo_entrada_saida, 
       loja_entradas.codigo_tab_preco, 
       loja_entradas.numero_nf_transferencia, 
       loja_entradas.fornecedor, 
       loja_entradas.responsavel, 
       loja_entradas.emissao, 
       loja_entradas.obs, 
       loja_entradas.entrada_conferida, 
       loja_entradas.entrada_sem_produtos, 
       loja_entradas.qtde_total, 
       loja_entradas.valor_total, 
       loja_entradas.fator_preco, 
       loja_entradas.romaneio_nf_saida, 
       loja_entradas.valor_nao_conferido, 
       loja_entradas.qtde_nao_conferida, 
       CONVERT(BIT, 0) AS LIBERA_TRANSITO, 
       loja_entradas_dif.status_transito 
FROM   loja_entradas 
       JOIN filiais 
         ON loja_entradas.filial = filiais.filial 
       LEFT JOIN loja_entradas_dif 
              ON loja_entradas.filial = loja_entradas_dif.filial 
                 AND loja_entradas.numero_nf_transferencia = 
                     loja_entradas_dif.numero_nf_transferencia 
                 AND loja_entradas.filial_origem = 
                     loja_entradas_dif.filial_origem 
                 AND loja_entradas.romaneio_nf_saida = 
                     loja_entradas_dif.romaneio_nf_saida 
                 AND loja_entradas.emissao = loja_entradas_dif.emissao 
                 AND loja_entradas.romaneio_produto = 
                     loja_entradas_dif.romaneio_produto 
WHERE  filiais.matriz IN ( 'MATRIZ' ) 
       AND loja_entradas.entrada_conferida = 0 and loja_entradas.NUMERO_NF_TRANSFERENCIA like '%101'
ORDER  BY emissao ASC, 
          filiais.filial


/*
SELECT * FROM LOJA_ENTRADAS WHERE FILIAL='CONTROLE DE QUALIDADE' AND FILIAL_ORIGEM ='AMOSTRA PIRAJA' AND ENTRADA_CONFERIDA=1  AND NUMERO_NF_TRANSFERENCIA IN ('000000084','000000082')         

UPDATE LOJA_ENTRADAS
SET ENTRADA_CONFERIDA=0
WHERE FILIAL='CONTROLE DE QUALIDADE' AND FILIAL_ORIGEM ='AMOSTRA PIRAJA' AND ENTRADA_CONFERIDA=1  
AND NUMERO_NF_TRANSFERENCIA IN ('000000084','000000082')
           

*/


SELECT RTRIM(PACK)+'|'+PRODUTO+'|'+RTRIM(NF)+'|'+RTRIM(SERIE)+'|'+ CAST( ROW_NUMBER() OVER (ORDER BY PRODUTO)AS VARCHAR(MAX)) ETIQUETA
FROM  PDA_WMS_TB_RECEBIMENTO_IMPORTADO_COLETA A
INNER JOIN PDA_WMS_TB_REC_CD_STATUS_RECEBIMENTO B  ON A.NF+' '+SERIE = B.PEDIDO
WHERE B.STATUS=3
AND A.NF='000020054' AND SERIE='02'

select * from PDA_WMS_TB_RECEBIMENTO_IMPORTADO_COLETA


