USE [CAEDU]
GO

/****** Object:  View [dbo].[cgp_notas_enviadas_monitor_linx_vs_gl]    Script Date: 30/12/2024 14:51:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER view [dbo].[CGP_NOTAS_ENVIADAS_MONITOR_LINX_VS_GL] as
(

select 

	tab_entrada.* 

from (

select 
  
  count(1) as qtd_notas,
  nf_port_entrada_gl.interface,
  nf_port_entrada_gl.origem,
  nf_port_entrada_gl.destino,
  nf_port_entrada_gl.banco,
  nf_port_entrada_gl.dt_movimento

 from (

select 
	
'ENTRADA' as interface,
'LINX'    as origem,
'GL'      as destino,
'LINX'    as banco,

(select t.codigo_fiscal_operacao from (

(select 
	top 1 count(1) as qtd, 
	e1.codigo_fiscal_operacao 
	from 
	entradas_item e1 
	where e1.nome_clifor = e.nome_clifor 
	and e1.serie_nf_entrada = e.serie_nf_entrada 
	and e1.nf_entrada = e.nf_entrada 
	group by e1.codigo_fiscal_operacao 
	order by 1 desc)

) t ) as cfop,
cast(e.recebimento as date) as dt_movimento

from 
  entradas (nolock) e
  
where (e.nome_clifor not like 'KOMPORT%' and e.NOME_CLIFOR not like 'HARPIA%')   

) nf_port_entrada_gl

where 1=1

and nf_port_entrada_gl.cfop in 

	( 
		select 
		  cfg.cfop 
		from 
		  cgp_lt_param_cfop cf 

		inner join cgp_lt_param_cfop_gl cfg 
		        on cfg.cfop = cf.cfop  

		where 1=1
		  and cf.envia_gl = 1 
		  and cfg.tiponf = 'E' 
 
		group by 
		  cfg.cfop
   )

group by 
  nf_port_entrada_gl.interface,
  nf_port_entrada_gl.origem,
  nf_port_entrada_gl.destino,
  nf_port_entrada_gl.banco,
  nf_port_entrada_gl.dt_movimento
  
union all

select 
  
  count(1) as qtd_notas,
  nf_port_entrada_synchro.interface,
  nf_port_entrada_synchro.origem,
  nf_port_entrada_synchro.destino,
  nf_port_entrada_synchro.banco,
  nf_port_entrada_synchro.dt_movimento

 from (

select 
	
'ENTRADA' as interface,
'LINX'    as origem,
'SYNCHRO' as destino,
'LINX'    as banco,

(select t.codigo_fiscal_operacao from (

(select 
	top 1 count(1) as qtd, 
	e1.codigo_fiscal_operacao 
	from 
	entradas_item e1 
	where e1.nome_clifor = e.nome_clifor 
	and e1.serie_nf_entrada = e.serie_nf_entrada 
	and e1.nf_entrada = e.nf_entrada 
	group by e1.codigo_fiscal_operacao 
	order by 1 desc)

) t ) as cfop,
cast(e.recebimento as date) as dt_movimento

from 
  entradas (nolock) e 

) nf_port_entrada_synchro

where 1=1

and nf_port_entrada_synchro.cfop in 

	( 
		select 
		  cf.cfop 
		from 
		  cgp_lt_param_cfop cf 

		where 1=1
		  and cf.ativo = 1
		  and cf.envia_synchro = 1
   )

group by 
  nf_port_entrada_synchro.interface,
  nf_port_entrada_synchro.origem,
  nf_port_entrada_synchro.destino,
  nf_port_entrada_synchro.banco,
  nf_port_entrada_synchro.dt_movimento
  

) tab_entrada

union all

select 

	tab_saida.* 

from (

select 
  
  count(1) as qtd_notas,
  nf_port_saida_gl.interface,
  nf_port_saida_gl.origem,
  nf_port_saida_gl.destino,
  nf_port_saida_gl.banco,
  nf_port_saida_gl.dt_movimento

 from (

select 
	
'SAIDA' as interface,
'LINX'  as origem,
'GL'    as destino,
'LINX'  as banco,

(select t.codigo_fiscal_operacao from (

(select 
	top 1 count(1) as qtd, 
	f1.codigo_fiscal_operacao 
	from 
	faturamento_item f1 
	where f1.filial = f.filial
	and f1.serie_nf = f.serie_nf
	and f1.nf_saida = f.nf_saida 
	group by f1.codigo_fiscal_operacao 
	order by 1 desc)

) t ) as cfop,
cast(f.emissao as date) as dt_movimento

from 
  faturamento (nolock) f

) nf_port_saida_gl

where 1=1

and nf_port_saida_gl.cfop in 

	( 
		select 
		  cfg.cfop 
		from 
		  cgp_lt_param_cfop cf 

		inner join cgp_lt_param_cfop_gl cfg 
		        on cfg.cfop = cf.cfop  

		where 1=1
		  and cf.envia_gl = 1 
		  and cfg.tiponf = 'S' 
 
		group by 
		  cfg.cfop
   )

group by 
  nf_port_saida_gl.interface,
  nf_port_saida_gl.origem,
  nf_port_saida_gl.destino,
  nf_port_saida_gl.banco,
  nf_port_saida_gl.dt_movimento
  

union all

select 
  
  count(1) as qtd_notas,
  nf_port_saida_synchro.interface,
  nf_port_saida_synchro.origem,
  nf_port_saida_synchro.destino,
  nf_port_saida_synchro.banco,
  nf_port_saida_synchro.dt_movimento

 from (

select 
	
'SAIDA'   as interface,
'LINX'    as origem,
'SYNCHRO' as destino,
'LINX'    as banco,

(select t.codigo_fiscal_operacao from (

(select 
	top 1 count(1) as qtd, 
	f1.codigo_fiscal_operacao 
	from 
	faturamento_item f1 
	where f1.filial = f.filial
	and f1.serie_nf = f.serie_nf
	and f1.nf_saida = f.nf_saida 
	group by f1.codigo_fiscal_operacao 
	order by 1 desc)

) t ) as cfop,
cast(f.emissao as date) as dt_movimento

from 
  faturamento (nolock) f

) nf_port_saida_synchro

where 1=1

and nf_port_saida_synchro.cfop in 

	( 
		select 
		  cf.cfop 
		from 
		  cgp_lt_param_cfop cf 

		where 1=1
		  and cf.ativo = 1
		  and cf.envia_synchro = 1
   )

group by 
  nf_port_saida_synchro.interface,
  nf_port_saida_synchro.origem,
  nf_port_saida_synchro.destino,
  nf_port_saida_synchro.banco,
  nf_port_saida_synchro.dt_movimento
  

) tab_saida


)
GO


