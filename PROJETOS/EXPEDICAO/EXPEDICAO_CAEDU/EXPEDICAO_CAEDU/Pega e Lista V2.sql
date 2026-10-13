--Conferindo com base em Romaneio do Maelson
--Processo sempre de CD BARRA VELHA para CD SAO ROQUE

000016374	A0585979	376920	IMAGEM KIDS	283
000016375	A0578656	375151	IMAGEM KIDS	245
Select entrada_encerrada,* 
--update LE set entrada_Encerrada = 0
from LOJA_ENTRADAS LE where romaneio_produto  
in ('A0282004')
go

Select ROMANEIO_NF_SAIDA,* FROM LOJA_ENTRADAS where romaneio_produto = 'A0289084'
GO
--O PEDIDO apresentado sempre usar para usar Listar
--**SEMPRE SÉRIE 010
SELECT PEDIDO,*
FROM FATURAMENTO_PROD WHERE NF_SAIDA = '000017251' AND FILIAL = 'CD BARRA VELHA' AND SERIE_NF = '010'
GO
--SELECT * FROM CSM_TRANSITO_NOTAS WHERE PEDIDO_TRANSFERENCIA = '129508'
--GO
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
												 WHERE A.PEDIDO_TRANSFERENCIA IN ('135041')       
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
