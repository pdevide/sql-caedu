declare @tabpro table (
produto varchar(8),
qtdcaixa int
)

insert into @tabpro(produto,qtdcaixa) values ('44160061',1)
insert into @tabpro(produto,qtdcaixa) values ('47012245',5)
insert into @tabpro(produto,qtdcaixa) values ('51180299',1)
insert into @tabpro(produto,qtdcaixa) values ('51180309',8)
insert into @tabpro(produto,qtdcaixa) values ('53022549',6)
insert into @tabpro(produto,qtdcaixa) values ('55110306',3)
insert into @tabpro(produto,qtdcaixa) values ('82010235',5)
insert into @tabpro(produto,qtdcaixa) values ('82010236',2)
insert into @tabpro(produto,qtdcaixa) values ('82010237',6)
insert into @tabpro(produto,qtdcaixa) values ('BE080015',1)
insert into @tabpro(produto,qtdcaixa) values ('J3010037',61)
insert into @tabpro(produto,qtdcaixa) values ('N4020053',81)
insert into @tabpro(produto,qtdcaixa) values ('N4030081',1)
insert into @tabpro(produto,qtdcaixa) values ('T7300372',73)
insert into @tabpro(produto,qtdcaixa) values ('Z5010214',1)
insert into @tabpro(produto,qtdcaixa) values ('Z6110021',77)
insert into @tabpro(produto,qtdcaixa) values ('82010234',3)

DECLARE @LISTAPRODUTOS TABLE (
LINHA INT IDENTITY(1,1) NOT NULL,
PRODUTO VARCHAR(8), 
CAIXAS INT
)

DECLARE @ESTOQUE TABLE (
PRODUTO VARCHAR(8)
,COR_PRODUTO VARCHAR(5)
,FILIAL VARCHAR(25)
,ESTOQUE INT
,ES1 INT
,ES2 INT
,ES3 INT
,ES4 INT
,ES5 INT
,ES6 INT
,ES7 INT
,ES8 INT
,ES9 INT
,ES10 INT
,ES11 INT
,ES12 INT
,ES13 INT
,ES14 INT
,ES15 INT 
,ES16 INT
,CAIXAS INT
,COR_PACK VARCHAR(5)
,PACK CHAR(1)
,QTDE INT
,Q1 INT
,Q2 INT
,Q3 INT
,Q4 INT
,Q5 INT
,Q6 INT
,Q7 INT
,Q8 INT
,Q9 INT
,Q10 INT
,Q11 INT
,Q12 INT
,Q13 INT
,Q14 INT
,Q15 INT 
,Q16 INT
)

INSERT INTO @LISTAPRODUTOS
select produto, qtdcaixa as caixas from @tabpro

DECLARE @LINHA INT, @TOTLINHA INT, @PRODUTO VARCHAR(8), @CAIXAS INT

SELECT @LINHA=MIN(LINHA), @TOTLINHA=MAX(LINHA)
FROM @LISTAPRODUTOS

WHILE @LINHA <= @TOTLINHA
BEGIN
	SELECT @PRODUTO = PRODUTO, @CAIXAS=CAIXAS
	FROM @LISTAPRODUTOS
	WHERE LINHA = @LINHA

	INSERT INTO @ESTOQUE
			(PRODUTO
			,COR_PRODUTO
			,FILIAL
			,ESTOQUE
			,ES1
			,ES2
			,ES3
			,ES4
			,ES5
			,ES6
			,ES7
			,ES8
			,ES9
			,ES10
			,ES11
			,ES12
			,ES13
			,ES14
			,ES15
			,ES16
			,CAIXAS)
	SELECT 
			PRODUTO
			,COR_PRODUTO
			,FILIAL
			,ESTOQUE
			,ES1
			,ES2
			,ES3
			,ES4
			,ES5
			,ES6
			,ES7
			,ES8
			,ES9
			,ES10
			,ES11
			,ES12
			,ES13
			,ES14
			,ES15
			,ES16
			,@CAIXAS
	FROM ESTOQUE_PRODUTOS EP 
	WHERE EP.PRODUTO = @PRODUTO 
		AND FILIAL = 'CD - SP - SAO ROQUE'

	
	UPDATE A SET	COR_PACK=B.COR_PRODUTO,
					PACK=B.PACK,
					QTDE=B.QTDE,
					Q1=B.Q1,
					Q2=B.Q2,
					Q3=B.Q3,
					Q4=B.Q4,
					Q5=B.Q5,
					Q6=B.Q6,
					Q7=B.Q7,
					Q8=B.Q8,
					Q9=B.Q9,
					Q10=B.Q10,
					Q11=B.Q11,
					Q12=B.Q12,
					Q13=B.Q13,
					Q14=B.Q14,
					Q15=B.Q15,
					Q16=B.Q16
	FROM @ESTOQUE A
	INNER JOIN PRODUTOS_PACKS_PERMITIDOS B 
				ON B.PRODUTO=A.PRODUTO AND B.COR_PRODUTO=A.COR_PRODUTO
	WHERE A.PRODUTO = @PRODUTO

	SET @LINHA += 1
END
/*
SELECT *,
	CAIXAS*QTDE AS VOLUME,
	Q1*CAIXAS AS VOL1,
	Q2*CAIXAS AS VOL2,
	Q3*CAIXAS AS VOL3,
	Q4*CAIXAS AS VOL4,
	Q5*CAIXAS AS VOL5,
	Q6*CAIXAS AS VOL6,
	Q7*CAIXAS AS VOL7,
	Q8*CAIXAS AS VOL8,
	Q9*CAIXAS AS VOL9,
	Q10*CAIXAS AS VOL10,
	Q11*CAIXAS AS VOL11,
	Q12*CAIXAS AS VOL12,
	Q13*CAIXAS AS VOL13,
	Q14*CAIXAS AS VOL14,
	Q15*CAIXAS AS VOL15,
	Q16*CAIXAS AS VOL16
FROM @ESTOQUE
ORDER BY PRODUTO, COR_PRODUTO
*/
select a.* 
--update a set
--pack = b.pack,
--qtde_packs = caixas,
--COR_PRODUTO = b.cor_produto,
--QTDE = b.qtde,
--Q1 = b.q1,
--Q2 = b.q2,
--Q3 = b.q3,
--Q4 = b.q4,
--Q5 = b.q5,
--Q6 = b.q6,
--Q7 = b.q7,
--Q8 = b.q8,
--Q9 = b.q9,
--Q10 = b.q10,
--Q11 = b.q11,
--Q12 = b.q12,
--Q13 = b.q13,
--Q14 = b.q14,
--Q15 = b.q15,
--Q16 = b.q16
from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250521 a
--inner join @estoque b on b.produto = a.produto
where a.produto not in ('Z6110021','53022549')

