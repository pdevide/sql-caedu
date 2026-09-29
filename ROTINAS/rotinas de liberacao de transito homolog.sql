--lx_processos
/* lx120024spk  CursorAdapter: cur_v_loja_entradas_transito_01(Alias: v_loja_entradas_transito_01)  */

/*
SELECT * 
FROM LOJA_ENTRADAS
WHERE FILIAL = 'CAMPINAS - BANDEIRAS' AND ROMANEIO_PRODUTO='A0923017'       
SELECT * FROM FATURAMENTO WHERE CHAVE_NFE = '35260946377727011390550010000226881421769679'
select cast(newid() as varchar(50))

SELECT ERP_CUPS_ID_TRANSFERENCIA,* 
update a set ERP_CUPS_ID_TRANSFERENCIA = cast(newid() as varchar(50))
FROM FATURAMENTO a 
WHERE CHAVE_NFE = '35260946377727011390550010000226881421769679'

SELECT ERP_CUPS_ID_TRANSFERENCIA,* 
update a set ERP_CUPS_ID_TRANSFERENCIA = cast(newid() as varchar(50))
FROM FATURAMENTO a 
WHERE CHAVE_NFE = '35260946377727011390550010000226891713255737'

SELECT ERP_CUPS_ID_TRANSFERENCIA,* 
update a set ERP_CUPS_ID_TRANSFERENCIA = cast(newid() as varchar(50))
FROM FATURAMENTO a 
WHERE CHAVE_NFE = '35260946377727011390550010000226901977261449'

SELECT ERP_CUPS_ID_TRANSFERENCIA,* 
update a set ERP_CUPS_ID_TRANSFERENCIA = cast(newid() as varchar(50))
FROM FATURAMENTO a 
WHERE CHAVE_NFE = '35260946377727011390550010000226911622921465'

*/
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
       loja_entradas_dif.status_transito,
       LOJA_ENTRADAS.CHAVE_NFE
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
WHERE  loja_entradas.emissao >= '20260903'
       AND loja_entradas.emissao <= '20260903'
       AND filiais.matriz IN ( 'MATRIZ' )
       AND loja_entradas.entrada_conferida = 0
       AND loja_entradas.entrada_cancelada = 0
       /* verifica se é uma nota fiscal do processo de transferência entre loja vs quiosque ou quiosque vs loja do Danilo */
       AND EXISTS(SELECT 1 
                    FROM FATURAMENTO 
                    WHERE CHAVE_NFE = loja_entradas.CHAVE_NFE AND ERP_CUPS_ID_TRANSFERENCIA IS NOT NULL) 
ORDER  BY emissao ASC,
          filiais.filial 
		  


/* lx120024spk  CursorAdapter: cur_v_loja_entradas_transito_01(Alias: v_loja_entradas_transito_01)  */
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
WHERE  loja_entradas.emissao >= '20260901'
       AND loja_entradas.emissao <= '20260901'
       AND filiais.matriz IN ( 'MATRIZ' )
       AND loja_entradas.entrada_conferida = 0
       AND loja_entradas.entrada_cancelada = 0
ORDER  BY emissao ASC,
          filiais.filial 
		  


--exec sp_executesql N'
/* lx120024spk  CursorAdapter: cur_v_loja_entradas_transito_01_produto(Alias: v_loja_entradas_transito_01_produto)  */
SELECT     produtos.grade,
           loja_entradas_produto.filial,
           loja_entradas_produto.romaneio_produto,
           loja_entradas_produto.produto,
           loja_entradas_produto.cor_produto,
           loja_entradas_produto.en1,
           loja_entradas_produto.en2,
           loja_entradas_produto.en3,
           loja_entradas_produto.en4,
           loja_entradas_produto.en5,
           loja_entradas_produto.en6,
           loja_entradas_produto.en7,
           loja_entradas_produto.en8,
           loja_entradas_produto.en9,
           loja_entradas_produto.en10,
           loja_entradas_produto.en11,
           loja_entradas_produto.en12,
           loja_entradas_produto.en13,
           loja_entradas_produto.en14,
           loja_entradas_produto.en15,
           loja_entradas_produto.en16,
           0 AS en17,
           0 AS en18,
           0 AS en19,
           0 AS en20,
           0 AS en21,
           0 AS en22,
           0 AS en23,
           0 AS en24,
           0 AS en25,
           0 AS en26,
           0 AS en27,
           0 AS en28,
           0 AS en29,
           0 AS en30,
           0 AS en31,
           0 AS en32,
           0 AS en33,
           0 AS en34,
           0 AS en35,
           0 AS en36,
           0 AS en37,
           0 AS en38,
           0 AS en39,
           0 AS en40,
           0 AS en41,
           0 AS en42,
           0 AS en43,
           0 AS en44,
           0 AS en45,
           0 AS en46,
           0 AS en47,
           0 AS en48,
           loja_entradas_produto.valor,
           loja_entradas_produto.preco4,
           loja_entradas_produto.preco3,
           loja_entradas_produto.preco2,
           loja_entradas_produto.preco1,
           loja_entradas_produto.qtde_entrada,
           loja_entradas_produto.cor_sortida_trocada,
           loja_entradas_produto.pedido_compra,
           loja_entradas_produto.pedido
FROM       loja_entradas_produto LOJA_ENTRADAS_PRODUTO
INNER JOIN dbo.produtos PRODUTOS
ON         loja_entradas_produto.produto = produtos.produto
WHERE      loja_entradas_produto.filial = ('BARUERI')
AND        loja_entradas_produto.romaneio_produto = ('A0964531')
ORDER BY   loja_entradas_produto.produto
		   


--exec sp_executesql N'
/* lx120024spk  CursorAdapter: cur_v_loja_entradas_transito_01_produto(Alias: v_loja_entradas_transito_01_produto)  */
SELECT     produtos.grade,
           loja_entradas_produto.filial,
           loja_entradas_produto.romaneio_produto,
           loja_entradas_produto.produto,
           loja_entradas_produto.cor_produto,
           loja_entradas_produto.en1,
           loja_entradas_produto.en2,
           loja_entradas_produto.en3,
           loja_entradas_produto.en4,
           loja_entradas_produto.en5,
           loja_entradas_produto.en6,
           loja_entradas_produto.en7,
           loja_entradas_produto.en8,
           loja_entradas_produto.en9,
           loja_entradas_produto.en10,
           loja_entradas_produto.en11,
           loja_entradas_produto.en12,
           loja_entradas_produto.en13,
           loja_entradas_produto.en14,
           loja_entradas_produto.en15,
           loja_entradas_produto.en16,
           0 AS en17,
           0 AS en18,
           0 AS en19,
           0 AS en20,
           0 AS en21,
           0 AS en22,
           0 AS en23,
           0 AS en24,
           0 AS en25,
           0 AS en26,
           0 AS en27,
           0 AS en28,
           0 AS en29,
           0 AS en30,
           0 AS en31,
           0 AS en32,
           0 AS en33,
           0 AS en34,
           0 AS en35,
           0 AS en36,
           0 AS en37,
           0 AS en38,
           0 AS en39,
           0 AS en40,
           0 AS en41,
           0 AS en42,
           0 AS en43,
           0 AS en44,
           0 AS en45,
           0 AS en46,
           0 AS en47,
           0 AS en48,
           loja_entradas_produto.valor,
           loja_entradas_produto.preco4,
           loja_entradas_produto.preco3,
           loja_entradas_produto.preco2,
           loja_entradas_produto.preco1,
           loja_entradas_produto.qtde_entrada,
           loja_entradas_produto.cor_sortida_trocada,
           loja_entradas_produto.pedido_compra,
           loja_entradas_produto.pedido
FROM       loja_entradas_produto LOJA_ENTRADAS_PRODUTO
INNER JOIN dbo.produtos PRODUTOS
ON         loja_entradas_produto.produto = produtos.produto
WHERE      loja_entradas_produto.filial = ('CIDADE OCIAN')
AND        loja_entradas_produto.romaneio_produto = ('A0989289')
ORDER BY   loja_entradas_produto.produto



-- exec sp_executesql N'
/* lx120024spk  CursorAdapter: cur_v_loja_entradas_transito_01_produto(Alias: v_loja_entradas_transito_01_produto)  */
SELECT     produtos.grade,
           loja_entradas_produto.filial,
           loja_entradas_produto.romaneio_produto,
           loja_entradas_produto.produto,
           loja_entradas_produto.cor_produto,
           loja_entradas_produto.en1,
           loja_entradas_produto.en2,
           loja_entradas_produto.en3,
           loja_entradas_produto.en4,
           loja_entradas_produto.en5,
           loja_entradas_produto.en6,
           loja_entradas_produto.en7,
           loja_entradas_produto.en8,
           loja_entradas_produto.en9,
           loja_entradas_produto.en10,
           loja_entradas_produto.en11,
           loja_entradas_produto.en12,
           loja_entradas_produto.en13,
           loja_entradas_produto.en14,
           loja_entradas_produto.en15,
           loja_entradas_produto.en16,
           0 AS en17,
           0 AS en18,
           0 AS en19,
           0 AS en20,
           0 AS en21,
           0 AS en22,
           0 AS en23,
           0 AS en24,
           0 AS en25,
           0 AS en26,
           0 AS en27,
           0 AS en28,
           0 AS en29,
           0 AS en30,
           0 AS en31,
           0 AS en32,
           0 AS en33,
           0 AS en34,
           0 AS en35,
           0 AS en36,
           0 AS en37,
           0 AS en38,
           0 AS en39,
           0 AS en40,
           0 AS en41,
           0 AS en42,
           0 AS en43,
           0 AS en44,
           0 AS en45,
           0 AS en46,
           0 AS en47,
           0 AS en48,
           loja_entradas_produto.valor,
           loja_entradas_produto.preco4,
           loja_entradas_produto.preco3,
           loja_entradas_produto.preco2,
           loja_entradas_produto.preco1,
           loja_entradas_produto.qtde_entrada,
           loja_entradas_produto.cor_sortida_trocada,
           loja_entradas_produto.pedido_compra,
           loja_entradas_produto.pedido
FROM       loja_entradas_produto LOJA_ENTRADAS_PRODUTO
INNER JOIN dbo.produtos PRODUTOS
ON         loja_entradas_produto.produto = produtos.produto
WHERE      loja_entradas_produto.filial = ('CIDADE TIRADENTES')
AND        loja_entradas_produto.romaneio_produto = ('A0939579')
ORDER BY   loja_entradas_produto.produto

-- exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
UPDATE loja_entradas
SET    entrada_conferida = 1,
       entrada_encerrada = 1,
       status_transito = 4,
       obs = 'retirado do transito pela tela de Liberação'
WHERE  romaneio_produto='A0964531'
AND    filial ='BARUERI'
  

-- exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
UPDATE a
SET        a.data_para_transferencia = Getdate ()
FROM       estoque_produtos a
INNER JOIN loja_entradas_produto b
ON         a.filial = b.filial
AND        a.produto = b.produto
AND        a.cor_produto = b.cor_produto
INNER JOIN loja_entradas c
ON         b.filial = c.filial
AND        b.romaneio_produto = c.romaneio_produto
WHERE      c.romaneio_produto = 'A0964531'
AND        c.filial = 'BARUERI'

-- exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
INSERT INTO loja_processos
(
    codigo_filial,
    sequencia,
    processo,
    comando,
    data_criacao,
    data_processo,
    erro,
    data_para_transferencia
)
VALUES
(
    '000046',
    3364,
    'lx120024 - baixar transito da loja',
    'UPDATE loja_transito SET lancado_loja = 1 WHERE filial_origem = ''cd - sp - sao roque'' AND numero_nf_transferencia = ''000022684''',
    GETDATE(),
    NULL,
    NULL,
    GETDATE()
);
  

-- exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */

UPDATE loja_entradas 
SET entrada_conferida = 1, 
    entrada_encerrada = 1, 
    status_transito = 4, 
    obs = 'Retirado do Transito pela Tela de Liberação' 
WHERE romaneio_produto = 'A0989289' 
  AND filial = 'CIDADE OCIAN';  

-- exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
UPDATE a 
SET a.data_para_transferencia = GETDATE() 
FROM estoque_produtos a  
INNER JOIN LOJA_ENTRADAS_PRODUTO b  
   ON a.FILIAL = b.FILIAL  
  AND a.PRODUTO = b.PRODUTO  
  AND a.COR_PRODUTO = b.COR_PRODUTO  
INNER JOIN loja_entradas c  
   ON b.filial = c.filial  
  AND b.romaneio_produto = c.romaneio_produto  
WHERE c.ROMANEIO_PRODUTO = 'A0989289'  
  AND c.filial = 'CIDADE OCIAN';  

--exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
INSERT INTO LOJA_PROCESSOS 
(
    CODIGO_FILIAL, 
    SEQUENCIA, 
    PROCESSO, 
    COMANDO, 
    DATA_CRIACAO, 
    DATA_PROCESSO, 
    ERRO, 
    DATA_PARA_TRANSFERENCIA
)  
VALUES 
(
    '000059', 
    3246, 
    'LX120024 - BAIXAR TRANSITO DA LOJA', 
    'UPDATE LOJA_TRANSITO SET LANCADO_LOJA = 1 WHERE FILIAL_ORIGEM = ''CD - SP - SAO ROQUE'' AND NUMERO_NF_TRANSFERENCIA = ''000022685'' ', 
    GETDATE(), 
    NULL, 
    NULL, 
    GETDATE() 
);  

--exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
UPDATE loja_entradas 
SET entrada_conferida = 1, 
    entrada_encerrada = 1, 
    status_transito = 4, 
    obs = 'Retirado do Transito pela Tela de Liberação' 
WHERE romaneio_produto = 'A0939579' 
  AND filial = 'CIDADE TIRADENTES';  
  

--exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
UPDATE a 
SET a.data_para_transferencia = GETDATE() 
FROM estoque_produtos a  
INNER JOIN LOJA_ENTRADAS_PRODUTO b  
   ON a.FILIAL = b.FILIAL  
  AND a.PRODUTO = b.PRODUTO  
  AND a.COR_PRODUTO = b.COR_PRODUTO  
INNER JOIN loja_entradas c  
   ON b.filial = c.filial  
  AND b.romaneio_produto = c.romaneio_produto  
WHERE c.ROMANEIO_PRODUTO = 'A0939579'  
  AND c.filial = 'CIDADE TIRADENTES';  

--exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
INSERT INTO LOJA_PROCESSOS 
(
    CODIGO_FILIAL, 
    SEQUENCIA, 
    PROCESSO, 
    COMANDO, 
    DATA_CRIACAO, 
    DATA_PROCESSO, 
    ERRO, 
    DATA_PARA_TRANSFERENCIA
)  
VALUES 
(
    '000056', 
    3243, 
    'LX120024 - BAIXAR TRANSITO DA LOJA', 
    'UPDATE LOJA_TRANSITO SET LANCADO_LOJA = 1 WHERE FILIAL_ORIGEM = ''CD - SP - SAO ROQUE'' AND NUMERO_NF_TRANSFERENCIA = ''000022686'' ', 
    GETDATE(), 
    NULL, 
    NULL, 
    GETDATE() 
);

/*  
SELECT *
FROM SEQUENCIAIS WHERE TABELA_COLUNA LIKE '%LOJA_PROCESSOS%'

SELECT DISTINCT PROCESSO FROM LOJA_PROCESSOS
*/
