SELECT GERAL.EMPRESA               AS EMPRESA, 
       GERAL.DESTINO               AS DESTINO, 
       GERAL.GRIFFE                AS GRIFFE, 
       Max(GERAL.ISENTO)           AS isento, 
       GERAL.REQUERIDO_POR         AS REQUERIDO_POR, 
--       GERAL.RECEBIMENTO           AS RECEBIMENTO, 
       GERAL.QTDE_ENTREGAR         AS QUANTIDADE_ENTREGAR, 
       Sum(GERAL.QTDE_ENTREGUE)    AS QUANTIDADE_ENTREGUE, 
       CASE 
         WHEN Sum(GERAL.QTDE_AGENDADA) > 0 THEN Max(GERAL.QTDE_ENTREGAR) 
         ELSE 0 
       END                         AS QUANTIDADE_AGENDADA, 
       GERAL.LINHA                 AS LINHA, 
       GERAL.GRUPO_PRODUTO         AS GRUPO_PRODUTO, 
       GERAL.SUBGRUPO_PRODUTO      AS SUBGRUPO_PRODUTO, 
       GERAL.FORNECEDOR            AS FORNECEDOR, 
       Max(GERAL.CONTINUIDADE)     AS CONTINUIDADE, 
       GERAL.PEDIDO                AS PEDIDO, 
       GERAL.PRODUTO               AS PRODUTO, 
       GERAL.TIPO_COMPRA           AS TIPO_COMPRA, 
       GERAL.DESC_PRODUTO          AS DESC_PRODUTO, 
       GERAL.EMISSAO               AS EMISSAO, 
       GERAL.ENTREGA               AS ENTREGA, 
       GERAL.LIMITE_ENTREGA        AS LIMITE_ENTREGA, 
       Max(GERAL.DATA_AGENDAMENTO) AS DATA_AGENDAMENTO, 
       Max(GERAL.DATA_CHEGADA)     AS DATA_CHEGADA, 
       Max(GERAL.CODIGO_AGENDA)    AS CODIGO_AGENDA, 
       GERAL.APROVACAO_CQ          AS APROVACAO_CQ, 
       GERAL.OBS_CQ                AS OBS_CQ, 
       GERAL.APROVACAO_COMPRAS     AS APROVACAO_COMPRAS, 
       GERAL.OBS_COMPRAS           AS OBS_COMPRAS, 
       GERAL.APROVACAO_MODELAGEM   AS APROVACAO_MODELAGEM, 
       GERAL.OBS_MODELAGEM         AS OBS_MODELAGEM, 
       GERAL.STATUS_ENTREGA        AS STATUS_ENTREGA, 
       GERAL.OBSERVACAO            AS OBSERVACAO,
	   MAX(DBO.FX_DATA_ENTRADA('R',GERAL.NF_ENTRADA,GERAL.NOME_CLIFOR, GERAL.SERIE_NF_ENTRADA))	AS RECEBIMENTO_DZAIACOOK
	   
FROM  (SELECT 'CAEDU' 
                    AS 
                    EMPRESA, 
              (SELECT TOP 1 CASE ID_EMPRESA 
                              WHEN 1 THEN 'SP' 
                              ELSE 'SC' 
                            END 
               FROM   PORTAL_FORNECEDOR.DBO.LOGIN 
               WHERE  Upper(Rtrim(Ltrim(NOME))) = 
                      Rtrim(Ltrim(FORNECEDORES.FORNECEDOR))) AS 
              DESTINO, 
              PRODUTOS.GRIFFE, 
              Max(ISNULL(AMI.ID, 0)) 
                    AS isento, 
              COMPRAS.REQUERIDO_POR, 
              --ENT.RECEBIMENTO 
              --      RECEBIMENTO2, 

			  --(SELECT MAX(ISNULL(ENTRADAS.RECEBIMENTO,'')) AS RECEBIMENTO
			  --FROM ENTRADAS 
			  --WHERE ENTRADAS.NF_ENTRADA =PENT.NF_ENTRADA AND ENTRADAS.NOME_CLIFOR=PENT.NOME_CLIFOR AND ENTRADAS.SERIE_NF_ENTRADA=PENT.SERIE_NF_ENTRADA
			  --) AS RECEBIMENTO,

              Cast(Max(COMPRAS.TOT_QTDE_ORIGINAL) AS INT) 
                    QTDE_ENTREGAR, 
              COMPRAS_PRODUTO.QTDE_ENTREGUE 
                    QTDE_ENTREGUE, 
              Sum(RECEBIMENTO_PEDIDO.QTDE_AGENDADA) 
                    qtde_agendada, 
              PRODUTOS.LINHA, 
              PRODUTOS.GRUPO_PRODUTO, 
              PRODUTOS.SUBGRUPO_PRODUTO, 
              FORNECEDORES.FORNECEDOR, 
              Max(PRODUTOS.CONTINUIDADE) 
                    AS CONTINUIDADE, 
              COMPRAS.PEDIDO, 
              COMPRAS_PRODUTO.PRODUTO, 
              COMPRAS.TIPO_COMPRA, 
              PRODUTOS.DESC_PRODUTO, 
              Max(COMPRAS.EMISSAO) 
                    AS EMISSAO, 
              Max(COMPRAS_PRODUTO.ENTREGA) 
                    AS ENTREGA, 
              Max(COMPRAS_PRODUTO.LIMITE_ENTREGA) 
                    AS LIMITE_ENTREGA, 
              Max(RECEBIMENTO_PRODUTO.DATA_AGENDAMENTO) 
                    AS DATA_AGENDAMENTO, 
              Max(RECEBIMENTO_PRODUTO.DATA_CHEGADA) 
                    AS DATA_CHEGADA, 
              Max(RECEBIMENTO_PRODUTO.ID) 
                    AS CODIGO_AGENDA, 
              LAUDO.STATUS_1 
                    APROVACAO_CQ, 
              LAUDO.STATUS_2 
                    AS APROVACAO_COMPRAS, 
              LAUDO.STATUS_3 
                    AS APROVACAO_MODELAGEM, 
              LAUDO.OBS_1 
                    AS OBS_CQ, 
              LAUDO.OBS_2 
                    AS OBS_COMPRAS, 
              LAUDO.OBS_3 
                    AS OBS_MODELAGEM, 
              '' 
                    AS STATUS_ENTREGA, 
              '' 
                    AS OBSERVACAO,
			  MAX(PENT.NF_ENTRADA) AS NF_ENTRADA ,
			  MAX(PENT.NOME_CLIFOR) AS NOME_CLIFOR,
			  MAX(PENT.SERIE_NF_ENTRADA) AS SERIE_NF_ENTRADA		 
       FROM   CAEDU.DBO.COMPRAS 
              INNER JOIN CAEDU.DBO.COMPRAS_PRODUTO 
                      ON( COMPRAS_PRODUTO.PEDIDO = COMPRAS.PEDIDO ) 
              LEFT JOIN PORTAL_FORNECEDOR.DBO.AMOSTRA_ISENTAR AMI 
                     ON( COMPRAS_PRODUTO.PEDIDO = AMI.PEDIDO 
                         AND COMPRAS_PRODUTO.PRODUTO = AMI.PRODUTO ) 
              JOIN CAEDU.DBO.FORNECEDORES 
                ON FORNECEDORES.FORNECEDOR = COMPRAS.FORNECEDOR 
              INNER JOIN CAEDU.DBO.PRODUTOS 
                      ON PRODUTOS.PRODUTO = COMPRAS_PRODUTO.PRODUTO 
              LEFT JOIN [CAEDU].[DBO].[ESTOQUE_PROD1_ENT] P1ENT 
                     ON( P1ENT.PEDIDO2 = COMPRAS.PEDIDO ) 
              LEFT JOIN [CAEDU].[DBO].[ESTOQUE_PROD_ENT] PENT 
                     ON( PENT.ROMANEIO_PRODUTO = P1ENT.ROMANEIO_PRODUTO 
                         AND PENT.FILIAL = P1ENT.FILIAL ) 
              --LEFT JOIN [CAEDU].[DBO].[ENTRADAS] ENT 
              --       ON( ENT.NF_ENTRADA = PENT.NF_ENTRADA 
              --           AND ENT.SERIE_NF_ENTRADA = PENT.SERIE_NF_ENTRADA 
              --           AND ENT.NOME_CLIFOR = PENT.NOME_CLIFOR 
              --           AND ENT.FILIAL = 'CONTROLE DE QUALIDADE' ) 
              LEFT JOIN PORTAL_FORNECEDOR.DBO.RECEBIMENTO_PEDIDO 
                     ON ( COMPRAS_PRODUTO.PEDIDO = RECEBIMENTO_PEDIDO.PEDIDO 
                          AND PRODUTOS.PRODUTO = RECEBIMENTO_PEDIDO.PRODUTO 
                          AND COMPRAS_PRODUTO.PRODUTO = PRODUTOS.PRODUTO 
                          AND COMPRAS.PEDIDO = RECEBIMENTO_PEDIDO.PEDIDO ) 
              LEFT JOIN PORTAL_FORNECEDOR.DBO.RECEBIMENTO_PRODUTO 
                     ON( RECEBIMENTO_PRODUTO.ID = 
                         RECEBIMENTO_PEDIDO.RECEBIMENTO_PRODUTO_ID ) 
              LEFT JOIN PORTAL_FORNECEDOR.DBO.LAUDO_INSPECAO LAUDO 
                     ON( LAUDO.PRODUTO = COMPRAS_PRODUTO.PRODUTO 
                         AND LAUDO.PEDIDO = COMPRAS_PRODUTO.PEDIDO ) 
       WHERE  CAEDU.DBO.COMPRAS_PRODUTO.PEDIDO = '172937' 
       GROUP  BY COMPRAS_PRODUTO.PRODUTO, 
                 COMPRAS.PEDIDO, 
                 COMPRAS.REQUERIDO_POR, 
                 COMPRAS.TIPO_COMPRA, 
                 PRODUTOS.LINHA, 
                 --ENT.RECEBIMENTO, 
                 COMPRAS_PRODUTO.QTDE_ENTREGUE, 
                 PRODUTOS.GRUPO_PRODUTO, 
                 PRODUTOS.SUBGRUPO_PRODUTO, 
                 COMPRAS_PRODUTO.COR_PRODUTO, 
                 FORNECEDORES.FORNECEDOR, 
                 FORNECEDORES.COD_FORNECEDOR, 
                 COMPRAS.EMISSAO, 
                 COMPRAS.TRANSPORTADORA, 
                 PRODUTOS.DESC_PRODUTO, 
                 PRODUTOS.GRIFFE, 
                 LAUDO.STATUS_1, 
                 LAUDO.STATUS_2, 
                 LAUDO.STATUS_3, 
                 LAUDO.OBS_1, 
                 LAUDO.OBS_2, 
                 LAUDO.OBS_3) AS GERAL 

GROUP  BY GERAL.EMPRESA, 
          GERAL.DESTINO, 
          GERAL.GRIFFE, 
          GERAL.REQUERIDO_POR, 
          GERAL.LINHA, 
          GERAL.GRUPO_PRODUTO, 
          GERAL.SUBGRUPO_PRODUTO, 
          GERAL.FORNECEDOR, 
          GERAL.PEDIDO, 
          GERAL.PRODUTO, 
          GERAL.TIPO_COMPRA, 
          GERAL.DESC_PRODUTO, 
          GERAL.EMISSAO, 
          GERAL.ENTREGA, 
          GERAL.LIMITE_ENTREGA, 
          GERAL.APROVACAO_CQ, 
          GERAL.OBS_CQ, 
          GERAL.APROVACAO_COMPRAS, 
          GERAL.OBS_COMPRAS, 
          GERAL.APROVACAO_MODELAGEM, 
          GERAL.OBS_MODELAGEM, 
          GERAL.STATUS_ENTREGA, 
          GERAL.QTDE_ENTREGAR, 
          GERAL.OBSERVACAO, 
          GERAL.EMPRESA 
ORDER  BY GERAL.FORNECEDOR, 
          GERAL.PEDIDO, 
          GERAL.PRODUTO 
/*      
       select * from estoque_prod1_ent where pedido2 = '172937'; 
        
       select * from estoque_prod_ent where romaneio_produto = '4006579' 
       --000019422       
       --CHADY CONFECÇÕES        
       -- 001    
       select recebimento,* from entradas where NF_ENTRADA = '000019422' and nome_clifor = 'CHADY CONFECÇÕES'
       and serie_nf_entrada = '001'; 


SELECT DBO.FX_DATA_ENTRADA('R','000019422','CHADY CONFECÇÕES','001')


(
	@PDATA AS CHAR(1), @PNF CHAR(15), @PNOME_CLIFOR VARCHAR(25), @PSERIE VARCHAR(6)
)
*/ 