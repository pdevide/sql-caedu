--select max(codigo) from CAEDU_LISTA_COMBO
declare @tabesqueleto table (ID INT IDENTITY(1,1), ESQUELETO VARCHAR(50))

insert into @tabesqueleto (ESQUELETO) values ('BERMUDA BASQUETE')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA CARGO JEANS')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA CARGO MOLETOM')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA CARGO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA CHINO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA COS ELASTICO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA ECO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA FIVE POCKETS SARJA')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA JNS AJ SORTIDO')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA RECORTE LATERAL')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA RETA JEANS')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA SURF/BANHO')
insert into @tabesqueleto (ESQUELETO) values ('BERMUDA VIES LATERAL')
insert into @tabesqueleto (ESQUELETO) values ('CALCA BASICA JEANS')
insert into @tabesqueleto (ESQUELETO) values ('CALCA CARGO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('CALCA CHINO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('CALCA COS ELASTICO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('CALCA JOGGER SARJA')
insert into @tabesqueleto (ESQUELETO) values ('CALCA MOLETOM CARGO')
insert into @tabesqueleto (ESQUELETO) values ('CALCA MOLETOM FAIXA LATERAL')
insert into @tabesqueleto (ESQUELETO) values ('CALCA MOLETOM JOGGER')
insert into @tabesqueleto (ESQUELETO) values ('CALCA MOLETOM JOGGER SUPER')
insert into @tabesqueleto (ESQUELETO) values ('CALCA MOLETOM RETA')
insert into @tabesqueleto (ESQUELETO) values ('CALCA RETA JEANS')
insert into @tabesqueleto (ESQUELETO) values ('CALCA SLIM JEANS')
insert into @tabesqueleto (ESQUELETO) values ('CALCA SLIM SARJA')
insert into @tabesqueleto (ESQUELETO) values ('CAMISA SOCIAL')
insert into @tabesqueleto (ESQUELETO) values ('JAQUETA PUFFER')
insert into @tabesqueleto (ESQUELETO) values ('M/C BASICA CARECA')
insert into @tabesqueleto (ESQUELETO) values ('M/C BASICA CARECA SUPER')
insert into @tabesqueleto (ESQUELETO) values ('M/C BASICA V')
insert into @tabesqueleto (ESQUELETO) values ('M/C CONTRASTE')
insert into @tabesqueleto (ESQUELETO) values ('M/C ECKO')
insert into @tabesqueleto (ESQUELETO) values ('M/C ESPORTIVA DRY')
insert into @tabesqueleto (ESQUELETO) values ('M/C ESPORTIVA VIES LATERAL')
insert into @tabesqueleto (ESQUELETO) values ('M/C ESPORTIVA VIES OMBRO')
insert into @tabesqueleto (ESQUELETO) values ('M/C FATAL')
insert into @tabesqueleto (ESQUELETO) values ('M/C FAVINHO')
insert into @tabesqueleto (ESQUELETO) values ('M/C GANGSTER')
insert into @tabesqueleto (ESQUELETO) values ('M/C LICENCIADO')
insert into @tabesqueleto (ESQUELETO) values ('M/C MAQUINETADA')
insert into @tabesqueleto (ESQUELETO) values ('M/C OVERSIZED')
insert into @tabesqueleto (ESQUELETO) values ('M/C PENTEADA')
insert into @tabesqueleto (ESQUELETO) values ('M/C PORTUGUESA')
insert into @tabesqueleto (ESQUELETO) values ('M/C RECORTE')
insert into @tabesqueleto (ESQUELETO) values ('M/C SILK CASUAL')
insert into @tabesqueleto (ESQUELETO) values ('M/C SILK GOLA PUNHO')
insert into @tabesqueleto (ESQUELETO) values ('M/C SILK JOVEM')
insert into @tabesqueleto (ESQUELETO) values ('M/C SILK SUPER')
insert into @tabesqueleto (ESQUELETO) values ('M/L RAGLAN CAPUZ')
insert into @tabesqueleto (ESQUELETO) values ('POLO DOTS')
insert into @tabesqueleto (ESQUELETO) values ('POLO PIQUET')
insert into @tabesqueleto (ESQUELETO) values ('POLO RECORTE')
insert into @tabesqueleto (ESQUELETO) values ('S/M ESPORTIVA DRY')
insert into @tabesqueleto (ESQUELETO) values ('S/M GANGSTER')
insert into @tabesqueleto (ESQUELETO) values ('S/M MACHAO SILK')
insert into @tabesqueleto (ESQUELETO) values ('SHORTS ECO SARJA')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM ABERTO ESTAMPADO')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM ABERTO LISO')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM CANGURU LISO')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM FECHADO ESTAMPADO')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM GOLA CARECA LISO')
insert into @tabesqueleto (ESQUELETO) values ('TOP MOLETOM LICENCIADO')
insert into @tabesqueleto (ESQUELETO) values ('TRICO ABERTO')
insert into @tabesqueleto (ESQUELETO) values ('TRICO FECHADO')
insert into @tabesqueleto (ESQUELETO) values ('TRICO MEIO ZIPER')



DECLARE @ULTIMO_CODIGO INT, @codigo varchar(6)
SELECT @ULTIMO_CODIGO = CAST(max(codigo) AS INT) from CAEDU_LISTA_COMBO

SELECT @codigo = FORMAT(id + @ULTIMO_CODIGO,'000000')
FROM @tabesqueleto a

IF NOT EXISTS(SELECT 1 FROM CAEDU_DOMINIO_COMBOS WHERE COD_DOMINIO = '026')
BEGIN
	INSERT INTO CAEDU_DOMINIO_COMBOS VALUES ('026','ESQUELETO','CADASTRO DE ESQUELETO PLANEJAMENTO')
END

insert into CAEDU_LISTA_COMBO (codigo,descricao,id_dominio,desc_dominio,ERP_CUPS_DESCRICAO_IMPORTACAO)
select FORMAT(id + @ULTIMO_CODIGO,'000000') as codigo,
a.ESQUELETO as descricao,
'026' id_dominio,
'ESQUELETO' desc_dominio,
a.ESQUELETO as ERP_CUPS_DESCRICAO_IMPORTACAO
from @tabesqueleto a

UPDATE SEQUENCIAIS SET SEQUENCIA = @codigo WHERE TABELA_COLUNA = 'CAEDU_LISTA_COMBO.CODIGO'

/* PROVA DOS NOVE
-- RODE PRA VER SE ATUALIZOU CERTINHO --
SELECT * FROM SEQUENCIAIS WHERE TABELA_COLUNA LIKE 'CAEDU_LISTA%'
SELECT * FROM CAEDU_LISTA_COMBO WHERE id_dominio = '026'

*/