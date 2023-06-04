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

select *from tarefas; 

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
