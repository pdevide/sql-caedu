SELECT arb_parametros_markdown.id,
       arb_parametros_markdown.griffe,
       arb_parametros_markdown.linha,
       arb_parametros_markdown.grupo,
       arb_parametros_markdown.idadeinicio,
       arb_parametros_markdown.idadefim,
       arb_parametros_markdown.evinicio,
       arb_parametros_markdown.evfim,
       arb_parametros_markdown.descconto,
       arb_parametros_markdown.ativo,
       arb_parametros_markdown.id_markdown,
       arb_parametros_markdown.data_markdown,
       arb_parametros_markdown.data_emissao,
       arb_parametros_markdown.data_aprovacao,
       arb_parametros_markdown.filial,
       arb_parametros_markdown.cod_filial,
       arb_parametros_markdown.nome,
       arb_parametros_markdown.desconsiderar_ev,
       arb_parametros_markdown.envia_direto_mark_down,
       arb_parametros_markdown.margemminima,
       arb_parametros_markdown.aprovador_gerente_griffe,
       arb_parametros_markdown.aprovador_gerente_grupo,
       arb_parametros_markdown.data_aprovacao_gerente_griffe,
       arb_parametros_markdown.data_aprovacao_gerente_grupo,
       arb_parametros_markdown.custo,
       arb_parametros_markdown.segunda,
       arb_parametros_markdown.terca,
       arb_parametros_markdown.quarta,
       arb_parametros_markdown.quinta,
       arb_parametros_markdown.sexta,
       arb_parametros_markdown.sabado,
       arb_parametros_markdown.domingo,
       arb_parametros_markdown.hora,
       arb_parametros_markdown.datainicio,
       arb_parametros_markdown.datafim,
       arb_parametros_markdown.d,
       arb_parametros_markdown.ativo_1,
       arb_parametros_markdown.nao_exige_aprovacao,
       arb_parametros_markdown.seleciona,
       arb_parametros_markdown.segunda_2,
       arb_parametros_markdown.terca_2,
       arb_parametros_markdown.quarta_2,
       arb_parametros_markdown.quinta_2,
       arb_parametros_markdown.sexta_2,
       arb_parametros_markdown.sabado_2,
       arb_parametros_markdown.domingo_2,
       arb_parametros_markdown.hora_2,
       arb_parametros_markdown.datainicio_2,
       arb_parametros_markdown.d_2,
       arb_parametros_markdown.datafim_2,
       arb_parametros_markdown.ativo_2
FROM   arb_parametros_markdown
WHERE  1=1
and arb_parametros_markdown.id 
IN(SELECT DISTINCT arb_markdown_gerado.id
   FROM   arb_markdown_gerado
   INNER JOIN warb_parametros_markdown A
               ON A.id = arb_markdown_gerado.id
   WHERE  arb_markdown_gerado.custo_cmv IS NOT NULL
   AND arb_markdown_gerado.custo_total < arb_markdown_gerado.markdown_total
AND arb_markdown_gerado.margem_bruta > 0
AND arb_markdown_gerado.margem_bruta >=
Isnull(A.margemminima, 0)
AND arb_markdown_gerado.data_aprovacao IS
NULL)
ORDER  BY arb_parametros_markdown.griffe,
          arb_parametros_markdown.linha,
          arb_parametros_markdown.grupo 