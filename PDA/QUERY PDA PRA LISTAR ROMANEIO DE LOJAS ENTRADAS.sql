
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
												 WHERE A.PEDIDO_TRANSFERENCIA IN ('124209')       
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

--select * from loja_entradas where romaneio_produto = 'A0741895' 

--select * from faturamento_prod where nf_saida = '000005441' and filial='CD BARRA VELHA'     

/*
select * from LOJA_ENTRADAS
where romaneio_produto = 'A0725807'

select pedido from faturamento_prod 
where nf_saida='000005607' and filial='cd barra velha'
*/


--SELECT * 
--UPDATE A SET DATA='20250717'
--FROM CAEDU_RESERVA_AUTOMATICA A
--WHERE PEDIDO IN 
--('353456'
--,'353455'
--,'353449'
--,'353448'
--,'353447')
/*
select A.ENTRADA_ENCERRADA,a.entrada_conferida,(SELECT TOP 1 MAX(PEDIDO) FROM FATURAMENTO_PROD WHERE FILIAL='CD BARRA VELHA' AND NF_SAIDA=A.NUMERO_NF_TRANSFERENCIA) AS PEDIDO,           
A.* 
from loja_entradas A
where 1=1
and FILIAl='CD - SP - SAO ROQUE'
and romaneio_produto in
('A0724507'
,'A0729391'
,'A0758742'
,'A0720555'
,'A0753263'
,'A0747570'
,'A0765013'
,'A0758535'
,'A0725687'
,'A0242810'
,'A0727205')


SELECT PEDIDO,* FROM FATURAMENTO_PROD WHERE NF_SAIDA='000000894' AND FILIAL='CD BARRA VELHA' AND SERIE_NF='010'      
*/

