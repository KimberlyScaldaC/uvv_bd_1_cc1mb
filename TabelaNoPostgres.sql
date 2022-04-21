
CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);
COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informa��es dos funcion�rios.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcion�rio. Ser� a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endere�o do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Sal�rio do funcion�rio.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor.';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'N�mero do departamento do funcion�rio.';


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informa�o?s dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'N�mero do departamento. � a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser �nico.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. � uma FK para a tabela funcion�rios.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do in�cio do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informa��es sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'N�mero do projeto. � a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser �nico.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localiza��o do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'N�mero do departamento. � uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as poss�veis localiza��es dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'N�mero do departamento. Faz parta da PK desta tabela e tamb�m � uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localiza��o do departamento. Faz parte da PK desta tabela.';


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informa��es dos dependentes dos funcion�rios.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcion�rio. Faz parte da PK desta tabela e � uma FK para a tabela funcion�rio.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descri��o do parentesco do dependente com o funcion�rio.';


CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcion�rios trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcion�rio. Faz parte da PK desta tabela e � uma FK para a tabela funcion�rio.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'N�mero do projeto. Faz parte da PK desta tabela e � uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcion�rio neste projeto.';

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ALTER COLUMN cpf_supervisor DROP NOT NULL;
ALTER TABLE elmasri.trabalha_em ALTER COLUMN horas DROP NOT NULL;



INSERT INTO elmasri.funcionario
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



INSERT INTO elmasri.departamento 
(numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente) 
VALUES
(5, 'Pesquisa', '33344555587', '1988-05-22'),
(4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');



INSERT INTO elmasri.localizacoes_departamento 
(numero_departamento, "local")
VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');

INSERT INTO elmasri.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES
(1, 'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBeneficios', 'Mauá', 4);



INSERT INTO elmasri.dependente 
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
('33344555587', 'Alice', 'F', '1987-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');



INSERT INTO elmasri.trabalha_em 
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


