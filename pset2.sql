--PSET 2 RESPOSTAS

--questao 01
select avg(f.salario) as media_salarial, d.nome_departamento from elmasri.departamento d join elmasri.funcionario f on d.numero_departamento = f.numero_departamento group by d.nome_departamento;

--questao 02
select avg(salario) as media_salarial,
case sexo
when 'M' then 'Masculino'
when 'F' then 'Feminino'
end as sexo 
from elmasri.funcionario group by sexo;

---questao 3
select d.nome_departamento, f.salario , (f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_completo, data_nascimento, date_part('year', age('2022-01-01', data_nascimento)) as idade from elmasri.departamento d join elmasri.funcionario f on d.numero_departamento = f.numero_departamento
order by d.nome_departamento; 

--questao 4
select (f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_completo,date_part('year', age('2022-01-01', data_nascimento)) as idade,f.salario as salario_atual,
case 
when salario<35000 then salario*1.20
when salario>34999 then salario*1.15
end as salario_novo
from funcionario f
order by salario_novo desc;

--questao 5
select d.nome_departamento,
case
when d.cpf_gerente = f.cpf then (f.primeiro_nome, f.nome_meio, f.ultimo_nome)
end as nome_gerente,
case 
when d.cpf_gerente != f.cpf then (f.primeiro_nome, f.nome_meio, f.ultimo_nome)
end as nome_funcionario,
case 
when d.cpf_gerente != f.cpf then f.salario
end as salario_funcionario
from departamento d
inner join funcionario f on (d.numero_departamento = f.numero_departamento)
order by d.nome_departamento asc,
salario_funcionario desc;

--questao 6
select distinct  
(f.primeiro_nome, f.nome_meio, f.ultimo_nome) as nome_funcionario,
d.nome_departamento as trabalham,
de.nome_dependente,
date_part('year', age('2022-01-01', de.data_nascimento)) as idade_dependente,
case de.sexo
when 'M' then 'Masculino'
when 'F' then 'Feminino'
end as sexo_dependente
from departamento d 
inner join funcionario f on (d.numero_departamento = f.numero_departamento)
inner join dependente de on (f.cpf = de.cpf_funcionario);

--questao 7
SELECT DISTINCT
 dt.nome_departamento AS "Nome Departamento"
, concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome Completo"
, case 
  when d.nome_dependente is null
  then f.salario
  end AS "Salário"
FROM funcionario f
JOIN departamento dt
ON (f.numero_departamento = dt.numero_departamento)
LEFT JOIN dependente d 
ON (f.cpf = d.cpf_funcionario)
where d.nome_dependente is null
;

--questao 8
SELECT t.horas as "Horas Trabalhadas"
, p.nome_projeto as "Nome Do Projeto"
, concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome Do Funcionario"
, d.nome_departamento as "Nome do Depart"
FROM trabalha_em t
JOIN projeto p 
ON t.numero_projeto = p.numero_projeto
JOIN departamento d
ON p.numero_departamento = d.numero_departamento
JOIN funcionario f
ON f.cpf = t.cpf_funcionario
ORDER BY t.horas ASC;

--questao 9
SELECT sum(t.horas) as "Horas somadas"
, p.nome_projeto as "Nome Do Projeto"
, d.nome_departamento as "Nome Do Depart"
from trabalha_em t
join projeto p
on (p.numero_projeto = t.numero_projeto)
join departamento d
on (d.numero_departamento = p.numero_departamento)
where t.numero_projeto = t.numero_projeto 
group by t.numero_projeto, p.nome_projeto, d.nome_departamento;

--questao 10
SELECT
 AVG(f.salario) AS "Média Salaraial"
, d.nome_departamento AS " Nome do Departamento"
FROM elmasri.funcionario f
JOIN elmasri.departamento d 
ON (f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento;

--questao 11
select 
concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome Do Funcionario"
, p.nome_projeto
, case 
when t.horas>0 then t.horas*50
end as "Valor total"
from trabalha_em t
join projeto p on (t.numero_projeto = p.numero_projeto)
join funcionario f on (t.cpf_funcionario = f.cpf)
group by concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome),
p.nome_projeto, t.horas;

--questao 12
select 
  d.nome_departamento as "Nome do departamento"
, p.nome_projeto as "Nome Do Projeto"
, concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome Do Funcionario"
from departamento d
join projeto p on(d.numero_departamento = p.numero_departamento)
join funcionario f on (d.numero_departamento = f.numero_departamento)
join trabalha_em t on(t.numero_projeto = p.numero_projeto)
where t.horas is null;

--questao 13
select 
  nome_dependente as nome
, case sexo
when 'M' then 'Masculino'
when 'F' then 'Feminino'
end as sexo
, date_part('year', age('2022-01-01', data_nascimento)) as idade
from dependente d
union
select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS nome,
case sexo
when 'M' then 'Masculino'
when 'F' then 'Feminino'
end as sexo, date_part('year', age('2022-01-01', data_nascimento)) as idade
from funcionario f
order by idade desc;

--questao 14
SELECT 
d.nome_departamento AS "Nome do Departamento"
, case 
when f.numero_departamento = d.numero_departamento 
then COUNT(f.cpf) end as "Total de Funcionários"
from departamento d
join funcionario f
on (f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento, d.numero_departamento, f.numero_departamento
ORDER BY "Total de Funcionários" DESC;

--questao 15
SELECT
CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo"
, d.nome_departamento AS "Nome do departamento"
, p.nome_projeto AS "Nome do projeto"
FROM elmasri.trabalha_em t
JOIN elmasri.funcionario f
ON (t.cpf_funcionario = f.cpf)
JOIN elmasri.projeto p
ON (p.numero_projeto = t.numero_projeto)
JOIN elmasri.departamento d
ON (d.numero_departamento = p.numero_departamento)
WHERE p.numero_departamento = f.numero_departamento
ORDER BY f.primeiro_nome;



