SELECT
    OBJECT_NAME(object_id) As Tabela, Rows As Linhas,
    SUM(Total_Pages * 8)/1024 As Reservado,
    SUM(CASE WHEN Index_ID > 1 THEN 0 ELSE Data_Pages * 8 END)/1024 As Dados,
        (SUM(Used_Pages * 8) -
        SUM(CASE WHEN Index_ID > 1 THEN 0 ELSE Data_Pages * 8 END))/1024 As Indice,
    SUM((Total_Pages - Used_Pages) * 8)/1024 As NaoUtilizado
FROM
    sys.partitions As P
    INNER JOIN sys.allocation_units As A ON P.hobt_id = A.container_id
GROUP BY OBJECT_NAME(object_id), Rows
ORDER BY 4 desc