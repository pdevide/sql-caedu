USE [CAEDU]
GO

/****** Object:  View [dbo].[UNOUS_LINX_MAT_ALOC]    Script Date: 13/05/2019 09:06:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






alter VIEW [dbo].[UNOUS_LINX_MAT_ALOC]
AS
  

SELECT TABELAO.*, PC.COR_PRODUTO, PC.DESC_COR_PRODUTO

FROM (

select a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.VALOR_PROPRIEDADE , C.VALOR_PROPRIEDADE  AS unous_alocar
from UNOUS_CAE_PRODUTOS_FATOR_P A 
inner join  ( SELECT a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE 
			 from produtos a join PROP_PRODUTOS b
			 on a.produto = b.produto 
			 where b.propriedade = '00107'	
			 group by a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE
			) B 
			ON b.GRIFFE = a.GRIFFE and b.linha = a.LINHA and b.GRUPO_PRODUTO = a.GRUPO_PRODUTO and b.SUBGRUPO_PRODUTO = a.SUBGRUPO_PRODUTO 
inner join  ( SELECT a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE  
			 from produtos a inner join PROP_PRODUTOS b
			 on a.produto = b.produto 
			 where b.propriedade = '00108'	
			 group by a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE
			) C 
			ON C.GRIFFE = a.GRIFFE and c.linha = a.LINHA and c.GRUPO_PRODUTO = a.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =							a.SUBGRUPO_PRODUTO 
			and C.GRIFFE = b.GRIFFE and c.linha = b.LINHA and c.GRUPO_PRODUTO = b.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =						b.SUBGRUPO_PRODUTO 
where a.UNOUS_NIVEL = 'FATOR_P'
group by a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.VALOR_PROPRIEDADE , C.VALOR_PROPRIEDADE



union all

select a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.VALOR_PROPRIEDADE , C.VALOR_PROPRIEDADE  AS unous_alocar 
from UNOUS_CAE_PRODUTOS_FATOR_P A 
left join  ( SELECT a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE 
			 from produtos a inner join PROP_PRODUTOS b
			 on a.produto = b.produto 
			 where b.propriedade = '00105'	
			) B ON b.GRIFFE = a.GRIFFE and b.linha = a.LINHA and b.GRUPO_PRODUTO = a.GRUPO_PRODUTO and b.SUBGRUPO_PRODUTO = a.SUBGRUPO_PRODUTO 
left join  ( SELECT a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE  
			 from produtos a inner join PROP_PRODUTOS b
			 on a.produto = b.produto 
			 where b.propriedade = '00108'	
			) C 
			ON C.GRIFFE = a.GRIFFE and c.linha = a.LINHA and c.GRUPO_PRODUTO = a.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =							a.SUBGRUPO_PRODUTO 
			and C.GRIFFE = b.GRIFFE and c.linha = b.LINHA and c.GRUPO_PRODUTO = b.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =						b.SUBGRUPO_PRODUTO 
where UNOUS_NIVEL = 'FLEX'
group by a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.VALOR_PROPRIEDADE , C.VALOR_PROPRIEDADE

union all

select a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.DESC_COR_PRODUTO as VALOR_PROPRIEDADE, C.VALOR_PROPRIEDADE  AS unous_alocar
from UNOUS_CAE_PRODUTOS_FATOR_P A 
left join  (  SELECT b.produto, b.COR_PRODUTO, b.desc_cor_produto,   a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO 
			 from produto_cores B inner join PRODUTOS A
			 on a.produto = b.produto 
			) B ON b.GRIFFE = a.GRIFFE and b.linha = a.LINHA and b.GRUPO_PRODUTO = a.GRUPO_PRODUTO and b.SUBGRUPO_PRODUTO = a.SUBGRUPO_PRODUTO 
left join  ( SELECT a.produto, a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , b.VALOR_PROPRIEDADE  
			 from produtos a inner join PROP_PRODUTOS b
			 on a.produto = b.produto 
			 where b.propriedade = '00108'	
			) C 
			ON C.GRIFFE = a.GRIFFE and c.linha = a.LINHA and c.GRUPO_PRODUTO = a.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =							a.SUBGRUPO_PRODUTO 
			and C.GRIFFE = b.GRIFFE and c.linha = b.LINHA and c.GRUPO_PRODUTO = b.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO =						b.SUBGRUPO_PRODUTO 
where UNOUS_NIVEL = 'COR'
group by a.griffe, a.linha, a.GRUPO_PRODUTO , a.SUBGRUPO_PRODUTO , a.UNOUS_NIVEL , b.produto, b.DESC_COR_PRODUTO , C.VALOR_PROPRIEDADE
) AS TABELAO
LEFT JOIN PRODUTO_CORES PC ON PC.PRODUTO = TABELAO.PRODUTO



  









