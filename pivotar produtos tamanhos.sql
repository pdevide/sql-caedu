--select * from produtos_tamanhos

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
ORDER BY
    pt.GRADE,
    v.Posicao;