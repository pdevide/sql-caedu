UPDATE PARAMETROS SET VALOR_ATUAL = '4.00' WHERE PARAMETRO = 'VERSAO_LAYOUT_XML_NFE' ;
UPDATE PARAMETROS SET VALOR_ATUAL = '\SCHEMA\SEFAZ\NFE_V4.00.XSD' WHERE PARAMETRO = 'PASTA_SCHEMA_XML_NFE_SEFA' ;
UPDATE PARAMETROS SET VALOR_ATUAL = '\SCHEMA\NFE_V4.00.XSD' WHERE PARAMETRO = 'PASTA_SCHEMA_XML_NFE' ;

update parametros set VALOR_ATUAL = '186.201.46.179' where parametro = 'IP_WS_NFE';
update parametros set VALOR_ATUAL = '2' where parametro = 'IDENTIFICA_AMBIENTE_NFE';
update parametros set VALOR_ATUAL = '2804' where parametro = 'PORTA_IP_WS_NFE';

--select * from parametros_loja where PARAMETRO='IDENTIFICA_AMBIENTE_NFE' 

update parametros_loja
set VALOR_ATUAL = '2' 
where PARAMETRO='IDENTIFICA_AMBIENTE_NFE' ;

/*

Acesso ao Portal: http://186.201.46.179:2803/Linx.Nfe.Portal
Portal Mid Homologação, 

Para acessar o portal MidNFe utilize os dados abaixo:
Usuário: paulo.devide@caedu.com.br
Senha: 6da4a7


*/

