SELECT loja_entradas.romaneio_produto, 
       loja_entradas.filial_origem LJ_ORIGEM, 
       loja_entradas.filial LJ_DESTINO, 
       loja_entradas.numero_nf_transferencia NF_SAIDA, 
	   faturamento.EMISSAO EMISSAO_NF,
       regiao, 
       loja_entradas.emissao EMISSAO_TRANSITO, 
       loja_entradas.entrada_conferida, 
       loja_entradas.qtde_total QTDE_TOTAL_TRANSITO, 
       loja_entradas.valor_total VALOR_TOTAL_TRANSITO, 
	   CAST(faturamento.QTDE_TOTAL AS INT) AS QTDE_TOTAL_NF,
	   faturamento.VALOR_TOTAL AS VALOR_NF,
       loja_entradas.romaneio_nf_saida, 
       CASE WHEN loja_entradas.entrada_conferida=1 THEN 'TRANSITO LIBERADO'
	   ELSE 'TRANSITO PENDENTE'
	   END 	   AS status_transito,
	   Datediff(dd, faturamento.emissao, Isnull(loja_entradas.data_entrada_conferida, Getdate())) AS DIAS_EM_TRANSITO,
	   loja_entradas.data_entrada_conferida
FROM   loja_entradas 
       JOIN filiais  
         ON loja_entradas.filial = filiais.filial 
       LEFT JOIN loja_entradas_dif 
              ON loja_entradas.filial = loja_entradas_dif.filial 
                 AND loja_entradas.numero_nf_transferencia = 
                     loja_entradas_dif.numero_nf_transferencia 
                 AND loja_entradas.filial_origem = 
                     loja_entradas_dif.filial_origem 
                 AND loja_entradas.romaneio_nf_saida = 
                     loja_entradas_dif.romaneio_nf_saida 
                 AND loja_entradas.emissao = loja_entradas_dif.emissao 
                 AND loja_entradas.romaneio_produto = 
                     loja_entradas_dif.romaneio_produto 
	LEFT JOIN FATURAMENTO 
		ON faturamento.NF_SAIDA = loja_entradas.numero_nf_transferencia AND faturamento.FILIAL = loja_entradas.filial_origem AND faturamento.SERIE_NF = loja_entradas.SERIE_NF_ENTRADA
WHERE  filiais.matriz IN ( 'MATRIZ' ) 
       --AND loja_entradas.entrada_conferida = 0 
	   --AND loja_entradas.filial = 'SP - PENHA'
	   AND YEAR(loja_entradas.EMISSAO)=YEAR(GETDATE())
ORDER  BY loja_entradas.emissao ASC, 
          filiais.filial 

		  

