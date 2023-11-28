create database dwhotel;

-- tabela de dimensão com dados do hóspede
create table dim_user (
	id bigserial primary key,
	nome varchar (255) not null, -- nome do hospede
	telefone varchar (100) -- telefone do hospedde
);

-- tabela de dimensão com dados da propriedade alugada
create table dim_propriedade (
	id bigserial primary key,
	titulo  varchar (255) not null, -- um título qualquer para a propriedade
	"local" varchar (255) not null, -- a descricao do local
	tipo int not null, -- 1=casa, 2=apartamento, 3=chalé, 4=pousada, 5=hotel, 6=albergue
	num_quartos int not null, -- numero de quartos da propriedade
	num_banheiros int not null, -- numero de banheiros da propriedade
	max_hospedes int not null, -- máximo de hóspedes permitidos na prioriedade
	permite_pets boolean not null, -- se permite pets na propriedade
	pontuacao int -- reputacao da propriedade (1-menor, 5 maior)
);

-- tabela de dimensão com dados da hospedagem
create table dim_hospedagem (
	id bigint primary key,
	data_hora_entrada timestamp not null, --data e hora entrada
	data_hora_saida timestamp not null, --data e hora saida
	num_dias int not null, -- número de dias de hospedagem
	data_hora_reserva timestamp not null, --data e hora da reserva
	origem_reserva varchar (100) -- origem da reserva. Ex: booking, site,  pessoalmente, instagram, facebook, etc.
);

-- tabela de dimensão pagamento
create table dim_pagamento (
	id bigint primary key,
	tipo int not null, --1=cartao, 2-dinheiro, 3-pix, 4-transferencia
	bandeira_cartao varchar(100) --bandeira do cartão. Ex: VISA
);

-- tabela de dimensão de revisao (nota dada a propriedade pelo hóspede)
create table dim_revisao (
	id bigint primary key,
	data_hora_nota timestamp, -- data e hora em que o review foi dado
	nota int -- nota dada a propriedade (1 a 5)
);

-- tabela de fatos
create table fat_estadia (
	id bigserial primary key,
	quantidade_hospedes_adultos int not null, -- quantidade de hospedes adultos durante a estadia
	quantidade_hospedes_criancas int not null, -- quantidade de criancas durante a estadia
	valor_estadia numeric not null, -- valor pago por toda a estadia
	dim_user_id bigint references dim_user(id), -- FK user
	dim_propriedade_id bigint references dim_propriedade(id), --FK propriedade
	dim_hospedagem_id bigint references dim_hospedagem(id), -- FK hospedagem
	dim_pagamento_id bigint references dim_pagamento(id), -- FK pagamento
	dim_revisao_id bigint references dim_revisao(id) -- FK revisao
);


copy dim_user (id, nome, telefone) 
from './tsvs/dim_user.tsv' (FORMAT text, HEADER true);

copy dim_propriedade (id, titulo, "local", tipo, num_quartos, num_banheiros, max_hospedes, permite_pets, pontuacao) 
from './tsvs/dim_propriedade.tsv' (FORMAT text, HEADER true);

copy dim_hospedagem (id, data_hora_entrada, data_hora_saida, num_dias, data_hora_reserva, origem_reserva)
from './tsvs/dim_hospedagem.tsv' (FORMAT text, HEADER true);

copy dim_revisao (id, data_hora_nota, nota)
from './tsvs/dim_revisao.tsv' (FORMAT text, HEADER true);

copy dim_pagamento (id, tipo, bandeira_cartao)
from './tsvs/dim_pagamento.tsv' (FORMAT text, HEADER true);

copy fat_estadia (id, quantidade_hospedes_adultos, quantidade_hospedes_criancas,valor_estadia,
dim_user_id, dim_propriedade_id, dim_hospedagem_id, dim_pagamento_id, dim_revisao_id)
from './tsvs/fat_estadia.tsv' (FORMAT text, HEADER true);
