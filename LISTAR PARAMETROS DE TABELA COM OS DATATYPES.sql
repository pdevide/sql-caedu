select column_name, '@'+COLUMN_NAME+' '+data_type +
		case when data_type = 'numeric' then '('+convert(varchar,NUMERIC_PRECISION)+','+convert(varchar,NUMERIC_SCALE) +')'
			 when data_type not in ('int','datetime','tinyint','bit','smallint') then '('+convert(varchar,CHARACTER_MAXIMUM_LENGTH)+')'
		else ''
		end +', ', *
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='CGP_FATURAMENTO_ITEM_LOG'

select '@'+COLUMN_NAME+' = '+COLUMN_NAME+', '
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='CGP_FATURAMENTO_ITEM_LOG'
ORDER BY ORDINAL_POSITION

SELECT COLUMN_NAME +',' from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='CGP_FATURAMENTO_ITEM_LOG'
ORDER BY ORDINAL_POSITION


SELECT * from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='CGP_FATURAMENTO_ITEM_LOG'

