--select count(*) 
--from produtos 
--where ERP_COD_ESQUELETO is not null

--select fc.* 
--from VENDAS_PROD_EMBALADO ve
--inner join faturamento_caixas fc on fc.caixa = ve.caixa
--where ve.caixa in (
--select caixa
--from PDA_WMS_TB_EMBARQUE
--where faturado = 0 and doca = 'FRANCO DA ROCHA CAIXA')

/*
 SELECT RTRIM(A.ROMANEIO_PRODUTO)                        AS CodigoPedido
                 , RTRIM(A.NUMERO_NF_TRANSFERENCIA)                 AS NotaFiscal
                 , RTRIM(A.CHAVE_NFE)                               AS ChaveNfe
                 , RTRIM(A.SERIE_NF_ENTRADA)                        AS Serie
                 , RTRIM(CONVERT(DATE,A.EMISSAO))                   AS Emissao
                 , FN.CLIFOR        AS CodigoFornecedorErp
                 , CASE WHEN FN.CLIFOR IS NULL THEN 0 ELSE 1 END AS ValidFornecedor
                 , ISNULL(FP.PEDIDO,FP.ITEM_CAEDU )                   Pedido
                 , CASE 
                    WHEN   MAX(ISNULL(TAB1.IMPORTADOS,0)) > 0 
                    THEN 'T' ELSE 'TI'  END             AS TipoEntrada
                 , (   SELECT RTRIM(ROMANEIO_PRODUTO)           AS CodigoPedido
                      , RTRIM(PRODUTO)         AS Produto
                      , RTRIM(QUANTIDADE)     AS Quantidade
                      , NULL         AS Custo
                      , NULL         AS Desconto
                      , NULL         AS ValorTotal
                   FROM
                      (
                        SELECT CP.ROMANEIO_PRODUTO
                       , CP.PRODUTO
                       , CP.QTDE_ENTRADA AS QUANTIDADE 
                       FROM LOJA_ENTRADAS_PRODUTO CP  (NOLOCK)
                       JOIN PRODUTOS_BARRA C  (NOLOCK) 
                            ON C.PRODUTO = CP.PRODUTO 
                        AND C.COR_PRODUTO = CP.COR_PRODUTO
                       JOIN LOJA_ENTRADAS  (NOLOCK) D  ON D.ROMANEIO_PRODUTO = CP.ROMANEIO_PRODUTO 
                             AND D.FILIAL = CP.FILIAL
                      WHERE CP.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO
                        AND CP.FILIAL  = A.FILIAL
                      GROUP BY CP.ROMANEIO_PRODUTO
                      , CP.PRODUTO
                      , CP.QTDE_ENTRADA
                      ) p
                     WHERE QUANTIDADE > 0 FOR JSON PATH ) as RecebimentoItens,
                     MAX(ISNULL(TAB1.IMPORTADOS,0)) AS IMPORTADOS,
                     max(fp.item_caedu) AS item_caedu 
                 FROM LOJA_ENTRADAS A  (NOLOCK)
                 JOIN LOJA_ENTRADAS_PRODUTO P   (NOLOCK)
                   ON A.ROMANEIO_PRODUTO = P.ROMANEIO_PRODUTO 
                  AND A.FILIAL = P.FILIAL
                 LEFT JOIN FATURAMENTO_PROD FP (NOLOCK)
                   ON FP.FILIAL = A.FILIAL_ORIGEM
                  AND FP.NF_SAIDA = A.NUMERO_NF_TRANSFERENCIA
                  AND FP.PRODUTO = P.PRODUTO
                  AND FP.COR_PRODUTO = P.COR_PRODUTO
               LEFT JOIN  ( SELECT E.PEDIDO
                    , CP.ERP_CUPS_SEGMENTO
                    , CP.FILIAL_A_ENTREGAR
                    , CP.FORNECEDOR
                    , F.ERP_IMPORTADORA
                    , XX.PEDIDO_TRANSFERENCIA
                    , E.NOME_CLIFOR
                  FROM (
                     SELECT ctn.[NOME_CLIFOR], 
                     [NF_ENTRADA],[SERIE_NF_ENTRADA], 
                     [FILIAL_ENTRADA], [FILIAL],[SERIE_NF],
                     [NF_SAIDA], [DATA], [PEDIDO_TRANSFERENCIA]
                     , ccf.CLIFOR 
                     FROM CSM_TRANSITO_NOTAS CTN 
                     inner join cadastro_cli_for ccf ON ccf.NOME_CLIFOR=ctn.nome_clifor
                     WHERE 
                     CTN.PEDIDO_TRANSFERENCIA IN (
                     SELECT isnull(C.PEDIDO, c.item_caedu) AS PEDIDO
                     FROM LOJA_ENTRADAS A
                     INNER JOIN LOJA_ENTRADAS_PRODUTO B ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO  
                     INNER JOIN FATURAMENTO_PROD C ON C.FILIAL=A.FILIAL_ORIGEM 
                              AND C.NF_SAIDA=A.NUMERO_NF_TRANSFERENCIA 
                              AND C.SERIE_NF=A.SERIE_NF_ENTRADA
                              AND C.PRODUTO=B.PRODUTO
                              AND C.COR_PRODUTO=B.COR_PRODUTO)) XX
                     INNER JOIN ESTOQUE_PROD_ENT E ON E.NF_ENTRADA = XX.NF_ENTRADA 
                              AND E.SERIE_NF_ENTRADA=XX.SERIE_NF_ENTRADA
                              AND E.NOME_CLIFOR = XX.NOME_CLIFOR
                     INNER JOIN COMPRAS CP ON CP.PEDIDO = E.PEDIDO
                     INNER JOIN FORNECEDORES F ON F.FORNECEDOR = CP.FORNECEDOR
                       WHERE F.ERP_IMPORTADORA = 0 
                  ) Z
                ON Z.PEDIDO_TRANSFERENCIA = isnull(fp.item_caedu, FP.PEDIDO)
               LEFT JOIN FILIAIS F  (NOLOCK) ON F.FILIAL = A.FILIAL_ORIGEM
               LEFT JOIN ( SELECT T2.CHAVE_NFE, COUNT(*) AS IMPORTADOS 
                   FROM FATURAMENTO_PROD T1 
                   INNER JOIN FATURAMENTO T2 
                    ON T2.NF_SAIDA = T1.NF_SAIDA AND T2.SERIE_NF = T1.SERIE_NF AND T2.FILIAL = T1.FILIAL
                   INNER JOIN PRODUTOS T3 ON T3.PRODUTO = T1.PRODUTO
                   INNER JOIN FORNECEDORES T4 ON T4.FORNECEDOR = T3.FABRICANTE
                   WHERE  T4.ERP_IMPORTADORA = 1 
                   GROUP BY T2.CHAVE_NFE) TAB1 ON TAB1.CHAVE_NFE = A.CHAVE_NFE 
               LEFT JOIN FORNECEDORES FN  (NOLOCK) ON FN.FORNECEDOR = Z.NOME_CLIFOR
                WHERE ENTRADA_ENCERRADA = 0
                  AND A.FILIAL = 'CD - SP - SAO ROQUE'
               GROUP BY A.ROMANEIO_PRODUTO
                 , A.EMISSAO
                 , A.CHAVE_NFe
                 , A.NUMERO_NF_TRANSFERENCIA
                 , A.SERIE_NF_ENTRADA
                 , A.FORNECEDOR
                 , F.COD_FILIAL
                 , A.FILIAL
                 , FP.PEDIDO 
                 ,FN.CLIFOR
                 ,fp.item_caedu
               ORDER BY A.EMISSAO DESC
*/

/* listar */
 SELECT DISTINCT RTRIM(LE.ROMANEIO_PRODUTO) pedido 
								 , RTRIM(B.COD_FILIAL) CodigoFilial 
								 , RTRIM(A.CAIXA) caixa
								 , RTRIM(A.PEDIDO)  CodigoDistribuicao 
								 , RTRIM(A.PRODUTO) produto
								 , A.QTDE_TOTAL as quantidade
								 , '' cor
								 , '' grade
								 , '' tamanho
								 , RTRIM(Z.LINHA)							Grupo
								 , RTRIM(Z.GRIFFE)							Grife
								 , RTRIM(COLECOES.DESC_COLECAO)				Colecao
								 , CASE 
	 								WHEN Z.COD_CATEGORIA = '2' 
	 								THEN  'Cabide'       
	 								ELSE '' END AS							Cabide       
								 , RTRIM(B.erp_cod_rota)					CodigoRota
								 , ( SELECT	NOME_CLIFOR CaixaNome 
	 								   FROM FATURAMENTO_CAIXAS (NOLOCK)		
	 								  WHERE CAIXA = A.CAIXA )				CaixaNome
								 , RTRIM(B.FILIAL)                          DescricaoFilial
				  FROM CAEDU_RESERVA_AUTOMATICA A  (NOLOCK)
				  JOIN PRODUTOS Z   (NOLOCK)
								ON Z.PRODUTO = A.PRODUTO
LEFT JOIN COLECOES  (nolock) on COLECOES.COLECAO = Z.COLECAO 
				  JOIN FILIAIS B   (NOLOCK)
								ON A.FILIAL = B.FILIAL
				  LEFT JOIN ( SELECT EPE.PEDIDO Pedido,A.PEDIDO_TRANSFERENCIA AS PedidoTransf
												  FROM CSM_TRANSITO_NOTAS A
												  JOIN ENTRADAS E 
													ON E.NOME_CLIFOR = A.NOME_CLIFOR
												   AND E.SERIE_NF_ENTRADA = A.SERIE_NF_ENTRADA
												   AND E.NF_ENTRADA = A.NF_ENTRADA
												  JOIN ESTOQUE_PROD_ENT EPE
													ON EPE.NF_ENTRADA = E.NF_ENTRADA
												   AND EPE.NOME_CLIFOR = E.NOME_CLIFOR
												   AND EPE.SERIE_NF_ENTRADA = E.SERIE_NF_ENTRADA
												 WHERE A.PEDIDO_TRANSFERENCIA IN ('139584')       
												)Y ON Y.Pedido = A.pedido
								JOIN FATURAMENTO_PROD FP (NOLOCK)
								  ON isnull(FP.PEDIDO,fp.item_caedu) = Y.PedidoTransf
								JOIN LOJA_ENTRADAS LE  (NOLOCK)
								  ON FP.FILIAL = LE.FILIAL_ORIGEM
								 AND FP.NF_SAIDA = LE.NUMERO_NF_TRANSFERENCIA
								JOIN LOJA_ENTRADAS_PRODUTO P   (NOLOCK)
								  ON LE.ROMANEIO_PRODUTO = P.ROMANEIO_PRODUTO 
								 AND LE.FILIAL = P.FILIAL
								 AND FP.PRODUTO = P.PRODUTO
								 AND FP.COR_PRODUTO = P.COR_PRODUTO			
				GROUP BY LE.ROMANEIO_PRODUTO  
												   , B.COD_FILIAL 
												   , A.CAIXA   
												   , A.PRODUTO 
												   , A.QTDE_TOTAL
												   , Z.LINHA 
												   , Z.GRIFFE
												   , COLECOES.DESC_COLECAO
												   , Z.COD_CATEGORIA
												   , B.erp_cod_rota
												   , B.FILIAL
												   , A.PEDIDO



 /*
select data,* 
--update a set data = '20261125'
from caedu_reserva_automatica a where pedido in 
('384700'
,'386385'
,'389695'
,'384352'
,'386905'
,'382355'
,'389287'
,'378306E'
,'388496')

select pedido,count(*) 
from caedu_reserva_automatica a where pedido in 
('384700'
,'386385'
,'389695'
,'384352'
,'386905'
,'382355'
,'389287'
,'378306E'
,'388496')
group by pedido


select * 
UPDATE A SET DATA_SALDO_PA = '20261031'
from cm_data_fechamento A
where filial in ('CD BARRA VELHA', 'CD - SP - SAO ROQUE')

select *
from loja_entradas 
where romaneio_produto = 'A1255754'

select pedido,item_caedu, * 
--update fp set item_caedu = '141262'      
from faturamento_prod fp 
where nf_saida = '000022375      '  and filial = 'CD BARRA VELHA' and SERIE_NF='010'               

select c.nf_entrada, c.nome_clifor,  p.* 
from estoque_prod1_ent p
inner join estoque_prod_ent c on c.romaneio_produto = p.romaneio_produto and c.filial=p.filial
where p.produto = 'F0000242    ' and p.cor_produto = '00112' and p.filial = 'cd navegantes'

/* achar pelo pedido de compras */
select c.nf_entrada, c.nome_clifor,  p.* 
from estoque_prod1_ent p
inner join estoque_prod_ent c on c.romaneio_produto = p.romaneio_produto and c.filial=p.filial
where c.pedido = '384700'

select * 
--update csm set pedido_transferencia = null
from csm_transito_notas csm where nf_entrada = '000053510      ' and nome_clifor= 'IMAGEM KIDS              ' 



select * from CGP_PDA_WMS_STATUS_DISTRIBUICAO where distribuicao in ('367431','376352','371468')

*/