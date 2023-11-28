select * from dim_user;
select * from dim_propriedade;
select * from dim_hospedagem;
select * from dim_pagamento;
select * from dim_revisao;
select * from fat_estadia;


-- Soma de valores por ano
select extract(year from dh.data_hora_entrada), sum(e.valor_estadia) valores
from fat_estadia e
inner join dim_hospedagem dh on e.dim_hospedagem_id = dh.id
group by extract(year from dh.data_hora_entrada);

-- Clientes que se hospedaram mais de 5 dias
select u.nome, e.valor_estadia, dh.num_dias from fat_estadia e
inner join dim_user u on e.dim_user_id = u.id
inner join dim_hospedagem dh on e.dim_hospedagem_id = dh.id
where dh.num_dias > 5;

-- 1 Timas
-- - Número de hospedagens em um determinado ano por tipo de propriedade
-- - Número de hospedagens em um determinado ano com crianças

-- 2 Hirrua
-- - Média do número de dias de hospedagens
-- - Média dos valores pagos pelas hospedagens

-- 3 Vitor
-- - Cliente com o maior valor já pago em uma hospedagem
-- - Criar uma 

-- 4 Gabriel
-- - Criar duas