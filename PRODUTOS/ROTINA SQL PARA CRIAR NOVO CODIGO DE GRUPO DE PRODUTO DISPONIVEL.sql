declare @VLETRAS table (COD varchar(2))
declare @i int = 1, @LETRA CHAR(1), @w int
while @i <= 26
BEGIN
	SET @LETRA = CHAR(64+@i)
	set @w=0
	while @w <= 9 
	BEGIN
		INSERT INTO @VLETRAS VALUES (@letra+CAST(@w as char(1)))
		set @w += 1
	END 
	set @i += 1
END

SELECT A.* 
from @VLETRAS a
left join PRODUTOS_GRUPO b on b.CODIGO_GRUPO = a.cod	
WHERE B.CODIGO_GRUPO IS NULL


