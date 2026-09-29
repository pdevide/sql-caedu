select * from parametros where parametro = 'LICENCA' 
-- 7A354CB86A7D634B098F5907231BCD7A32931467E187882BCF0AB2 chave da produção


select * from parametros where parametro = 'LICENCAID'
-- B54BE39036696640EFCF5416 licençaID da produção


/** Atualizar os parametros da chave Linx com os dados coletados em produção **/
UPDATE PARAMETROS SET VALOR_ATUAL = '7A354CB86A7D634B098F5907231BCD7A32931467E187882BCF0AB2' 
WHERE parametro = 'LICENCA'

UPDATE PARAMETROS SET VALOR_ATUAL = 'B54BE39036696640EFCF5416' 
WHERE parametro = 'LICENCAID'