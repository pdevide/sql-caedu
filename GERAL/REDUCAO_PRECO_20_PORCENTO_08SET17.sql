/*
// BACKUP DA TABELA DE PRECO DOS REGISTROS 
// QUE SERÃO ATUALIZADOS
*/
select * 
into PRODUTOS_PRECOS_BKP_08SET17
from produtos_precos where produto in
('01225152','01225151') 
and CODIGO_TAB_PRECO not in('00','01','02','03','04','05','35','37','cm','85')	
order by produto, CODIGO_TAB_PRECO
go


-- SCRIPT ida
DECLARE @PRODUTO CHAR(12)
SET @PRODUTO = '01225152' /* OU '01225151' */

update produtos_precos
set 
	PRECO1_ANTERIOR=PRECO1, 
	preco1 = (preco1 * 0.80), 
	DATA_CARGA_PRECOS='20170908'
WHERE 
	PRODUTO=@PRODUTO
	and CODIGO_TAB_PRECO not in('00','01','02','03','04','05','35','37','cm','85')	


-- SCRIPT VOLTA
DECLARE @PRODUTO CHAR(12)
SET @PRODUTO = '01225152' /* OU '01225151' */

update produtos_precos
set 
	PRECO1 = PRECO1_ANTERIOR, 
	DATA_CARGA_PRECOS='20170910'
WHERE 
	PRODUTO=@PRODUTO
	and CODIGO_TAB_PRECO not in('00','01','02','03','04','05','35','37','cm','85')	




