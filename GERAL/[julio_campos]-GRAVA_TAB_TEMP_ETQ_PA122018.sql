DECLARE @FILIAL CHAR(25), @produto char(12)
DECLARE FILIAL_cursor CURSOR FOR  

select filial, produto
 from cm_estoque_pa where cod_custo_medio = '201812'  AND FILIAL BETWEEN 'ITAIM' AND 'VILA FORMOSA'

order by 1,2

OPEN FILIAL_cursor;  

-- Perform the first fetch.  
FETCH NEXT FROM FILIAL_cursor INTO @FILIAL, @produto;  

-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN  
INSERT INTO TAB_TEMP_ESTOQUE_PA_NA_DATA (FILIAL, PRODUTO, DATA_SALDO, QTDE_ESTOQUE)
SELECT FILIAL, PRODUTO, '20181231', SUM(TT_MOV) 
FROM FX_MONTA_CARDEX_PA_DATA (@produto,'%',@FILIAL,1,'19990101','20181231')
GROUP BY FILIAL, PRODUTO
   FETCH NEXT FROM FILIAL_cursor into @filial, @produto;  
END  

CLOSE FILIAL_cursor;  
DEALLOCATE FILIAL_cursor; 