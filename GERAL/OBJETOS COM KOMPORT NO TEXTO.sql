select b.name, b.type
from syscomments a
inner join sysobjects b on b.id=a.id
where 1=1
and a.text like '%komport%'
group by b.name, b.type


/* 
OBJETOS COM KOMPORT NO TEXTO
name									type
=============================================
cgp_notas_enviadas_monitor_linx_vs_gl	V  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS --> OK
CGP_PRC_NF_ENTRADA_GL					P  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS --> OK
CGP_TRANSFERE_VENDA_ATACADO_NAVEGANTES	P  --> OK
CGP_VW_DADOS_CLUSTER_PEDIDOS			V  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - VALIDAR COM HELIO - OK
CGP_VW_DADOS_PEDIDOS					V  --> VALIDAR COM HELIO --> OK
cgp_vw_itens_nota_fiscal				V  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - VALIDAR COM HELIO - OK
cgp_vw_notas_fiscais					V  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - VALIDAR COM HELIO - OK
CSM_CAE_FATURAMENTO_ESPELHO				P  --> jira SI-503 
csm_cae_importa_entradas				P  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - OK
LXU_PRODUTOS							TR --> ok
LXUA_DESC_ENTRADAS						TR --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - OK
RESUMO_IMPORTADO						V  --> SCRIPT ALTERADO E SALVO PARA EXECUTAR DEPOIS - OK

select * from sysobjects where  name = 'LXUA_DESC_ENTRADAS'

SELECT Object_Name(parent_id) AS [Nome Objeto], 
       type_desc              AS Tipo, 
       modify_date            AS [Data Modificação],
	   *
FROM   sys.triggers
*/

