
select a.produto, cor_produto, p.inativo, a.filial, f.cod_filial, f.cgc_cpf, p.grade, estoque,
ES1, ES2, ES3, ES4, ES5, ES6, ES7, ES8, ES9, ES10, ES11, ES12, ES13, ES14, ES15, ES16
from estoque_produtos a 
inner join filiais f on f.filial = a.filial 
inner join produtos p on p.produto = a.produto
where a.produto = '1'
and (
(es1<>0) or
(es2<>0) or
(es3<>0) or
(es4<>0) or
(es5<>0) or
(es6<>0) or
(es7<>0) or
(es8<>0) or
(es9<>0) or
(es10<>0) or
(es11<>0) or
(es12<>0) or
(es13<>0) or
(es14<>0) or
(es15<>0) or
(es16>0)) 
