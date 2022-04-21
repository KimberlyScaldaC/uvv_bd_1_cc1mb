CREATE TABLE uvv.funcionario  (
                cpf CHAR(11) NOT NULL COMMENT 'CPF do funcionario. Sera a PK da tabela.',
                primeiro_nome VARCHAR(15) NOT NULL COMMENT 'Primeiro nome do funcionario.',
                nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.',
                ultimo_nome VARCHAR(15) NOT NULL COMMENT 'Sobrenome do funcionario.',
                data_nascimento DATE COMMENT 'Data de nascimento do funcionario.',
                endereco VARCHAR(30) COMMENT 'Endereco do funcionrio.',
                sexo CHAR(1) COMMENT 'Sexo do funcionario.',
                salario NUMERIC(10,2) COMMENT 'Salario do funcionario.',
                cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor.',
                numero_departamento INTEGER NOT NULL COMMENT 'Numero do departamento do funcionario.',
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
)COMMENT 'Tabela que armazena as informacaes dos funcionarios.';


CREATE TABLE uvv.departamento(
                numero_departamento INTEGER NOT NULL COMMENT 'Numero do departamento. E a PK desta tabela.',
                nome_departamento VARCHAR(15) NOT NULL COMMENT 'Nome do departamento. Deve ser unico.',
                cpf_gerente CHAR(11) NOT NULL COMMENT 'CPF do gerente do departamento. E uma FK para a tabela funcionarios.',
                data_inicio_gerente DATE COMMENT 'Data do inicio do gerente no departamento.',
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
)COMMENT 'Tabela que armazena as informacoes dos departamentos.';


CREATE UNIQUE INDEX departamento_idx
 ON uvv.departamento
 ( nome_departamento );


CREATE TABLE uvv.projeto(
                numero_projeto INTEGER NOT NULL COMMENT 'Numero do projeto. E a PK desta tabela.',
                nome_projeto VARCHAR(15) NOT NULL COMMENT 'Nome do projeto. Deve ser unico.',
                local_projeto VARCHAR(15) COMMENT 'Localizacao do projeto.',
                numero_departamento INTEGER NOT NULL COMMENT 'Numero do departamento. E uma FK para a tabela departamento.',
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
)COMMENT 'Tabela que armazena as informacoes sobre os projetos dos departamentos.';


CREATE UNIQUE INDEX projeto_idx
 ON uvv.projeto
 ( nome_projeto );

CREATE TABLE uvv.localizacoes_departamento(
                numero_departamento INTEGER NOT NULL COMMENT 'Numero do departamento. Faz parta da PK desta tabela e tambem e uma FK para a tabela departamento.',
                local VARCHAR(15) NOT NULL COMMENT 'Localizacao do departamento. Faz parte da PK desta tabela.',
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
)COMMENT 'Tabela que armazena as possiveis localizaes dos departamentos.';


CREATE TABLE uvv.dependente(
                cpf_funcionario CHAR(11) NOT NULL COMMENT 'CPF do funcionario. Faz parte da PK desta tabela e e uma FK para a tabela funcionario.',
                nome_dependente VARCHAR(15) NOT NULL  COMMENT 'Nome do dependente. Faz parte da PK desta tabela.',
                sexo CHAR(1) COMMENT 'Sexo do dependente.',
                data_nascimento DATE COMMENT 'Data de nascimento do dependente.',
                parentesco VARCHAR(15) COMMENT 'Descricao do parentesco do dependente com o funcionario.',
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
)COMMENT 'Tabela que armazena as informacoes dos dependentes dos funcionarios.';


CREATE TABLE uvv.trabalha_em(
                cpf_funcionario CHAR(11) NOT NULL COMMENT 'CPF do funcionario. Faz parte da PK desta tabela e e uma FK para a tabela funcionario.',
                numero_projeto INTEGER NOT NULL COMMENT 'Numero do projeto. Faz parte da PK desta tabela e e uma FK para a tabela projeto.',
                horas NUMERIC(3,1) NOT NULL COMMENT 'Horas trabalhadas pelo funcion rio neste projeto.',
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
)COMMENT 'Tabela para armazenar quais funcionarios trabalham em quais projetos.';

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
;

alter table  uvv.funcionario modify cpf_supervisor CHAR(11) ;  
alter table  uvv.trabalha_em modify horas NUMERIC(3,1) ;

INSERT INTO uvv.funcionario
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'RuadasFlores,751,SãoPaulo,SP', 'M', 30000.00, '33344555587', 5),
('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'RuadaLapa,34,SãoPaulo,SP', 'M', 40000.00, '88866555576', 5),
('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', 25000.00, '98765432168', 4),
('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'AvArthur,54,SantoAndré,SP', 'F', 43000.00, '88866555587', 4),
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'RuaRebouças,65, Piracicaba, SP', 'M', 38000.00, '33344555587', 5),
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av.LucasObes,74, São Paulo, SP', 'F', 25000.00, '33344555587', 5),
('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'RuaTimbira, 35, São Paulo, SP', 'M', 25000.00, '98765432168', 4),
('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'RuadoHorto, 35, São Paulo, SP', 'M', 55000.00, null, 1);

INSERT INTO uvv.departamento (numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente) 
VALUES 
(5, 'Pesquisa', '33344555587', '1988-05-22'),
(4, 'Administração', '98765432168', '1995-01-01'), 
(1, 'Matriz', '88866555576', '1981-06-19');

INSERT INTO uvv.localizacoes_departamento 
(numero_departamento, local)
VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');

INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES
(1, 'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBeneficios', 'Mauá', 4);

INSERT INTO uvv.dependente 
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
('33344555587', 'Alice', 'F', '1987-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

INSERT INTO uvv.trabalha_em 
(cpf_funcionario, numero_projeto,horas)
VALUES
('12345678966', 1, '32.50'),
('12345678966', 2, '07.50'),
('66688444476', 3, '40.00'),
('45345345376', 1, '20.00'),
('45345345376', 2, '20.00'),
('33344555587', 2, '10.00'),
('33344555587', 3, '10.00'),
('33344555587', 10, '10.00'),
('33344555587', 20, '10.00'),
('99988777767', 30, '30.00'),
('99988777767', 10, '10.00'),
('98798798733', 10, '35.00'),
('98798798733', 30, '05.00'),
('98765432168', 30, '20.00'),
('98765432168', 20, '15.00'),
('88866555576', 20, null);



