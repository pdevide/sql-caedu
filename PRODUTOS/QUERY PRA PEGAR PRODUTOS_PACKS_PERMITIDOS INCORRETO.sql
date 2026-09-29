DECLARE @PRODUTO VARCHAR(8) = 'T7050566'
DECLARE @COR VARCHAR(6) = '00234'

select * 
from ESTOQUE_PRODUTOS E
left join produtos_packs_permitidos pp
	on pp.PRODUTO = e.PRODUTO and pp.COR_PRODUTO=e.COR_PRODUTO
WHERE 1=1
AND E.FILIAL IN (SELECT FILIAL FROM FILIAIS WHERE CGC_CPF='46377727007015') /*CD CAJAMAR*/

/* seleciona estoque se o produto tiver quantidade > 0 em pelo menos 1 posição na grade */
and (es1 > 0 or es2 > 0 or es3 > 0 or es4 > 0 or es5 > 0 or es6 > 0 or es7 > 0 or es8 > 0 
		or es9 > 0 or es10 > 0 or es11 > 0 or es12 > 0 or es13 > 0 or es14 > 0 or es15 > 0 or es16 > 0) 
and pp.produto is null
AND E.PRODUTO = @PRODUTO    



insert into PRODUTOS_PACKS_PERMITIDOS (PRODUTO, PACK, QTDE, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, 
Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, 
Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48, DATA_PARA_TRANSFERENCIA, COR_PRODUTO, 
INDICA_PACK_COR, INATIVO)
select top 1 PRODUTO, PACK, QTDE, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, 
Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, 
Q40, Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48, DATA_PARA_TRANSFERENCIA, @COR      as COR_PRODUTO, INDICA_PACK_COR, INATIVO
From produtos_packs_permitidos where produto = @PRODUTO 


UPDATE A SET PACK = 'B'
FROM PRODUTOS_PACKS_PERMITIDOS A
WHERE PRODUTO = @PRODUTO AND COR_PRODUTO = @COR



/*
SELECT RTRIM(A.ROMANEIO_PRODUTO)                        AS CodigoPedido
									, RTRIM(A.NUMERO_NF_TRANSFERENCIA)                 AS NotaFiscal
									, RTRIM(A.CHAVE_NFE)                               AS ChaveNfe
									, RTRIM(A.SERIE_NF_ENTRADA)                        AS Serie
									, RTRIM(CONVERT(DATE,A.EMISSAO))                   AS Emissao
									, RTRIM(ISNULL(A.FORNECEDOR,F.COD_FILIAL))         AS CodigoFornecedorErp
									, CASE WHEN A.FORNECEDOR IS NULL THEN 0 ELSE 1 END AS ValidFornecedor
								    , 'T'                                              AS TipoEntrada
									, FP.PEDIDO 
									, (   SELECT RTRIM(ROMANEIO_PRODUTO)		         AS CodigoPedido
													 , RTRIM(PRODUTO)				     AS Produto
													 , RTRIM(QUANTIDADE)				 AS Quantidade
													 , NULL								 AS Custo
													 , NULL								 AS Desconto
													 , NULL								 AS ValorTotal
									        FROM
													 (
													   SELECT DISTINCT CP.ROMANEIO_PRODUTO
															, CP.PRODUTO
															, CP.QTDE_ENTRADA AS QUANTIDADE 
														 FROM LOJA_ENTRADAS_PRODUTO CP  (NOLOCK)
														 JOIN PRODUTOS_BARRA C  (NOLOCK) ON C.PRODUTO = CP.PRODUTO 
																			  AND C.COR_PRODUTO = CP.COR_PRODUTO
													     JOIN PRODUTOS_PACKS_PERMITIDOS E   (NOLOCK)
														   ON E.PRODUTO = CP.PRODUTO
														  AND E.COR_PRODUTO =CP.COR_PRODUTO
														 JOIN LOJA_ENTRADAS  (NOLOCK) D  ON D.ROMANEIO_PRODUTO = CP.ROMANEIO_PRODUTO 
																			  AND D.FILIAL = CP.FILIAL
														WHERE CP.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO
														  AND CP.FILIAL  = A.FILIAL
													 GROUP BY CP.ROMANEIO_PRODUTO
														, CP.PRODUTO
														, CP.QTDE_ENTRADA
													 ) p
										   WHERE QUANTIDADE > 0 FOR JSON PATH ) as RecebimentoItens
								 FROM LOJA_ENTRADAS A  (NOLOCK)
								 JOIN LOJA_ENTRADAS_PRODUTO P   (NOLOCK)
								   ON A.ROMANEIO_PRODUTO = P.ROMANEIO_PRODUTO 
							      AND A.FILIAL = P.FILIAL
								 LEFT JOIN FATURAMENTO_PROD FP (NOLOCK)
								   ON FP.FILIAL = A.FILIAL_ORIGEM
								  AND FP.NF_SAIDA = A.NUMERO_NF_TRANSFERENCIA
								  AND FP.PRODUTO = P.PRODUTO
								  AND FP.COR_PRODUTO = P.COR_PRODUTO
							LEFT JOIN  (	SELECT E.PEDIDO
										     , CP.ERP_CUPS_SEGMENTO
											 , CP.FILIAL_A_ENTREGAR
											 , CP.FORNECEDOR
											 , F.ERP_IMPORTADORA
											 , XX.PEDIDO_TRANSFERENCIA
										FROM (
										SELECT * FROM CSM_TRANSITO_NOTAS CTN WHERE 
										CTN.PEDIDO_TRANSFERENCIA IN (
										SELECT C.PEDIDO
										FROM LOJA_ENTRADAS A
										INNER JOIN LOJA_ENTRADAS_PRODUTO B ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO  
										INNER JOIN FATURAMENTO_PROD C ON C.FILIAL=A.FILIAL_ORIGEM 
																			AND C.NF_SAIDA=A.NUMERO_NF_TRANSFERENCIA AND C.PRODUTO=B.PRODUTO
																			AND C.COR_PRODUTO=B.COR_PRODUTO)) XX
										INNER JOIN ESTOQUE_PROD_ENT E ON E.NF_ENTRADA = XX.NF_ENTRADA AND E.SERIE_NF_ENTRADA=XX.SERIE_NF_ENTRADA
																			AND E.NOME_CLIFOR = XX.NOME_CLIFOR
										INNER JOIN COMPRAS CP ON CP.PEDIDO = E.PEDIDO
										INNER JOIN FORNECEDORES F ON F.FORNECEDOR = CP.FORNECEDOR
									   WHERE F.ERP_IMPORTADORA = 0 )Z
								ON Z.PEDIDO_TRANSFERENCIA = FP.PEDIDO
							LEFT JOIN FILIAIS F  (NOLOCK) ON F.FILIAL = A.FILIAL_ORIGEM
							LEFT JOIN FORNECEDORES FN  (NOLOCK) ON FN.FORNECEDOR = A.FORNECEDOR
								WHERE ENTRADA_ENCERRADA = 0
								  AND A.FILIAL = @Origemfilial
								  AND FP.PEDIDO IS NULL
							 GROUP BY A.ROMANEIO_PRODUTO
									, A.EMISSAO
									, A.CHAVE_NFe
									, A.NUMERO_NF_TRANSFERENCIA
									, A.SERIE_NF_ENTRADA
									, A.FORNECEDOR
									, F.COD_FILIAL
									, A.FILIAL
									, FP.PEDIDO 
							 ORDER BY A.EMISSAO DESC
*/



