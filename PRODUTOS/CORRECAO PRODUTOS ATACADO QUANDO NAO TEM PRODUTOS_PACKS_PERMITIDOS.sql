SELECT 
       RTRIM(A.PRODUTO) AS Codigo_Produto,
       RTRIM(A.DESC_PRODUTO) AS Desc_Produto,
       ISNULL(RTRIM(A.COD_CATEGORIA), '') AS Categoria_01,
       ISNULL(RTRIM(A.COD_SUBCATEGORIA), '') AS Categoria_02,
       RTRIM(A.GRUPO_PRODUTO) AS Categoria_03,
       RTRIM(A.COLECAO) AS Categoria_04,
       RTRIM(A.SUBGRUPO_PRODUTO) AS Categoria_05,
       RTRIM(A.LINHA) AS Categoria_06,
       RTRIM(A.FABRICANTE) AS Fabricante,
       RTRIM(A.ALTURA) AS Altura,
       RTRIM(A.LARGURA) AS Largura,
       RTRIM(A.COMPRIMENTO) AS Comprimento
       --, A.DATA_PARA_TRANSFERENCIA
FROM PRODUTOS A
JOIN PRODUTOS_BARRA B
    ON A.PRODUTO = B.PRODUTO
JOIN PRODUTO_CORES C
    ON B.PRODUTO = C.PRODUTO
   AND C.COR_PRODUTO = B.COR_PRODUTO
WHERE CONVERT(DATE, ISNULL(A.DATA_PARA_TRANSFERENCIA, '19000101')) >= (GETDATE() - 5)
and A.PRODUTO 
--IN ('38031528','45030643')
IN (
SELECT DISTINCT PRODUTO
FROM COMPRAS_PRODUTO 
WHERE PEDIDO IN 
('373269' 
,'373344' 
,'373276' 
,'373295' 
,'373167E' 
,'373353' 
,'375945'
,'373300' 
,'373280' 
,'373298' 
,'373294' 
,'37563'
,'375623' 
,'375632' 
,'375607' 
,'373980' 
,'375608' 
,'375627' 
,'374109' 
,'373257' 
,'373253' 
,'373255' 
,'373256' 
,'373254'))

ORDER BY A.DATA_PARA_TRANSFERENCIA DESC;



SELECT P.DATA_UMODE, P.GRADE, P.PRODUTO, p.inativo, PP.* 
--UPDATE PP SET PACK='A', INATIVO=0
--update p set inativo = 0
FROM PRODUTOS P 
LEFT JOIN PRODUTOS_PACKS_PERMITIDOS PP ON PP.PRODUTO = P.PRODUTO 
--LEFT JOIN PRODUTOS_BARRA PP ON PP.PRODUTO = P.PRODUTO 
--LEFT JOIN PRODUTOS_PRECOS PP ON PP.PRODUTO = P.PRODUTO 
WHERE 
--P.PRODUTO IN ('38031528','45030643')

P.PRODUTO IN
 (
SELECT DISTINCT PRODUTO
FROM COMPRAS_PRODUTO 
WHERE PEDIDO IN 
('373269' 
,'373344' 
,'373276' 
,'373295' 
,'373167E' 
,'373353' 
,'375945'
,'373300' 
,'373280' 
,'373298' 
,'373294' 
,'37563'
,'375623' 
,'375632' 
,'375607' 
,'373980' 
,'375608' 
,'375627' 
,'374109' 
,'373257' 
,'373253' 
,'373255' 
,'373256' 
,'373254'))



SELECT P.GRADE, B.* 
FROM COMPRAS_PRODUTO A
INNER JOIN CAEDU_COMPRAS_PRODUTOS_PACKS B ON B.PRODUTO=A.PRODUTO AND B.COR_PRODUTO=A.COR_PRODUTO
INNER JOIN PRODUTOS P ON P.PRODUTO = A.PRODUTO
WHERE A.PRODUTO IN ('38031528','45030643')

INSERT INTO PRODUTOS_PACKS_PERMITIDOS
(PRODUTO
,PACK
,QTDE
,Q1
,Q2
,Q3
,Q4
,Q5
,Q6
,Q7
,Q8
,Q9
,Q10
,Q11
,Q12
,Q13
,Q14
,Q15
,Q16
,Q17
,Q18
,Q19
,Q20
,Q21
,Q22
,Q23
,Q24
,Q25
,Q26
,Q27
,Q28
,Q29
,Q30
,Q31
,Q32
,Q33
,Q34
,Q35
,Q36
,Q37
,Q38
,Q39
,Q40
,Q41
,Q42
,Q43
,Q44
,Q45
,Q46
,Q47
,Q48
,DATA_PARA_TRANSFERENCIA
,COR_PRODUTO
,INDICA_PACK_COR
,INATIVO)
SELECT DISTINCT
B.PRODUTO
,A.PACKS
,B.QTDE
,Q1
,Q2
,Q3
,Q4
,Q5
,Q6
,Q7
,Q8
,Q9
,Q10
,Q11
,Q12
,Q13
,Q14
,Q15
,Q16
,Q17
,Q18
,Q19
,Q20
,Q21
,Q22
,Q23
,Q24
,Q25
,Q26
,Q27
,Q28
,Q29
,Q30
,Q31
,Q32
,Q33
,Q34
,Q35
,Q36
,Q37
,Q38
,Q39
,Q40
,Q41
,Q42
,Q43
,Q44
,Q45
,Q46
,Q47
,Q48
,GETDATE() AS DATA_PARA_TRANSFERENCIA
,B.COR_PRODUTO
,0 INDICA_PACK_COR
,INATIVO
FROM
COMPRAS_PRODUTO A
INNER JOIN CAEDU_COMPRAS_PRODUTOS_PACKS B ON B.PRODUTO=A.PRODUTO AND B.COR_PRODUTO=A.COR_PRODUTO
INNER JOIN PRODUTOS P ON P.PRODUTO = A.PRODUTO
WHERE A.PRODUTO IN ('38031528','45030643')


SELECT DISTINCT PRODUTO
FROM COMPRAS_PRODUTO 
WHERE PEDIDO IN 
('373269' 
,'373344' 
,'373276' 
,'373295' 
,'373167E' 
,'373353' 
,'375945'
,'373300' 
,'373280' 
,'373298' 
,'373294' 
,'37563'
,'375623' 
,'375632' 
,'375607' 
,'373980' 
,'375608' 
,'375627' 
,'374109' 
,'373257' 
,'373253' 
,'373255' 
,'373256' 
,'373254')




SELECT  RTRIM(A.PRODUTO)                            AS Codigo_Produto
                      , RTRIM(A.DESC_PRODUTO)                 AS Desc_Produto
                      , ISNULL(RTRIM(A.COD_CATEGORIA),'')     AS Categoria_01
                      , ISNULL(RTRIM(A.COD_SUBCATEGORIA),'')     AS Categoria_02
                      , RTRIM(A.GRUPO_PRODUTO)                 AS Categoria_03
                      , RTRIM(A.COLECAO)                     AS Categoria_04
                      , RTRIM(A.SUBGRUPO_PRODUTO)               AS Categoria_05
                     ---- , ISNULL(PP.PRECO1 ,0.00)                   AS PrecoVenda 
                       , RTRIM( A.GRIFFE)                   AS Fabricante
                      , RTRIM(ISNULL(A.ALTURA,0))         AS Altura
                      , RTRIM(ISNULL(A.LARGURA,0))             AS Largura
                      , RTRIM(ISNULL(A.COMPRIMENTO,0))         AS Comprimento
                   , A.DATA_PARA_TRANSFERENCIA
                      , (
                                   SELECT CONCAT(rtrim(BB.PACK),rtrim(BB.PRODUTO)) AS Codigo_Barra
                                  , ''                                 AS Grade
                                  , ''                               AS Tamanho
                                  , ''                               AS Cor_Produto
                                  , RTRIM(BB.PACK)                          AS CodigoPack
                                  , SUM(BB.QTDE)                            AS Quantidade
                                 FROM PRODUTOS BA (NOLOCK) 
                                 JOIN PRODUTOS_PACKS_PERMITIDOS BB  (NOLOCK) 
                                   ON BA.PRODUTO  = BB.PRODUTO  
                                 JOIN PRODUTO_CORES BC  (NOLOCK) 
                                   ON BB.PRODUTO  = BC.PRODUTO 
                                  AND BC.COR_PRODUTO = BB.COR_PRODUTO 
                                WHERE BA.PRODUTO = A.PRODUTO
                               GROUP BY BB.PACK,BB.PRODUTO  FOR JSON PATH 
                       ) AS sBarras
                     FROM PRODUTOS A (NOLOCK) 
                      WHERE A.INATIVO = 0
                                            AND A.DESC_PRODUTO != ''
                                             AND CONVERT(DATE, ISNULL(A.DATA_PARA_TRANSFERENCIA, '19000101')) >= (getdate()-1)
AND a.PRODUTO in 
('18130397'    
,'18130405'    
,'18130411'    
,'18130412'    
,'18130413'    
,'18130428'    
,'45560409'    
,'45560410'    
,'53080511'    
,'F8010001'    
,'T7022141'    
,'T7022142'    
,'T7052193'    
,'S9070250'    
,'S9070249'    
,'S9070248'    
,'S9070247'
,'38031528'
,'45030643')    
ORDER BY A.DATA_PARA_TRANSFERENCIA DESC


update produtos set DATA_PARA_TRANSFERENCIA = getdate()
where produto in 
('38031528'
,'45030643'
,'18130397'    
,'18130405'    
,'18130411'    
,'18130412'    
,'18130413'    
,'18130428'    
,'45560409'    
,'45560410'    
,'53080511'    
,'F8010001'    
,'T7022141'    
,'T7022142'    
,'T7052193'    
,'S9070250'    
,'S9070249'    
,'S9070248'    
,'S9070247')  

