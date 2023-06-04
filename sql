use formativaHogwarts;

alter table usuarios
add column foto_url varchar (1000) not null;

alter table usuarios
add column telefone varchar (30) not null;

create table tarefas (
id_Tarefas bigint not null auto_increment,
nome_tarefa varchar(150) not null,
descricao_tarefa varchar(500) not null,
prazo_execucao datetime not null,
data_abertura datetime not null,
data_fim datetime not null,
LocalFK bigint not null,
solicitante bigint not null,
foto_urlFK bigint not null,
primary key (id_Tarefas),
foreign key (LocalFK) references locais(id),
foreign key (solicitante) references usuarios(id)

);

create table users_responsaveis(
id_responsaveis bigint not null,
TarefaFK bigint not null,
responsaveis bigint not null,
primary key (id_responsaveis),
foreign key (TarefaFK) references tarefas (id_Tarefas),
foreign key (responsaveis) references usuarios(id)


);

create table status_tarefa(
id_status_tarefa bigint not null auto_increment,
status_tarefa varchar(200) not null,
primary key (id_status_tarefa)

);

create table andamento_tarefas(
id_andamentoTarefas bigint not null auto_increment,
id_TarefaFK bigint not null,
status_tarefaFK bigint not null,
inicio_status datetime not null,
comentario varchar(200) not null,
foto_urlFK bigint not null,
primary key (id_andamentoTarefas),
foreign key (id_TarefaFK) references tarefas (id_Tarefas),
foreign key (status_tarefaFK) references status_tarefa (id_status_tarefa)

);

create table imagens (
id_imagem bigint not null auto_increment,
foto_url text not null,
id_TarefaFK bigint not null,
status_tarefaFK bigint not null,
id_andamentoTarefasFK bigint not null,
primary key (id_imagem),
foreign key (id_TarefaFK) references tarefas (id_Tarefas),
foreign key (status_tarefaFK) references status_tarefa (id_status_tarefa),
foreign key (id_andamentoTarefasFK) references andamento_tarefas (id_andamentoTarefas)
);
select *from usuarios;
insert into usuarios (telefone) values 
('19977777777'),('19911111111'),
('19988888888'),('19922222222'),
('19999999999'),('19933333333');


select *from imagens;
insert into fototarefa (foto_url) values 
('lampada'),('tv'),
('armario'),('cafeteira'),
('mesa'),('teclado');

select *from users_responsaveis;
insert into users_responsaveis (usuarioFK) values 
('1'),('2'),
('3'),('5'),('6');

insert into tarefas(nome_tarefa, descricao, data_inicio, data_prazo, data_fim, solicitacao, localFK, fotoFK, progressoFK, responsaveisFK) values
('cabo de internet', 'o cabo esta rompido e precisa ser trocado', '14-05-2023', '20-05-2023', '30-05-2023', 1, 1, 2, 2),
('limpar mesa da sala', 'a mesa da sala esta suja de guarana', '17-06-2023', '20-06-2023', '30-06-2023', 3, 2, 1, 5);

insert into responsaveis(responsaveisFK, tarefaFK) values
(1, 3),
(2, 4);

insert into progresso(status, dataAndamento, dataConclusao) values
('em andamento', '20-05-2023', '25-05-2023'),
('concluida', '19-06-2023', '23-06-2023');

insert into status (feita, data_Mod, progressoFK) values
('não', '18-05-2023', 2),
('sim', '17-06-2023', 3);

insert into foto_tarefa(link_foto) values
('https://www.fictitiouslink123.com/'),
('https://www.madeuplink456.org/');


select * from tarefas as tf
inner join status_tarefa as st on st.id = tf.statusFK
inner join usuarios as us on us.id = tf.usuaririosFK
where st.progressoFK<2;

select lc.nome, count(tf.id) as todas_as_tarefa  from tarefa as tf
inner join locais as lc on lc.id = tf.localfk
group by lc.nome
having todas_as_tarefa > 1;

select * from tarefa as tf
inner join status_tarefa as st on st.id = tf.statusFK
inner join locais as lc on lc.id = tf.localFK
inner join eventos as ev on lc.id = ev.localFk
where st.etapas = '0';

select lc.nome, count(tf.id) as todas_as_tarefa from tarefa as tf
inner join locais as lc on lc.id = tf.localFK
group by lc.nome;

select lc.nome, count(tf.id) total_tarefa_completas from tarefa as tf
inner join statustarefa as st on st.id = tf.statusFK
inner join locais as lc on lc.id = tf.localFK
inner join eventos as ev on lc.id = ev.localFk
where st.etapas = '1' and progressoFK = '4' 
group by lc.nome;

select us.nome, count(tf.id) as todas_as_tarefa from tarefa as tf
inner join usuarios as us on us.id = tf.responsavelFK
group by us.nome;

select us.nome, count(tf.id) tarefa_concluidas  from tarefa as tf
inner join usuarios as us on us.id = tf.responsavelFK
inner join statustarefa as st on st.id = tf.statusFK
where st.etapas = '1' and progressoFK = '4' 
group by us.nome;

select month(t.data_abertura) as mes, l.local_nome, count(t.id_Tarefas) 
AS total_tarefas from tarefas t join locais l ON t.localFK = l.id group by mes, l.local_nome;
