DROP SCHEMA estaciobd;

CREATE SCHEMA IF NOT EXISTS estaciobd DEFAULT CHARACTER SET utf8 ;

USE estaciobd ;

CREATE TABLE Estado (
  UF CHAR(2) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (UF))

insert into Estado (UF, Nome) values ('RJ', 'Rio de Janeiro');
insert into Estado (UF, Nome) values ('SP', 'São Paulo');
insert into Estado (UF, Nome) values ('MG', 'Minas Gerais');

select * from Estado;

--######################
--##Exercício 1
--######################

go

create procedure lista_estados
as
begin
  select * from estado;
end

exec lista_estados

--######################
--##Exercício 2
--######################
go

create procedure insere_estado(@pUF char(02), @pNome varchar(20))
as
begin
  insert into estado (UF, Nome) values (@pUF, @pNome)
end

exec insere_estado 'RS', 'Rio Grande do Sul'
exec lista_estados

--######################
--##Exercício 3
--######################
go

create procedure altera_estado(@pUF char(02), @pNome varchar(20))
as
begin
  update estado set Nome = @pNome where UF = @pUF;
end

exec altera_estado 'RS', 'Rio Grande do WWW'
exec lista_estados
exec altera_estado'RS', 'Rio Grande do Sul'
exec lista_estados

--######################
--##Exercício 4
--######################
go

create procedure deleta_estado(@pUF char(02))
as
begin
  delete from estado where UF = @pUF;
end

exec deleta_estado 'RS'
exec lista_estados

drop procedure deleta_estado

