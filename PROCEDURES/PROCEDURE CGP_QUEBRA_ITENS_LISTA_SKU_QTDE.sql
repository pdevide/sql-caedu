CREATE OR ALTER PROCEDURE [dbo].[CGP_QUEBRA_ITENS_LISTA_SKU_QTDE]
/*
DESCRIÇÃO /OBJETIVO:
LISTA DE ITENS PARA O FATURAMENTO
FORMATO: SKU, QTDE, CAIXA
DELIMITADOR ENTRE GRUPOS: ;
DELIMITADOR ENTRE CAMPOS DO GRUPO: ,
NO ULTIMO GRUPO NÃO INFORMAR ;
AUTOR: PAULO DEVIDE
DATA CRIAÇÃO: 28-06-2026
DATA ALTERAÇÃO: 26-08-2026 - Inclusão do parâmetro CAIXA na lista de itens
*/
    @lista_itens varchar(max)
--exemplo de lista
--set @lista_itens = '012264990000301,8,C01;012264990000302,2,C01;012264990000303,8,C02;012264990000304,10,C02;012264990000305,7,C03'
/*
exec  CGP_QUEBRA_ITENS_LISTA_SKU_QTDE '012264990000301,8,C01;012264990000302,2,C02;012264990000303,8,C03;012264990000304,10,C04;012264990000305,7,C05'
*/

AS
BEGIN
    DECLARE @tab_itens TABLE (
        id_rows      INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
        codigo_barra VARCHAR(25)  NOT NULL,
        qtde         INT          NOT NULL,
        caixa        VARCHAR(8)       NULL
    )

    DECLARE @tab_itens_nf TABLE (
        id_rows int not null primary key,
        codigo_barra varchar(25) not null,
        qtde int not null,
        PRODUTO varchar(12) not null,
        COR_PRODUTO varchar(10) not null,
        POSICAO INT NOT NULL,
        GRADE_SKU VARCHAR(25) NOT NULL,
        GRADE_PRODUTO VARCHAR(25) NOT NULL,
        PRECO_TRANSFERENCIA NUMERIC(14,2) NOT NULL,
        CAIXA VARCHAR(8) NULL
    )

    -- Converte a lista em XML com dois níveis (item / valor) para extrair os 3 campos
    DECLARE @xml XML
    SET @xml = CAST(
        '<i><v>' +
        REPLACE(REPLACE(@lista_itens, ';', '</v></i><i><v>'), ',', '</v><v>') +
        '</v></i>'
        AS XML)

    INSERT INTO @tab_itens (codigo_barra, qtde, caixa)
    SELECT
        LTRIM(RTRIM(item.value('(v[1]/text())[1]', 'VARCHAR(25)'))) AS codigo_barra,
        CAST(LTRIM(RTRIM(item.value('(v[2]/text())[1]', 'VARCHAR(20)'))) AS INT) AS qtde,
        LTRIM(RTRIM(item.value('(v[3]/text())[1]', 'VARCHAR(8)'))) AS caixa
    FROM @xml.nodes('/i') AS T(item)

    -- Carrega resultado para tabela de itens de faturamento
    INSERT INTO @tab_itens_nf
    SELECT a.id_rows, pb.CODIGO_BARRA, a.qtde, pb.PRODUTO, pb.COR_PRODUTO, pb.TAMANHO, pb.GRADE, p.GRADE, isnull(pp.PRECO1,1), a.caixa
    FROM @tab_itens a
    INNER JOIN produtos_barra pb on pb.codigo_barra = a.codigo_barra
    INNER JOIN produtos p on p.produto = pb.produto
    INNER JOIN produtos_precos pp on pp.PRODUTO=pb.PRODUTO and pp.CODIGO_TAB_PRECO='02'
    INNER JOIN (
        SELECT
            pt.GRADE,
            v.Posicao       AS Tamanho_Posicao,
            v.TamanhoValor  AS Tamanho
        FROM dbo.PRODUTOS_TAMANHOS AS pt
        CROSS APPLY (
            VALUES
                (1,  pt.TAMANHO_1),
                (2,  pt.TAMANHO_2),
                (3,  pt.TAMANHO_3),
                (4,  pt.TAMANHO_4),
                (5,  pt.TAMANHO_5),
                (6,  pt.TAMANHO_6),
                (7,  pt.TAMANHO_7),
                (8,  pt.TAMANHO_8),
                (9,  pt.TAMANHO_9),
                (10, pt.TAMANHO_10),
                (11, pt.TAMANHO_11),
                (12, pt.TAMANHO_12),
                (13, pt.TAMANHO_13),
                (14, pt.TAMANHO_14),
                (15, pt.TAMANHO_15),
                (16, pt.TAMANHO_16)
        ) AS v(Posicao, TamanhoValor)
        WHERE
            v.TamanhoValor IS NOT NULL
            AND LTRIM(RTRIM(v.TamanhoValor)) <> ''
            AND v.TamanhoValor NOT LIKE '%.%'
    ) t on t.GRADE = p.GRADE and pb.TAMANHO=t.Tamanho_Posicao
    order by a.id_rows

    -- retorna um dataset estruturado
    select * from @tab_itens_nf
END