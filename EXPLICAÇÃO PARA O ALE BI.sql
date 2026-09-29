select * from CSM_TRANSITO_NOTAS where data> '20220405'
/*

1) PROCEDURE csm_cae_importa_entradas
le todas as notas da tabela entradas que o local de estoque 
seja igual a 'CD NAVEGANTES' e que ainda não existam na CSM_TRANSITO_NOTAS, neste caso o campo CSM_TRANSITO_NOTAS.NF_SAIDA será NULO
até que seja processado pela procedure CSM_CAE_FATURAMENTO_ESPELHO e a nota seja espelhada.

2) PROCEDURE CSM_CAE_FATURAMENTO_ESPELHO

*/