/*
PRODUÇÃO
*/

--declare @tabela varchar(100) 
--set @tabela = 'CLIENTES_ATACADO'

--select so.name, so.type, sc.*
--from syscolumns sc
--inner join sysobjects so on so.id=sc.id
--where sc.id = object_id(@tabela)
--order by colid

--SELECT
--    o.name      AS TABELA,
--    COUNT(c.id) AS QTD_COLUNAS
--FROM sysobjects o
--INNER JOIN syscolumns c ON c.id = o.id
--WHERE o.xtype = 'U'
--GROUP BY o.name
--ORDER BY o.name


SELECT
    o.name      AS TABELA,
    c.*     
FROM sysobjects o
INNER JOIN syscolumns c ON c.id = o.id
WHERE o.xtype = 'U'
and o.name in 
('CADASTRO_ITEM_FISCAL'
,'CTB_CHEQUE_CARTAO_ENVIADO'
,'CTB_EXCECAO_IMPOSTO'
,'CTB_EXCECAO_IMPOSTO_ITEM'
,'CTB_LX_IMPOSTO_TIPO'
,'ENTRADAS'
,'ESTOQUE_PROD_ENT'
,'ESTOQUE_PROD_SAI'
,'LF_SUB_ITEM_APURACAO'
,'LOJA_CAIXA_LANCAMENTOS'
,'LOJA_CAIXA_TIPOS'
,'LOJA_PEDIDO'
,'LOJA_VENDA'
,'LX_PROCESSO_LOG'
,'MDE_NFE'
,'NFE_EVENTO'
,'NFE_XML_IMPORTACAO_ARQUIVO'
,'NFE_XML_IMPORTACAO_ARQUIVO_LOG'
,'PRODUTOS'
,'RH_TABELA_PROGRESSIVA'
,'USERS'
,'VENDAS')
order by o.name, c.colid





