select  'exec PDA_WMS_SP_IN_RESERVA_DISTRIBUICAO ',char(39)+rtrim(PRODUTO)+char(39)+',' as produto, 
SUM(quantidade) as quantidade, ','+char(39)+rtrim(DISTRIBUICAO)+char(39)+',' as distribuicao,
char(39)+pack+char(39) 
from PDA_WMS_TB_DISTRIBUICAO where DISTRIBUICAO  = '00019695'
 group by DISTRIBUICAO, PRODUTO, pack
 
select * from PDA_WMS_TB_RESERVA_DISTRIBUICAO where PRODUTO = 'N3030134'
select * from PDA_WMS_TB_RESERVA_DISTRIBUICAO where DISTRIBUICAO = '00019695'
select * from PDA_WMS_TB_DISTRIBUICAO_COLETA where DISTRIBUICAO = '00019695'


PDA_WMS_SP_IN_RESERVA_DISTRIBUICAO 'N3030134',132,'00019695','A'

exec PDA_WMS_SP_IN_RESERVA_DISTRIBUICAO 	'N3030134',	132	,'00019695',	'A'
exec PDA_WMS_SP_IN_RESERVA_DISTRIBUICAO 	'N3030134',	132	,'00019695',	'A'

select estoque,* from estoque_produtos where produto = 'N3030114'

select * from filiais where filial = 'cd cajamar'

select * from PDA_WMS_TB_ENDERECO_FILIAL


exec cgp_lx_gerar_codigo_barra '01050985'


select * from produtos where produto = '61040036'