--CGP_QUEBRA_ITENS_LISTA_SKU_QTDE '081100010018301,9;081100010018302,3;081100010018303,9;081100010018304,1;081100020018401,2;081100020018402,8;081100020018403,4;081100020018404,9;081300330014507          ,7;081300330014508          ,1;081300330014509          ,8;081300330014510          ,4;081300350000301          ,6;081300350000302          ,6;081300350000303          ,5;081300350000304          ,6;081300350011201          ,4;081300350011202          ,2;081300350011203          ,1;081300350011204          ,3'

CREATE OR ALTER PROCEDURE CGP_QUEBRA_ITENS_LISTA_SKU_QTDE --'012264990000301,8;012264990000302,2;012264990000303,8;012264990000304,10;012264990000305,7'
/*
DESCRIÇÃO /OBJETIVO:
LISTA DE ITENS PARA O FATURAMENTO
FORMATO: SKU, QTDE
DELIMITADOR: ;
CADA GRUPO DE SKU E QUANTIDADE SÃO DELIMITADOS POR , E AO FINAL SEPARADOS POR ;
NO ULTIMO GRUPO NÃO INFORMAR ;
AUTOR: PAULO DEVIDE
DATA CRIAÇÃO: 28-06-2026
*/
     @LISTA_ITENS varchar(max) 
--exemplo de lista
--set @lista_itens = '012264990000301,8;012264990000302,2;012264990000303,8;012264990000304,10;012264990000305,7'
AS
BEGIN
    DECLARE @tab_itens TABLE (
        id_rows      INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
        codigo_barra VARCHAR(25)  NOT NULL,
        qtde         INT          NOT NULL
    )

    declare @tab_itens_nf table (
    id_rows int not null primary key,
    codigo_barra varchar(25) not null,
    qtde int not null,
    PRODUTO varchar(12) not null,
    COR_PRODUTO varchar(10) not null,
    POSICAO INT NOT NULL,
    GRADE_SKU VARCHAR(25) NOT NULL,
    GRADE_PRODUTO VARCHAR(25) NOT NULL,
    PRECO_TRANSFERENCIA NUMERIC(14,2) NOT NULL
    )

    -- Converte a lista em XML para facilitar o split
    DECLARE @xml XML
    SET @xml = CAST('<i>' + REPLACE(@lista_itens, ';', '</i><i>') + '</i>' AS XML)

    INSERT INTO @tab_itens (codigo_barra, qtde)
    SELECT
        LTRIM(RTRIM(LEFT(item.value('.', 'VARCHAR(50)'),  CHARINDEX(',', item.value('.', 'VARCHAR(50)')) - 1))) AS codigo_barra,
        CAST(LTRIM(RTRIM(SUBSTRING(item.value('.', 'VARCHAR(50)'), CHARINDEX(',', item.value('.', 'VARCHAR(50)')) + 1, 50))) AS INT) AS qtde
    FROM @xml.nodes('/i') AS T(item)

    -- Carrega resultado para tabela de itens de faturamento
    INSERT INTO @tab_itens_nf
    SELECT a.id_rows, pb.CODIGO_BARRA, a.qtde, pb.PRODUTO, pb.COR_PRODUTO, pb.TAMANHO, pb.GRADE, p.GRADE, isnull(pp.PRECO1,1)
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
        --AND GRADE = '10 AO 16'
        AND v.TamanhoValor NOT LIKE '%.%'
    --ORDER BY
    --    pt.GRADE,
    --    v.Posicao
    ) t on t.GRADE = p.GRADE and pb.TAMANHO=t.Tamanho_Posicao
    order by a.id_rows
    -- retorna um dataset estruturado
    select * from @tab_itens_nf
    END
GO
