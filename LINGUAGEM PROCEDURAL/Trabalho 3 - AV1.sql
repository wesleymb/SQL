-- Considere tabelas com as seguintes estruturas e dados:
create table Funcionario(
  Id int not null primary key,
  Nome varchar(30) not null,
  Salario decimal(8,2) not null,
  Cargo varchar(30) not null,
  Nivel int not null,
  Desempenho int not null)
  
create table Bonificacao(
  Funcionario_Id Int not null,
  Data Date not null,
  Valor decimal(8,2),
  primary key (Funcionario_Id, Data))
 
-- Os seguintes dados devem ser populados na tabela:
insert into Funcionario values (1, 'João', 5000, 'Analista', 1, 8)
insert into Funcionario values (2, 'Maria', 3400, 'Programador', 2, 6)
insert into Funcionario values (3, 'Pedro', 2000, 'Técnico', 1, 7)
insert into Funcionario values (4, 'Marcos', 9000, 'Gerente', 3, 5)
insert into Funcionario values (5, 'Paula', 6000, 'Analista de Testes', 2, 8)

delete Funcionario  where id = 1

/*
1) Criar uma stored procedure chamada "BONIFICAR", que deverá receber dois parâmetros: ID do Funcionario, PercentualBonus e Data.
   Essa stored deverá incluir na tabela Bonificacao o bônus do funcionario, no dia da bonificação informado.
   Exemplo: Se o salário era 5.000,00 e foi passado um Percentual de 10% de Bônus na data de 01/03/2020, deverá ser incluído
            na tabela Bonificacao uma linha com o ID do funcionário, 01/03/2020 e 500.00 de bônus.


2) Criar uma stored procedure chamada "PROMOVER", que deverá receber um parâmetro: ID do Funcionario
   Essa stored deverá alterar o Nivel do Funcionario passado, acrescentando 1 nível a mais para ele.
   Exemplo: O funcionário João possui nível 1. Fazer um update somando 1 nível a mais, ou seja, seu Nível deverá ficar 2.

 

3)Criar uma stored procedure chamada "AVALIAR_FUNCIONARIOS" que deverá percorrer a lista de todos os funcionários e, para cada um,
  se o desempenho for maior ou igual a 8, o funcionário deverá ser promovido (chamando a procedure PROMOVER). Senão, se o desempenho 
  foi maior ou igual a 6, ele deverá ser bonificado (chamando a procedure BONIFICAR). A bonificação será de 10% e será feita 
  na data corrente.


cursor na tabela funcinário
*/

go

alter procedure BONIFICAR (@ID_do_Funcionario int, @PercentualBonus float,  @Data date)
as
begin
	declare @salario decimal(8,2)
	select @salario =  Salario from Funcionario where id = @ID_do_Funcionario
	
	insert into Bonificacao 
		(Funcionario_Id,Data,Valor) values 
		(@ID_do_Funcionario, @Data, @salario*(@PercentualBonus/100))
end

exec BONIFICAR 1, 10, '2020-05-06'
delete from Bonificacao
select * from Bonificacao


go

alter procedure PROMOVER (@ID_do_Funcionario int)
as
begin
	declare @nivel_atual int
	select @nivel_atual= Nivel from Funcionario where id = @ID_do_Funcionario 
	begin
	UPDATE Funcionario
	set Nivel = @nivel_atual+1
	WHERE id = @ID_do_Funcionario
	end
end

exec PROMOVER 1

SELECT * FROM Funcionario




 GO

alter PROCEDURE AVALIAR_FUNCIONARIOS
as
begin
	declare @funcionario_id int
	declare @funcionario_desempenho int
	
	DEClARE cursor_id_desempenho CURSOR FOR 
	select id,Desempenho
	from Funcionario
	
	open cursor_id_desempenho
	FETCH cursor_id_desempenho INTO @funcionario_id, @funcionario_desempenho
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		
		if (@funcionario_desempenho >= 8)
			begin
			--select @funcionario_id
			exec PROMOVER @funcionario_id
			end	
		else
			if (@funcionario_desempenho >= 6)
				begin
				--select @funcionario_id
				declare @data_corrente date
				SELECT @data_corrente = CONVERT (date, GETDATE())
				exec BONIFICAR @funcionario_id, 10, @data_corrente
				end
				FETCH cursor_id_desempenho INTO @funcionario_id, @funcionario_desempenho

		end
		CLOSE cursor_id_desempenho
		DEALLOCATE cursor_id_desempenho
END

drop PROCEDURE AVALIAR_FUNCIONARIOS

exec AVALIAR_FUNCIONARIOS

select * from Funcionario
