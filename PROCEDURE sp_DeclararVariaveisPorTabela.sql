--sp_DeclararVariaveisPorTabela 'FATURAMENTO'

CREATE OR ALTER PROCEDURE sp_DeclararVariaveisPorTabela --'FATURAMENTO'
    @NomeTabela NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = '';
    
    -- Cria uma consulta para obter as colunas e seus tipos
    SELECT 
			'DECLARE @' + c.name + ' ' + 
                t.name + 
                CASE 
                    WHEN t.name IN ('varchar', 'nvarchar', 'char', 'nchar') 
                        THEN '(' + IIF(c.max_length = -1, 'MAX', CAST(c.max_length AS VARCHAR)) + ')'
                    WHEN t.name IN ('decimal', 'numeric') 
                        THEN '(' + CAST(c.precision AS VARCHAR) + ',' + CAST(c.scale AS VARCHAR) + ')'
                    ELSE ''
                END + ';' + CHAR(13) + CHAR(10)
    FROM 
        sys.columns c
    JOIN 
        sys.types t ON c.user_type_id = t.user_type_id
    WHERE 
        c.object_id = OBJECT_ID(@NomeTabela);

    -- Exibir o script gerado
    --PRINT @sql;
END;
GO
