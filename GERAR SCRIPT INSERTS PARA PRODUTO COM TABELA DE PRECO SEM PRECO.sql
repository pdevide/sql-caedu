DECLARE @columns NVARCHAR(MAX), @whereClause NVARCHAR(MAX), @sql NVARCHAR(MAX);
DECLARE @dataAtual VARCHAR(8) = CONVERT(VARCHAR(8), GETDATE(), 112); -- Formato AAAAMMDD
DECLARE @PRECO1 VARCHAR(20) = '15.99'; -- Defina o preço padrão aqui
DECLARE @PRODUTO VARCHAR(50) = '62020009'; -- Defina o código do produto aqui

-- Gera a lista de colunas dinamicamente (SQL 2016 compatible)
SELECT @columns = STUFF((
    SELECT ',' + QUOTENAME(CODIGO_TAB_PRECO)
    FROM (
        SELECT DISTINCT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> 'MATRIZ'
    ) AS codes
    ORDER BY CODIGO_TAB_PRECO
    FOR XML PATH('')
), 1, 1, '');

-- Gera a cláusula WHERE com OR entre as colunas
SELECT @whereClause = STUFF((
    SELECT ' OR ' + QUOTENAME(CODIGO_TAB_PRECO) + ' IS NULL'
    FROM (
        SELECT DISTINCT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> 'MATRIZ'
    ) AS codes
    ORDER BY CODIGO_TAB_PRECO
    FOR XML PATH('')
), 1, 4, '');

-- Monta a query dinâmica que gera os INSERTs
SET @sql = N'
SELECT 
    ''INSERT INTO PRODUTOS_PRECOS '' +
    ''(CODIGO_TAB_PRECO,PRODUTO,PRECO1,PRECO2,PRECO3,PRECO4,LIMITE_DESCONTO,PROMOCAO_DESCONTO,PROMOCAO_ATACADO,ULT_ATUALIZACAO) '' +
    ''VALUES ('''''' + tab.CODIGO_TAB_PRECO + '''''','''''' + RTRIM(pv.PRODUTO) + '''''','''''' + @PRECO1 + '''''',''''0.00'''',''''0.00'''',''''0.00'''',''''0.00000'''',''''0.00000'''',''''0.00000'''','''''' + @dataAtual + '''''');'' AS ScriptInsert
FROM (
    SELECT 
        PRODUTO,
        ' + @columns + '
    FROM (
        SELECT 
            PP.PRODUTO,
            PP.CODIGO_TAB_PRECO,
            PP.PRECO1
        FROM PRODUTOS_PRECOS PP
        WHERE PP.PRODUTO = @PRODUTO
          AND PP.CODIGO_TAB_PRECO IN (
              SELECT A.CODIGO_TAB_PRECO 
              FROM TABELAS_PRECO A
              INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
              WHERE A.INATIVO = 0 
                AND B.ATIVO = 1 
                AND B.LOJA <> ''MATRIZ''
          )
    ) AS SourceTable
    PIVOT (
        MAX(PRECO1)
        FOR CODIGO_TAB_PRECO IN (' + @columns + ')
    ) AS PivotTable
    WHERE ' + @whereClause + '
) pv
CROSS APPLY (
    SELECT CODIGO_TAB_PRECO 
    FROM (
        SELECT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> ''MATRIZ''
    ) tabs
) tab';

-- Adiciona condições para verificar se cada coluna específica está NULL
DECLARE @columnList TABLE (CODIGO_TAB_PRECO VARCHAR(50));
INSERT INTO @columnList
SELECT DISTINCT A.CODIGO_TAB_PRECO 
FROM TABELAS_PRECO A
INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
WHERE A.INATIVO = 0 
  AND B.ATIVO = 1 
  AND B.LOJA <> 'MATRIZ'
ORDER BY A.CODIGO_TAB_PRECO;

DECLARE @colName VARCHAR(50);
DECLARE @whereCondition NVARCHAR(MAX) = '';
DECLARE col_cursor CURSOR FOR SELECT CODIGO_TAB_PRECO FROM @columnList;
OPEN col_cursor;
FETCH NEXT FROM col_cursor INTO @colName;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @whereCondition <> ''
        SET @whereCondition = @whereCondition + ' OR ';

    SET @whereCondition = @whereCondition + '(tab.CODIGO_TAB_PRECO = ''' + @colName + ''' AND pv.' + QUOTENAME(@colName) + ' IS NULL)';

    FETCH NEXT FROM col_cursor INTO @colName;
END;

CLOSE col_cursor;
DEALLOCATE col_cursor;

SET @sql = @sql + ' WHERE ' + @whereCondition + ' ORDER BY tab.CODIGO_TAB_PRECO;';

EXEC sp_executesql @sql, N'@PRODUTO VARCHAR(50), @PRECO1 VARCHAR(20), @dataAtual VARCHAR(8)', @PRODUTO, @PRECO1, @dataAtual;
