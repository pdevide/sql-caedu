
select b.* 
from estoque_prod_ent a
inner join csm_transito_notas b on b.nf_entrada=a.nf_entrada and b.nome_clifor=a.nome_clifor and b.SERIE_NF_ENTRADA=a.SERIE_NF_ENTRADA
where a.pedido='348063'

select * from faturamento_prod 
where 
pedido = '117352'      
--nf_saida='000004639' and filial='CD BARRA VELHA'

select A.ENTRADA_ENCERRADA,* 
from loja_entradas a
inner join loja_entradas_produto b 
	on b.romaneio_produto = a.romaneio_produto and b.filial=a.filial
WHERE A.NUMERO_NF_TRANSFERENCIA='000004660' AND FILIAL_ORIGEM='CD BARRA VELHA' AND A.FILIAL='CD - SP - SAO ROQUE'
--a.romaneio_produto = 'A0516997'




	SELECT DISTINCT RTRIM(LE.ROMANEIO_PRODUTO) pedido 
								 , RTRIM(B.COD_FILIAL) CodigoFilial 
								 , RTRIM(A.CAIXA) caixa
								 , RTRIM(A.CAIXA)  CodigoDistribuicao 
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
												 WHERE A.PEDIDO_TRANSFERENCIA IN ('117334')       
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
