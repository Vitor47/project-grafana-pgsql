select * from dim_user;
select * from dim_propriedade;
select * from dim_hospedagem;
select * from dim_pagamento;
select * from dim_revisao;
select * from fat_estadia;


select extract(year from dh.data_hora_entrada), sum(e.valor_estadia) valores
from fat_estadia e
inner join dim_hospedagem dh on e.dim_hospedagem_id = dh.id
group by extract(year from dh.data_hora_entrada);

select u.nome, e.valor_estadia, dh.num_dias from fat_estadia e
inner join dim_user u on e.dim_user_id = u.id
inner join dim_hospedagem dh on e.dim_hospedagem_id = dh.id
where dh.num_dias > 5;